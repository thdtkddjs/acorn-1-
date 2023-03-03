package com.gura.acorn.es;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.elasticsearch.action.search.ClearScrollRequest;
import org.elasticsearch.action.search.ClearScrollResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.search.SearchScrollRequest;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.core.TimeValue;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.index.query.RangeQueryBuilder;
import org.elasticsearch.index.query.TermQueryBuilder;
import org.elasticsearch.script.Script;
import org.elasticsearch.script.ScriptType;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.aggregations.BucketOrder;
import org.elasticsearch.search.aggregations.bucket.terms.Terms;
import org.elasticsearch.search.aggregations.bucket.terms.TermsAggregationBuilder;
import org.elasticsearch.search.builder.SearchSourceBuilder;
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
    
    //index의 모든 id값의 개수를 추출
    public Map<String, Object> getCountOfIdsFromIndex(String indexName) throws IOException {

        RestHighLevelClient client = RestClients.create(clientConfiguration).rest();

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
    
    //index의 모든 id별 data 추출
//    public List<Map<String, Object>> getAllDataFromIndex(String indexName) throws IOException {
//    	RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
//    	
//        List<Map<String, Object>> dataList = new ArrayList<>();
//
//        SearchRequest searchRequest = new SearchRequest(indexName);
//        searchRequest.scroll(TimeValue.timeValueMinutes(1L));
//
//        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
//        searchSourceBuilder.query(QueryBuilders.matchAllQuery());
//        searchSourceBuilder.size(1000); // 한 번에 가져올 문서 개수
//
//        searchRequest.source(searchSourceBuilder);
//
//        SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
//        String scrollId = searchResponse.getScrollId();
//        SearchHit[] searchHits = searchResponse.getHits().getHits();
//
//        while (searchHits != null && searchHits.length > 0) {
//            for (SearchHit hit : searchHits) {
//                Map<String, Object> sourceAsMap = hit.getSourceAsMap();
//                dataList.add(sourceAsMap);
//            }
//
//            SearchScrollRequest scrollRequest = new SearchScrollRequest(scrollId);
//            scrollRequest.scroll(TimeValue.timeValueMinutes(1L));
//            SearchResponse scrollResponse = client.scroll(scrollRequest, RequestOptions.DEFAULT);
//            scrollId = scrollResponse.getScrollId();
//            searchHits = scrollResponse.getHits().getHits();
//        }
//
//        ClearScrollRequest clearScrollRequest = new ClearScrollRequest();
//        clearScrollRequest.addScrollId(scrollId);
//        ClearScrollResponse clearScrollResponse = client.clearScroll(clearScrollRequest, RequestOptions.DEFAULT);
//        
//        
//        return dataList;
//    }
    
    //기간내의 모든 데이터 검색
//    public List<Map<String, Object>> searchByDateRange(String indexName, String field, Object start, Object end) throws IOException {
//    	RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
//        SearchRequest searchRequest = new SearchRequest(indexName);
//        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
//        
//        RangeQueryBuilder rangeQuery = QueryBuilders
//                .rangeQuery(field)
//                .gte(start)
//                .lte(end)
//                .format("yyyy-MM-dd");
//
//        searchSourceBuilder.query(rangeQuery);
//        searchSourceBuilder.size(1000);
//        searchRequest.source(searchSourceBuilder);
//
//        SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
//        SearchHit[] searchHits = searchResponse.getHits().getHits();
//
//        List<Map<String, Object>> resultList = new ArrayList<>();
//        for (SearchHit hit : searchHits) {
//            Map<String, Object> sourceAsMap = hit.getSourceAsMap();
//            resultList.add(sourceAsMap);
//        }
//
//        return resultList;
//    }
    
    
    //기간내의 데이터 검색 + 그 안의 storeId 로 검색
//    public List<Map<String, Object>> searchByDateRange2(String indexName, String field, Object start, Object end) throws IOException {
//    	RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
//        SearchRequest searchRequest = new SearchRequest(indexName);
//        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
//        
//        RangeQueryBuilder rangeQuery = QueryBuilders
//                .rangeQuery(field)
//                .gte(start)
//                .lte(end)
//                .format("yyyy-MM-dd");
//        
//        TermQueryBuilder termQuery = QueryBuilders.termQuery("storeId", 29);
//        
//        BoolQueryBuilder boolQuery = QueryBuilders.boolQuery();
//        boolQuery.must(rangeQuery);
//        boolQuery.must(termQuery);
//
//        searchSourceBuilder.query(boolQuery);
//        searchSourceBuilder.size(1000);
//        searchRequest.source(searchSourceBuilder);
//
//        SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
//        SearchHit[] searchHits = searchResponse.getHits().getHits();
//
//        List<Map<String, Object>> resultList = new ArrayList<>();
//        for (SearchHit hit : searchHits) {
//            Map<String, Object> sourceAsMap = hit.getSourceAsMap();
//            resultList.add(sourceAsMap);
//        }
//
//        return resultList;
//    }
    
  //기간내의 데이터 검색 + 
    public Map<String, Object> searchByDateRange3(String indexName, String field, Object start, Object end) throws IOException {
        RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
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
    	RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
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
    	RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
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
    
    //total 통계에서 가장 높은 pv
//    public Map<String, Object> groupMax(String indexName) throws IOException {
//    	RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
//
//    	SearchRequest searchRequest = new SearchRequest(indexName);
//
//    	SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
//    	TermsAggregationBuilder aggregation = AggregationBuilders.terms("pv_count").field("storeName.keyword")
//    	    .size(1) // 결과 중 가장 많은 항목 하나만 리턴하도록 설정합니다.
//    	    .order(BucketOrder.count(false)); // doc_count 내림차순으로 정렬합니다.
//
//    	searchSourceBuilder.aggregation(aggregation);
//    	searchRequest.source(searchSourceBuilder);
//
//    	SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
//    	Terms pvCount = searchResponse.getAggregations().get("pv_count");
//
//    	if (pvCount.getBuckets().size() > 0) {
//    	    String maxStore = pvCount.getBuckets().get(0).getKeyAsString();
//    	    long maxCount = pvCount.getBuckets().get(0).getDocCount();
//    	    Map<String, Object> resultMap = new HashMap<>();
//    	    resultMap.put("maxStore", maxStore);
//    	    resultMap.put("maxCount", maxCount);
//    	    return resultMap;
//    	} else {
//    	    return null;
//    	}
//    }
}