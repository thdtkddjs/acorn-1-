<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<title>list.jsp</title>
<style>
.img-wrapper {
	height: 300px;
}

.img-wrapper img {
	width: 100%;
	height: 100%;
	object-fit: fill;
}

.card-body {
	width: 100%;
	height: 100%;
	object-fit: fill;
}

.shop_info {
	width: 100%;
	height: 100%;
	object-fit: fill;
}

.shopInfo {
	border-right: 1px solid gray;
}

.title {
	text-align : center;
	font-weight : bold;
	font-size : 1.5rem;
}

.category{
	display : flex;
	flex-direction : column;
	height : 150px;
}
.category>.row{
	flex:1;
	width : 100%;
	justify-content: center;
	height : 125px !important;
	margin : auto;
	text-align : center;
}
.category>.row>a{
	flex:1;
	justify-content: center;
	text-decoration : none;
	padding : 0;
	margin : 0;
	
}
.category>.row>.col{
	align-self : center;
}
.category>.row>a>img{
	border : 1px solid white;
	border-radius : 75px;
	padding : 0;
	margin : 0;
	width : 125px;
	height : 125px;
	overflow : hidden;
}
</style>
</head>
<body>
	<div class="container">
		<a href="${pageContext.request.contextPath}/">인덱스로</a><br />
	   	<h1>임시 리스트</h1>
	   	
	   	<div class="category">
	   		<div class="row">
				<a href="${pageContext.request.contextPath}/shop/list"> 
					<img src="${pageContext.request.contextPath}/resources/images/category/all.jpg"
						alt="전체" title="전체" class="col" />
				</a> 
				
				<a href="${pageContext.request.contextPath}/shop/list?category=한식">
					<img src="${pageContext.request.contextPath}/resources/images/category/hansik.jpg"
						alt="한식" title="한식" class="col" />
				</a> 
				
				<a href="${pageContext.request.contextPath}/shop/list?category=중식">
					<img src="${pageContext.request.contextPath}/resources/images/category/jungsik.jpg"
						alt="중식" title="중식" class="col" />
				</a> 
				
				<a href="${pageContext.request.contextPath}/shop/list?category=일식">
					<img src="${pageContext.request.contextPath}/resources/images/category/ilsik.jpg"
						alt="일식" title="일식" class="col" />
				</a>
				
				<a href="${pageContext.request.contextPath}/shop/list?category=양식">
					<img src="${pageContext.request.contextPath}/resources/images/category/bunsik.jpg"
						alt="분식" title="분식" class="col" />
				</a> 
				
				<a href="${pageContext.request.contextPath}/shop/list?category=패스트푸드">
					<img src="${pageContext.request.contextPath}/resources/images/category/yangsik.jpg"
						alt="양식" title="양식" class="col" />
				</a> 
				
				<a href="${pageContext.request.contextPath}/shop/list?category=분식">
					<img src="${pageContext.request.contextPath}/resources/images/category/fastfood.jpg"
						alt="패스트푸드" title="패스트푸드" class="col" />
				</a> 
				
				<a href="${pageContext.request.contextPath}/shop/list?category=기타">
					<img src="${pageContext.request.contextPath}/resources/images/category/guitar.jpg"
						alt="기타" title="기타" class="col" />
				</a>
			</div>
	   	</div>
	   	
	   	<div class="row">
			<c:forEach var="tmp" items="${list }">
				<div class="col-sm-8" style="margin : auto;">
	         		<div class="card mb-3">
	         			<a href="${pageContext.request.contextPath}/shop/detail?num=${tmp.num}&keyword=${keyword}" style="color: black; text-decoration : none">
	         				<div class="row g-0">
		         				<div class="img-wrapper col-md-4">
			            			<img src="${pageContext.request.contextPath}/${tmp.imagePath}"	class="card-img-top" alt="...">
			            		</div>
			            		<div class="img-wrapper col-md-8">
			            			<div class="card-body">
			            				<table class="shop_info">
											<thead>
												<tr>
													<th colspan="2" class="title">${tmp.title }</th>
												</tr>
											</thead>
											<tbody class="table-group-divider" style="text-align : center;">
												<tr>
													<td class="shopInfo">소개</td>
													<td>${tmp.content}</td>
												</tr>
												
												<tr>
													<td class="shopInfo">카테고리</td>
													<td>${tmp.categorie}</td>
												</tr>
												
												<tr>
													<td class="shopInfo">영업 시간</td>
													<td>${tmp.startTime}~ ${tmp.endTime}</td>
												</tr>
												
												<tr>
													<td class="shopInfo">주소</td>
													<td>${tmp.addr}</td>
												</tr>
												
												<tr>
													<td class="shopInfo">전화 번호</td>
													<td>${tmp.telNum}</td>
												</tr>
											</tbody>
										</table>
									</div>
			            		</div>
	         				</div>
	         			</a>
	         		</div>
	      		</div>
			</c:forEach>
	   	</div>
	   	<nav>
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="${startPageNum ne 1 }">
					<li class="page-item">
	               		<a class="page-link" href="list?pageNum=${startPageNum - 1}&category=${category }&condition=${condition}&keyword=${encodedK}">Prev</a>
	            	</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
	               		<a class="page-link" href="javascript:">Prev</a>
	            	</li>
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
				<li class="page-item ${pageNum eq i ? 'active' : '' }">
					<a class="page-link" href="list?pageNum=${i }&category=${category }&condition=${condition}&keyword=${encodedK}">${i }</a>
				</li>
			</c:forEach>
			<c:choose>
				<c:when test="${endPageNum lt totalPageCount }">
					<li class="page-item">
	               		<a class="page-link" href="list?pageNum=${endPageNum + 1}&category=${category }&condition=${condition}&keyword=${encodedK}"">Next</a>
	            	</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
	               		<a class="page-link" href="javascript:">Next</a>
	            	</li>
				</c:otherwise>
			</c:choose>
	      </ul>
	   </nav>   
	</div>
</body>
</html>