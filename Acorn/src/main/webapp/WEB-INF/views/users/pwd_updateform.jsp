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
label{
	width : 150px;
	text-align:left;
}
input{
	border : 1px solid #000000;
	border-radius:5px;
}
</style>
<body class="text-center">
<div class="container">
		<a href="${pageContext.request.contextPath}/index" class="logo_text">
			<img class="logo" src="${pageContext.request.contextPath}/resources/images/1_acorn_logo.png" alt="" />
		</a>	
	   <h1>CHANGE P/W</h1>
	   <br>
	   <br>
	   <form action="${pageContext.request.contextPath}/users/pwd_update" method="post" id="myForm">
	      <div>
	         <label for="pwd">OLD P/W</label>
	         <input type="password" name="pwd" id="pwd"/>
	      </div>
	      <br />
	      <div>
	         <label for="newPwd">NEW P/W</label>
	         <input type="password" name="newPwd" id="newPwd"/>
	      </div>
	      <br />
	      <div>
	         <label for="newPwd2">NEW P/W CONFIRM</label>
	         <input type="password" id="newPwd2"/>
	      </div>
	      <br />
	      <br />
	      <br />
	      <button type="submit" class="btn btn-outline-warning">CHANGE</button>
	      <a href="${pageContext.request.contextPath}/users/info" class="btn btn-outline-danger">CANCEL</a>
	   </form>
</div>
<script>
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

