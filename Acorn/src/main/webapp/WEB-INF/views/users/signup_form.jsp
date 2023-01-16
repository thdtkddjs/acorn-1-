<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup_form.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<style>
.container{
	width : 624px;
	height : 600px;
	box-shadow: 0px 5px 20px 0px grey;
	margin-top : 150px;
	border-radius : 20px;
	padding-top : 50px;
}
h1{
	text-align : center;
}
.submit_btn{
	width : 100px;
}
.form-control{
	width : 400px;
	margin-left:100px;
	
}
</style>
<body class="text-center">
	<div class="container">
		<a href="${pageContext.request.contextPath}/index" class="logo_text">
			<img class="logo" src="${pageContext.request.contextPath}/resources/images/1_acorn_logo.png" alt="" />
		</a>		
	    <h1>SIGN-UP</h1>
	    <form action="${pageContext.request.contextPath}/users/signup" method="post" id="myForm">
	      <div>
	         <label class="control-label" for="id">ID</label>

	         <input class="form-control" type="text" name="id" id="id"/>
	         <small class="form-text text-muted">영문자 소문자로 시작하고 5글자~10글자 이내로 입력하세요.</small>
             <div class="valid-feedback">사용가능한 아이디 입니다.</div>
             <div class="invalid-feedback">사용할 수 없는 아이디 입니다.</div>      
	      </div>
	      <div>
	         <label class="control-label" for="pwd">PASSWORD</label>
	         <input class="form-control" type="password" name="pwd" id="pwd"/>
	         <small class="form-text text-muted">특수 문자를 하나 이상 조합하세요.</small>
	         <div class="invalid-feedback">비밀번호를 확인 하세요</div>

	      </div>
	      <div>
	         <label class="control-label" for="pwd2">PASSWORD CONFIRM</label>
	         <input class="form-control" type="password" name="pwd2" id="pwd2"/>
	      </div>
	      <div>
	         <label class="control-label" for="email">E-MAIL</label>
	         <input class="form-control" type="text" name="email" id="email"/>
	         <div class="invalid-feedback">이메일 형식에 맞게 입력하세요.</div>
	      </div>
	      <button class="submit_btn btn btn-primary" type="submit">SIGN-UP</button>
	   </form>
	</div>   
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	
	//유효성 여부를 저장할 변수를 만들고 초기값 대입 
	let isIdValid=false;
	let isPwdValid=false;
	let isEmailValid=false;   
	
	$("#email").on("input", function(){
		 $(this).removeClass("is-valid is-invalid");
		 const inputEmail=$(this).val();
		 const reg=new RegExp("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$");
		
		 if(!reg.test(inputEmail)){
		     $(this).addClass("is-invalid");
		     isEmailValid=false;
		  }else{
		     $(this).addClass("is-valid");
		     isEmailValid=true;
		  }
	});
	
	function checkPwd(){
		//먼저 2개의 클래스를 제거하고 
		document.querySelector("#pwd").classList.remove("is-valid");
		document.querySelector("#pwd").classList.remove("is-invalid");
		//입력한 두개의 비밀 번호를 읽어와서 
		const pwd=document.querySelector("#pwd").value;
		const pwd2=document.querySelector("#pwd2").value;
	
		//비밀번호를 검증할 정규 표현식
		const reg = new RegExp("^[a-zA-Z\\d`~!@#$%^&*()-_=+]{8,24}$");
		//만일 정규표현식 검증을 통과 하지 못했다면
		if(!reg.test(pwd)){
		document.querySelector("#pwd").classList.add("is-invalid");
		isPwdValid=false;
		return; //함수를 여기서 끝내라 
		}
	
		//만일 비밀번호 입력란과 확인란이 다르다면
		if(pwd != pwd2){
		   document.querySelector("#pwd").classList.add("is-invalid");
		   isPwdValid=false;
		}else{//같다면
		   document.querySelector("#pwd").classList.add("is-valid");
		   isPwdValid=true;
		}
	}
	
	document.querySelector("#pwd").addEventListener("input", function(){
	checkPwd();
	});
	
	document.querySelector("#pwd2").addEventListener("input", function(){
	checkPwd();
	});
	
	// id 를 입력 할때 마다 호출되는 함수 등록 
    $("#id").on("input", function(){
       //input 요소의 참조 값을 self 에 미리 담아 놓기 
       const self = this;
       //일단 2개의 클래스를 모두 제거 한다음 
       
       $(self).removeClass("is-valid is-invalid")
       
       //1. 입력한 아이디를 읽어와서
       const inputId = $(self).val();
       const reg=new RegExp("^[a-z].{4,9}$");
       
     	//만일 정규표현식 검증을 통과 하지 못했다면
		if(!reg.test(inputId)){
			document.querySelector("#id").classList.add("is-invalid");
			isIdValid=false;
			return; //함수를 여기서 끝내라 
		}
       
       //2. 서버에 페이지 전환없이 전송을 하고 응답을 받는다.
       $.ajax({
      	 url:"${pageContext.request.contextPath}/users/checkid",
      	 data:{inputId},
  		 success:function(data){
            console.log(data);
            if(data.isExist){
               $(self).addClass("is-invalid");
               isIdValid = false;
            }else{
               $(self).addClass("is-valid");
               isIdValid = true;
            }
       	}
       });
    });
	
	
	$("#myForm").on("submit", function(){
	  const isFormValid = isIdValid && isPwdValid && isEmailValid;
	  if(!isFormValid){
	     return false;
	  }
	});

</script>
</body>
</html>