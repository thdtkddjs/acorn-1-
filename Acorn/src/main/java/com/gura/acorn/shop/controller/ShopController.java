package com.gura.acorn.shop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gura.acorn.shop.service.ShopService;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gura.acorn.es.ElasticUtil;
import com.gura.acorn.exception.loginException;
import com.gura.acorn.shop.dto.ShopDto;
import com.gura.acorn.shop.dto.ShopMenuDto;
import com.gura.acorn.shop.dto.ShopReviewDto;

@Controller
public class ShopController {

	@Autowired
	private ShopService service;
	
	
	@RequestMapping("shop/review_list")
	public String reviewList(HttpServletRequest request) {
		service.getReviewList(request);
		return "shop/review_list";
	}
   
	@RequestMapping("shop/search")
	public String search(HttpServletRequest request) {
		service.getSearchList(request);
		service.getReviewList(request);
		return "shop/search";
	}

	
	//index 페이지에서 가게리스트 출력
	@RequestMapping("/")
	public String index(HttpServletRequest request, HttpSession session) {
		service.getTopList(request);
		//이 메소드가 실행될때 ES의 /gaia/_doc/1에 Map2의 정보가 전달되어 기록된다.
		//메소드가 실행될때마다 덮어써진다.
		//id나 index를 바꾸면서 기록할 필요가 있어보인다.
		//덮어쓰기 말고 추가되는 방식을 찾아봤지만 아직은 못찾았다.
		String index = "gaia";
		String id = "1";
		
		Map<String,Object> map2  = new HashMap<>();
		map2.put("web_adress", request.getRequestURL().toString());
		map2.put("id", session.getAttribute("id"));
		map2.put("date", LocalDate.now().toString()+" "+LocalTime.now().toString());
		System.out.println(map2);
		
		try {
			ElasticUtil.getInstance().create(index, id, map2);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "index";
	}
	
	@RequestMapping("/index")
	public String index2(HttpServletRequest request) {
		service.getTopList(request);
		return "index";
		
	}
	
	@RequestMapping("/shop/list")
	public String list(HttpServletRequest request) {
		service.getList(request);
		return "shop/list";
	}
	
	//글 작성폼 이동
	@GetMapping("/shop/insertform")
	public String insertform(HttpSession session) {
		String id = (String)session.getAttribute("id");
		if(id == null) {
			throw new loginException("needLogin");
		}else if(!id.equals("admin")) {
			throw new loginException("needAuthority");
		}
		return "shop/insertform";
	}
	
	//글 작성
	@RequestMapping("/shop/insert")
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
		service.test(request);  
		service.getDetail(request);
		service.menuGetList(request);
		return "shop/detail";
	}
	
	//가게 정보 업데이트 (가게정보 수정 기능 구현 후 사용)
	@GetMapping("/shop/updateform")
	public String updateform(HttpServletRequest request, HttpSession session) {
		String id = (String)session.getAttribute("id");
		if(id == null) {
			throw new loginException("needLogin");
		}else if(!id.equals("admin")) {
			throw new loginException("needAuthority");
		}
		service.getData(request);
		return "shop/updateform";
	}
	
	@GetMapping("/shop/update")
	public String update(ShopDto dto, HttpServletRequest request) {
		service.updateContent(dto, request);
		return "shop/update";
	}
	
	@GetMapping("/shop/delete")
	public String delete(int num, HttpServletRequest request, HttpSession session) {
		String id = (String)session.getAttribute("id");
		if(id == null) {
			throw new loginException("needLogin");
		}else if(!id.equals("admin")) {
			throw new loginException("needAuthority");
		}
		service.deleteContent(num, request);
		return "redirect:/";
	}
	
	//리뷰 작성
	@RequestMapping("/shop/review_insert")
	public String reviewInsert(HttpServletRequest request, int ref_group) {
		service.saveReview(request);
		return "redirect:/shop/detail?num="+ref_group;
	}
	
	//리뷰 삭제
	@RequestMapping("/shop/review_delete")
	@ResponseBody
	public Map<String, Object> reviewDelete(HttpServletRequest request) {
		service.deleteReview(request);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("isSuccess", true);
		return map;
	}
	
	//댓글 수정
	@RequestMapping("/shop/review_update")
	@ResponseBody
	public Map<String, Object> reviewUpdate(ShopReviewDto dto, HttpServletRequest request){
		service.updateReview(dto);
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("isSuccess", true);
		return map;
	}
	
	//리뷰 이미지 업로드
	@ResponseBody
	@RequestMapping(value = "/shop/review_image_upload", method = RequestMethod.POST)
	public Map<String, Object> reviewImageUpload(MultipartFile image, HttpServletRequest request) {
		return service.saveImagePath(request, image);
	}
	
	@RequestMapping("/shop/menulist")
	public String getList(HttpServletRequest request) {
		service.menuGetList(request);
		return "shop/menulist";
	}
	
	@RequestMapping("/shop/menu_insertform")
	public String menuinsertform(HttpSession session) {
		String id = (String)session.getAttribute("id");
		if(id == null) {
			throw new loginException("needLogin");
		}else if(!id.equals("admin")) {
			throw new loginException("needAuthority");
		}
		return "shop/menu_insertform";
	}
	
	@GetMapping("/shop/menu_insert")
	public String menuinsert(ShopMenuDto dto, HttpServletRequest request) {
		dto.setNum(Integer.parseInt(request.getParameter("num")));
		service.saveMenu(dto, request);		
		return "shop/menu_insert";
	}

	
	//테스트용 statistic 
	@RequestMapping("/statistics/example_1")
	public String ex1(HttpServletRequest request) {
		service.getDetail(request);
		service.menuGetList(request);
		return "statistics/example_1";
	}
}
