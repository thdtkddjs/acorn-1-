package com.gura.acorn.shop.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import com.gura.acorn.shop.dto.ShopDto;
import com.gura.acorn.shop.service.ShopService;

@Controller
public class ShopController {
	
	@Autowired ShopService service;
	
	@PostMapping("/shop/list")
	public String list(HttpServletRequest request) {
		service.getList(request);
		
		return "shop/list";
	}
	
	@PostMapping("/shop/detail")
	public String detail(HttpServletRequest request) {
		service.getDetail(request);
		
		return "shop/detail";
	}
	
	@PostMapping("/shop/insertform")
	public String insertform() {
		
		return "shop/insertform";
	}
	
	@PostMapping("/shop/insert")
	public String list(ShopDto dto) {
		service.saveContent(dto);
		
		return "redirect:shop/list";
	}
}
