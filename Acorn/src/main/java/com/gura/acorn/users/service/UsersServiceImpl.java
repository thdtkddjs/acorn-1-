package com.gura.acorn.users.service;

import java.io.File;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gura.acorn.exception.BanException;
import com.gura.acorn.users.dao.UsersDao;
import com.gura.acorn.users.dto.UsersDto;

@Service
public class UsersServiceImpl implements UsersService{
	
	@Autowired
	private UsersDao dao;
	
	@Override
	public Map<String, Object> isExistId(String inputId) {
		boolean isExist=dao.isExist(inputId);
		Map<String, Object> map=new HashMap<>();
		map.put("isExist", isExist);
		return map;
	}
	//회원 한명의 정보를 추가하는 메소드
	@Override
	public void addUser(UsersDto dto) {
		//가입시 입력한 비밀번호를 읽어와서
		String pwd=dto.getPwd();
		//암호화 한후에 
		BCryptPasswordEncoder encoder=new BCryptPasswordEncoder();
		String encodedPwd=encoder.encode(pwd);
		//dto 에 다시 넣어준다.
		dto.setPwd(encodedPwd);
		//암호화된 비밀번호가 들어 있는 dto 를 dao 에 전달해서 새로운 회원 정보를 추가 한다.
		dao.insert(dto);
	}
	//로그인 처리를 하는 메소드
	@Override
	public void loginProcess(UsersDto dto, HttpSession session, HttpServletResponse response) {
		//입력한 정보가 맞는지 여부
		boolean isValid=false;
		//아이디를 이용해서 회원 정보를 얻어온다.
		UsersDto resultDto=dao.getData(dto.getId());
		
		
		//만일 select 된 회원 정보가 존재하고 
		if(resultDto != null) {
			//Bcrypt 클래스의 static 메소드를 이용해서 입력한 비밀번호와 암호화 해서 저장된 비밀번호 일치 여부를 알아내야한다.
			isValid = BCrypt.checkpw(dto.getPwd(), resultDto.getPwd());
		}else {
			throw new BanException("notExist");
		}
		
		if(resultDto.getBan() != null) { // 만일 getBan 에 담긴 값이 없다면? => 일반유저
			throw new BanException("banUser");
		}
		
		//만일 유효한 정보이면 
		if(isValid) {
			//로그인 처리를 한다.
			session.setAttribute("id", resultDto.getId());
		}
		// 로그인 정보를 저장하기로 했는지 확인해서 저장하기로 했다면 쿠키로 응답한다.
		String isSave = dto.getIsSave();
	      if(isSave == null){ // 체크 박스를 체크 안했다면
	          // 저장된 쿠키 삭제 
	          Cookie idCook = new Cookie("savedId", dto.getId());
	          idCook.setMaxAge(0); // 삭제하기 위해 0 으로 설정 
	          response.addCookie(idCook);

	          Cookie pwdCook = new Cookie("savedPwd", dto.getPwd());
	          pwdCook.setMaxAge(0);
	          response.addCookie(pwdCook);
	       }else{ // 체크 박스를 체크 했다면 
	          // 아이디와 비밀번호를 쿠키에 저장
	          Cookie idCook = new Cookie("savedId", dto.getId());
	          idCook.setMaxAge(60*60*24); // 하루동안 유지 (일주일로 설정을 하고싶다면 *7 을 추가하면 된다)
	          response.addCookie(idCook);

	          Cookie pwdCook = new Cookie("savedPwd", dto.getPwd());
	          pwdCook.setMaxAge(60*60*24);
	          response.addCookie(pwdCook);
	       }
	}

	@Override
	public void getInfo(HttpSession session, ModelAndView mView) {
		//로그인된 아이디를 읽어온다. 
		String id=(String)session.getAttribute("id");
		//DB 에서 회원 정보를 얻어와서 
		UsersDto dto=dao.getData(id);
		//ModelAndView 객체에 담아준다.
		mView.addObject("dto", dto);
	}

	@Override
	public void updateUserPwd(HttpSession session, UsersDto dto, ModelAndView mView) {
		//세션 영역에서 로그인된 아이디 읽어오기
		String id=(String)session.getAttribute("id");
		//DB 에 저장된 회원정보 얻어오기
		UsersDto resultDto=dao.getData(id);
		//DB 에 저장된 암호화된 비밀 번호
		String encodedPwd=resultDto.getPwd();
		//클라이언트가 입력한 비밀번호
		String inputPwd=dto.getPwd();
		//두 비밀번호가 일치하는지 확인
		boolean isValid=BCrypt.checkpw(inputPwd, encodedPwd);
		//만일 일치 한다면
		if(isValid) {
			//새로운 비밀번호를 암호화 한다.
			BCryptPasswordEncoder encoder=new BCryptPasswordEncoder();
			String encodedNewPwd=encoder.encode(dto.getNewPwd());
			//암호화된 비밀번호를 dto 에 다시 넣어준다.
			dto.setNewPwd(encodedNewPwd);
			//dto 에 로그인된 아이디도 넣어준다.
			dto.setId(id);
			//dao 를 이용해서 DB 에 수정 반영한다.
			dao.updatePwd(dto);
			//로그아웃 처리
			session.removeAttribute("id");
		}
		//작업의 성공여부를 ModelAndView 객체에 담아 놓는다(결국 HttpServletRequest 에 담긴다)
		mView.addObject("isSuccess", isValid);
		//로그인된 아이디도 담아준다.
		mView.addObject("id", id);		
	}

	@Override
	public Map<String, Object> saveProfileImage(HttpServletRequest request, MultipartFile mFile) {
		//업로드된 파일에 대한 정보를 MultipartFile 객체를 이용해서 얻어낼수 있다.	
		
		//원본 파일명
		String orgFileName=mFile.getOriginalFilename();
		//upload 폴더에 저장할 파일명을 직접구성한다.
		// 1234123424343xxx.jpg
		String saveFileName=System.currentTimeMillis()+orgFileName;
		
		// webapp/upload 폴더까지의 실제 경로 얻어내기 
		String realPath=request.getServletContext().getRealPath("/resources/upload");
		// upload 폴더가 존재하지 않을경우 만들기 위한 File 객체 생성
		File upload=new File(realPath);
		if(!upload.exists()) {//만일 존재 하지 않으면
			upload.mkdir(); //만들어준다.
		}
		try {
			//파일을 저장할 전체 경로를 구성한다.  
			String savePath=realPath+File.separator+saveFileName;
			//임시폴더에 업로드된 파일을 원하는 파일을 저장할 경로에 전송한다.
			mFile.transferTo(new File(savePath));
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		// json 문자열을 출력하기 위한 Map 객체 생성하고 정보 담기 
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("imagePath", "/resources/upload/"+saveFileName);
		
		return map;
	}

	@Override
	public void updateUser(UsersDto dto, HttpSession session) {
		//수정할 회원의 아이디
		String id=(String)session.getAttribute("id");
		//dto 에 id 도 넣어준다. 
		dto.setId(id);
		//만일 프로필 이미지를 등록하지 않은 상태이면
		if(dto.getProfile().equals("empty")) {
			//users 테이블의  profile 칼럼을 null 인 상태로 유지하기 위해 profile 에 null 을 넣어준다.
			dto.setProfile(null);
		}
		dao.update(dto);
	}

	@Override
	public void deleteUser(HttpSession session, ModelAndView mView) {
		//로그인된 아이디를 얻어와서 
		String id=(String)session.getAttribute("id");
		//해당 정보를 DB 에서 삭제하고
		dao.delete(id);
		//로그아웃 처리도 한다.
		session.removeAttribute("id");
		//ModelAndView 객체에 탈퇴한 회원의 아이디를 담아준다.
		mView.addObject("id", id);
		
	}
	@Override
	public void getList(HttpServletRequest request) {
		// 한 페이지에 몇개씩 표시할 것인지
		   final int PAGE_ROW_COUNT=5;
		   // 하단 페이지를 몇개씩 표시할 것인지
		   final int PAGE_DISPLAY_COUNT=5;

		   // 보여줄 페이지의 번호를 일단 1이라고 초기값 지정
		   int pageNum=1;

		   // 페이지 번호가 파라미터로 전달되는지 읽어와 본다.
		   String strPageNum=request.getParameter("pageNum");
		   // 만일 페이지 번호가 파라미터로 넘어 온다면
		   if(strPageNum != null){
		      // 숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
		      pageNum=Integer.parseInt(strPageNum);
		   }   
		   
		   // 보여줄 페이지의 시작 ROWNUM
		   int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		   // 보여줄 페이지의 끝 ROWNUM
		   int endRowNum=pageNum*PAGE_ROW_COUNT;
		   
		   
		   
	   	  /*
	         [ 검색 키워드에 관련된 처리 ]
	         - 검색 키워드가 파라미터로 넘어올수도 있고 안넘어 올수도 있다.      
	   	  */
	      String keyword=request.getParameter("keyword");
	      String condition=request.getParameter("condition");
	      // 만일 키워드가 넘어오지 않는다면 
	      if(keyword==null){
	         // 키워드와 검색 조건에 빈 문자열을 넣어준다. 
	         // 클라이언트 웹브라우저에 출력할때 "null" 을 출력되지 않게 하기 위해서  
	         keyword="";
	         condition=""; 
	      }

	      // 특수기호를 인코딩한 키워드를 미리 준비한다. 
	      String encodedK=URLEncoder.encode(keyword);
	         
	      // CafeDto 객체에 startRowNum 과 endRowNum 을 담는다.
	      UsersDto dto=new UsersDto();
	      dto.setStartRowNum(startRowNum);
	      dto.setEndRowNum(endRowNum);

	      // 만일 검색 키워드가 넘어온다면 
	      if(!keyword.equals("")){
	         // 검색 조건에 따라 분기 하기
	         if(condition.equals("id")){// 제목 + 내용 검색인 경우
	            dto.setId(keyword);
	         }
	      }
		   // 글 목록을 select 해 온다. 
		   List<UsersDto> list = dao.getList(dto);
		   		   
		   // 전체 글의 갯수(검색 키워드가 있는 경우 키워드에 부합하는 전체 글)
		   int totalRow = dao.getCount(dto);
		   
		   // 하단 시작 페이지 번호 
		   int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		   // 하단 끝 페이지 번호
		   int endPageNum = startPageNum+PAGE_DISPLAY_COUNT-1;
		   
		   // 전체 페이지의 갯수 구하기
		   int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		   // 끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
		   if(endPageNum > totalPageCount){
		      endPageNum = totalPageCount; //보정해 준다. 
		   }
		   
		   // 응답에 필요한 데이터를 viewPage 에 전달하기 위해 request Scope 에 담는다.
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
	public void getData(HttpServletRequest request) {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void banUser(HttpServletRequest request) {
		//수정할 회원의 아이디
		String id=(String)request.getParameter("id");
		System.out.println(id);
		dao.ban(id);
	}
}
