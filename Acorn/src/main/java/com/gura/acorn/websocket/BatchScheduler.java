package com.gura.acorn.websocket;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gura.acorn.es.ElasticsearchService;

@Component
public class BatchScheduler {
	
    @Autowired
    private ElasticsearchService Esservice;
    
	private final WebSocketService service;
	
	public BatchScheduler(WebSocketService service) {
		this.service = service;
    }
	//표기된 숫자 milisecond마다 PV를 얻어내서 websocket으로 쏴준다.
	//지금은 테스트용으로 10초지만, 멘토님은 5분을 요구하심.
	@Scheduled(fixedDelay = 10000) 
	public void testSchedule() {
		List<Map<String, Object>> resultList = new ArrayList<>();
    	try {
    		//PV의 대상이 될 데이터를 얻어온다. 현재는 24시간 전까지 긁어옴.
    		resultList = Esservice.searchError();
    		ObjectMapper objectMapper = new ObjectMapper();
        	String json = objectMapper.writeValueAsString(resultList);
        	service.sendMessage(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
}