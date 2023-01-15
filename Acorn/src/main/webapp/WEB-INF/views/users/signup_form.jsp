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
	      </div>
	      <div>
	         <label class="control-label" for="pwd">PASSWORD</label>
	         <input class="form-control" type="password" name="pwd" id="pwd"/>   
	      </div>
	      <div>
	         <label class="control-label" for="pwd2">PASSWORD CONFIRM</label>
	         <input class="form-control" type="password" name="pwd2" id="pwd2"/>
	      </div>
	      <div>
	         <label class="control-label" for="email">E-MAIL</label>
	         <input class="form-control" type="text" name="email" id="email"/>
	      </div>
	      <button class="submit_btn btn btn-primary" type="submit">SIGN-UP</button>
	   </form>
</div>  
<script
  src="https://code.jquery.com/jquery-3.6.3.js"
  integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
  crossorigin="anonymous"></script> 
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
	
    
    $("#myForm").on("submit", function(){
    	const isFormValid = isPwdValid && isEmailValid;
        if(!isFormValid){
           return false;
        }
        
     });
</script>
</body>
</html>