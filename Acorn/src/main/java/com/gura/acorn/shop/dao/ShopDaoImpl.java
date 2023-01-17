package com.gura.acorn.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gura.acorn.shop.dto.ShopDto;
@Repository
public class ShopDaoImpl implements ShopDao{

	@Autowired private SqlSession session;
	
	@Override
	public List<ShopDto> getList(ShopDto dto) {
		return session.selectList("shop.getList", dto);
	}

	@Override
	public int getCount(ShopDto dto) {
		return session.selectOne("shop.getCount");
	}

	@Override
	public void insert(ShopDto dto) {
		session.insert("shop.insert",dto);
	}

	@Override
	public void delete(int num) {
		session.delete("shop.delete", num);
	}

	@Override
	public void update(ShopDto dto) {
		session.update("shop.update", dto);
	}

	@Override
	public ShopDto getData(int num) {
		return session.selectOne("shop.getData",num);
	}
	
	//검색정보
	@Override
	public ShopDto getData(ShopDto dto) {
		return session.selectOne("shop.getData2", dto);
	}
}
