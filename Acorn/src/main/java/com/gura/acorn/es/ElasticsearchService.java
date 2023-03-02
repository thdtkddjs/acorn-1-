package com.gura.acorn.es;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
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
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.index.query.RangeQueryBuilder;
import org.elasticsearch.script.Script;
import org.elasticsearch.script.ScriptType;
import org.elasticsearch.search.SearchHit;
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
    
    //index의 모든 id를 추출
    public List<String> fetchAllIdsFromIndex(String indexName) throws IOException {

        RestHighLevelClient client = RestClients.create(clientConfiguration).rest();

        SearchRequest searchRequest = new SearchRequest(indexName);
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
        searchSourceBuilder.query(QueryBuilders.matchAllQuery());
        searchSourceBuilder.size(1000); // batch size 설정 (default는 10)
        searchSourceBuilder.timeout(TimeValue.timeValueMinutes(2)); // timeout 설정
        searchSourceBuilder.fetchSource(false); // 결과로 데이터를 받지 않음 (ID 정보만 필요한 경우)

        searchRequest.source(searchSourceBuilder);

        SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);

        List<String> idList = new ArrayList<>();
        
        for (SearchHit hit : searchResponse.getHits().getHits()) {
            idList.add(hit.getId());
        }
        
        return idList;
    }
    
    //index의 모든 id값의 개수를 추출
    public long getCountOfIdsFromIndex(String indexName) throws IOException {

        RestHighLevelClient client = RestClients.create(clientConfiguration).rest();

        SearchRequest searchRequest = new SearchRequest(indexName);
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
        searchSourceBuilder.query(QueryBuilders.matchAllQuery());
        searchSourceBuilder.size(0); // 결과를 받지 않고 개수만 필요한 경우 0으로 설정
        searchSourceBuilder.timeout(TimeValue.timeValueMinutes(2));

        searchRequest.source(searchSourceBuilder);

        SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);

        return searchResponse.getHits().getTotalHits().value;
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
    
	// match_all 외의 쿼리 사용
    public List<Map<String, Object>> getAllDataFromIndex1(String indexName, String fieldName, String fieldValue) throws IOException {
    	RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
        SearchRequest searchRequest = new SearchRequest(indexName);

        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
        searchSourceBuilder.query(QueryBuilders.boolQuery()
                .must(QueryBuilders.termQuery(fieldName, fieldValue))
                .must(QueryBuilders.scriptQuery(
                    new Script(
                        ScriptType.INLINE, 
                        "painless",
                        "def sdf = new SimpleDateFormat(\"MM-dd\"); return sdf.format(Date.parse(\"yyyy-MM-dd HH:mm\", doc['date.keyword'].value)) == params.value;",
                        Collections.singletonMap("value", fieldValue)
                    )
                ))
        );

        searchSourceBuilder.size(10000);

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

    public List<Map<String, Object>> searchByDateRange(String indexName, String field, String start, String end) throws IOException {
    	RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
        SearchRequest searchRequest = new SearchRequest(indexName);
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
        
        RangeQueryBuilder rangeQuery = QueryBuilders
                .rangeQuery(field)
                .gte(start)
                .lte(end)
                .format("yyyy-MM-dd'T'HH:mm:ss.SSSZ");

        searchSourceBuilder.query(rangeQuery);
        searchSourceBuilder.size(1000);
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

