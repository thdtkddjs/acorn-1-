package com.gura.acorn.shop.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gura.acorn.shop.service.ShopService;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gura.acorn.shop.dto.ShopDto;
import com.gura.acorn.shop.dto.ShopMenuDto;
import com.gura.acorn.shop.dto.ShopReviewDto;

@Controller
public class ShopController {

	@Autowired
	private ShopService service;
	

	//추천 가게가 아닌 검색했을 경우 검색어에 대한 결과 list 출력

	
	//인덱스 페이지부터 가게리스트를 받을예정 ( 홈컨트롤러에서 리스트 불러오기 필요 ) > 나중에 필요하다면 리스트에 관련된 컨트롤러 추가
	
	//기능시험용 리스트 페이지 이동(추후 삭제 예정)
	@RequestMapping("/shop/list")
	public String list(HttpServletRequest request) {
		service.getList(request);
		return "shop/list";
	}
	
	//글 작성폼 이동
	@GetMapping("/shop/insertform")
	public String insertform() {
		return "shop/insertform";
		//주소입력으로 관리자외의 사람이 글 작성하려고 할 경우 막기 위해 session 추가 필요
	}
	
	//글 작성
	@RequestMapping("/shop/insert")
	public String insert(ShopDto dto, HttpServletRequest request) {
		String imagePath = (String)request.getParameter("imagePath");
		dto.setImagePath(imagePath);
		service.saveContent(dto);
		return "shop/insert";
	}
	
	@RequestMapping("/index")
	public String index(HttpServletRequest request) {
		service.getList(request);
		return "index";
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
		service.getList(request);
		service.getDetail(request);
		service.menuGetList(request);
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
	
	//새로운 댓글 저장 요청 처리
	@RequestMapping("/shop/review_insert")
	public String reviewInsert(HttpServletRequest request, int ref_group) {
	      
		service.saveReview(request);
	   
		return "redirect:/shop/detail?num="+ref_group;
	}
	//댓글 더보기 요청 처리
	@RequestMapping("/shop/ajax_review_list")
	public String reviewList(HttpServletRequest request) {
	    
		//테스트를 위해 시간 지연시키기
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		service.moreReviewList(request);
	      
		return "shop/ajax_review_list";
	}
	//댓글 삭제 요청 처리
	@RequestMapping("/shop/review_delete")
	@ResponseBody
	public Map<String, Object> reviewDelete(HttpServletRequest request) {
		service.deleteReview(request);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("isSuccess", true);
		// {"isSuccess":true} 형식의 JSON 문자열이 응답되도록 한다. 
		return map;
	}
	//댓글 수정 요청처리 (JSON 을 응답하도록 한다)
	@RequestMapping("/shop/review_update")
	@ResponseBody
	public Map<String, Object> reviewUpdate(ShopReviewDto dto, HttpServletRequest request){
		service.updateReview(dto);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("isSuccess", true);
		// {"isSuccess":true} 형식의 JSON 문자열이 응답되도록 한다. 
		return map;

	}
	
	@RequestMapping("/shop/menulist")
	public String getList(HttpServletRequest request) {
		service.menuGetList(request);
		return "shop/menulist";
	}
	
	@RequestMapping("/shop/menu_insertform")
	public String menuinsertform() {
		return "shop/menu_insertform";
	}
	
	@GetMapping("/shop/menu_insert")
	public String menuinsert(ShopMenuDto dto, HttpServletRequest request) {
		dto.setNum(Integer.parseInt(request.getParameter("num")));
		service.saveMenu(dto, request);		
		return "shop/menu_insert";
	}

}
