package com.gura.acorn.shop.dao;

import java.util.List;

import com.gura.acorn.shop.dto.ShopDto;

public interface ShopDao {
	   //글목록
	   public List<ShopDto> getList(ShopDto dto);
	   public List<ShopDto> getTopList(ShopDto dto);
	   //글의 갯수
	   public int getCount(ShopDto dto);
	   //글 추가
	   public void insert(ShopDto dto);
	   //글 삭제
	   public void delete(int num);
	   //글 수정
	   public void update(ShopDto dto);
	   //글정보 얻어오기
	   public ShopDto getData(int num);
	   //키워드를 활용하여 글정보 얻어오기
	   public ShopDto getData(ShopDto dto);
	   // 글 조회수 증가시키기
	   public void addViewCount(int num);
}
