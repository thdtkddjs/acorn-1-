<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<h1>임시 db 저장소</h1>
		<a href="${pageContext.request.contextPath}/shop/insertform">상점 추가</a>
		<a href="${pageContext.request.contextPath}/users/insertform">회원가입</a>
	</div>
</body>
</html>