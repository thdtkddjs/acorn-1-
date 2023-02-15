<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/users/delete.jsp</title>
</head>
<body>
	<div class="container">
		<script>
			alert("탈퇴처리 되었습니다")
			window.location.href = '${pageContext.request.contextPath}/users/loginform';
		</script>
	</div>
</body>
</html>