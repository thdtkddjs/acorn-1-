package com.gura.acorn.es;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.apache.http.HttpHost;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.elasticsearch.action.bulk.BulkRequest;
import org.elasticsearch.action.bulk.BulkResponse;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.RestHighLevelClientBuilder;
import org.springframework.beans.factory.annotation.Autowired;

import com.gura.acorn.shop.dao.ShopDao;

public class RandomData {
	
	private static RestHighLevelClient client;
	
	public static void main(String[] args) {
		//Util을 끌어다 쓰기에는 속도가 걱정되므로 새로 client를 정의하자.
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
		
		//랜덤 데이터가 들어갈 BulkRequest를 작성
		BulkRequest rq=new BulkRequest();
		
		for (int i=0;i<3000;i++) {
			//시간과 날짜를 랜덤으로 정한다.(오늘로부터 1년 후까지)
			String time = LocalTime.of((int)(Math.random()*24), 0).toString();
			String date= LocalDate.ofEpochDay((long) (LocalDate.now().toEpochDay()+Math.random()*365)).toString();
			//7개의 id 중 하나를 랜덤으로 정하는데 필요한 값
			int ran1=(int)(Math.random()*7);
			//pageId 및 Type을 정하는 값
			int ran2=(int)(Math.random()*30); // 0 ~ 29
			//pageType이 Shop일 경우 list 인지 detail인지를 구분
			int ran3=(int)(Math.random()*2);
			//storeId 및 storeName을 정하는 값
			int ran4=(int)(Math.random()*55)+1;

			//7개의 카테고리를 정하는 값
			int ran5=(int)(Math.random()*7);
			
			String userId = null;
			String pageType = null;
			int pageId = 0;
			int storeId = 0;
			String storeName = null;
			String category = null;
			
			
			switch (ran1) {
				case 6:
					userId = "acorn";
					break;
				case 5:
					userId = "tTest";
					break;
				case 4:
					userId = "song1";
					break;
				case 3:
					userId = "yg1234";
					break;
				case 2:
					userId = "seodae";
					break;
				case 1:
					userId = "maple";
					break;
				case 0:
					userId = "admin";
					break;
			}
			
			switch (ran2) { // 0 ~ 24 DETAIL
			case 29:
				pageId = 6;
    			pageType = "ERROR";
				break;
			case 28:
				pageId = 5;
    			pageType = "STATISTICS";
				break;
			case 27:
				pageId = 4;
    			pageType = "SEARCH";
				break;
			case 26:
				pageId = 3;
    			pageType = "USERS";
				break;
			case 25:
				pageId = 1;
	    		pageType = "INDEX";
				break;
			default:
				pageId = 2;
				pageType = "DETAIL";
    			if(ran3 == 0) {
    				pageType = "DETAIL";
    				storeId = ran4;
    				storeName = "store"+ran4;
    				switch(ran5) {
    				case 0:
    					category = "한식";
    					break;
    				case 1:
    					category = "일식";
    					break;
    				case 2: 
    					category = "양식";
    					break;
    				case 3:
    					category = "중식";
    					break;
    				case 4:
    					category = "분식";
    					break;
    				case 5:
    					category = "패스트푸드";
    					break;
    				case 6: 
    					category = "기타";
    					break;
    				}
    			}else {
    				pageType = "SHOPLIST";
    			}
				break;
		}
			
			
			
			//데이터를 mapping한다.
			Map<String, Object> map2= new HashMap<>();
			map2.put("userId", userId);
			map2.put("date", date);
			map2.put("pageId", pageId);
			map2.put("pageType", pageType);
			map2.put("storeName", storeName);
			map2.put("storeId", storeId);
			map2.put("category", category);
			//데이터를 {"index":{"_index":"testlog"}
			//		 {"id": xx, "url" : xx, "date" : xx}
			//형식으로 만들어 bulkrequest에 입력한다.
			rq.add(new IndexRequest("dktest4").source(map2));
		}
		
		
		
		BulkResponse rp=null;

		try {
			//request를 client에 넣어 작동시킨다.
			rp=client.bulk(rq, RequestOptions.DEFAULT);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		System.out.println(rp);
	}
}
