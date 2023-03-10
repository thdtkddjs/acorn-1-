package com.gura.acorn.es;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.elasticsearch.action.search.ClearScrollRequest;
import org.elasticsearch.action.search.ClearScrollResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.search.SearchScrollRequest;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.core.CountRequest;
import org.elasticsearch.client.core.CountResponse;
import org.elasticsearch.core.TimeValue;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.index.query.RangeQueryBuilder;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.aggregations.AggregationBuilder;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.aggregations.BucketOrder;
import org.elasticsearch.search.aggregations.bucket.histogram.DateHistogramInterval;
import org.elasticsearch.search.aggregations.bucket.histogram.Histogram;
import org.elasticsearch.search.aggregations.bucket.terms.Terms;
import org.elasticsearch.search.aggregations.bucket.terms.TermsAggregationBuilder;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.sort.FieldSortBuilder;
import org.elasticsearch.search.sort.SortOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.elasticsearch.client.ClientConfiguration;
import org.springframework.data.elasticsearch.client.RestClients;
import org.springframework.data.elasticsearch.core.ElasticsearchRestTemplate;
import org.springframework.stereotype.Service;



@Service
public class ElasticsearchService {

    @Autowired
    private ElasticsearchRestTemplate elasticsearchTemplate;

    ClientConfiguration clientConfiguration = ClientConfiguration.builder()
    		.connectedTo("34.125.190.255:9200")
            .withBasicAuth("elastic", "acorn")
            .build();
    
    RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
    
    public Map<String, Object> aggregateByMonthUV() throws IOException {
    	// date_histogram 집계 쿼리를 작성합니다.
    	SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
    	SearchRequest searchRequest = new SearchRequest("uvtest");
    	
    	AggregationBuilder dateAggregation = AggregationBuilders.dateHistogram("date_count")
                .field("date")
                .calendarInterval(DateHistogramInterval.MONTH)
                .order(BucketOrder.key(true));
    	
        sourceBuilder.aggregation(dateAggregation);    
        searchRequest.source(sourceBuilder);
        SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);

        // 그룹별 개수를 저장할 Map 객체 생성
        TreeMap<String, Object> groupCounts = new TreeMap<>();

        // aggregation 결과 파싱
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");
        Histogram agg = searchResponse.getAggregations().get("date_count");
        for (Histogram.Bucket bucket : agg.getBuckets()) {
            String groupKey = bucket.getKeyAsString();
            LocalDateTime date = LocalDateTime.parse(groupKey, DateTimeFormatter.ISO_DATE_TIME);
            String formattedDate = date.format(formatter);
            long docCount = bucket.getDocCount();
            
            groupCounts.put(formattedDate, docCount);        
        }
        return groupCounts;
    }
    
    public Map<String, Object> aggregateByMonth() throws IOException {
    	// date_histogram 집계 쿼리를 작성합니다.
    	SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
    	SearchRequest searchRequest = new SearchRequest("testlog6");
    	
    	AggregationBuilder dateAggregation = AggregationBuilders.dateHistogram("date_count")
                .field("date")
                .calendarInterval(DateHistogramInterval.MONTH)
                .order(BucketOrder.key(true));
    	
    	AggregationBuilder storeAggregation = AggregationBuilders.terms("store_count")
                .field("storeName.keyword")
                .size(1)
                .order(BucketOrder.count(false));
    	
    	AggregationBuilder categoryAggregation = AggregationBuilders.terms("category_count")
                .field("category.keyword")
                .size(10) 
                .order(BucketOrder.key(false));
    	
    	AggregationBuilder storeIdAggregation = AggregationBuilders.terms("store_id")
    			.field("storeId")
    			.size(1)
    			.order(BucketOrder.count(false));
    	
    	storeAggregation.subAggregation(storeIdAggregation);
    	dateAggregation.subAggregation(categoryAggregation);
    	dateAggregation.subAggregation(storeAggregation);
        sourceBuilder.aggregation(dateAggregation);
        
        searchRequest.source(sourceBuilder);

        SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);

        // 그룹별 개수를 저장할 Map 객체 생성
        TreeMap<String, Object> groupCounts = new TreeMap<>();

        // aggregation 결과 파싱
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");
        Histogram agg = searchResponse.getAggregations().get("date_count");
        for (Histogram.Bucket bucket : agg.getBuckets()) {
            String groupKey = bucket.getKeyAsString();
            LocalDateTime date = LocalDateTime.parse(groupKey, DateTimeFormatter.ISO_DATE_TIME);
            String formattedDate = date.format(formatter);
            long docCount = bucket.getDocCount();
            
            TreeMap<String, Object> pvCounts = new TreeMap<>();
            pvCounts.put("total", docCount);
            Terms storeAgg = bucket.getAggregations().get("store_count");
            if (storeAgg.getBuckets().size() > 0) {
            	String storeName = storeAgg.getBuckets().get(0).getKeyAsString();
                long maxCount = storeAgg.getBuckets().get(0).getDocCount();
                pvCounts.put(storeName, maxCount);
                
                Terms storeIdAgg = storeAgg.getBuckets().get(0).getAggregations().get("store_id");
                if (storeIdAgg.getBuckets().size() > 0) {
                    int storeId = storeIdAgg.getBuckets().get(0).getKeyAsNumber().intValue();
                    pvCounts.put("storeId", storeId);
                }
        	}
            
            
			Terms categoryAgg = bucket.getAggregations().get("category_count");
            for (Terms.Bucket categoryBucket : categoryAgg.getBuckets()) {
            	String category = categoryBucket.getKeyAsString();
                long count = categoryBucket.getDocCount();
                pvCounts.put(category, count);
        	}
            
            groupCounts.put(formattedDate, pvCounts);        
        }

        return groupCounts;
    }

    //index의 모든 id값의 개수를 추출
    public Map<String, Object> getTotalPV() throws IOException {
        SearchRequest searchRequest = new SearchRequest("testlog6");
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
        searchSourceBuilder.query(QueryBuilders.matchAllQuery());
        searchSourceBuilder.size(0); // 결과를 받지 않고 개수만 필요한 경우 0으로 설정
        searchSourceBuilder.timeout(TimeValue.timeValueMinutes(2));

        searchRequest.source(searchSourceBuilder);

        SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
        
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("PVTotalCount", searchResponse.getHits().getTotalHits().value);
        
        return resultMap;
    }
    
  //기간내의 데이터 검색 + 
    public Map<String, Object> searchByDateRange3() throws IOException {
        SearchRequest searchRequest = new SearchRequest("testlog6");
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
        
        LocalDate start = LocalDate.now().minusMonths(1).withDayOfMonth(1);
        LocalDate end = LocalDate.of(2023, start.getMonth(), start.lengthOfMonth());

        RangeQueryBuilder rangeQuery = QueryBuilders
                .rangeQuery("date")
                .gte(start)
                .lte(end)
                .format("yyyy-MM-dd");
        searchSourceBuilder.query(rangeQuery);

        TermsAggregationBuilder aggregation = AggregationBuilders.terms("pv_count").field("storeName.keyword")
        	    .size(1) // 결과 중 가장 많은 항목 하나만 리턴하도록 설정합니다.
        	    .order(BucketOrder.count(false)); // doc_count 내림차순으로 정렬합니다.
        searchSourceBuilder.aggregation(aggregation);

        searchRequest.source(searchSourceBuilder);

        SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);

        Terms pvCount = searchResponse.getAggregations().get("pv_count");

    	if (pvCount.getBuckets().size() > 0) {
    	    String maxStore = pvCount.getBuckets().get(0).getKeyAsString();
    	    long maxCount = pvCount.getBuckets().get(0).getDocCount();
    	    Map<String, Object> resultMap = new HashMap<>();
    	    resultMap.put("maxStore", maxStore);
    	    resultMap.put("maxCount", maxCount);
    	    return resultMap;
    	} else {
    	    return null;
    	}
    }

    
    public Map<String, Object> searchDayPV(String indexName, String field) throws IOException {
    	
    	LocalDate yesterday = LocalDate.now().minusDays(1);
    	
        SearchRequest searchRequest = new SearchRequest(indexName);
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();

        RangeQueryBuilder rangeQuery = QueryBuilders
                .rangeQuery(field)
                .gte(yesterday)
                .lte(yesterday)
                .format("yyyy-MM-dd");

        searchSourceBuilder.query(rangeQuery);

        searchRequest.source(searchSourceBuilder);

        SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("PVDayCount", searchResponse.getHits().getTotalHits().value);
        
        return resultMap;
    }
     
	// 기간내의 모든 Error 데이터 검색
	public List<Map<String, Object>> searchError() throws IOException {
		SearchRequest searchRequest = new SearchRequest("error2");
		SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();

		LocalDateTime now = LocalDateTime.now();
		LocalDateTime oneMinutesAgo = now.minus(1, ChronoUnit.MINUTES);

		RangeQueryBuilder rangeQuery = QueryBuilders.rangeQuery("time")
				.gte(oneMinutesAgo.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss")))
				.lte(now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss")))
				.format("strict_date_optional_time||epoch_millis");

		searchSourceBuilder.query(rangeQuery);
		searchSourceBuilder.size(1000);
		searchSourceBuilder.sort(new FieldSortBuilder("time").order(SortOrder.ASC));

		searchRequest.source(searchSourceBuilder);

		SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
		SearchHit[] searchHits = searchResponse.getHits().getHits();

		List<Map<String, Object>> resultList = new ArrayList<>();
		for (SearchHit hit : searchHits) {
			Map<String, Object> sourceAsMap = hit.getSourceAsMap();
			resultList.add(sourceAsMap);
		}

		return resultList;
	}
}