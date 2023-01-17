<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/users/signup.jsp</title>
</head>
<body>
	<script>
		alert("회원가입이 정상적으로 처리되었습니다.")
		location.href = "${pageContext.request.contextPath}/users/loginform";
	</script>
</body>
</html>