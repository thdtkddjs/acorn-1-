<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>views/users/updateform.jsp</title>
<style>
   /* 이미지 업로드 폼을 숨긴다 */
   #imageForm{
      display: none;
   }
   #profileImage{
      width: 100px;
      height: 100px;
      border: 1px solid #cecece;
      border-radius: 50%;
   }
</style>
</head>
<body>
   <div class="container">
      <h3>회원 가입 수정 폼 입니다.</h3>
      
      <a id="profileLink" href="javascript:">
      		<c:choose> 
      			<c:when test="${ empty dto.profile }"> <!-- requestScope.dto.getProfile() == null  -->
		            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
		              <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
		              <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
		            </svg>
      			</c:when>
      			<c:otherwise>
		            <img id="profileImage" src="${pageContext.request.contextPath }${dto.profile}">
      			</c:otherwise>
      		</c:choose>
      </a>
      <form id="myform" action="${pageContext.request.contextPath}/users/update" method="post">
         <input type="hidden" name="profile" 
            value="${ empty dto.profile ? 'empty' : dto.profile }"/>
         <div>
            <label for="id">아이디</label>
            <input type="text" id="id" value="${dto.id }" disabled/>
         </div>
         <div>
            <label for="email">이메일</label>
            <input type="text" id="email" name="email" value="${dto.email }"/>
         </div>
         <button type="submit">수정</button>
         <button type="reset">취소</button>
      </form>   
      
      <form id="imageForm" action="${pageContext.request.contextPath}/users/profile_upload" method="post" enctype="multipart/form-data">
         프로필 사진
         <input type="file" id="image" name="image" accept=".jpg, .png, .gif"/>
         <button type="submit">업로드</button>
      </form>
               
   </div>
   <!-- gura_util.js 로딩 -->
   <script src="${pageContext.request.contextPath }/resources/js/gura_util.js"></script>
	<script>
      //프로필 이미지 링크를 클릭하면 
      document.querySelector("#profileLink").addEventListener("click", function(){
         // input type="file" 을 강제 클릭 시킨다. 
         document.querySelector("#image").click();
      });   
      
      //프로필 이미지를 선택하면(바뀌면) 실행할 함수 등록
      document.querySelector("#image").addEventListener("change", function(){
         //ajax 전송할 폼의 참조값 얻어오기
         const form=document.querySelector("#imageForm");
         //gura_util.js 에 있는 함수를 이용해서 ajax 전송하기 
         ajaxFormPromise(form)
         .then(function(response){
            return response.json();
         })
         .then(function(data){
            console.log(data);
            // input name="profile" 요소의 value 값으로 이미지 경로 넣어주기
            document.querySelector("input[name=profile]").value=data.imagePath;
            
            // img 요소를 문자열로 작성한 다음 
            let img= `<img id="profileImage" 
               src="${pageContext.request.contextPath }\${data.imagePath}">`;
            //id 가 profileLink 인 요소의 내부(자식요소)에 덮어쓰기 하면서 html 형식으로 해석해 주세요 라는 의미 
            document.querySelector("#profileLink").innerHTML=img;
         });
         </script>
         
         <script src="https://code.jquery.com/jquery-3.6.3.js" 
         integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous"></script> 
   <script>

   let isPwdValid=false;
	let isEmailValid=false;	

		// id 가 email 인 요소에 input 이벤트가 일어 났을때 실행할 함수 등록
		$("#email").on("input", function(){	
		//두개의 클래스 제거하기
		$(this).removeClass("is-valid is-invalid");
		
		//입력한 이메일
		const inputEmail=$(this).val();
		//이메일을 검증할 정규 표현식  
		const reg=/@/;
		//만일 입력한 이메일이 정규표현식 검증을 통과 하지 못했다면
		if(!reg.test(inputEmail)){
			$(this).addClass("is-invalid");
			isEmailValid=false;
		}else{//통과 했다면 
			$(this).addClass("is-valid");
			isEmailValid=true;
		}
	});	

	function checkPwd(){
		//먼저 2개의 클래스를 제거하고 
		$("#pwd").removeClass("is-valid is-invalid");
		
		//입력한 두개의 비밀 번호를 읽어와서 
		const pwd=$("#pwd").val();
		const pwd2=$("#pwd2").val();
		
		//만일 비밀번호 입력란과 확인란이 다르다면
		if(pwd != pwd2){
			$("#pwd").addClass("is-invalid");
			isPwdValid=false;
		}else{//같다면
			$("#pwd").addClass("is-valid");
			isPwdValid=true;
		}
	}
	
	// #pwd 와 #pwd2 를 모두 선택해서 이벤트 리스너 함수 등록
	$("#pwd, #pwd2").on("input", function(){
		checkPwd();
	});
	
   
   $("#myform").on("submit", function(){
   	const isFormValid = isPwdValid && isEmailValid;
       if(!isFormValid){
          return false;
       }
       
    });
</script>
</body>
</html>