<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/index.css">
<link rel="stylesheet" type="text/css" href="../resources/css/shop_detail.css">
</head>
<style>
.container {
	width : 60%;
	padding-top: 100px;
}
p{
	margin : 0;
}
.total_search_result{
	text-align : center;
	height : 75px;
}
.shop_search_result, .review_search_result{
	min-height : 150px;
}
.result_zero{
	display: flex;
    place-content: center;
    height: 75px;
    align-items: center;
}
.result_header{
	position : relative;
	display: flex;
    align-items: center;
}
.result_title{
	font-size : 20px;
	font-weight : bold;
	margin-bottom:5px;
}
.more_info{
	display: flex;
    position: absolute;
    right: 1%;
    text-decoration: none;
    font-size: 13px;
    font-weight: bold;
}
.keyword_style{
    font-weight: bold;
    font-size : 18px;
}
.result_style{
	color : blue;
    font-weight: bold;
    font-size : 18px;
    margin-left : 3px;
}
.result_content{
	border-top : 3px solid blue;
}
ul, li{
	list-style:none;
	padding : 0;
}
a{
	text-decoration : none;
}
p{
    display: inline-block;
}
.result_item{
	height : 100px;
	border-left : 1px solid #cecece;
	border-right : 1px solid #cecece;
	border-bottom : 1px solid #cecece;
	padding : 10px;
	margin:0;
	position : relative;
}
.result_item>a{
	text-decoration : none;
	font-weight : bold;
	font-size : 15px;
	color : black;
}
.item_style1{
	border : 1px solid green;
	border-radius : 5px;
	padding : 0 20px;
}
.cat_style{
	border : 1px solid green;
	border-radius : 5px;
	padding : 0 10px;
	font-weight : bold;
}
.tit_style>a{
	font-weight : bold;
	font-size : 18px;
	color : black;
}
.content_mid{
	font-size : 13px;
	position: absolute;
    bottom: 40px;

}
.content_info{
	position : absolute;
	bottom : 10px;
}
.info_style{
	font-weight:bold;
	font-size : 15px;
}
.txt-hlight {
	font-weight : bold;
	color : #DB7E05;
}
.shop_link{
	max-width : 200px;
	display:inline-block;
	padding-left : 10px;
}
.review_list_store_name{
    display: flex;
    width: 100%;
}
.review_list_store_name>svg{
    align-self: center;
    margin-right : 5px;
}
</style>
<body>
	<jsp:include page="../../views/include/navbar.jsp">
		<jsp:param value="search01" name="thisPage"/>
	</jsp:include>
	<div data-bs-spy="scroll" data-bs-target="#simple-list-example" data-bs-offset="0" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
		<div id="simple-list-item-1"></div>
	
		
		<div class="container">
			<div class="total_search_result">
				<b style="font-weight: bold">
						<span class="keyword_style">"${keyword}"</span>에 대해  검색 결과
						총 
						<p class="result_style">${totalRow+rvtotalRow}</p>
						건이 검색 되었습니다.
				</b>
			</div>
			<div class="shop_search_result">
				<div class="result_header">
					<c:choose>
						<c:when test="${totalRow gt 5}">
							<a class="more_info"
								href="${pageContext.request.contextPath}/shop/list?keyword=${keyword}">더보기 > </a>
						</c:when>
					</c:choose>
					<p class="result_title">가게 목록 (${totalRow}건)</p>				
				</div>
				<div class="result_content">
							<c:if test="${totalRow eq 0}">
								<div class="result_zero">
									<span >"${keyword}"로 검색한 결과가 없습니다.</span>
								</div>
							</c:if>
							<c:forEach var="tmp" items="${list }">
							<ul class="result_item">
								<li class="content_head">
									<span class="cat_style">${tmp.categorie }</span>
									<span class="tit_style">
										<a href="detail?num=${tmp.num }&condition=${condition}&keyword=${encodedK}">${tmp.title }</a>
									</span>
								</li>
								<li class="content_mid">
									<span class="con_style">${tmp.content}</span>
								</li>
								<li class="content_info">
									<span class="info_style">평점 </span>${tmp.grade }점
									<span class="info_style">리뷰 </span>${tmp.reviewCount }개
									<span class="info_style">페이지뷰 </span>PV 회
								</li>
							
							</ul>
							</c:forEach>
				</div>
				
				<script type="text/javascript">
				$(document).ready(function () {
				    var search = '${keyword}';
				    console.log("search : "+search);
				    $("span:contains('"+search+"')").each(function () {
				        var regex = new RegExp(search,'gi');
				        $(this).html( $(this).text().replace(regex, "<span class='txt-hlight'>"+search+"</span>") );
				    });
				});
				
				</script>
				
			</div>		



			<div class="review_search_result">
				<div class="result_header" style="border-bottom: 3px solid blue;">
					<c:choose>
						<c:when test="${rvtotalRow gt 5}">
							<a class="more_info" href="${pageContext.request.contextPath}/shop/review_list?keyword=${rvkeyword}">더보기 > </a>
						</c:when>
					</c:choose>
					<p class="result_title">리뷰 목록(${rvtotalRow}건)</p>
				</div>
			<div class="review_list">
				<div class="reviews">
					<ul>
						<c:forEach var="tmp" items="${rvlist }">
							<c:choose>
								<c:when test="${tmp.deleted eq 'yes' }">
									<dt class="row">
										<li>삭제된 리뷰 입니다.</li>
									</dt>
								</c:when>
								<c:otherwise>
									<c:if test="${tmp.num eq tmp.review_group }">
										<li id="reli${tmp.num }">
									</c:if>
	
									<dl>
										<dt class="row">
											<div class="comment_box">
												<!-- 유저 프로필 -->
												<div class="review_profile col">
													<c:if test="${ empty tmp.profile }">
														<svg class="profile-image"
															xmlns="http://www.w3.org/2000/svg" width="16" height="16"
															fill="currentColor" class="bi bi-person-circle"
															viewBox="0 0 16 16">
						                                <path
																d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" />
						                                <path fill-rule="evenodd"
																d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z" />
						                              </svg>
													</c:if>
													<c:if test="${not empty tmp.profile }">
														<img class="profile-image"
															src="${pageContext.request.contextPath}${tmp.profile }" />
													</c:if>
												</div>
												<span class="col">${tmp.writer }</span> <span class="bg_bar"></span>
												<span style="font-weight: 100; font-size: 13px; color: gray;">${tmp.regdate }</span>
												<div class="shop_link">
													<a class="review_list_store_name" href="detail?num=${tmp.ref_group}">
														<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-shop-window" viewBox="0 0 16 16">
															<path d="M2.97 1.35A1 1 0 0 1 3.73 1h8.54a1 1 0 0 1 .76.35l2.609 3.044A1.5 1.5 0 0 1 16 5.37v.255a2.375 2.375 0 0 1-4.25 1.458A2.371 2.371 0 0 1 9.875 8 2.37 2.37 0 0 1 8 7.083 2.37 2.37 0 0 1 6.125 8a2.37 2.37 0 0 1-1.875-.917A2.375 2.375 0 0 1 0 5.625V5.37a1.5 1.5 0 0 1 .361-.976l2.61-3.045zm1.78 4.275a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 1 0 2.75 0V5.37a.5.5 0 0 0-.12-.325L12.27 2H3.73L1.12 5.045A.5.5 0 0 0 1 5.37v.255a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0zM1.5 8.5A.5.5 0 0 1 2 9v6h12V9a.5.5 0 0 1 1 0v6h.5a.5.5 0 0 1 0 1H.5a.5.5 0 0 1 0-1H1V9a.5.5 0 0 1 .5-.5zm2 .5a.5.5 0 0 1 .5.5V13h8V9.5a.5.5 0 0 1 1 0V13a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V9.5a.5.5 0 0 1 .5-.5z"/>
														</svg>
														<span style="font-size:13px;">${tmp.title }</span>
													</a>
												</div>
													
												
												<div class="startRadio" style="pointer-events: none;">
													<c:forEach var="i" begin="0" end="9">
														<label class="startRadio__box"> <input type="radio"
															name="grade_number" value=${i }
															${tmp.grade eq (i/2+0.5) ? 'class="point"' : '' }>
															<span class="startRadio__img"> <span class="blind">별
																	${(i/2+0.5) }개</span>
														</span>
														</label>
													</c:forEach>
												</div>
												<span class="review_content_box" id="spc${tmp.num }"
													name="content" style="display: block;">
													${tmp.content}</span>
												<div class="comment_box" id="pre${tmp.num }">
													<input class="review_title_box" type="text" name="title"
														id="spt${tmp.num }" value="${tmp.title}" disabled />
												</div>
												
												
											</div>
	
	
										</dt>
										<div class="col-2">
											<c:choose>
												<c:when
													test="${empty tmp.imagePath or tmp.imagePath eq 'empty' }">
												</c:when>
												<c:otherwise>
													<img class="review_img"
														src="${pageContext.request.contextPath}${tmp.imagePath}" />
												</c:otherwise>
											</c:choose>
										</div>
									</dl>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</ul>
				</div>
			</div>		
		</div>
	</div>
</body>
</html>