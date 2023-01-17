<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/users/login.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
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
img{
	width : 450px;
	border-radius : 10px;
}
</style>
</head>
<body class="text-center">
	<div class="container">
	   <c:choose>
	      <c:when test="${not empty sessionScope.id }">
	         <script>
	         	window.location.href = '${pageContext.request.contextPath}';
	         </script>
	      </c:when>
	      <c:otherwise>
         	<img src="${pageContext.request.contextPath}/resources/images/access_denied.png" alt="" />
            <br />
            <br />
            <br />
            <h3>LOGIN FAIL</h3>
            <br />
            <p>PLEASE CHECK YOUR ID & PW</p>
            <br />
            <a class="btn btn-outline-warning" href="loginform?url=${requestScope.encodedUrl }">LOGIN PAGE</a>
	      </c:otherwise>
	   </c:choose>
	</div>
</body>
</html>