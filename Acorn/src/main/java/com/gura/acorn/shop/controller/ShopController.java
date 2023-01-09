package com.gura.acorn.shop.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gura.acorn.shop.service.ShopService;

@Controller
public class ShopController {
	
	@Autowired
	private ShopService service;
	
	@RequestMapping("/index/")
	public String index(HttpServletRequest request) {
		service.getList(request);
		
		return "index";
	}
	
	@RequestMapping("/shop/list")
	public String list(HttpServletRequest request) {
		service.getList(request);
		
		return "shop/list";
	}
	@RequestMapping("/shop/detail")
	public String detail(HttpServletRequest request) {
		service.getData(request);
		//service.getDetail(request);
		service.getList(request);
		return "/shop/detail";
	}
}
