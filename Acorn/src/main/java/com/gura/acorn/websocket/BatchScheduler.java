package com.gura.acorn.websocket;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonNumber;
import javax.json.JsonObject;
import javax.json.JsonObjectBuilder;
import javax.json.JsonString;
import javax.json.JsonValue;
import javax.json.JsonValue.ValueType;
import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.gura.acorn.es.ElasticsearchService;

@Component
public class BatchScheduler {
	
    @Autowired
    private ElasticsearchService Esservice;
    
	private final WebSocketService service;
	
	public BatchScheduler(WebSocketService service) {
		this.service = service;
    }
	//300초 = 5분마다 PV를 얻어내서 websocket으로 쏴준다.
	@Scheduled(fixedDelay = 300000)
	public void testSchedule() {
		int num = 0;
		List<Map<String, Object>> resultList = new ArrayList<>();
    	try {
    		//PV를 얻어온다. 현재는 5일 전까지 긁어옴.
    		resultList = Esservice.PVforWebSocket();
			num = resultList.size();
			System.out.println(num);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String message=Integer.toString(num);
		String clientID = "DatePath";
		//JSON으로 데이터를 build
		JSONObject msg1=new JSONObject();
		msg1.put("type", "data");
		msg1.put("text", message);
		msg1.put("id", clientID);
		msg1.put("date", LocalDateTime.now().getMinute());
		//아래와 같은 형태의 데이터.
//        var msg1 = {
//        	    type: "message",
//        	    text: msg,
//        	    id:   clientID,
//        	    date: Date.now()
//        	  };
		//데이터를 websocket에 send한다.
		service.sendMessage(msg1.toString());
		
	}
}
