package com.gura.acorn.shop.service;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.gura.acorn.shop.dao.ShopDao;
import com.gura.acorn.shop.dao.ShopReviewDao;
import com.gura.acorn.shop.dto.ShopDto;
import com.gura.acorn.shop.dto.ShopReviewDto;

@Service
public class ShopServiceImpl implements ShopService{

	@Autowired
	private ShopDao shopDao;
	@Autowired
	private ShopReviewDao shopReviewDao;
	
	@Override
	public void getList(HttpServletRequest request) {
		// 한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT = 5;
		// 하단 페이지를 몇개씩 표시할 것인지 (css에 따라 삭제 및 변경 있을 수 있음)
		final int PAGE_DISPLAY_COUNT = 5;

		// 보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		int pageNum = 1;

		// 페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		String strPageNum = request.getParameter("pageNum");
		// 만일 페이지 번호가 파라미터로 넘어 온다면
		if (strPageNum != null) {
			// 숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
			pageNum = Integer.parseInt(strPageNum);
		}

		// 보여줄 페이지의 시작 ROWNUM
		int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;
		// 보여줄 페이지의 끝 ROWNUM
		int endRowNum = pageNum * PAGE_ROW_COUNT;

		/*
	        [ 검색 키워드에 관련된 처리 ]
	        -검색 키워드가 파라미터로 넘어올수도 있고 안넘어 올수도 있다.    
	        현재는 가게이름, 카테고리 (추후 검색기능 확대시 mapper 수정)  
		*/
		String keyword = request.getParameter("keyword");
		String condition = request.getParameter("condition");
		//만일 키워드가 넘어오지 않는다면 
		if(keyword == null){
			//키워드와 검색 조건에 빈 문자열을 넣어준다. 
			//클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  
			keyword="";
			condition=""; 
		}
		
		//특수기호를 인코딩한 키워드를 미리 준비한다. 
		String encodedK = URLEncoder.encode(keyword);
		    
		//CafeDto 객체에 startRowNum 과 endRowNum 을 담는다.
		ShopDto dto = new ShopDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		//만일 검색 키워드가 넘어온다면 
		if(!keyword.equals("")){
				dto.setTitle(keyword);
		}
		
		// 목록을 select 해 온다.(검색 키워드가 있는경우 키워드에 부합하는 전체 글)
		List<ShopDto> list = shopDao.getList(dto);
		// 전체 글의 갯수(검색 키워드가 있는경우 키워드에 부합하는 전체 글의 개수)
		int totalRow = shopDao.getCount(dto);
		// 하단 시작 페이지 번호
		int startPageNum = 1 + ((pageNum - 1) / PAGE_DISPLAY_COUNT) * PAGE_DISPLAY_COUNT;
		// 하단 끝 페이지 번호
		int endPageNum = startPageNum + PAGE_DISPLAY_COUNT - 1;
		// 전체 페이지의 갯수 구하기
		int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);
		// 끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		if (endPageNum > totalPageCount) {
			endPageNum = totalPageCount; // 보정해 준다.
		}
		
		// view page에 전달하기 위해 request scope에 담기
		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("keyword", keyword);
		request.setAttribute("encodedK", encodedK);
		request.setAttribute("totalRow", totalRow);
		request.setAttribute("condition", condition);

	}

	@Override
	public void getDetail(HttpServletRequest request) {

		//보여줄 글 번호를 읽어오기
		int num = Integer.parseInt(request.getParameter("num"));
		
		String keyword = request.getParameter("keyword");
		String condition = request.getParameter("condition");
		//만일 키워드가 넘어오지 않는다면 
		if(keyword == null){
			//키워드와 검색 조건에 빈 문자열을 넣어준다. 
			//클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  
			keyword = "";
			condition = ""; 
		}
		
		String encodedK = URLEncoder.encode(keyword);
		
		ShopDto dto = new ShopDto();
		dto.setNum(num);
		//만일 검색 키워드가 넘어온다면 
		if(!keyword.equals("")){
			dto.setTitle(keyword);
		}
		//글 정보 얻기
		ShopDto resultDto = shopDao.getData(dto);
		
		//[ 리뷰 페이징 처리에 관련된 로직 ]
		
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT=10;

		//detail.jsp 페이지에서는 항상 1페이지의 댓글 내용만 출력한다. 
		int pageNum = 1;

		//보여줄 페이지의 시작 ROWNUM
		int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;
		//보여줄 페이지의 끝 ROWNUM
		int endRowNum = pageNum * PAGE_ROW_COUNT;

		//원글의 글번호를 이용해서 해당글에 달린 댓글 목록을 얻어온다.
		ShopReviewDto reviewDto = new ShopReviewDto();
		reviewDto.setRef_group(num);
		//1페이지에 해당하는 startRowNum 과 endRowNum 을 dto 에 담아서  
		reviewDto.setStartRowNum(startRowNum);
		reviewDto.setEndRowNum(endRowNum);

		//1페이지에 해당하는 댓글 목록만 select 되도록 한다.
		List<ShopReviewDto> commentList = shopReviewDao.getList(reviewDto);

		//원글의 글번호를 이용해서 댓글 전체의 갯수를 얻어낸다.
		int totalRow = shopReviewDao.getCount(num);
		//댓글 전체 페이지의 갯수
		int totalPageCount = (int)Math.ceil(totalRow / (double)PAGE_ROW_COUNT);
		
		//request에 담기
		request.setAttribute("dto", resultDto);
		request.setAttribute("keyword", keyword);
		request.setAttribute("encodedK", encodedK);
		request.setAttribute("condition", condition);
		request.setAttribute("totalRow", totalRow);
		request.setAttribute("commentList", commentList);
		request.setAttribute("totalPageCount", totalPageCount);
		
	}

	@Override
	public void saveContent(ShopDto dto) {
		shopDao.insert(dto);
    
		/*
		 * 아래의 등록, 수정, 삭제의 경우
		 * 가게리스트 페이지에서 관리자계정으로 로그인 시에만
		 * 글 작성 버튼이 보이도록 뷰페이지에서 관리 필요
		 * 나중에 유저들끼리 가게추천하는 게시판을 만들경우 수정도 필요
		 */
	}

	@Override
	public void updateContent(ShopDto dto, HttpServletRequest request) {
		dto.setNum(Integer.parseInt(request.getParameter("num")));
		shopDao.update(dto);	
	}

	@Override
	public void deleteContent(int num, HttpServletRequest request) {
		shopDao.delete(num);
	}

	@Override
	public void getData(HttpServletRequest request) {
		int num = Integer.parseInt(request.getParameter("num"));
		ShopDto dto = shopDao.getData(num);
		request.setAttribute("dto", dto);
	}

	@Override
	public void addLikeCount(int num) {
		shopDao.addLikeCount(num);
		//나중에 별도의 테이블 추가 후 좋아요/싫어요를 이미 누른 글에서는 다시 못누르도록하는 기능 구현 필요
	}

	@Override
	public void addDislikeCount(int num) {
		shopDao.addDislikeCount(num);
	}

	@Override
	public Map<String, Object> saveImagePath(HttpServletRequest request, MultipartFile mFile) {
		// 원본 파일명
		String orgFileName = mFile.getOriginalFilename();
		// 저장할 파일명을 직접구성
		String saveFileName = System.currentTimeMillis() + orgFileName;
	
		// 필요하다면 fileLocation 이용하여 다른곳에 저장
		String realPath = request.getServletContext().getRealPath("/resources/upload");
		// upload 폴더가 존재하지 않을경우 만들기 위한 File 객체 생성
		File upload = new File(realPath);
		if (!upload.exists()) {// 만일 존재 하지 않으면
			upload.mkdir(); // 만들어준다.
		}
		try {
			// 파일을 저장할 전체 경로를 구성한다.
			String savePath = realPath + File.separator + saveFileName;
			// 임시폴더에 업로드된 파일을 원하는 파일을 저장할 경로에 전송한다.
			mFile.transferTo(new File(savePath));
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		// json 문자열을 출력하기 위한 Map 객체 생성하고 정보 담기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("imagePath", "/resources/upload/" + saveFileName);
		
		return map;
	}

	@Override
	public void countReview(int num) {
		// 가게별 리뷰개수 구하는 dao 추가 후 코드 작성
	}

	@Override
	public void saveReview(HttpServletRequest request) {
		//폼 전송되는 파라미터 추출 
		int ref_group = Integer.parseInt(request.getParameter("ref_group"));//원글의 글번호
		String target_id = request.getParameter("target_id"); //댓글 대상자의 아이디
		String content = request.getParameter("content"); //댓글의 내용

		String review_group = request.getParameter("review_group");

		//댓글 작성자는 session 영역에서 얻어내기
		String writer = (String)request.getSession().getAttribute("id");
		//댓글의 시퀀스 번호 미리 얻어내기
		int seq = shopReviewDao.getSequence();
		//저장할 댓글의 정보를 dto 에 담기
		ShopReviewDto dto = new ShopReviewDto();
		dto.setNum(seq);
		dto.setWriter(writer);
		dto.setTarget_id(target_id);
		dto.setContent(content);
		dto.setRef_group(ref_group);
		//원글의 댓글인경우
		if(review_group == null){
			//댓글의 글번호를 comment_group 번호로 사용한다.
			dto.setReview_group(seq);
		}else{
			//전송된 comment_group 번호를 숫자로 바꾸서 dto 에 넣어준다. 
			dto.setReview_group(Integer.parseInt(review_group));
		}
		//댓글 정보를 DB 에 저장하기
		shopReviewDao.insert(dto);
	}

	@Override
	public void deleteReview(HttpServletRequest request) {
		int num = Integer.parseInt(request.getParameter("num"));
		//삭제할 댓글 정보를 읽어와서 
		ShopReviewDto dto = shopReviewDao.getData(num);
		String id = (String)request.getSession().getAttribute("id");
		
		/*글 작성자와 로그인된 아이디와 일치하지 않으면 처리를 막기 위한 익셉션코드 추후 활성화 예정
		if(!dto.getWriter().equals(id)) {
			throw new NotDeleteException("관리자만 삭제 가능합니다.");
		}
	    
	    */
		shopReviewDao.delete(num);
	}

	@Override
	public void updateReview(ShopReviewDto dto) {
		shopReviewDao.update(dto);
	}

	@Override
	public void moreReviewList(HttpServletRequest request) {
		//로그인된 아이디
		String id = (String)request.getSession().getAttribute("id");
		//ajax 요청 파라미터로 넘어오는 댓글의 페이지 번호를 읽어낸다
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		//ajax 요청 파라미터로 넘어오는 원글의 글 번호를 읽어낸다
		int num = Integer.parseInt(request.getParameter("num"));
		/*
	         [ 댓글 페이징 처리에 관련된 로직 ]
		 */
		//한 페이지에 몇개씩 표시할 것인지
		final int PAGE_ROW_COUNT = 10;

		//보여줄 페이지의 시작 ROWNUM
		int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;
		//보여줄 페이지의 끝 ROWNUM
		int endRowNum = pageNum * PAGE_ROW_COUNT;

		//원글의 글번호를 이용해서 해당글에 달린 댓글 목록을 얻어온다.
		ShopReviewDto reviewDto = new ShopReviewDto();
		reviewDto.setRef_group(num);
		//1페이지에 해당하는 startRowNum 과 endRowNum 을 dto 에 담아서  
		reviewDto.setStartRowNum(startRowNum);
		reviewDto.setEndRowNum(endRowNum);

		//pageNum에 해당하는 댓글 목록만 select 되도록 한다. 
		List<ShopReviewDto> reviewList = shopReviewDao.getList(reviewDto);
		//원글의 글번호를 이용해서 댓글 전체의 갯수를 얻어낸다.
		int totalRow = shopReviewDao.getCount(num);
		//댓글 전체 페이지의 갯수
		int totalPageCount = (int)Math.ceil(totalRow / (double)PAGE_ROW_COUNT);

		//view page 에 필요한 값 request 에 담아주기
		request.setAttribute("reviewList", reviewList);
		request.setAttribute("num", num); //원글의 글번호
		request.setAttribute("pageNum", pageNum); //댓글의 페이지 번호
	}

	//리뷰 기능 구현 후 리뷰관련 함수 추가 필요
}