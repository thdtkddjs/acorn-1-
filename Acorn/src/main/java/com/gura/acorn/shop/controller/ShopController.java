package com.gura.acorn.shop.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gura.acorn.shop.dto.ShopDto;
import com.gura.acorn.shop.service.ShopService;

@Controller
public class ShopController {

	@Autowired
	private ShopService service;
	
	//인덱스 페이지부터 가게리스트를 받을예정 ( 홈컨트롤러에서 리스트 불러오기 필요 ) > 나중에 필요하다면 리스트에 관련된 컨트롤러 추가
	
	//글 작성폼 이동
	@GetMapping("/shop/insertform")
	public String insertform() {
		return "shop/insertform";
		//주소입력으로 관리자외의 사람이 글 작성하려고 할 경우 막기 위해 session 추가 필요
	}
	
	//글 작성
	@GetMapping("/shop/insert")
	public String insert(ShopDto dto, HttpServletRequest request) {
		String imagePath = (String)request.getParameter("imagePath");
		dto.setImagePath(imagePath);
		service.saveContent(dto);
		return "shop/insert";
	}
	
	//글 섬네일 등록을 위한 메소드
	@ResponseBody
	@RequestMapping(value = "/shop/image_upload", method = RequestMethod.POST)
	public Map<String, Object> imageUpload(MultipartFile image, HttpServletRequest request) {

		return service.saveImagePath(request, image);
	}
	
	//가게정보 상세보기
	@GetMapping("/shop/detail")
	public String detail(HttpServletRequest request) {
		service.getDetail(request);
		return "shop/detail";
	}
	
	//가게 정보 업데이트(등록과 마찬가지로 관리자 권한 기능 필요하다면 session 추가/삭제 필요)
	@GetMapping("/shop/updateform")
	public String updateform(HttpServletRequest request) {
		service.getData(request);
		return "shop/updateform";
	}
	
	@GetMapping("/shop/update")
	public String update(ShopDto dto, HttpServletRequest request) {
		service.updateContent(dto, request);
		return "shop/update";
	}
	
	//등록, 수정과 마찬가지로 session 추가 필요
	@GetMapping("/shop/delete")
	public String delete(int num, HttpServletRequest request) {
		service.deleteContent(num, request);
		return "redirect:/shop/list";
	}
	
	//리뷰 기능 구현 후 리뷰관련 처리 추가 필요
}
