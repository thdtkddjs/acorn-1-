package com.gura.acorn.shop.dao;

import java.util.List;

import com.gura.acorn.shop.dto.ShopMenuDto;

public interface ShopMenuDao {
	public List<ShopMenuDto> getList(int num);
	public int getCount(int num);
	public void insert(ShopMenuDto dto);
}
