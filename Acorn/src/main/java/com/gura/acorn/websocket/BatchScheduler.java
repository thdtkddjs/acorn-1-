package com.gura.acorn.websocket;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

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
	@Scheduled(fixedDelay = 2000)
	public void testSchedule() {
		int num = 0;
		List<Map<String, Object>> resultList = new ArrayList<>();
    	try {
    		//PV의 대상이 될 데이터를 얻어온다. 현재는 24시간 전까지 긁어옴.
    		resultList = Esservice.PVforWebSocket();
			//데이터의 size가 곧 pv이다.
    		num = resultList.size();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String message=Integer.toString(num);
		//적당한 이름을 정해준다. 별로 중요하진 않다.
		String clientID = "DatePath";
		//JSON type으로 데이터를 build
		JSONObject msg1=new JSONObject();
		msg1.put("type", "data");
		msg1.put("text", message);
		msg1.put("id", clientID);
		//어차피 분단위 이상은 필요하지 않을 것 같아서 잘라버렸다.
		msg1.put("date", LocalDateTime.now().getMinute());
		msg1.put("channel", "data");
		//아래와 같은 형태의 데이터가 된다.
//        var msg1 = {
//        	    type: "message",
//        	    text: msg,
//        	    id:   clientID,
//        	    date: Date.now(),
//				channel : "data"
//        	  };
		//데이터를 websocket에 send한다.
		service.sendMessage(msg1.toString());
		
	}
}