package com.gura.acorn.shop.service;

import javax.servlet.http.HttpServletRequest;

import com.gura.acorn.shop.dto.ShopDto;

public interface ShopService {
	//가게 리스트 얻어오기
	public void getList(HttpServletRequest request);
	//가게 상세정보(가게별 메뉴/가격/사진 테이블 추가 후 조인까지 생각)
	public void getDetail(HttpServletRequest request);
	//가게 등록(등록, 수정, 삭제 는 우선 관리자만 할 수 있도록?)
	public void saveContent(ShopDto dto);
	//가게 정보 수정
	public void updateContent(ShopDto dto);
	//가게 삭제
	public void deleteContent(int num, HttpServletRequest request);
	//가게 정보 수정 시 필요한 정보 불러오기
	public void getData(HttpServletRequest request); 
	//좋아요 증가
	public void addLikeCount(int num);
	//좋아요 증가
	public void addDislikeCount(int num);
	
	
	/*
	 * 코멘트 기능 구현 후 활성화
	public void countReview(int num); //리뷰 카운트 증가/감소 (리뷰를 삭제할경우 감소로)
	public void saveComment(HttpServletRequest request);//댓글 저장
	public void deleteComment(HttpServletRequest request);//댓글 삭제
	public void updateComment(ShopCommentDto dto); 댓글 수정 코멘트 기능 구현 후 활성화
	public void moreCommentList(HttpServletRequest request);//댓글 더보기 기능
	*/
}
