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
   .img-wrapper{
      height: 250px;
      transition: transform 0.3s ease-out;
   }
   .img-wrapper:hover{
      transform: scale(1.1);
   }
   
   .card .card-text{
      display:block;
      white-space : nowrap;
      text-overflow: ellipsis;
      overflow: hidden;
   }
   	.img-wrapper img{
	   	width: 100%;
	   	height: 100%;
		object-fit: fill;	
   	}
   	.shop_info{
   margin-top:20px;
   margin-bottom:20px;
}
</style>
</head>
<body>
	<div class="container">
		<a href="${pageContext.request.contextPath}/">인덱스로</a><br />
	   	<h1>임시 리스트</h1>
	   	
	   	<div class="row">
			<p class="col">
				<a href="${pageContext.request.contextPath}/shop/list">전체</a>
			</p>
			<p class="col">
				<a href="${pageContext.request.contextPath}/shop/list?category=한식">한식</a>
			</p>
			<p class="col">
				<a href="${pageContext.request.contextPath}/shop/list?category=중식">중식</a>
			</p>
			<p class="col">
				<a href="${pageContext.request.contextPath}/shop/list?category=일식">일식</a>
			</p>
			<p class="col">
				<a href="${pageContext.request.contextPath}/shop/list?category=양식">양식</a>
			</p>
			<p class="col">
				<a href="${pageContext.request.contextPath}/shop/list?category=패스트푸드">패스트푸드</a>
			</p>
			<p class="col">
				<a href="${pageContext.request.contextPath}/shop/list?category=분식">분식</a>
			</p>
			<p class="col">
				<a href="${pageContext.request.contextPath}/shop/list?category=기타">기타</a>
			</p>
		</div>
	   	
	   	<div class="row">
			<c:forEach var="tmp" items="${list }">
				<div class="col-sm-8" style="margin : auto;">
	         		<div class="card mb-3">
	         			<div class="row g-0">
	         				<div class="img-wrapper col-md-4">
		            			<img src="${pageContext.request.contextPath}/${tmp.imagePath}"	class="card-img-top" alt="...">
		            		</div>
		            		<div class="col-md-8">
		            			<div class="card-body">
		            				<h5 class="card-title">${tmp.title }</h5>
		            				
		            				<table class="shop_info" style="content-align : center;">
										<tbody style="text-align : center;">
											<tr class=shopInfo>
												<td style="border-right: 1px solid gray">소개</td>
												<td>${tmp.content}</td>
											</tr>
											<tr style="height: 20px"></tr>
											<tr class=shopInfo>
												<td style="border-right: 1px solid gray">카테고리</td>
												<td>${tmp.categorie}</td>
											</tr>
											<tr style="height: 20px"></tr>
											<tr class=shopInfo>
												<td style="border-right: 1px solid gray">영업 시간</td>
												<td>${tmp.startTime}~ ${tmp.endTime}</td>
											</tr>
											<tr style="height: 20px"></tr>
											<tr class=shopInfo>
												<td style="border-right: 1px solid gray">주소</td>
												<td>${tmp.addr}</td>
											</tr>
											<tr style="height: 20px"></tr>
											<tr class=shopInfo>
												<td style="border-right: 1px solid gray">전화 번호</td>
												<td>${tmp.telNum}</td>
											</tr>
										</tbody>
									</table>
									
									<a href="${pageContext.request.contextPath}/shop/detail?num=${tmp.num}&keyword=${keyword}" class="btn btn-primary mb-2" style="float: right;">INFO</a>
								</div>
		            		</div>
	         			</div>
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