package com.gura.acorn.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
/*
 * 안드로이드의 요청을 처리할 컨트롤러
 */

@Controller
public class AndroidController {
	/*
	 * JSON 문자열 응답하기
	 * 
	 * 1. ResponseBody 어노테이션
	 * 2. Map, List, Dto를 리턴하면 자동으로 JSON 문자열으로 변환되어서 응답한다.
	 */
	@PostMapping("/api/send")
	@ResponseBody
	public Map<String, Object> send(String msg){
		System.out.println(msg);
		Map<String, Object> map=new HashMap<>();
		map.put("isSuccess", true);
		map.put("response","hello client!");
		map.put("num", 1);
		return map;
	}
	
	@RequestMapping("/api/list")
	@ResponseBody
	public List<String> list(){
		List<String> list=new ArrayList<>();
		list.add("김구라");
		list.add("해골");
		list.add("원숭이");
		return list;
				
	}
   @RequestMapping("/api/logincheck")
   @ResponseBody
   public Map<String, Object> logincheck(HttpSession session){
	   //테스트용도
      System.out.println("세션 아이디:"+session.getId());
      Map<String, Object> map=new HashMap<>();
      //세션 영역에 id라는 키값으로 저장된 값이 있는지 확인
      String id=(String)session.getAttribute("id");
      //로그인 여부에 따라 map의 isLogin과 id에 정보를 담기
      if(id == null) {
         map.put("isLogin", false);
         System.out.println("로그인중이 아님요");
      }else {
         map.put("isLogin", true);
         map.put("id", id);
         System.out.println(id+" 로그인중...");
      }
      return map;
   }
   @RequestMapping("/api/login")
   @ResponseBody
   public Map<String, Object> login(String id, String pwd, HttpSession session){
      
      System.out.println(id+"|"+pwd);
      Map<String, Object> map=new HashMap<>();
      if(id.equals("gura") && pwd.equals("1234")) {
         map.put("isSuccess", true);
         map.put("id", id);
         session.setAttribute("id", id);
      }else {
         map.put("isSuccess", false);
      }
      return map;
   }
   @RequestMapping("/api/logout")
   @ResponseBody
   public Map<String, Object> logout(HttpSession session){
      session.invalidate();
      Map<String, Object> map=new HashMap<>();
      map.put("isSuccess", true);
      return map;
   }
}
