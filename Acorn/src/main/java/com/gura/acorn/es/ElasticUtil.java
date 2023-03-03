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
import org.elasticsearch.action.search.MultiSearchRequest;
import org.elasticsearch.action.search.MultiSearchRequestBuilder;
import org.elasticsearch.action.search.MultiSearchResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.Cancellable;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.RestHighLevelClientBuilder;
import org.elasticsearch.common.Strings;
import org.elasticsearch.common.document.DocumentField;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.springframework.stereotype.Service;

import co.elastic.clients.elasticsearch._types.query_dsl.BoolQuery;

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
	public Map<String,Object> getReponse(String index) {
		GetResponse response = null; 
		
		GetRequest getRequest = new GetRequest(index);
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
	public Cancellable create(String index, Map<String, Object> data ) throws IOException {
		ActionListener<IndexResponse> listener= null;
		
		IndexRequest indexRequest = new IndexRequest(index).source(data);
		System.out.println(indexRequest);
		//비동기 방식으로 index 작업을 진행한다.
		Cancellable response = client.indexAsync(indexRequest, RequestOptions.DEFAULT, listener = new ActionListener<IndexResponse>() {
		    @Override
		    public void onResponse(IndexResponse indexResponse) {
		        System.out.println("성공!");
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
	
		//search(인덱스 전체를 search한다.)
		public List<Map<String, Object>> simplesearch(String index, int size){
			List<Map<String, Object>> result=new ArrayList<>(); 
			SearchRequest searchRequest = new SearchRequest(index); 
			SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
			searchSourceBuilder.query(QueryBuilders.matchAllQuery()).size(size); 
			searchRequest.source(searchSourceBuilder);

			try {
				SearchResponse response=client.search(searchRequest, RequestOptions.DEFAULT);
				SearchHits hits=response.getHits();
				for (SearchHit hit:hits) {
					result.add(hit.getSourceAsMap());
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			return result;
		}

		//search(조건을 걸어 검색한다.)
		//matchQuery : analyzer로 분석하여 형태소에 걸맞는 정보를 순서에 상관없이 출력한다.
		//ex)2023-10-10으로 검색했을때 10이란 숫자가 date의 시간 10:00의 10도 정답인것으로 인지한다.
		//matchphraseQuery : 위와 같은 형태지만 문자열의 순서를 지킨다.(어지간해선 이걸 쓰는게 좋다.)
		//termQuery : 정확히 내용이 일치하는 것만 출력한다.(id로만 쓰자. 나머지는 제대로 작동안함)
		public List<Map<String, Object>> detailsearch(String index, String field, String text, int size){
			List<Map<String, Object>> result=new ArrayList<>();
			String condition = "";
			SearchResponse response= null;
			SearchRequest searchRequest = new SearchRequest(index); 
			SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder(); 
			if(field.equals("date")) {
				condition = text;
				searchSourceBuilder.query(QueryBuilders.matchPhraseQuery(field, condition)).size(size); 
			}else if(field.equals("url")){
				condition = text;
				searchSourceBuilder.query(QueryBuilders.matchPhraseQuery(field, condition)).size(size); 
			}else {
				condition = text;
				searchSourceBuilder.query(QueryBuilders.termQuery(field, condition)).size(size); 
			}
			searchRequest.source(searchSourceBuilder);

			try {
				response=client.search(searchRequest, RequestOptions.DEFAULT);
				SearchHits hits=response.getHits();
				for (SearchHit hit:hits) {
					result.add(hit.getSourceAsMap());

				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			return result;
		}
		//조건을 여러개 걸어서 검색
		//parameter는 어떻게 조건이 걸릴지 몰라서 일단은 detailsearch와 동일하게 정해뒀음. 
		//size 말곤 실제로 쓰지는 않음.
		public List<Map<String, Object>> multisearch(String index, String field, String text, int size){
			List<Map<String, Object>> result=new ArrayList<>();
			String condition = "";
			SearchResponse response= null;
			SearchRequest searchRequest = new SearchRequest(index); 
			SearchSourceBuilder sSBuilder = new SearchSourceBuilder();
			//BoolQuery로 id조건과 date 조건을 등록
			//must -> 포함되어야 함
			//must not -> 포함되면 안됨		
			//filter, should 등의 다른 메소드들은 따로 공부해서 추가해볼 예정, 일단은 이정도만으로도 충분하다.
			sSBuilder.query(QueryBuilders.boolQuery()
					.must(QueryBuilders.termQuery("id", "admin"))
					.must(QueryBuilders.matchPhraseQuery("date", "2023-04-01")));
			//너무 길어졌으므로 사이즈를 따로 분리
			sSBuilder.size(size);
			searchRequest.source(sSBuilder);

			try {
				response=client.search(searchRequest, RequestOptions.DEFAULT);
				SearchHits hits=response.getHits();
				for (SearchHit hit:hits) {
					result.add(hit.getSourceAsMap());

				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			return result;
		}
}
