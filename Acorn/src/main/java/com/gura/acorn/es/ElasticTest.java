package com.gura.acorn.es;

import java.io.IOException;
import java.net.http.HttpClient;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpHost;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.HttpClientBuilder;
import org.elasticsearch.action.get.GetResponse;
import org.elasticsearch.action.index.IndexAction;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.index.IndexRequestBuilder;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestClientBuilder;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.Strings;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.sort.FieldSortBuilder;

import co.elastic.clients.elasticsearch._types.SortOrder;
import co.elastic.clients.elasticsearch.indices.PutAliasRequest;

public class ElasticTest {
	
	public static void main(String[] args) throws IOException {
		String index = "gaia";
//		//id와 password 입력
//		CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
//		credentialsProvider.setCredentials(AuthScope.ANY, new UsernamePasswordCredentials("elastic", "acorn"));
//		String hostname = "34.125.190.255";
//		int port = 9200;
//		HttpHost host = new HttpHost(hostname, port);
//		RestClientBuilder restClientBuilder = RestClient.builder(host).setHttpClientConfigCallback(
//				 httpClientBuilder -> httpClientBuilder.setDefaultCredentialsProvider(credentialsProvider)
//			);
//		
//		client = new RestHighLevelClient(restClientBuilder);
		
//		GetRequest getRequest = new GetRequest(index, id);
//		RequestOptions options = RequestOptions.DEFAULT;
//		
//		GetResponse response = client.get(getRequest, options);
//		System.out.println(getRequest);
//		Map<String,Object> map = response.getSourceAsMap();
//		System.out.println(map);
//		
//		
//		System.out.println(simpleSearch(null, null, null, null));
//		
//		Map<String, Object> result=ElasticUtil.getInstance().getReponse(index);
//		
//		System.out.println(result);
//	
//		Map<String,Object> map2  = new HashMap<>();
//		map2.put("작동", "155");
//		map2.put("확인", "153");
//		System.out.println(map2);
//		ElasticUtil ES=ElasticUtil.getInstance();
//		ES.create(index, map2);
//				
//		System.out.println(ES.simplesearch());
		
	}
	
//	public IndexResponse create(String index, String id, Map<String, Object> data ) throws IOException {
//		IndexResponse response = null;
//		
//		IndexRequest indexRequest = new IndexRequest(index).id(id).source(data);
//		System.out.println(indexRequest);
//		response = client.index(indexRequest, RequestOptions.DEFAULT);
//		
//		return response;
//	}
//	public static List<Map<String,Object>> simpleSearch( 
//			String index
//			, Map<String,Object> query
//			, Map<String,SortOrder> sort
//			, Integer size
//			) throws IOException{
//		
//		// search에 index 조건 걸기
//		SearchRequest searchRequest=new SearchRequest("gaia");
//		SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
//		searchSourceBuilder.query(QueryBuilders.termQuery("다시", "153"));
//		searchRequest.source(searchSourceBuilder);
//		
//		
//		List<Map<String,Object>> list = new ArrayList<>();
//		
//		SearchResponse response=client.search(searchRequest, RequestOptions.DEFAULT);
//		SearchHits searchHits=response.getHits();
//		for(SearchHit hit:searchHits) {
//			Map<String, Object> sourceMap=hit.getSourceAsMap();
//			list.add(sourceMap);
//		}
//		
//		return list;
//		
//	}
}