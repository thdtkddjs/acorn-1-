package com.gura.acorn.shop.service;

import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gura.acorn.shop.dao.ShopDao;
import com.gura.acorn.shop.dto.ShopDto;

@Service
public class ShopServiceImpl implements ShopService{
	
	@Autowired
	private ShopDao shopDao;
	
	@Override
	public void getList(HttpServletRequest request) {
		final int PAGE_ROW_COUNT = 5;
		final int PAGE_DISPLAY_COUNT = 5;

		int pageNum = 1;
		String strPageNum = request.getParameter("pageNum");
		if (strPageNum != null) {
			pageNum = Integer.parseInt(strPageNum);
		}

		int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;
		int endRowNum = pageNum * PAGE_ROW_COUNT;


		ShopDto dto = new ShopDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		
		List<ShopDto> list = shopDao.getList(dto);
		int totalRow = shopDao.getCount(dto);

		int startPageNum = 1 + ((pageNum - 1) / PAGE_DISPLAY_COUNT) * PAGE_DISPLAY_COUNT;
		int endPageNum = startPageNum + PAGE_DISPLAY_COUNT - 1;

		int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);
		if (endPageNum > totalPageCount) {
			endPageNum = totalPageCount;
		}
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("list", list);
		request.setAttribute("totalRow", totalRow);		
	}

	@Override
	public void getDetail(HttpServletRequest request) {
/*		int num = Integer.parseInt(request.getParameter("num"));

		ShopDto dto = new ShopDto();
		dto.setNum(num);

		ShopDto resultDto = shopDao.getData(dto);

		final int PAGE_ROW_COUNT = 10;

		int pageNum = 1;

		int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;
		int endRowNum = pageNum * PAGE_ROW_COUNT;

		ShopCommentDto commentDto = new ShopCommentDto();
		commentDto.setRef_group(num);
		commentDto.setStartRowNum(startRowNum);
		commentDto.setEndRowNum(endRowNum);

		List<ShopCommentDto> commentList = shopCommentDto.getList(commentDto);

		int totalRow = shopCommentDto.getCount(num);
		int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

		request.setAttribute("dto", resultDto);
		request.setAttribute("totalRow", totalRow);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("commentList", commentList);
*/
	}

	@Override
	public void saveContent(ShopDto dto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateContent(ShopDto dto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteContent(int num, HttpServletRequest request) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void getData(HttpServletRequest request) {
		int num = Integer.parseInt(request.getParameter("num"));
		ShopDto dto = shopDao.getData(num);
		request.setAttribute("dto",dto);
		
	}

	@Override
	public void addLikeCount(int num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addDislikeCount(int num) {
		// TODO Auto-generated method stub
		
	}

}
