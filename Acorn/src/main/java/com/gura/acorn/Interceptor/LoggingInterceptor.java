package com.gura.acorn.Interceptor;

import java.io.IOException;
import java.time.LocalDate;
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
import org.springframework.web.servlet.HandlerInterceptor;

import com.gura.acorn.es.ElasticUtil;
import com.gura.acorn.shop.dao.ShopDao;
import com.gura.acorn.shop.dto.ShopDto;

@Component
public class LoggingInterceptor implements HandlerInterceptor {
	@Autowired
	private ShopDao dao;
	
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	String requesturl = request.getRequestURL().toString();
    	HttpSession session = request.getSession();
    	String id = (String)session.getAttribute("id");
    	
    	String[] str = requesturl.split("/");
    	
    	String index = "test3";
    	
    	int pageId = 0;
    	int storeId = 0;
    	String pageType = null;
    	String storeName = null;
    	
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

		System.out.println(pageId);
		System.out.println(pageType);
		System.out.println(storeName);
		
		Map<String, Object> map = new HashMap<>();
		map.put("userId", id);
		map.put("date", LocalDate.now().atStartOfDay(ZoneId.systemDefault()).toInstant().toString());
		map.put("pageId", pageId);
		map.put("pageType", pageType);
		map.put("storeName", storeName);
		map.put("storeId", storeId);
		
		try {
			ElasticUtil.getInstance().create(index, map);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return true;
    }
}