package com.gura.acorn.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gura.acorn.shop.dto.ShopReviewDto;

@Repository
public class ShopReviewDaoImpl implements ShopReviewDao{

	@Autowired
	private SqlSession session;
	
	@Override
	public List<ShopReviewDto> getList(ShopReviewDto dto) {
		return session.selectList("shopReview.getList", dto);
	}

	@Override
	public void delete(int num) {
		session.update("shopReview.delete", num);
	}

	@Override
	public void insert(ShopReviewDto dto) {
		session.insert("shopReview.insert", dto);
	}

	@Override
	public int getSequence() {
		return session.selectOne("shopReview.getSequence");
	}

	@Override
	public void update(ShopReviewDto dto) {
		session.update("shopReview.update", dto);
	}

	@Override
	public ShopReviewDto getData(int num) {
		return session.selectOne("shopReview.getData", num);
	}

	@Override
	public int getCount(int ref_group) {
		return session.selectOne("shopReview.getCount", ref_group);
	}

	@Override
	public double getGrade(int ref_group) {
		return session.selectOne("shopReview.getGrade",ref_group);
	}
}
