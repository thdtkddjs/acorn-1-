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
		<form action="${pageContext.request.contextPath}/todo/insert">
		<div>
			<label for="content">할일</label>
			<input type="text" name="content" />
		</div>
		<button type="submit">제출</button>
		</form>
	</div>
</body>
</html>