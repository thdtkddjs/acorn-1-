package com.gura.acorn.es;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
import org.elasticsearch.client.core.CountRequest;
import org.elasticsearch.client.core.CountResponse;
import org.elasticsearch.core.TimeValue;
import org.elasticsearch.index.query.MatchQueryBuilder;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.index.query.RangeQueryBuilder;
import org.elasticsearch.index.query.TermQueryBuilder;
import org.elasticsearch.script.Script;
import org.elasticsearch.script.ScriptType;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.aggregations.AggregationBuilder;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.aggregations.bucket.terms.Terms;
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

    public List<Map<String, Object>> searchByDateRange(String indexName, String field, Object start, Object end) throws IOException {
    	RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
        SearchRequest searchRequest = new SearchRequest(indexName);
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
        
        
        
        RangeQueryBuilder rangeQuery = QueryBuilders
                .rangeQuery(field)
                .gte(start)
                .lte(end)
                .format("yyyy-MM-dd");
        
        TermQueryBuilder termQuery = QueryBuilders.termQuery("id", "admin");
        
        QueryBuilder query=QueryBuilders.boolQuery()
        		.must(termQuery)
        		.must(rangeQuery);

        searchSourceBuilder.query(query);
        searchSourceBuilder.size(10000);
        searchRequest.source(searchSourceBuilder);

        System.out.println(searchSourceBuilder);

        SearchResponse searchResponse = client.search(searchRequest, RequestOptions.DEFAULT);
        SearchHit[] searchHits = searchResponse.getHits().getHits();

        List<Map<String, Object>> resultList = new ArrayList<>();
        for (SearchHit hit : searchHits) {
            Map<String, Object> sourceAsMap = hit.getSourceAsMap();
            resultList.add(sourceAsMap);
        }

        return resultList;
    }
    
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
    
    //지정일로부터 1년 전까지의 PV를 가져오는 메소드
    //CountRequest를 쓰고있지만, 둘 다 써본 결과
    //SearchRequest를 쓰고 Hit로 추출한 값을 size()로 하는것과 속도차이는 크지 않다.
    //date를 오늘로 하면 오늘부터 1년 전까지의 PV를 가져온다.
    public List<Map<String, Object>> dailyChart(String index, LocalDate date){
		List<Map<String, Object>> resultList=new ArrayList<>();
    	RestHighLevelClient client = RestClients.create(clientConfiguration).rest();
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();

        CountRequest CR = new CountRequest(index); 
        //오늘로부터 365일 전까지의 Data를 가져온다.
        //여기서는 내림차순이지만, 원한다면 i의 값을 바꿔서 오름차순으로 쓸 수 도 있다.
        for(int i=0; i <366; i++) {
        	//
	        LocalDate dateStart=LocalDate.ofEpochDay(LocalDate.now().toEpochDay()-i);
//	        LocalDate dateEnd=date;
	        RangeQueryBuilder rangeQuery = QueryBuilders
	                .rangeQuery("date")
	                .gte(dateStart)
	                .lte(dateStart)
	                .format("yyyy-MM-dd");
	        //ID를 추가로 search할 필요는 없으므로 뺐다.
//     		TermQueryBuilder termQuery = QueryBuilders.termQuery("id", "admin");
	        
	        QueryBuilder query=QueryBuilders.boolQuery()
//	        		.must(termQuery)
	        		.must(rangeQuery);
	
	        searchSourceBuilder.query(query);
	        searchSourceBuilder.size(10000);
	        CR.source(searchSourceBuilder);
	
	        System.out.println(searchSourceBuilder);
	
	        CountResponse SR=null;
			try {
				//Count의 결과로 나온 값을 적절한 date key값으로 매핑해준다.
				Map<String, Object> tmp = new HashMap<>();
				SR = client.count(CR, RequestOptions.DEFAULT);
				tmp.put(dateStart.toString(), SR.getCount());
				//Map을 List에 차곡차곡 담는다.
				resultList.add(tmp);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
        
    	
    	return resultList;
    }
    //Aggregation
    //집계라고 번역되며, Metrics/Bucket 두 종류로 데이터를 조작한다.
    //이 메소드에서는 Bucket 방식의 조작만 진행한다.
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

}

