package com.gura.acorn.es;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

@Component
public class CustomExceptionResolver implements HandlerExceptionResolver {

    private static final Logger logger = LoggerFactory.getLogger(CustomExceptionResolver.class);

    @Override
    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
                                         Exception ex) {
        logger.error("An error occurred while processing the request", ex);
        
        String errorMsg = ex.toString();

        // 적절한 오류 페이지로 이동
        ModelAndView mav = new ModelAndView("error-page");
        mav.addObject("errorMessage", ex.getMessage());

        // whitelabel 페이지에 대한 로그 기록
        Map<String, Object> map = new HashMap<>();
        map.put("errorCode", "NG");
		map.put("time", LocalDateTime.now().toString());
		map.put("elapsedTime", System.currentTimeMillis() - (Long) request.getAttribute("startTime"));
		map.put("errorMsg", ex.toString());
        try {
            ElasticUtil.getInstance().create("error80", map);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return mav;
    }
}

