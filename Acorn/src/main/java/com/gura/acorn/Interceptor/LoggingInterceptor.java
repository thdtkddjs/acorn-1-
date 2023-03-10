package com.gura.acorn.Interceptor;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.HandlerInterceptor;

import com.gura.acorn.es.ElasticUtil;
import com.gura.acorn.shop.dao.ShopDao;
import com.gura.acorn.shop.dto.ShopDto;

@Component
public class LoggingInterceptor implements HandlerInterceptor {
	@Autowired
	private ShopDao dao;
	
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    
    private Map<String, Object> map = new HashMap<>();
    private Map<String, Object> map2 = new HashMap<>();
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	String requesturl = request.getRequestURL().toString();
    	HttpSession session = request.getSession();
    	request.setAttribute("startTime", System.currentTimeMillis());
    	String id = (String)session.getAttribute("id");
    	
    	String[] str = requesturl.split("/");
    	
    	int pageId = 0;
    	int storeId = 0;
    	String pageType = null;
    	String storeName = null;
    	String category = null;
    	
    	if(str.length == 3) {
    		pageId = 1;
    		pageType = "INDEX";
    	}else {
    		switch (str[3]) {
    		case "shop":
    			pageId = 2;
    			pageType = "SHOP";
    			break;

    		case "users":
    			pageId = 3;
    			pageType = "USERS";
    			break;

    		case "search":
    			pageId = 4;
    			pageType = "SEARCH";
    			break;

    		case "statistics":
    			pageId = 5;
    			pageType = "STATISTICS";
    			break;

    		case "error":
    			pageId = 6;
    			pageType = "ERROR";
    			break;
    		}
    	}
		
    	if(str.length > 4) {
    		switch (str[4]) {
    		case "detail":
    			pageType = "DETAIL";
    			ShopDto dto = dao.getData(Integer.parseInt(request.getParameter("num")));
    			storeName = dto.getTitle();
    			storeId = dto.getNum();
    			switch(dto.getCategorie()) {
    			case "한식":
    				category = "cate1";
    				break;
    			case "중식":
    				category = "cate2";
    				break;
    			case "일식":
    				category = "cate3";
    				break;
    			case "분식":
    				category = "cate4";
    				break;
    			case "양식":
    				category = "cate5";
    				break;
    			case "패스트푸드":
    				category = "cate6";
    				break;
    			case "기타":
    				category = "cate7";
    				break;
    			}
    			break;
    		case "list":
    			if(pageId == 2) {
    				pageType = "SHOPLIST";
    			}else {
    				pageType = "USERSLIST";
    			}
    			break;
    		}
    	}		
		
		map.put("userId", id);
		map.put("date", LocalDate.now().toString());
		map.put("pageId", pageId);
		map.put("pageType", pageType);
		map.put("storeName", storeName);
		map.put("storeId", storeId);		
		map.put("category", category);
		
		return true;
    }
    
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        long startTime = (long) request.getAttribute("startTime");
        long endTime = System.currentTimeMillis();
        long executeTime = endTime - startTime;     
        
		map2.put("errorCode", "OK");
		map2.put("time", LocalDateTime.now().toString());
		map2.put("elapsedTime", executeTime);
		map2.put("errorMsg", null);
		
		try {
			ElasticUtil.getInstance().create("test4", map);
			ElasticUtil.getInstance().create("testlog6", map);
			ElasticUtil.getInstance().create("error2", map2);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}