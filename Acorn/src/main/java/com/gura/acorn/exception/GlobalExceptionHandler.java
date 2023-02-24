package com.gura.acorn.exception;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import com.gura.acorn.es.ElasticUtil;

@RestControllerAdvice
public class GlobalExceptionHandler {

	private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

	@ModelAttribute
	public void calculateRequestTime(HttpServletRequest request) {
		request.setAttribute("startTime", System.currentTimeMillis());
	}

	@AfterReturning(pointcut = "execution(* com.gura.acorn.*.*(..))", returning = "result")
	public void logResponseTime(JoinPoint joinPoint, Object result, HttpServletRequest request) {
		long startTime = (Long) request.getAttribute("startTime");
		long endTime = System.currentTimeMillis();
		long elapsedTime = endTime - startTime;
		logger.info(
				"Response time for " + joinPoint.getSignature().getName() + " is " + elapsedTime + " milliseconds.");
		request.setAttribute("excepTime", elapsedTime);

	}

	@ExceptionHandler(Exception.class)
	public String handleException(Exception ex, HttpServletRequest request) {
		String msg = "이럴수가! ";
		Map<String, Object> map = new HashMap<>();
		map.put("errorCode", ex.toString());
		map.put("time", LocalDateTime.now().toString());
		map.put("elapsedTime", System.currentTimeMillis() - (Long) request.getAttribute("startTime"));
		logger.info(map.toString());
		try {
			ElasticUtil.getInstance().create("error", map);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return msg + ex.toString();
	}
}