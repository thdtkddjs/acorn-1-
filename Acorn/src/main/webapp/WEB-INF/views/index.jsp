<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>index.jsp</title>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="resources/css/index.css">
<link rel="stylesheet" type="text/css" href="resources/css/shop_list.css">
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="shortcut icon" type="image/x-icon" href="data:image/x-icon;,">
</head>
<body>
	<jsp:include page="../views/include/navbar.jsp">
		<jsp:param value="index" name="thisPage"/>
	</jsp:include>
	<div data-bs-spy="scroll" data-bs-target="#simple-list-example" data-bs-offset="0" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
    <div id="simple-list-item-1" class="block_content_top"></div>
		<div class="roll_screen">
			<div id="carouselExampleInterval" class="carousel slide" data-bs-ride="carousel">
				<div class="carousel-inner">
					<div class="carousel-item active" data-bs-interval="5000">
						<img src="https://www.sivandesign.com/wp-content/uploads/2016/11/SD-Top-Slides-HOME-civilcad-1920x520-final.jpg" class="d-block w-100" alt="...">
					</div>
					<div class="carousel-item" data-bs-interval="5000">
						<img src="https://luxurycottages.com/wp-content/uploads/2020/05/Mam-Tor-1920x520.jpg" class="d-block w-100" alt="...">
					</div>
					<div class="carousel-item">
						<img src="https://www.teahub.io/photos/full/280-2809437_best-guitars-for-metal-rock-guitar.jpg" class="d-block w-100" alt="...">
					</div>
				</div>
				<button class="carousel-control-prev" type="button"
					data-bs-target="#carouselExampleInterval" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#carouselExampleInterval" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>
		</div>

		<div id="simple-list-item-2" class="category">
			<div class="row">
				<a href="${pageContext.request.contextPath}/shop/list"> <img
					src="${pageContext.request.contextPath}/resources/images/category/all.jpg"
					alt="전체" title="전체" class="col" />
	
				</a> <a
					href="${pageContext.request.contextPath}/shop/list?category=한식">
					<img
					src="${pageContext.request.contextPath}/resources/images/category/hansik.jpg"
					alt="한식" title="한식" class="col" />
	
				</a> <a
					href="${pageContext.request.contextPath}/shop/list?category=중식">
					<img
					src="${pageContext.request.contextPath}/resources/images/category/jungsik.jpg"
					alt="중식" title="중식" class="col" />
	
				</a> <a
					href="${pageContext.request.contextPath}/shop/list?category=일식">
					<img
					src="${pageContext.request.contextPath}/resources/images/category/ilsik.jpg"
					alt="일식" title="일식" class="col" />
				</a>
			</div>
			<div class="row">
				<a href="${pageContext.request.contextPath}/shop/list?category=분식">
					<img
					src="${pageContext.request.contextPath}/resources/images/category/bunsik.jpg"
					alt="분식" title="분식" class="col" />
				</a> <a
					href="${pageContext.request.contextPath}/shop/list?category=양식">
					<img
					src="${pageContext.request.contextPath}/resources/images/category/yangsik.jpg"
					alt="양식" title="양식" class="col" />
				</a> <a
					href="${pageContext.request.contextPath}/shop/list?category=패스트푸드">
					<img
					src="${pageContext.request.contextPath}/resources/images/category/fastfood.jpg"
					alt="패스트푸드" title="패스트푸드" class="col" />
	
				</a> <a
					href="${pageContext.request.contextPath}/shop/list?category=기타">
					<img
					src="${pageContext.request.contextPath}/resources/images/category/guitar.jpg"
					alt="기타" title="기타" class="col" />
				</a>
			</div>
		</div>
		<div class="block_content"></div>
		<div id="simple-list-item-3" class="hot_place">
			<p style="  -webkit-user-select:none;
						  -moz-user-select:none;
						  -ms-user-select:none;
						  user-select:none">HOT PLACE
			<br />
			<span>2월 방문자, 평점 </span><strong>TOP 10 !</strong>
			</p>
			
		</div>
		<div class="roll_screen_store row">
			<div class="slide slick-slider roller_store">
				<c:forEach var="tmp" items="${list }">
						<a href="${pageContext.request.contextPath}/shop/detail?num=${tmp.num}&keyword=${keyword}" style="margin-right : 20px; background-color:white; height:367px; border-radius:10px; overflow:hidden;">
		   					<span class="shop_item_img">
		   						<img src="${pageContext.request.contextPath}/shop/images/${tmp.imagePath}" alt="...">
		   					</span>
			   				<div class="shop_item_content">
			   					<span style="font-weight: bold; color: red; font-size: 20px;">${tmp.grade }</span>
			   					<div class="shop_title">${tmp.title}</div>
			   					<ul>
			   						<li class="shop_item_content_detail"><img src="${pageContext.request.contextPath}/resources/images/shop_info/address.png" alt="주소" class="shop_info_icon" title="주소"/>${tmp.addr }</li>
			   						<li class="shop_item_content_detail">${tmp.content }</li>
			   						<li class="shop_item_content_detail">${tmp.categorie}, ${tmp.startTime}~ ${tmp.endTime}, ${tmp.telNum}</li>
			   						<li class="shop_item_content_detail">👀 페이지 뷰 : <b style="color:black;">999+</b>, ✏️ 리뷰 : <b style="color:black;">${tmp.rCount}</b></li>
			   					</ul>
			   				</div>	 
						</a>
				</c:forEach>
			</div>
		<div class="block_content"></div>
		</div>
		<script>
			$('.slide.roller_store').slick({
				  infinite: true,
				  speed: 1000,
				  slidesToShow: 1,
				  variableWidth: true,
				  arrow:false,
				  autoplay: true,
				  autoplaySpeed : 1000,
				  prevArrow : false,
				  nextArrow : false,
				  draggable : false,
				});
		</script>
		<div id="simple-list-item-4" class="statistics">
			<p style="z-index : 3;
			  -webkit-user-select:none;
			  -moz-user-select:none;
			  -ms-user-select:none;
			  user-select:none
			  ">이번 달 가장 인기 있는 카테고리는?!
				<br />
				<span>월간 인기 카테고리 차트</span>
				<br /><br />
				<strong class="cloud_effect" style="place-content: center;">
					FOOD STATISTICS
				</strong>
				<br />
				<a class="btn btn-success" href="${pageContext.request.contextPath}/statistics/statistics" style="    height: 50px;
			    width: 200px;
			    text-decoration: none;
			    font-weight: bold;
			    display: flex;
			    align-items: center;
			    justify-content: center;
			    margin: auto;">지금 보러가기</a>
			</p>
			<div class="statistics_bg1" id="st_img">
				<img src="${pageContext.request.contextPath}/resources/images/pie_chart.svg" alt="" />
			</div>
			<div class="statistics_bg2" id="st_img">
				<img src="${pageContext.request.contextPath}/resources/images/chart_img.jpg" alt="" />
			</div>
		</div>
	</div>     


</body>
</html>