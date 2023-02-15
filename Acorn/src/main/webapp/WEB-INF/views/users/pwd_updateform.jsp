<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/users/pwd_updateform.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<link rel="stylesheet" type="text/css" href="../resources/css/index.css">
<style>
.container{
	width : 624px;
	height : 600px;
	border : 1px solid #CECECE;
	padding-top : 50px;
	margin-bottom:50px;
}
body::-webkit-scrollbar {
	width: 5px;
	height: 0px;
}
body::-webkit-scrollbar-thumb {
	background-color: #2f3542;
	border-radius: 10px;
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
	<jsp:include page="../../views/include/navbar.jsp">
		<jsp:param value="user05" name="thisPage"/>
	</jsp:include>
	<div data-bs-spy="scroll" data-bs-target="#simple-list-example" data-bs-offset="0" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
		<div id="simple-list-item-1" class="container">
			<br />

			<h1>CHANGE P/W</h1>
			<br> <br>
			<form action="${pageContext.request.contextPath}/users/pwd_update"
				method="post" id="myForm">
				<div>
					<label class="control-label" for="pwd">OLD P/W</label> <input
						class="form-control" type="password" name="pwd" id="pwd" />
				</div>
				<br />
				<div>
					<label class="control-label" for="newPwd">NEW P/W</label> <input
						class="form-control" type="password" name="newPwd" id="newPwd" />
					<div class="invalid-feedback">비밀번호를 확인 하세요</div>
				</div>
				<br />
				<div>
					<label class="control-label" for="newPwd2">NEW P/W CONFIRM</label>
					<input class="form-control" type="password" id="newPwd2" /> <small
						class="form-text" style="color: #dc3545; font-size: 12px;">특수문자와
						숫자를 포함한 8글자 이상의 비밀번호를 입력해주세요</small>
				</div>
				<br /> <br />
				<button type="submit" class="btn btn-outline-warning">CHANGE</button>
				<a href="${pageContext.request.contextPath}/users/info"
					class="btn btn-outline-danger">CANCEL</a>
			</form>
		</div>
	</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
<script>
	
	let isPwdValid=false;
	
	function checkNewPwd(){
		//먼저 2개의 클래스를 제거하고 
		document.querySelector("#newPwd").classList.remove("is-valid");
		document.querySelector("#newPwd").classList.remove("is-invalid");
		//입력한 두개의 비밀 번호를 읽어와서 
		const newPwd=document.querySelector("#newPwd").value;
		const newPwd2=document.querySelector("#newPwd2").value;
	
		//비밀번호를 검증할 정규 표현식 update
		const reg= /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
		//만일 정규표현식 검증을 통과 하지 못했다면
		if(!reg.test(newPwd)){
		document.querySelector("#newPwd").classList.add("is-invalid");
		isPwdValid=false;
		return; //함수를 여기서 끝내라 
		}
	
		//만일 비밀번호 입력란과 확인란이 다르다면
		if(newPwd != newPwd2){
		   document.querySelector("#newPwd").classList.add("is-invalid");
		   isPwdValid=false;
		}else{//같다면
		   document.querySelector("#newPwd").classList.add("is-valid");
		   document.querySelector("#newPwd2").classList.add("is-valid");
		   isPwdValid=true;
		}
	}
	
	document.querySelector("#newPwd").addEventListener("input", function(){
	checkNewPwd();
	});
	
	document.querySelector("#newPwd2").addEventListener("input", function(){
	checkNewPwd();
	});

   // 폼에 submit 이벤트가 일어났을때 실행할 함수를 등록하고 
   document.querySelector("#myForm").addEventListener("submit", function(e){
      let pwd1 = document.querySelector("#newPwd").value;
      let pwd2 = document.querySelector("#newPwd2").value;
      // 새 비밀번호와 비밀번호 확인이 일치하지 않으면 폼 전송을 막는다.
      if(pwd1 != pwd2){
         alert("비밀번호를 확인 하세요!");
         e.preventDefault(); // 폼 전송 막기 
      }
   });
</script>
</body>
</html>

