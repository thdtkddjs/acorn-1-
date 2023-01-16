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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<style>
.container {
	display: grid;
	grid-template-areas: 
		"header header header"
		"search main main";
	grid-template-columns: 1fr 2fr 1fr;
	grid-template-rows: 50px 870px;
	box-shadow: 0px 5px 20px 0px grey;
	border-right: thin;
	z-index: 1;
	min-width: 1320px;
}

.header {
	grid-area: header;
	text-align: right;
	display: block;
}

.side_menu_a {
	grid-area: search;
	width: 100%;
	text-align: center;
	background-color: lightgray;
}

.search_menu {
	grid-area: search;
	box-shadow: 2px 2px 3px 0px grey;
	background-color: white;
	z-index: 3;
	position: relative;
}

.search_result {
	grid-area: main;
	width: 100%;
	height: 680px;
	text-align: center;
}

.side_menu_b {
	grid-area: b;
	width: 100%;
	text-align: center;
	background-color: lightgray;
}

.footer {
	padding-left: 10px;
	padding-right: 10px;
	margin-top: 0px;
	background-color: white;
	grid-area: footer;
	bottom: 0px;
	width: 100%;
	position: fixed;
	z-index: 5;
}


.search_bar {
	border: 3px solid;
	border-color: rgb(64, 219, 43);
	border-radius: 5px;
	margin: 10px;
	width: 290px;
}

.search_bar>form>input {
	width: 250px;
	margin: 10px;
	border: none;
	font-size: large;
}

.suggest_menu>.card {
	margin-left: 10px;
}

#map {
	z-index: 2;
	box-shadow: 2px 2px 3px 0px grey;
	width: 972px; 
	height: 870px;  
	float: right;
}

.suggest_menu {
	height: 763px;
	overflow: scroll;
	-ms-overflow-style: none;
}
.suggest_menu::-webkit-scrollbar {
	width : 5px;
	height : 0px;
}
.suggest_menu::-webkit-scrollbar-thumb {
    background-color: #2f3542;
    border-radius: 10px;
}
.suggest_menu::-webkit-scrollbar-track {
}


.fold_btn {
	position: absolute;
	left: 300px;
	top: 150px;
	z-index: 5;
}

.open_btn {
	position: absolute;
	left: 200px;
	top: 150px;
	z-index: 5;
}
.search_box{
	position: relative;
}
.search_img{
	position : absolute;
	width: 17px;
	margin: 0;
	top:25px;
	right:13%;
}
.search_input{
border : none;
  width: 100%;
  padding: 10px 12px;
  font-size: 14px;
}
.logo{
	width:50px;
}
.logo_text{
	display: flex; 
	position: fixed;
	text-decoration : none;
	font-size : 30px;
	font-weight : bold;
}
.top_menu{
	padding: 0px;
    width: 70px;
    margin-top: 10px;
}
.user_menu{
	text-decoration : none;
	margin-top : 12px;
	padding : 0px;
	width : 120px;
	height : 25px;
	padding-top:7px;
}
.logout_menu{
	text-decoration : none;
	margin-top : -2px;
	padding : 0px;
	width : 70px;
	height : 25px;
}
.card-img-top{
	width:286px;
	height:200px;
}
.rainbow_effect{
	animation-duration: 1s; 
	animation-name: rainbowLink; 
	animation-iteration-count: infinite; 
}
@keyframes rainbowLink {     
 0% { background-color: #ff2a2a; }
 15% { background-color: #ff7a2a; }
 30% { background-color: #ffc52a; }
 45% { background-color: #43ff2a; }
 60% { background-color: #2a89ff; }
 75% { background-color: #202082; }
 90% { background-color: #6b2aff; } 
 100% { background-color: #e82aff; }
}
</style>
<body>
    <div class="container">
        <div class="header">
			<c:choose>
				<c:when test="${ empty sessionScope.id}">
					<a href="${pageContext.request.contextPath}/index" class="logo_text">
						<img class="logo" src="${pageContext.request.contextPath}/resources/images/1_acorn_logo.png" alt="" />
						HOMEPAGE NAME
					</a>
					<a href="${pageContext.request.contextPath}/users/loginform"  class="top_menu btn btn-outline-dark">LOGIN</a>
					<a href="${pageContext.request.contextPath}/users/signup_form"  class="top_menu btn btn-outline-success">SIGN-UP</a>
				</c:when>
				<c:when test="${sessionScope.id eq 'admin'}">
					<a href="${pageContext.request.contextPath}/index" class="logo_text">
						<img class="logo" src="${pageContext.request.contextPath}/resources/images/1_acorn_logo.png" alt="" />
						HOMEPAGE NAME
					</a>
					<a href="${pageContext.request.contextPath}/shop/insertform" class="user_menu badge text-bg-success">REGIST SHOP</a>
					<a href="${pageContext.request.contextPath}/users/list" class="user_menu badge text-bg-warning">USER LIST</a>
					<a href="${pageContext.request.contextPath}/users/info" class="rainbow_effect user_menu badge">${sessionScope.id }</a>
					<a href="${pageContext.request.contextPath}/users/logout" class="logout_menu btn btn-outline-danger">LOGOUT</a>
				</c:when>
				<c:otherwise>
					<a href="${pageContext.request.contextPath}/index" class="logo_text">
						<img class="logo" src="${pageContext.request.contextPath}/resources/images/1_acorn_logo.png" alt="" />
						HOMEPAGE NAME
					</a>
					<a href="${pageContext.request.contextPath}/users/info" class="user_menu badge text-bg-primary">${sessionScope.id }</a>
					<a href="${pageContext.request.contextPath}/users/logout" class="logout_menu btn btn-outline-danger">LOGOUT</a>

				</c:otherwise>
			</c:choose>
			

		</div>
        <div class="search_menu">
            <div class="search_bar">
                <form action="${pageContext.request.contextPath}/index/" method="post">
                    <div class="serch_box">
                    	<button type="submit" style="display:contents"><img class="search_img" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" alt="" /></button>
                    	<input class="search_input" type="text" name="keyword" value="${keyword}" placeholder="가게 명을 입력하세요...">
                    </div>
                </form>
            </div>
            
            
            <hr>
            <div class="suggest_menu">
				<c:choose>
					<c:when test="${ empty keyword}">
						<h5 style="margin-left:20px;">STORE LIST</h5>
					</c:when>
					<c:otherwise>
						<h5 style="margin-left:20px;"><strong>"${keyword}"</strong>로 검색한 결과</h5>
					</c:otherwise>
				</c:choose>
				<c:forEach var="tmp" items="${list }">
					<div class="card" style="width: 18rem;">
	                    <img src="${pageContext.request.contextPath}/${tmp.imagePath}" class="card-img-top" alt="...">
	                    <div class="card-body">
	                    	<h5 class="card-title">${tmp.title }</h5>
	                    	<p class="card-text">${tmp.content }</p>
	                    	<a href="${pageContext.request.contextPath}/shop/detail?num=${tmp.num}&keyword=${keyword}"	class="btn btn-primary">INFO</a>

						</div>
	                </div>
                <br>
				</c:forEach>



            </div>
        </div>
        <div class="search_result">
            <div id="map"></div>
            
        </div>
        <div class="bottom">　</div>


        
    </div>        
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b45a7e1f67e033582e03cb02a068e52&libraries=services"></script>
	<script>
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('서울특별시 강남구 테헤란로 124', function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">Acorn Academy</div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});    
	</script>

	<!-- 메뉴 접기 버튼 잠시 휴식
     
	<button class="fold_btn" onclick="fold_menu()"> ◀ </button>
    <button class="open_btn" onclick="open_menu()" style="display: none;"> ▶ </button>
    <script>
        function fold_menu() {
            document.querySelector(".search_bar").style.display ="none";
            document.querySelector(".search_menu").style.display ="none";
            document.querySelector("#map").style.width ="1296px";
            document.querySelector("#map").style.height ="700px";
            document.querySelector(".open_btn").style.removeProperty("display");
            document.querySelector(".fold_btn").style.display="none";
        };

        function open_menu() {
            document.querySelector(".search_bar").style.removeProperty("display");
            document.querySelector(".search_menu").style.removeProperty("display");
            document.querySelector("#map").style.width ="972px";
            document.querySelector("#map").style.height ="700px";
            document.querySelector(".fold_btn").style.removeProperty("display");
            document.querySelector(".open_btn").style.display="none";
        };
    </script>   -->
   
    <div class="footer">
        <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
          <symbol id="bootstrap" viewBox="0 0 118 94">
            <title>Bootstrap</title>
            <path fill-rule="evenodd" clip-rule="evenodd"
                d="M24.509 0c-6.733 0-11.715 5.893-11.492 12.284.214 6.14-.064 14.092-2.066 20.577C8.943 39.365 5.547 43.485 0 44.014v5.972c5.547.529 8.943 4.649 10.951 11.153 2.002 6.485 2.28 14.437 2.066 20.577C12.794 88.106 17.776 94 24.51 94H93.5c6.733 0 11.714-5.893 11.491-12.284-.214-6.14.064-14.092 2.066-20.577 2.009-6.504 5.396-10.624 10.943-11.153v-5.972c-5.547-.529-8.934-4.649-10.943-11.153-2.002-6.484-2.28-14.437-2.066-20.577C105.214 5.894 100.233 0 93.5 0H24.508zM80 57.863C80 66.663 73.436 72 62.543 72H44a2 2 0 01-2-2V24a2 2 0 012-2h18.437c9.083 0 15.044 4.92 15.044 12.474 0 5.302-4.01 10.049-9.119 10.88v.277C75.317 46.394 80 51.21 80 57.863zM60.521 28.34H49.948v14.934h8.905c6.884 0 10.68-2.772 10.68-7.727 0-4.643-3.264-7.207-9.012-7.207zM49.948 49.2v16.458H60.91c7.167 0 10.964-2.876 10.964-8.281 0-5.406-3.903-8.178-11.425-8.178H49.948z"></path>
          </symbol>
          <symbol id="facebook" viewBox="0 0 16 16">
            <path
                d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951z" />
          </symbol>
          <symbol id="instagram" viewBox="0 0 16 16">
              <path
                d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.917 3.917 0 0 0-1.417.923A3.927 3.927 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.916 3.916 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.926 3.926 0 0 0-.923-1.417A3.911 3.911 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0h.003zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599.28.28.453.546.598.92.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.47 2.47 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.478 2.478 0 0 1-.92-.598 2.48 2.48 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233 0-2.136.008-2.388.046-3.231.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92.28-.28.546-.453.92-.598.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045v.002zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92zm-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217zm0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334z" />
          </symbol>
          <symbol id="twitter" viewBox="0 0 16 16">
            <path
                d="M5.026 15c6.038 0 9.341-5.003 9.341-9.334 0-.14 0-.282-.006-.422A6.685 6.685 0 0 0 16 3.542a6.658 6.658 0 0 1-1.889.518 3.301 3.301 0 0 0 1.447-1.817 6.533 6.533 0 0 1-2.087.793A3.286 3.286 0 0 0 7.875 6.03a9.325 9.325 0 0 1-6.767-3.429 3.289 3.289 0 0 0 1.018 4.382A3.323 3.323 0 0 1 .64 6.575v.045a3.288 3.288 0 0 0 2.632 3.218 3.203 3.203 0 0 1-.865.115 3.23 3.23 0 0 1-.614-.057 3.283 3.283 0 0 0 3.067 2.277A6.588 6.588 0 0 1 .78 13.58a6.32 6.32 0 0 1-.78-.045A9.344 9.344 0 0 0 5.026 15z" />
          </symbol>
        </svg>
    
    
    
    
        <footer
            class="d-flex flex-wrap justify-content-between align-items-center py-3 border-top">
            <div class="col-md-4 d-flex align-items-center">
                <a href="/"
                    class="mb-3 me-2 mb-md-0 text-muted text-decoration-none lh-1">
                    <svg class="bi" width="30" height="24">
                        <use xlink:href="#bootstrap" /></svg>
                </a> <span class="mb-3 mb-md-0 text-muted">&copy; 2023 Acorn, Team 1</span>
            </div>
    
            <ul class="nav col-md-4 justify-content-end list-unstyled d-flex">
                <li class="ms-3"><a class="text-muted" href="#"><svg
                            class="bi" width="24" height="24">
                            <use xlink:href="#twitter" /></svg></a></li>
                <li class="ms-3"><a class="text-muted" href="#"><svg
                            class="bi" width="24" height="24">
                            <use xlink:href="#instagram" /></svg></a></li>
                <li class="ms-3"><a class="text-muted" href="#"><svg
                            class="bi" width="24" height="24">
                            <use xlink:href="#facebook" /></svg></a></li>
            </ul>
        </footer>
    
    </div>
</body>
</html>