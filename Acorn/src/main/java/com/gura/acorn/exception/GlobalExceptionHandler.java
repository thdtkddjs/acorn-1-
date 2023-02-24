package com.gura.acorn.exception;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.gura.acorn.es.ElasticUtil;


//Json형태로 값을 응답하는 ControllerAdvice
//이 project 내에서 Exception이 발생한 모든 경우에 ExceptionHandler 메소드를 호출할 수 있도록 해준다.
@RestControllerAdvice
public class GlobalExceptionHandler {
	//체크용 logger
	private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);
	  //시작시간을 기록하여 elapsedtime을 구할 수 있도록 해준다.
	  @ModelAttribute
	  public void calculateRequestTime(HttpServletRequest request) {
	      request.setAttribute("startTime", System.currentTimeMillis());
	  }
	  //Exception 발생시 아래의 메소드가 호출된다.
	    @ExceptionHandler(Exception.class)
	    public String handleException(Exception ex, HttpServletRequest request) {
	        String msg = "이럴수가! ";
	        //ES에 적재할 정보를 입력한다.
	        Map<String, Object> map=new HashMap<>();
	        //에러코드
	        map.put("errorCode", ex.toString());
	        //현재시간
	        map.put("time", LocalDateTime.now().toString());
	        //request time-response time을 구함
	        map.put("elapsedTime", System.currentTimeMillis() -(Long) request.getAttribute("startTime"));
	        //info 형태로 콘솔창에 입력된 정보를 체크한다.
	        logger.info(map.toString());
	        
			try {
				//error라는 index에 정보를 적재한다.
				ElasticUtil.getInstance().create("error", null, map);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//작동 체크용 리턴값
	        return msg+ex.toString();
	    }
}