package com.gura.acorn.es;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.elasticsearch.action.get.GetRequest;
import org.elasticsearch.action.get.GetResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.core.TimeValue;
import org.elasticsearch.index.query.QueryBuilders;
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
    
    public String getSourceOfIdFromIndex(String indexName, String id) throws IOException {
        
        RestHighLevelClient client = RestClients.create(clientConfiguration).rest();

        GetRequest getRequest = new GetRequest(indexName, id);

        GetResponse getResponse = client.get(getRequest, RequestOptions.DEFAULT);

        return getResponse.getSourceAsString();
    }
    
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
}

