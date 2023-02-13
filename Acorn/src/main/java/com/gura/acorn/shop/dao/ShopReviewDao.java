package com.gura.acorn.shop.dao;

import java.util.List;

import com.gura.acorn.shop.dto.ShopReviewDto;

public interface ShopReviewDao {
	//리뷰 목록 얻어오기
	public List<ShopReviewDto> getList(ShopReviewDto dto);
	//리뷰 삭제
	public void delete(int num);
	//리뷰 추가
	public void insert(ShopReviewDto dto);
	//추가할 리뷰의 글번호를 리턴하는 메소드
	public int getSequence();
	//리뷰 수정
	public void update(ShopReviewDto dto);
	//리뷰 하나의 정보를 리턴하는 메소드
	public ShopReviewDto getData(int num);
	//리뷰의 갯수를 리턴하는 메소드
	public int getCount(int ref_group);
	//리뷰의 평점을 리턴하는 메소드
	public double getGrade(int ref_group);
	//
	public int getReviewCount(ShopReviewDto dto);
	//
	public List<ShopReviewDto> getReviewList(ShopReviewDto dto);
}
