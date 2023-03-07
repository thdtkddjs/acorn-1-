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
		String msg = "error";
		String exMsg = ex.toString();
		String errorMsg = exMsg.substring(0, exMsg.indexOf(":"));
		System.out.println(errorMsg);
		Map<String, Object> map = new HashMap<>();
		map.put("errorCode", "NG");
		map.put("time", LocalDateTime.now().toString());
		map.put("elapsedTime", System.currentTimeMillis() - (Long) request.getAttribute("startTime"));
		map.put("errorMsg", errorMsg.toString());
		try {
			ElasticUtil.getInstance().create("error2", map);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return msg + ex.toString();
	}
}