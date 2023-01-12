<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/users/info.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<style>
/* 프로필 이미지를 작은 원형으로 만든다 */
#profileImage {
	width: 50px;
	height: 50px;
	border: 1px solid #cecece;
	border-radius: 50%;
}

.container {
	width: 624px;
	height: 600px;
	box-shadow: 0px 5px 20px 0px grey;
	margin-top: 150px;
	border-radius: 20px;
	padding-top: 50px;
}

h1 {
	text-align: center;
}

.submit_btn {
	width: 100px;
}
table{
	width : 300px;
	margin-left: 150px;
}
tr{
	height : 30px;
	
}
th{
	border-right : 1px solid black;
	text-align : left;
	height : 30px;
}
a{
	text-decoration:none;
}
</style>
</head>
<body class="text-center">
	<div class="container">
		<a href="${pageContext.request.contextPath}/index" class="logo_text">
			<img class="logo" src="${pageContext.request.contextPath}/resources/images/1_acorn_logo.png" alt="" />
		</a>
	   <h1>INFO</h1>
	   <br>
	   <table>
	      <tr>
	         <th>ID</th>
	         <td>${id }</td>
	      </tr>
	      <tr style="height:10px;"></tr>
	      <tr>
	         <th>PROFILE</th>
	         <td>
	         <c:choose>
	            <c:when test="${empty dto.profile }">
	               <svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
	                 <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
	                 <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
	               </svg>
	            </c:when>
	            <c:otherwise>
	               <img id="profileImage" 
	                  src="${pageContext.request.contextPath}${dto.profile}"/>
	            </c:otherwise>
	         </c:choose>
	         </td>
	      </tr>
	      <tr style="height:10px;"></tr>
	      <tr>
	         <th>비밀번호</th>
	         <td><a href="${pageContext.request.contextPath}/users/pwd_updateform" class="btn btn-outline-info" style="padding :2px;">수정하기</a></td>
	      </tr>
	      <tr style="height:10px;"></tr>
	      <tr>
	         <th>이메일</th>
	         <td>${dto.email }</td>
	      </tr>
	      <tr style="height:10px;"></tr>
	      <tr>
	         <th>가입일</th>
	         <td>${dto.regdate }</td>
	      </tr>
	      <tr style="height:10px;"></tr>
	   </table>
	   <br>
	   <br>
	   <a href="${pageContext.request.contextPath}/users/updateform" class="btn btn-outline-warning">EDIT</a>
	   <a href="javascript:deleteConfirm()" class="btn btn-outline-danger">DROP-OUT</a>
	</div>
	<script>
	   function deleteConfirm(){
	      const isDelete=confirm("${id} 님 탈퇴 하시겠습니까?");
	      if(isDelete){
	         location.href="${pageContext.request.contextPath}/users/delete";
	      }
	   }
	</script>
</body>
</html>