package com.gura.acorn.es;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpHost;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.elasticsearch.action.ActionListener;
import org.elasticsearch.action.get.GetRequest;
import org.elasticsearch.action.get.GetResponse;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.Cancellable;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.RestHighLevelClientBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.springframework.stereotype.Service;

@Service
public class ElasticUtil {
	private static ElasticUtil self;
	private static RestHighLevelClient client;
	//RestHighLevelClient 타입의 client에 ip, port, id와 pwd를 전달하여
	//접속정보를 전달한다.
	//RestHighLevelClient는 java에서 ES를 제어하는 방법 중 하나이다.
	//버전이 7.17.0에서 중단된 것을 보면 지금은 자주 쓰지 않는 방식같다.
	private ElasticUtil() throws IOException {
		//id와 password 입력
		CredentialsProvider credentialsProvider = new BasicCredentialsProvider();
		credentialsProvider.setCredentials(AuthScope.ANY, new UsernamePasswordCredentials("elastic", "acorn"));
		//ip와 host 입력 후 http 방식으로 사용할 것이라고 schema를 정의
		String hostname = "34.125.190.255";
		int port = 9200;
		HttpHost host = new HttpHost(hostname, port, "http");
		//위 정보를 바탕으로 client에 값을 주입
		client = new RestHighLevelClientBuilder(RestClient.builder(host).setHttpClientConfigCallback(
				httpClientBuilder -> httpClientBuilder.setDefaultCredentialsProvider(credentialsProvider)
				).build()).
				//7.17버전이라 8.6.1버전인 ES와 맞지 않아서 호환성을 맞춰준다.
				setApiCompatibilityMode(true).build();
			
	};
	
	public static ElasticUtil getInstance() throws IOException {
		if(self == null)
			self = new ElasticUtil();
		return self;
	}
	//특정 index/id에 있는 정보를 Map<String,Obect>형태로 받아온다.
	public Map<String,Object> getReponse(String index, String id) {
		GetResponse response = null; 
		
		GetRequest getRequest = new GetRequest(index, id);
		RequestOptions options = RequestOptions.DEFAULT;
		try {
		response = client.get(getRequest, options);
		System.out.println(response);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return response.getSourceAsMap();
	}
	//특정 index/id에 Map<String, Object>방식으로 저장된 data를 전달하여 저장한다.
	//본래는 json방식으로 전달해야하지만 request 과정에서 자동으로 변환해준다.
	//다만 type이 상당히 엄격하다.
	public Cancellable create(String index, String id, Map<String, Object> data ) throws IOException {
		ActionListener<IndexResponse> listener= null;
		
		IndexRequest indexRequest = new IndexRequest(index).id(id).source(data);
		System.out.println(indexRequest);
		//비동기 방식으로 index 작업을 진행한다.
		Cancellable response = client.indexAsync(indexRequest, RequestOptions.DEFAULT, listener = new ActionListener<IndexResponse>() {
		    @Override
		    public void onResponse(IndexResponse indexResponse) {
		        System.out.println("성공!");
		        System.out.println(indexResponse);
		    }

		    @Override
		    public void onFailure(Exception e) {
		        System.out.println("실패!");
		        System.out.println(e);
		    }
		}
		);
		return response;
	}
	
	//search
	public List<Map<String, Object>> simplesearch(){
		//search의 결과를 담아둘 List
		List<Map<String, Object>> result=new ArrayList<>();
		SearchRequest searchRequest = new SearchRequest("gaia"); 
		SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder(); 
		searchSourceBuilder.query(QueryBuilders.matchAllQuery()); 
		searchRequest.source(searchSourceBuilder);
		
//		Cancellable response=client.searchAsync(searchRequest, RequestOptions.DEFAULT, new ActionListener<SearchResponse>() {
//		    @Override
//		    public void onResponse(SearchResponse searchResponse) {
//		        System.out.println("ES로부터 정보를 가져옵니다.");
//		        SearchHits hits=searchResponse.getHits();
//		        for(SearchHit hit:hits) {
//		        	result.add(hit.getSourceAsMap());
//		        }
//		    }
//
//		    @Override
//		    public void onFailure(Exception e) {
//		        System.out.println("search작업 실패");
//		        System.out.println(e);
//		    }
//		});
		try {
			SearchResponse response=client.search(searchRequest, RequestOptions.DEFAULT);
			SearchHits hits=response.getHits();
			for (SearchHit hit:hits) {
				result.add(hit.getSourceAsMap());
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
}
