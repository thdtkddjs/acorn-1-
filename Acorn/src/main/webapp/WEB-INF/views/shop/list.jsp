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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/shop_list.css">
<title>list.jsp</title>
</head>
<body>
	<jsp:include page="../../views/include/navbar.jsp">
		<jsp:param value="list" name="thisPage"/>
	</jsp:include>
	<div data-bs-spy="scroll" data-bs-target="#simple-list-example" data-bs-offset="0" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
    <div id="simple-list-item-1" class="block_content_top"></div>
    <div class="category_bar">
    	<div class="row">
    			<a href="${pageContext.request.contextPath}/shop/list">
    			전체
				</a> 
				
				<a href="${pageContext.request.contextPath}/shop/list?category=한식">
				한식
				</a> 
				
				<a href="${pageContext.request.contextPath}/shop/list?category=중식">
				중식
				</a> 
				
				<a href="${pageContext.request.contextPath}/shop/list?category=일식">
				일식
				</a>
				
				<a href="${pageContext.request.contextPath}/shop/list?category=양식">
				양식
				</a> 
				
				<a href="${pageContext.request.contextPath}/shop/list?category=패스트푸드">
				패스트푸드
				</a> 
				
				<a href="${pageContext.request.contextPath}/shop/list?category=분식">
				분식
				</a> 
				
				<a href="${pageContext.request.contextPath}/shop/list?category=기타">
				기타
				</a>
    	</div>
    </div>

	<div class="container">
		<div class="shop_list">
			<p class="list_title">
				<span> 
					<c:choose>
						<c:when test="${category ne '' }">
							<span style="color: black !important; font-size: 20px; font-weight: bold;">"${category}" 검색 결과 : </span>
							<span style="font-size: 20px; font-weight: bold; color: red;">${totalRow}개</span>
							|<strong style="color: black;"> ${category} </strong>카테고리 평점 기준으로 정렬한 맛집 리스트 입니다.
						</c:when>
						<c:otherwise>
							<strong style="color: black;">전체</strong> 카테고리 평점 기준으로 정렬한 맛집 리스트 입니다.
						</c:otherwise>
					</c:choose>
				</span>
			</p>
			<ul>
				<c:forEach var="tmp" items="${list }">
					<li class="shop_item_wrapper">
						<div class="shop_item" style="margin-right: 20px; background-color: white; border-radius: 10px; overflow: hidden;">
							<a href="${pageContext.request.contextPath}/shop/detail?num=${tmp.num}&keyword=${keyword}"
								style="color: black; text-decoration: none"> 
								<span class="shop_item_img"> 
									<img src="${pageContext.request.contextPath}${tmp.imagePath}" alt="...">
								</span>
								<div class="shop_item_content">
									<span style="font-weight: bold; color: red; font-size: 20px;">${tmp.grade }</span>
									<div class="shop_title">${tmp.title}</div>
								</div>
							</a>
							<ul style="	padding-left : 10px;">
								<li class="shop_item_content_detail">
									<img src="${pageContext.request.contextPath}/resources/images/shop_info/address.png"
										alt="주소" class="shop_info_icon" title="주소" />${tmp.addr }
								</li>
								<li class="shop_item_content_detail">${tmp.content }</li>
								<li class="shop_item_content_detail">${tmp.categorie}, ${tmp.startTime}~ ${tmp.endTime}, ${tmp.telNum}</li>
								<li class="shop_item_content_detail">
									👀 <b style="color: blue;">999+</b>, '
									리뷰 <b style="color: red;">${tmp.rCount }</b>,
									etc..
								</li>
							</ul>
						</div>
					</li>
				</c:forEach>
			</ul>
		</div>
	</div>

		<nav>
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="${startPageNum ne 1 }">
					<li class="page-item">
	               		<a class="page-link" href="list?pageNum=${startPageNum - 1}&category=${category }&condition=${condition}&keyword=${encodedK}">◀</a>
	            	</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
	               		<a class="page-link" href="javascript:">◀</a>
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
	               		<a class="page-link" href="list?pageNum=${endPageNum + 1}&category=${category }&condition=${condition}&keyword=${encodedK}"">▶</a>
	            	</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
	               		<a class="page-link" href="javascript:">▶</a>
	            	</li>
				</c:otherwise>
			</c:choose>
	      </ul>
	   </nav>   
	</div>
</body>
</html>