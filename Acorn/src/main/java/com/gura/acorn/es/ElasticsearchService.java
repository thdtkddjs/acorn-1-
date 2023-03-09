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
    
    public Map<String, Object> aggregateByMonth1(String indexName) throws IOException {
    	// date_histogram 집계 쿼리를 작성합니다.
    	SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
    	SearchRequest searchRequest = new SearchRequest(indexName);
    	
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
    
    
    public Map<String, Object> aggregateByMonth(String indexName) throws IOException {
    	// date_histogram 집계 쿼리를 작성합니다.
    	SearchSourceBuilder sourceBuilder = new SearchSourceBuilder();
    	SearchRequest searchRequest = new SearchRequest(indexName);
    	sourceBuilder.aggregation(
    	        AggregationBuilders.dateHistogram("monthly")
    	                .field("date")
    	                .calendarInterval(DateHistogramInterval.MONTH)
    	                .format("yyyy-MM")
    	);

    	// Elasticsearch에 쿼리를 보내서 결과를 받아옵니다.
    	searchRequest.source(sourceBuilder);
    	SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
    	
    	// Elasticsearch에서 반환된 결과를 Map<String, Object> 형식으로 변환합니다.
    	Map<String, Object> resultMap = new HashMap<>();
    	Histogram monthlyHistogram = searchResponse.getAggregations().get("monthly");
    	for (Histogram.Bucket monthlyBucket : monthlyHistogram.getBuckets()) {
    	    Map<String, Object> monthlyAggMap = new HashMap<>();
    	    monthlyAggMap.put("month", monthlyBucket.getKeyAsString());
    	    monthlyAggMap.put("count", monthlyBucket.getDocCount());
    	    resultMap.put("monthlyAggMap", monthlyAggMap);
    	}

    	// 결과를 반환합니다.
    	return resultMap;
    }
    
    //index의 모든 id값의 개수를 추출
    public Map<String, Object> getCountOfIdsFromIndex(String indexName) throws IOException {
        SearchRequest searchRequest = new SearchRequest(indexName);
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
    public Map<String, Object> searchByDateRange3(String indexName, String field, Object start, Object end) throws IOException {
        SearchRequest searchRequest = new SearchRequest(indexName);
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();

        RangeQueryBuilder rangeQuery = QueryBuilders
                .rangeQuery(field)
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

    
    //기간 내 데이터의 개수를 리턴
    public Map<String, Object> searchMonthPV(String indexName, String field, Object start, Object end) throws IOException {
        SearchRequest searchRequest = new SearchRequest(indexName);
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();

        RangeQueryBuilder rangeQuery = QueryBuilders
                .rangeQuery(field)
                .gte(start)
                .lte(end)
                .format("yyyy-MM-dd");

        searchSourceBuilder.query(rangeQuery);
        searchRequest.source(searchSourceBuilder);

        SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("PVMonthCount", searchResponse.getHits().getTotalHits().value);
        
        return resultMap;
    }
    
    public Map<String, Object> searchDayPV(String indexName, String field, Object start) throws IOException {
        SearchRequest searchRequest = new SearchRequest(indexName);
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();

        RangeQueryBuilder rangeQuery = QueryBuilders
                .rangeQuery(field)
                .gte(start)
                .lte(start)
                .format("yyyy-MM-dd");

        searchSourceBuilder.query(rangeQuery);

        searchRequest.source(searchSourceBuilder);

        SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("PVDayCount", searchResponse.getHits().getTotalHits().value);
        
        return resultMap;
    }
    
    public Map<String, Object> searchErrorLog() throws IOException {
        SearchRequest searchRequest = new SearchRequest("error2");
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();

        RangeQueryBuilder rangeQuery = QueryBuilders
                .rangeQuery("time")
                .gte(LocalDate.now())
                .lte(LocalDate.now())
                .format("yyyy-MM-dd");

        searchSourceBuilder.query(rangeQuery);

        AggregationBuilder aggr = AggregationBuilders.terms("code_count").field("errorCode.keyword");
        searchSourceBuilder.aggregation(aggr);

        searchRequest.source(searchSourceBuilder);

        SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);

        Terms codeCount = searchResponse.getAggregations().get("code_count");
        Map<String, Object> resultMap = new HashMap<>();
        for (Terms.Bucket bucket : codeCount.getBuckets()) {
            String groupKey = bucket.getKeyAsString();
            long docCount = bucket.getDocCount();
            resultMap.put(groupKey, docCount);
        }

        return resultMap;
    }
    
    //현재 달 포함 과거 12달의 pv 리턴
//    public List<Map<String, Object>> searchPV2(String indexName) throws IOException {
//    	RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
//        SearchRequest searchRequest = new SearchRequest(indexName);
//        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
//        
//        LocalDate now = LocalDate.now();
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
//        DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyy-MM");
//        List<Map<String, Object>> resultList = new ArrayList<>();
//        for (int i = 0; i < 12; i++) {
//           String startDate = now.minusMonths(i).withDayOfMonth(1).format(formatter);
//           String endDate = now.minusMonths(i).with(TemporalAdjusters.lastDayOfMonth()).format(formatter);
//           
//           RangeQueryBuilder rangeQuery = QueryBuilders
//                   .rangeQuery("date")
//                   .gte(startDate)
//                   .lte(endDate)
//                   .format("yyyy-MM-dd");
//           
//           searchSourceBuilder.query(rangeQuery);
//           searchRequest.source(searchSourceBuilder);
//
//           SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
//
//           String date = now.minusMonths(i).format(formatter2);
//           Map<String, Object> resultMap = new HashMap<>();
//           resultMap.put(date, searchResponse.getHits().getTotalHits().value);
//           resultList.add(resultMap);
//        }
//
//        return resultList;
//    }
    


public int count() {
    	RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
    	
		List<Map<String, Object>> result=new ArrayList<>();
		CountResponse response=null;
		
		
		CountRequest countRequest = new CountRequest("testlog"); 
		SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder(); 
		searchSourceBuilder.query(QueryBuilders.boolQuery()
				.must(QueryBuilders.termQuery("id", "admin"))
				.must(QueryBuilders.matchPhraseQuery("date", "2023-04-01"))); 
		countRequest.source(searchSourceBuilder); 
		
		try {
			response = client.count(countRequest, RequestOptions.DEFAULT);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println(response.getCount());
		
		return (int) response.getCount();
	}
    
    //Aggregation
    //집계라고 번역되며, Metrics/Bucket 두 종류로 데이터를 조작한다.
    //이 메소드에서는 Bucket 방식의 조작만 진행한다.
    //return은 배열 형태가 아닌 마지막으로 Term에서 나온 ID 값이 기록된다.
    //필요에 따라 배열의 형태, 혹은 int 형태의 갯수를 리턴하자.
    public String testAggregation() {
    	
    	RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
    	SearchSourceBuilder sSB = new SearchSourceBuilder();
    	SearchRequest sRequest = new SearchRequest("testlog2");
    	String example=null;
    	//7개의 아이디가 모두 들어있지 않은 날을 골랐다.
    	LocalDate date=LocalDate.ofEpochDay(LocalDate.now().toEpochDay()-350);
    	LocalDate date2=LocalDate.ofEpochDay(LocalDate.now().toEpochDay()-351);
    	
    	//늘 쓰던 RangeQuery
    	RangeQueryBuilder rangeQuery = QueryBuilders
                .rangeQuery("date")
                .gte(date2)
                .lte(date)
                .format("yyyy-MM-dd");
    	//id의 키워드로 id variety를 구하는 식으로 보인다.
    	AggregationBuilder AB=AggregationBuilders.terms("id_variety").field("id.keyword").size(1000);
    	
    	sSB.query(rangeQuery);
    	//SearchSourceBuilder에 넣는다.
    	sSB.aggregation(AB);
    	sSB.size(100);
    	
    	sRequest.source(sSB);
    	
    	SearchResponse sResponse=null;
		try {
			sResponse = client.search(sRequest, RequestOptions.DEFAULT);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	//아마 ID 종류를 담은 배열로 보인다.
		Terms idVarietyAgg = sResponse.getAggregations().get("id_variety");
    	for(Terms.Bucket bucket : idVarietyAgg.getBuckets()) {
    	    String idVariety = bucket.getKeyAsString();
    	    System.out.println(idVariety);
    	    example=idVariety;
    	}
    	
    	
    	return example;
    }
    

    //index의 모든 id별 data 추출
  public List<Map<String, Object>> getAllDataFromIndex(String indexName) throws IOException {
  	RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
  	
      List<Map<String, Object>> dataList = new ArrayList<>();

      SearchRequest searchRequest = new SearchRequest(indexName);
      searchRequest.scroll(TimeValue.timeValueMinutes(1L));

      SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
      searchSourceBuilder.query(QueryBuilders.matchAllQuery());
      searchSourceBuilder.size(1000); // 한 번에 가져올 문서 개수

      searchRequest.source(searchSourceBuilder);

      SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
      String scrollId = searchResponse.getScrollId();
      SearchHit[] searchHits = searchResponse.getHits().getHits();

      while (searchHits != null && searchHits.length > 0) {
          for (SearchHit hit : searchHits) {
              Map<String, Object> sourceAsMap = hit.getSourceAsMap();
              dataList.add(sourceAsMap);
          }

          SearchScrollRequest scrollRequest = new SearchScrollRequest(scrollId);
          scrollRequest.scroll(TimeValue.timeValueMinutes(1L));
          SearchResponse scrollResponse = client.scroll(scrollRequest, RequestOptions.DEFAULT);
          scrollId = scrollResponse.getScrollId();
          searchHits = scrollResponse.getHits().getHits();
      }

      ClearScrollRequest clearScrollRequest = new ClearScrollRequest();
      clearScrollRequest.addScrollId(scrollId);
      ClearScrollResponse clearScrollResponse = client.clearScroll(clearScrollRequest, RequestOptions.DEFAULT);
      
      
      return dataList;
  }
  
  //기간내의 모든 Error 데이터 검색
  public List<Map<String, Object>> searchError() throws IOException {
      SearchRequest searchRequest = new SearchRequest("error2");
      SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
      
      LocalDateTime now = LocalDateTime.now();
      LocalDateTime fiveMinutesAgo = now.minus(1, ChronoUnit.MINUTES);
      
      RangeQueryBuilder rangeQuery = QueryBuilders
    		  .rangeQuery("time")
    		  .gte(fiveMinutesAgo.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss")))
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
  
  //Websocket에 보낼 pv를 수집한다.
  public List<Map<String, Object>> PVforWebSocket() throws IOException {
	int Count = 0;
    SearchRequest searchRequest = new SearchRequest("test4");
    SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
    
    LocalDateTime now = LocalDateTime.now();
    LocalDateTime fiveMinutesAgo = now.minus(1, ChronoUnit.HOURS);
    
    RangeQueryBuilder rangeQuery = QueryBuilders
  		  .rangeQuery("date")
  		  .gte(fiveMinutesAgo.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss")))
  		  .lte(now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss")))
  		  .format("strict_date_optional_time||epoch_millis");

    searchSourceBuilder.query(rangeQuery);
    searchSourceBuilder.size(1000);
    searchRequest.source(searchSourceBuilder);

    SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
    SearchHit[] searchHits = searchResponse.getHits().getHits();

    List<Map<String, Object>> resultList = new ArrayList<>();
    for (SearchHit hit : searchHits) {
        Map<String, Object> sourceAsMap = hit.getSourceAsMap();
        resultList.add(sourceAsMap);
        Count++;
    }

    return resultList;
}
  
  
  //기간내의 데이터 검색 + 그 안의 storeId 로 검색
//  public List<Map<String, Object>> searchByDateRange2(String indexName, String field, Object start, Object end) throws IOException {
//  	RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
//      SearchRequest searchRequest = new SearchRequest(indexName);
//      SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
//      
//      RangeQueryBuilder rangeQuery = QueryBuilders
//              .rangeQuery(field)
//              .gte(start)
//              .lte(end)
//              .format("yyyy-MM-dd");
//      
//      TermQueryBuilder termQuery = QueryBuilders.termQuery("storeId", 29);
//      
//      BoolQueryBuilder boolQuery = QueryBuilders.boolQuery();
//      boolQuery.must(rangeQuery);
//      boolQuery.must(termQuery);
//
//      searchSourceBuilder.query(boolQuery);
//      searchSourceBuilder.size(1000);
//      searchRequest.source(searchSourceBuilder);
//
//      SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
//      SearchHit[] searchHits = searchResponse.getHits().getHits();
//
//      List<Map<String, Object>> resultList = new ArrayList<>();
//      for (SearchHit hit : searchHits) {
//          Map<String, Object> sourceAsMap = hit.getSourceAsMap();
//          resultList.add(sourceAsMap);
//      }
//
//      return resultList;
//  }
    
    //total 통계에서 가장 높은 pv
//  public Map<String, Object> groupMax(String indexName) throws IOException {
//  	RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
//
//  	SearchRequest searchRequest = new SearchRequest(indexName);
//
//  	SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
//  	TermsAggregationBuilder aggregation = AggregationBuilders.terms("pv_count").field("storeName.keyword")
//  	    .size(1) // 결과 중 가장 많은 항목 하나만 리턴하도록 설정합니다.
//  	    .order(BucketOrder.count(false)); // doc_count 내림차순으로 정렬합니다.
//
//  	searchSourceBuilder.aggregation(aggregation);
//  	searchRequest.source(searchSourceBuilder);
//
//  	SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
//  	Terms pvCount = searchResponse.getAggregations().get("pv_count");
//
//  	if (pvCount.getBuckets().size() > 0) {
//  	    String maxStore = pvCount.getBuckets().get(0).getKeyAsString();
//  	    long maxCount = pvCount.getBuckets().get(0).getDocCount();
//  	    Map<String, Object> resultMap = new HashMap<>();
//  	    resultMap.put("maxStore", maxStore);
//  	    resultMap.put("maxCount", maxCount);
//  	    return resultMap;
//  	} else {
//  	    return null;
//  	}
//  }
}