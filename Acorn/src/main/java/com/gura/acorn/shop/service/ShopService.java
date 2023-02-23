package com.gura.acorn.shop.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.gura.acorn.shop.dto.ShopDto;
import com.gura.acorn.shop.dto.ShopMenuDto;
import com.gura.acorn.shop.dto.ShopReviewDto;

public interface ShopService {
	//가게 리스트 얻어오기
	public void getList(HttpServletRequest request);
	//가게 상세정보(가게별 메뉴/가격/사진 테이블 추가 후 조인까지 생각)
	public void getDetail(HttpServletRequest request);
	//가게 등록(등록, 수정, 삭제 는 우선 관리자만 할 수 있도록?)
	public void saveContent(ShopDto dto);
	//가게 정보 수정
	public void updateContent(ShopDto dto, HttpServletRequest request);
	//가게 삭제
	public void deleteContent(int num, HttpServletRequest request);
	//가게 정보 수정 시 필요한 정보 불러오기
	public void getData(HttpServletRequest request); 
	//섬네일 저장하는 메소드
	public Map<String, Object> saveImagePath(HttpServletRequest request, MultipartFile mFile);
	
	public void countReview(int num); //리뷰 카운트 증가/감소 (리뷰를 삭제할경우 감소로)
	public void saveReview(HttpServletRequest request);//리뷰 저장
	public void deleteReview(HttpServletRequest request);//리뷰 삭제
	public void updateReview(ShopReviewDto dto); //리뷰수정
	
	public void saveMenu(ShopMenuDto dto, HttpServletRequest request);
	public void menuGetList(HttpServletRequest request);
	public void getReviewList(HttpServletRequest request);
	public void getSearchList(HttpServletRequest request);
	public void getTopList(HttpServletRequest request);
	public void test(HttpServletRequest request);
}
