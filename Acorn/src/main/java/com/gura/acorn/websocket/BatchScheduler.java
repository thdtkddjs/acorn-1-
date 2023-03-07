package com.gura.acorn.websocket;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.Date;
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
	
	@Scheduled(fixedDelay = 300000)
	public void testSchedule() {
		int num = 0;
    	try {
			num = Esservice.PVforWebSocket();
			System.out.println(num);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String message=Integer.toString(num);
		String clientID = "DatePath";
		
		JSONObject msg1=new JSONObject();
		msg1.put("type", "data");
		msg1.put("text", message);
		msg1.put("id", clientID);
		msg1.put("date", LocalDateTime.now().toString());
		System.out.println(msg1);
//        var msg1 = {
//        	    type: "message",
//        	    text: msg,
//        	    id:   clientID,
//        	    date: Date.now()
//        	  };
		service.sendMessage(msg1.toString());
		
	}
}
