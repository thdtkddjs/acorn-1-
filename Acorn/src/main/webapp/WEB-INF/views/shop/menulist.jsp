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
	<table>
		<thead>
			<tr>
				<th>메뉴번호</th>
				<th>메뉴명</th>
				<th>가격</th>
				<th>메뉴 설명</th>
				<th>이미지</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="tmp" items="${menuList }">
			<tr>
				<th>${tmp.menuNum }</th>
				<th>${tmp.name }</th>
				<th>${tmp.price }</th>
				<th>${tmp.content }</th>
				<th>${tmp.imagePath }</th>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</body>
</html>