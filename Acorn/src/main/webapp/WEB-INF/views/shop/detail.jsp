<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>detail.jsp</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.slim.js" integrity="sha256-HwWONEZrpuoh951cQD1ov2HUK5zA5DwJ1DNUXaM6FsY=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
</head>
<style>
.container {
	display: grid;
	grid-template-areas: "header header header"
		"search main main" "  bot   bot   bot  ";
	grid-template-columns: 1fr 2fr 1fr;
	grid-template-rows: 50px 870px;
	box-shadow: 0px 5px 20px 0px grey;
	border-right: thin;
	z-index: 1;
	min-width: 1320px;
}

.main_content {
	grid-area: main;
}

.header {
	grid-area: header;
	text-align: right;
	display: block;
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
	height: 870px;
	text-align: center;
	box-shadow: 2px 2px 3px 0px grey;
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
.table_1::-webkit-scrollbar, .table_2::-webkit-scrollbar, 
.table_3::-webkit-scrollbar, .table_4::-webkit-scrollbar {
	width : 5px;
	height : 0px;
}
.table_1::-webkit-scrollbar-thumb, .table_2::-webkit-scrollbar-thumb, 
.table_3::-webkit-scrollbar-thumb, .table_4::-webkit-scrollbar-thumb {
    background-color: #2f3542;
    border-radius: 10px;
}
.table_1::-webkit-scrollbar-track, .table_2::-webkit-scrollbar-track, 
.table_3::-webkit-scrollbar-track, .table_4::-webkit-scrollbar-track {

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
  width: 100%;
  padding: 10px 12px;
  font-size: 14px;
}
.content_photo_1>img, .content_photo_2>img {
	width: 200px;
	margin: 0.5px;
	margin-right: -5px;
}

.main_title {
	height: 220px;
}

.btn_box {
	
}

.main_table {
	width: 900px;
}

td>img {
	width: 200px;
}


button {
	background-color: dodgerblue;
	padding: 8px 30px !important;
	width: 243px;
	font-size: 14px;
	color: white;
	border: 0px solid transparent;
	float: left;
}

button:hover {
	background-color: skyblue;
}
.table_1, .table_2, .table_3, .table_4{
	width : 972px;
	height : 600px; 
	overflow: scroll;
}

th>img{
	width : 200px;
}

.menu_card{
 	width: 18rem;
 	float : left;
 	margin-left: 25px;
	margin-top: 15px;
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

/* 리뷰 관련 스타일 */ 
.content {
	border: 1px dotted gray;
}
/* 리뷰 프로필 이미지를 작은 원형으로 만든다. */
.profile-image {
	width: 30px;
	height: 30px;
	border: 1px solid #cecece;
	border-radius: 50%;
}
/* ul 요소의 기본 스타일 제거 */
.reviews ul {
	padding: 0;
	margin: 0;
	list-style-type: none;
}

.reviews dt {
	margin-top: 10px;
	position : relative;
}

.reviews dd {
	margin-left: 50px;
}

.review-form textarea, .review-form button {
	float: left;
}

.reviews li {
	clear: left;
}


/* 댓글에 댓글을 다는 폼과 수정폼은 일단 숨긴다. */
.reviews .review-form {
	display: none;
	text-align : left;
	height : 152px;
	width : 590px;
	padding : 0px;
	margin : 0px;
	margin-left : 3px;
	padding : 15px;
}

pre {
	display: block;
	padding: 9.5px;
	margin: 0 0 10px;
	font-size: 13px;
	line-height: 1.42857143;
	color: #333333;
	word-break: break-all;
	word-wrap: break-word;
    background-color: #eeffee;
    border: 1px solid #c9c9c9;
    border-radius: 10px
}

@keyframes rotateAni { 
	0%{
		transform: rotate(0deg);
	}
	100%{
		transform:rotate(360deg);
	}
}
#profileImage{
    width: 100px;
    height: 100px;
    border: 1px solid #cecece;
    border-radius: 50%;
  }
#imageForm{
	display: none;
   }

.col-2{
	width : auto;
	border:1px solid #c9c9c9; 
	border-radius:10px;
	padding : 0px;
	overflow:hidden;
}
.col-8{
	padding : 0px;
}
.comment_box{
	text-align : left;
	height : 152px;
	width : 590px;
	padding : 0px;
	margin : 0px;
	margin-left : 3px;
	padding : 15px;
}
.review_profile{
	background-color : #feffe6;
	right: 0px;
    height: 152px;
    width: 150px;
    position: absolute;
    padding : 10px;
}
.profile-image{
	width : 50px;
	height : 50px;
}
.review_img{
	width : 200px;
	height : 150px;
}
.row {
	margin-left : 10px;
}
.update-link{
	font-size : 15px;
	text-decoration : none;
	padding : 0px;
}
.delete-link{
	font-size : 15px;
	text-decoration : none;
	padding : 0px;
}
.regist_comment_box{
 	height: 100px; 
 	width: 692px;
    background-color: #eeffee;
    border: 1px solid #c9c9c9;
    border-radius: 10px;
	text-align : left;
	padding : 0px;
	margin : 0px;
	margin-left : 3px;
	padding : 15px;
}
.regist_btn{
	width:148px;
	height : 100px;
	margin-left:5px;
    border: 1px solid #c9c9c9;
    border-radius: 10px;
}
.comment_img{
	width:100px;
	height:100px;
	border: 1px solid #c9c9c9;
    border-radius: 10px;
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
				<h5 style="margin-left:20px;"><strong>"${keyword}"</strong>로 검색한 결과</h5>
				<c:forEach var="tmp" items="${list }">
					<div class="card" style="width: 18rem;">
	                    <img src="${pageContext.request.contextPath}/${tmp.imagePath}" class="card-img-top" alt="...">
	                    <div class="card-body">
	                    	<h5 class="card-title">${tmp.title }</h5>
	                    	<p class="card-text">${tmp.content}</p>
	                    	<a href="${pageContext.request.contextPath}/shop/detail?num=${tmp.num}" class="btn btn-primary">가게 정보 보기</a>
	                    </div>
	                </div>
                <br>
				</c:forEach>
            </div>
        </div>
        <div class="search_result">
                <div class="main_content">
		            <div class="content_images">

						<div class="main_title">
							<div id="map"style="width: 300px; height: 220px; margin: auto; float: right; "></div>

							<br>
							<br> <Strong>${dto.title }</Strong>
							<p>리뷰 ${dto.reviewCount } 회</p>
							<p>좋아요 : ${dto.likeCount}, 싫어요 : ${dto.dislikeCount }</p>
							<p style="margin: 0px;"></p>
						</div>
						<div class=btn_box>
							<button type="button" id="btn_1">가게 소개</button>
							<button type="button" id="btn_2">메뉴</button>
							<button type="button" id="btn_3">리뷰</button>
							<button type="button" id="btn_4">사진</button>
						</div>
					<div class="table_1">
						<table>
							<tbody>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 가게 소개 : ${dto.content }</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 전화 번호 : ${dto.telNum}</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 영업 시간 :</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 주소 : ${dto.addr }</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 단체 손님 환영</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>
								<tr class=shopInfo>
									<td colspan="5">&nbsp; 더미 데이터</td>
								</tr>


							</tbody>
						</table>
					</div>
					<div class="table_2">
						<table>
							<c:choose>
								<c:when test="${sessionScope.id eq 'admin'}">
									<a href="${pageContext.request.contextPath}/shop/menu_insertform?num=${dto.num}" style="display:block; width:101%;" class="btn btn-outline-warning">메뉴 추가</a>
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
						
							<tbody>
								<c:forEach var="tmp" items="${menuList }">
								<div class="menu_card card">
									<img src="${pageContext.request.contextPath}/${tmp.imagePath}" class="card-img-top" alt="...">
									<div class="card-body">
										<h5 class="card-title">${tmp.name}</h5>
										<p class="card-text">${tmp.content}</p>
										<a href="#" class="btn btn-primary">${tmp.price }원</a>
									</div>
								</div>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="table_3">
						<table style="width:950px;">
							<tbody>
								<tr>
									<td>리뷰</td>
								</tr>
								<tr>
									<td>평점  :  ${grade}점</td>
								</tr>
								<tr>
									<td>
										<div class="reviews">
											<ul>
												<c:forEach var="tmp" items="${reviewList }">
													<c:choose>
														<c:when test="${tmp.deleted eq 'yes' }">
															<li>삭제된 리뷰 입니다.</li>
														</c:when>
														<c:otherwise>
															<c:if test="${tmp.num eq tmp.review_group }">
																<li id="reli${tmp.num }">
															</c:if>
															
															<dl>
																<dt class="row">
																	<div class="col-2">
																		<c:if test="${ empty tmp.imagePath }">
																			<img class="review_img" src="${pageContext.request.contextPath}/resources/images/photo.png"/>
																		</c:if>
																		<c:if test="${not empty tmp.imagePath }">
																			<img class="review_img" src="${pageContext.request.contextPath}${tmp.imagePath}"/>
																		</c:if>
																	</div>
																	<div class="col-8">
																		<pre class="comment_box" id="pre${tmp.num }">${tmp.content }</pre>
																		<c:if test="${tmp.writer eq id }">
																			<form id="updateForm${tmp.num }"
																				class="review-form update-form" action="review_update"
																				method="post">
																				<input type="hidden" name="num" value="${tmp.num }" />
																				<textarea name="content">${tmp.content }</textarea>
																				<button type="submit" id="ur${tmp.num }">수정</button>
																			</form>
																		</c:if>
																	</div>
																	<div class="review_profile col-2 ">
																		<c:if test="${ empty tmp.profile }">
																			<svg class="profile-image" xmlns="http://www.w3.org/2000/svg"
																				width="16" height="16" fill="currentColor"
																				class="bi bi-person-circle" viewBox="0 0 16 16">
									                                      <path
																					d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" />
									                                      <path fill-rule="evenodd"
																					d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z" />
									                                    </svg>
																		</c:if>
																		<c:if test="${not empty tmp.profile }">
																			<img class="profile-image" src="${pageContext.request.contextPath}${tmp.profile }"  />
																		</c:if>
																		<br>
																		<span class="col">${tmp.writer }</span>
																		<br>
																		<span style="font-weight:100;">${tmp.regdate }</span> 
																		
																		<br>
																	
																		<c:choose>
																			<c:when test="${ (id ne null) and (tmp.writer eq id) }">
																				<a data-num="${tmp.num }" class="update-link btn btn-warning"
																					href="javascript:">수정</a>
																				<a data-num="${tmp.num }" class="delete-link btn btn-danger"
																					href="javascript:">삭제</a>
																			</c:when>
																			<c:when test="${id eq 'admin' }">
																				<a data-num="${tmp.num }" class="delete-link btn btn-danger"
																					href="javascript:">삭제</a>
																			</c:when>
																		</c:choose>
																	</div>
																</dt>

															</dl>
														</c:otherwise>
													</c:choose>
												</c:forEach>
											</ul>
										</div>
									</td>
								</tr>
								<tr>
								<td style="left: 10px; position: relative;">
								<!-- 원글에 리뷰를 작성할 폼 -->
										<form class="review-form insert-form" action="review_insert" method="post">
											<!-- 숨겨진 imageform을 통해 등록된 이미지를 폼에 제출할 수 있도록 하는 hidden input -->
  	  										<input type="hidden" name="imagePath" value="empty"/>
											
											<a id="profileLink" href="javascript:" style="float:left;">
												<img class="comment_img" src="${pageContext.request.contextPath}/resources/images/photo.png" alt=""/>
											</a>
											<label for="grade_number">1</label>
											<input type="radio" name="grade_number" value=1 />
											<label for="grade_number">2</label>
											<input type="radio" name="grade_number" value=2 />
											<label for="grade_number">3</label>
											<input type="radio" name="grade_number" value=3 />
											<label for="grade_number">4</label>
											<input type="radio" name="grade_number" value=4 />
											<label for="grade_number">5</label>
											<input type="radio" name="grade_number" value=5 />
											
											<!-- 원글의 글번호가 리뷰의 ref_group 번호가 된다. -->
											<input type="hidden" name="ref_group" value="${dto.num }" />
											<textarea class="regist_comment_box" name="content">${empty id ? '댓글 작성을 위해 로그인이 필요 합니다.' : '' }</textarea>
											<button class="regist_btn" type="submit">등록</button>

										</form>
										
										<!-- 이미지 등록용 숨겨진 form -->
									   <form id="imageForm" action="${pageContext.request.contextPath}/shop/review_image_upload" method="post" enctype="multipart/form-data">
									      사진
									      <input type="file" id="image" name="image" accept=".jpg, .png, .gif, .jpeg"/>
									      <button type="submit">업로드</button>
									   </form>
									</td>
								</tr>
							</tbody>
						</table>
						<nav>
							<ul class="pagination" style="margin:10px;">
								<%--
								  startPageNum 이 1 이 아닌 경우에만 Prev 링크를 제공한다. 
								  &condition=${condition}&keyword=${encodedK}
								--%>
								<c:if test="${startPageNum ne 1 }">
									<li class="page-item">
										<a class="page-link" href="list?pageNum=${startPageNum - 1 }&condition=${condition}&keyword=${encodedK}">Prev</a>
									</li>
								</c:if>
								<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
									<li class="page-item ${pageNum eq i ? 'active' : '' }">
										<a class="page-link" href="list?pageNum=${i }&condition=${condition}&keyword=${encodedK}">${i }</a>
									</li>
								</c:forEach>
				
								<%--
									마지막 페이지 번호가 전체 페이지의 갯수보다 작으면 Next 링크를 제공한다. 
								--%>
								<c:if test="${endPageNum lt totalPageCount }">
									<li class="page-item">
										<a class="page-link" href="list?pageNum=${endPageNum + 1 }&condition=${condition}&keyword=${encodedK}">Next</a>
									</li>
								</c:if>
							</ul>
						</nav>
					</div>
					<div class="table_4">
						<table>
							<tbody>
								<tr>
									<td> <img src="https://www.newiki.net/w/images/thumb/8/8f/Grilled_porterhouse_steak.jpg/450px-Grilled_porterhouse_steak.jpg" alt="" /></td>
									<td> <img src="https://www.newiki.net/w/images/thumb/8/8f/Grilled_porterhouse_steak.jpg/450px-Grilled_porterhouse_steak.jpg" alt="" /></td>
									<td> <img src="https://www.newiki.net/w/images/thumb/8/8f/Grilled_porterhouse_steak.jpg/450px-Grilled_porterhouse_steak.jpg" alt="" /></td>
								</tr>
									<td> <img src="https://www.newiki.net/w/images/thumb/8/8f/Grilled_porterhouse_steak.jpg/450px-Grilled_porterhouse_steak.jpg" alt="" /></td>
									<td> <img src="https://www.newiki.net/w/images/thumb/8/8f/Grilled_porterhouse_steak.jpg/450px-Grilled_porterhouse_steak.jpg" alt="" /></td>
									<td> <img src="" alt="" /></td>
								</tr>
								
							</tbody>
						</table>
					</div>

				</div>
		        </div>    
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
	geocoder.addressSearch( '${dto.addr}' , function(result, status) {
	
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
	            content: '<div style="width:150px;text-align:center;padding:6px 0;"> ${dto.title} </div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	});    
	</script>
	<script>

		window.onload = function() {
			$("#btn_1").css({"background-color" : "gray"})
			$("#btn_2").css({"background-color" : "#BDBDBD"})
			$("#btn_3").css({"background-color" : "#BDBDBD"})
			$("#btn_4").css({"background-color" : "#BDBDBD"})
			$(".table_1").show();
			$(".table_2").hide();
			$(".table_3").hide();
			$(".table_4").hide();
		}
		$(document).ready(function() {
			$("#btn_1").click(function() {
				$("#btn_1").css({"background-color" : "gray"})
				$("#btn_2").css({"background-color" : "#BDBDBD"})
				$("#btn_3").css({"background-color" : "#BDBDBD"})
				$("#btn_4").css({"background-color" : "#BDBDBD"})
				$(".table_1").show();
				$(".table_2").hide();
				$(".table_3").hide();
				$(".table_4").hide();
			})
			$("#btn_2").click(function() {
				$("#btn_1").css({"background-color" : "#BDBDBD"})
				$("#btn_2").css({"background-color" : "gray"})
				$("#btn_3").css({"background-color" : "#BDBDBD"})
				$("#btn_4").css({"background-color" : "#BDBDBD"})
				$(".table_1").hide();
				$(".table_2").show();
				$(".table_3").hide();
				$(".table_4").hide();
			})
			$("#btn_3").click(function() {
				$("#btn_1").css({"background-color" : "#BDBDBD"})
				$("#btn_2").css({"background-color" : "#BDBDBD"})
				$("#btn_3").css({"background-color" : "gray"})
				$("#btn_4").css({"background-color" : "#BDBDBD"})
				$(".table_1").hide();
				$(".table_2").hide();
				$(".table_3").show();
				$(".table_4").hide();
			})
			$("#btn_4").click(function() {
				$("#btn_1").css({"background-color" : "#BDBDBD"})
				$("#btn_2").css({"background-color" : "#BDBDBD"})
				$("#btn_3").css({"background-color" : "#BDBDBD"})
				$("#btn_4").css({"background-color" : "gray"})
				$(".table_1").hide();
				$(".table_2").hide();
				$(".table_3").hide();
				$(".table_4").show();
			})
		})

	</script>
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
    <script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
	<script>
      
      //클라이언트가 로그인 했는지 여부
      let isLogin=${ not empty id };
      
      document.querySelector(".insert-form")
         .addEventListener("submit", function(e){
            //만일 로그인 하지 않았으면 
            if(!isLogin){
               //폼 전송을 막고 
               e.preventDefault();
               //로그인 폼으로 이동 시킨다.
               location.href=
                  "${pageContext.request.contextPath}/users/loginform?url=${pageContext.request.contextPath}/shop/detail?num=${dto.num}";
            }
         });
      
      /*
         detail
          페이지 로딩 시점에 만들어진 1 페이지에 해당하는 
         댓글에 이벤트 리스너 등록 하기 
      */
      addUpdateFormListener(".update-form");
      addUpdateListener(".update-link");
      addDeleteListener(".delete-link");
      
      
      //댓글의 현재 페이지 번호를 관리할 변수를 만들고 초기값 1 대입하기
      let currentPage=1;
      //마지막 페이지는 totalPageCount 이다.  
      <%-- 댓글의 개수가 0일 때 오류를 발생하지 않기 위해 --%>
      let lastPage=${totalPageCount eq 0 ? 1 : totalPageCount};
      
      //추가로 댓글을 요청하고 그 작업이 끝났는지 여부를 관리할 변수 
      let isLoading=false; //현재 로딩중인지 여부 
      
      /*
         window.scrollY => 위쪽으로 스크롤된 길이
         window.innerHeight => 웹브라우저의 창의 높이
         document.body.offsetHeight => body 의 높이 (문서객체가 차지하는 높이)
      */
      window.addEventListener("scroll", function(){
         //바닥 까지 스크롤 했는지 여부 
         const isBottom = 
            window.innerHeight + window.scrollY  >= document.body.offsetHeight;
         //현재 페이지가 마지막 페이지인지 여부 알아내기
         let isLast = currentPage == lastPage;   
         //현재 바닥까지 스크롤 했고 로딩중이 아니고 현재 페이지가 마지막이 아니라면
         if(isBottom && !isLoading && !isLast){
            //로딩바 띄우기
            document.querySelector(".loader").style.display="block";
            
            //로딩 작업중이라고 표시
            isLoading=true;
            
            //현재 댓글 페이지를 1 증가 시키고 
            currentPage++;
            
            /*
               해당 페이지의 내용을 ajax 요청을 통해서 받아온다.
               "pageNum=xxx&num=xxx" 형식으로 GET 방식 파라미터를 전달한다. 
            */
            ajaxPromise("ajax_review_list","get",
                  "pageNum="+currentPage+"&num=${dto.num}")
            .then(function(response){
               //json 이 아닌 html 문자열을 응답받았기 때문에  return response.text() 해준다.
               return response.text();
            })
            .then(function(data){
               //data 는 html 형식의 문자열이다. 
               console.log(data);
               // beforebegin | afterbegin | beforeend | afterend
               document.querySelector(".reviews ul")
                  .insertAdjacentHTML("beforeend", data);
               //로딩이 끝났다고 표시한다.
               isLoading=false;
               //새로 추가된 댓글 li 요소 안에 있는 a 요소를 찾아서 이벤트 리스너 등록 하기 
               addUpdateListener(".page-"+currentPage+" .update-link");
               addDeleteListener(".page-"+currentPage+" .delete-link");
               addReplyListener(".page-"+currentPage+" .reply-link");
               //새로 추가된 댓글 li 요소 안에 있는 댓글 수정폼에 이벤트 리스너 등록하기
               addUpdateFormListener(".page-"+currentPage+" .update-form");
               
               //로딩바 숨기기
               document.querySelector(".loader").style.display="none";
            });
         }
      });
      
      //인자로 전달되는 선택자를 이용해서 이벤트 리스너를 등록하는 함수 
      function addUpdateListener(sel){
         //댓글 수정 링크의 참조값을 배열에 담아오기 
         // sel 은  ".page-xxx  .update-link" 형식의 내용이다 
         let updateLinks=document.querySelectorAll(sel);
         for(let i=0; i<updateLinks.length; i++){
            updateLinks[i].addEventListener("click", function(){
               //click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
               const num=this.getAttribute("data-num"); //댓글의 글번호
               
               const form = document.querySelector("#updateForm"+num);
               const form2 = document.querySelector("#pre"+num);
               
               //현재 문자열 읽어오기 ( "수정" or "취소")
               let current = this.innerText;
               
               if(current == "수정"){
            	   form.style.display="block";
            	   form2.style.display="none";
                   form.classList.add("animate__flash");
                   this.innerText="취소";   
                   form.addEventListener("animationend", function(){
                      form.classList.remove("animate__flash");
                   }, {once:true});
                   document.querySelector("#ur"+num).addEventListener("click", function(){
                	   form2.style.display="block";	
                	   updateLinks[i].innerText = "수정";
				   });
                 }else if(current == "취소"){
                    form.classList.add("animate__fadeOut");
                    this.innerText="수정";
                    form.addEventListener("animationend", function(){
                       form.classList.remove("animate__fadeOut");
                       form.style.display="none";
                       form2.style.display="block";
                    },{once:true});
               }
               
               
            });
         }
      }
      function addDeleteListener(sel){
         //댓글 삭제 링크의 참조값을 배열에 담아오기 
         let deleteLinks=document.querySelectorAll(sel);
         for(let i=0; i<deleteLinks.length; i++){
            deleteLinks[i].addEventListener("click", function(){
               //click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
               const num=this.getAttribute("data-num"); //댓글의 글번호
               const isDelete=confirm("리뷰를 삭제 하시겠습니까?");
               if(isDelete){
                  // gura_util.js 에 있는 함수들 이용해서 ajax 요청
                  ajaxPromise("review_delete", "post", "num="+num)
                  .then(function(response){
                     return response.json();
                  })
                  .then(function(data){
                     //만일 삭제 성공이면 
                     if(data.isSuccess){
                        //댓글이 있는 곳에 삭제된 댓글입니다를 출력해 준다. 
                        document.querySelector("#reli"+num).innerText="삭제된 리뷰입니다.";
                     }
                  });
               }
            });
         }  
      }
      
      function addUpdateFormListener(sel){
         //댓글 수정 폼의 참조값을 배열에 담아오기
         let updateForms=document.querySelectorAll(sel);
         for(let i=0; i<updateForms.length; i++){
            //폼에 submit 이벤트가 일어 났을때 호출되는 함수 등록 
            updateForms[i].addEventListener("submit", function(e){
               //submit 이벤트가 일어난 form 의 참조값을 form 이라는 변수에 담기 
               const form=this;
               //폼 제출을 막은 다음 
               e.preventDefault();
               //이벤트가 일어난 폼을 ajax 전송하도록 한다.
               ajaxFormPromise(form)
               .then(function(response){
                  return response.json();
               })
               .then(function(data){
                  if(data.isSuccess){
                     /*
                        document.querySelector() 는 html 문서 전체에서 특정 요소의 
                        참조값을 찾는 기능
                        
                        특정문서의 참조값.querySelector() 는 해당 문서 객체의 자손 요소 중에서
                        특정 요소의 참조값을 찾는 기능
                     */
                     const num=form.querySelector("input[name=num]").value;
                     const content=form.querySelector("textarea[name=content]").value;
                     //수정폼에 입력한 value 값을 pre 요소에도 출력하기 
                     document.querySelector("#pre"+num).innerText=content;
                     form.style.display="none";
                  }
               });
            });
         }
      }
    //이미지 링크를 클릭하면 
		document.querySelector("#profileLink").addEventListener("click", function(){
			document.querySelector("#image").click();	
		});   

		document.querySelector("#image").addEventListener("change", function(){
			const form = document.querySelector("#imageForm"); 
			ajaxFormPromise(form)
			.then(function(response){
				return response.json();
			})
			.then(function(data){
				document.querySelector("input[name=imagePath]").value = data.imagePath;
				let img = `<img id="profileImage" src="${pageContext.request.contextPath }\${data.imagePath}">`;
				document.querySelector("#profileLink").innerHTML=img;
			});
		});
   </script>
</body>
</html>