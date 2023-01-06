package com.gura.acorn;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	
	@GetMapping("/")
	public String home(HttpServletRequest request) {
		
		List<String> noticeList = new ArrayList<>();
		noticeList.add("Spring Boot start.");
		noticeList.add("zxc");
		noticeList.add("asd");
		
		request.setAttribute("noticeList", noticeList);
		
		return "home";
	}
	
	@GetMapping("/index")
	public String index() {
		return "index";
	}
}
