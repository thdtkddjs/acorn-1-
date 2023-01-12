package com.gura.acorn.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gura.acorn.shop.dto.ShopMenuDto;

@Repository
public class ShopMenuDaoImpl implements ShopMenuDao{
	
	@Autowired
	private SqlSession session;

	@Override
	public List<ShopMenuDto> getList(int num) {
		
		return session.selectList("shopMenu.getList", num);
	}

	@Override
	public int getCount(int num) {
		
		return session.selectOne("shopMenu.getCount",num);
	}

	@Override
	public void insert(ShopMenuDto dto) {
		session.insert("shopMenu.insert", dto);
	}

}
