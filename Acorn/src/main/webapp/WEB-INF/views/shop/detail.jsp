<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>detail.jsp</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js"
	integrity="sha256-HwWONEZrpuoh951cQD1ov2HUK5zA5DwJ1DNUXaM6FsY="
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
	<link rel="stylesheet" type="text/css" href="../resources/css/shop_detail.css">
</head>

<body>
	<div class="container">
		<div class="header">
			<c:choose>
				<c:when test="${ empty sessionScope.id}">
					<a href="${pageContext.request.contextPath}" class="logo_text">
						<img class="logo" src="${pageContext.request.contextPath}/resources/images/logos/cloud${dto.num}.png" alt="" style ="height:40px; margin:5px;"/>
						<p class="cloud_effect">FOOD CLOUD</p>
					</a>
					<a href="${pageContext.request.contextPath}/users/loginform" class="top_menu btn btn-outline-dark">LOGIN</a>
					<a href="${pageContext.request.contextPath}/users/signup_form" class="top_menu btn btn-outline-success">SIGN-UP</a>
				</c:when>
				<c:when test="${sessionScope.id eq 'admin'}">
					<a href="${pageContext.request.contextPath}" class="logo_text">
						<img class="logo" src="${pageContext.request.contextPath}/resources/images/logos/cloud${dto.num}.png" alt="" />
						<p class="cloud_effect">FOOD CLOUD</p>
					</a>
					<a href="${pageContext.request.contextPath}/shop/insertform" class="user_menu badge text-bg-success">REGIST SHOP</a>
					<a href="${pageContext.request.contextPath}/users/list" class="user_menu badge text-bg-warning">USER LIST</a>
					<a href="${pageContext.request.contextPath}/users/info" class="rainbow_effect user_menu badge">${sessionScope.id }</a>
					<a href="${pageContext.request.contextPath}/users/logout" class="logout_menu btn btn-outline-danger">LOGOUT</a>
				</c:when>
				<c:otherwise>
					<a href="${pageContext.request.contextPath}" class="logo_text">
						<img class="logo" src="${pageContext.request.contextPath}/resources/images/logos/cloud${dto.num}.png" alt="" />
						<p class="cloud_effect">FOOD CLOUD</p>
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
						<button type="submit" style="display: contents">
							<img class="search_img" src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" alt="" />
						</button>
						<input class="search_input" type="text" name="keyword" value="${keyword}" placeholder="가게 명을 입력하세요...">
					</div>
				</form>
			</div>

			<hr>
			<div class="suggest_menu">
				<c:choose>
					<c:when test="${ empty keyword}">
						<h5 style="margin-left: 20px;">STORE LIST</h5>
					</c:when>
					<c:otherwise>
						<h5 style="margin-left: 20px;">
							<strong>"${keyword}"</strong>로 검색한 결과
						</h5>
					</c:otherwise>
				</c:choose>

				<c:forEach var="tmp" items="${list }">
					<div class="card" style="width: 18rem;">
						<img src="${pageContext.request.contextPath}/${tmp.imagePath}" class="card-img-top" alt="...">
						
						<div class="card-body">
							<h5 class="card-title">${tmp.title }</h5>
							<p class="card-text">${tmp.content}</p>
							<a href="${pageContext.request.contextPath}/shop/detail?num=${tmp.num}"
								class="btn btn-primary" id="card_info">INFO</a>
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
							<br> 
							<Strong style="font-size : 30px;">${dto.title}</Strong>
							<br /><br /><br />
							<p>리뷰 ${reviewCount} 회</p>
							<p style="margin: 0px;"></p>
						</div>
						<div class=btn_box>
							<button type="button" id="btn_1"><span>가게 소개</span></button>
							<button type="button" id="btn_2"><span>메뉴</span></button>
							<button type="button" id="btn_3"><span>리뷰</span></button>
							<button class="rainbow_effect" type="button" id="btn_4"><span class="rainbow_effect">★</span></button>
						</div>
					<div class="table_1" style="display:none;">
						<c:if test="${sessionScope.id eq 'admin'}">
							<a href="delete?num=${ dto.num}" style="display: block; width: 101%;"
								class="btn btn-outline-danger">가게 삭제</a>
						</c:if>
						
						<div class="table1_warpper">
							<table class="shop_info">
								<tbody>
									<tr class=shopInfo>
										<td style="border-right: 1px solid gray">소개</td>
										<td>${dto.content}</td>
									</tr>
									<tr style="height: 40px"></tr>
									<tr class=shopInfo>
										<td style="border-right: 1px solid gray">카테고리</td>
										<td>${dto.categorie}</td>
									</tr>
									<tr style="height: 40px"></tr>
									<tr class=shopInfo>
										<td style="border-right: 1px solid gray">영업 시간</td>
										<td>${startTime}~ ${endTime}</td>
									</tr>
									<tr style="height: 40px"></tr>
									<tr class=shopInfo>
										<td style="border-right: 1px solid gray">주소</td>
										<td>${dto.addr}</td>
									</tr>
									<tr style="height: 40px"></tr>
									<tr class=shopInfo>
										<td style="border-right: 1px solid gray">전화 번호</td>
										<td>${dto.telNum}</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					
					<div class="table_2" style="display: none;">
						<table>
							<c:if test="${sessionScope.id eq 'admin'}">
								<a
									href="${pageContext.request.contextPath}/shop/menu_insertform?num=${dto.num}"
									style="display: block; width: 101%;"
									class="btn btn-outline-warning">메뉴 추가</a>
							</c:if>
							
							<tbody>
								<c:forEach var="tmp" items="${menuList }">
									<div class="menu_card card">
										<img src="${pageContext.request.contextPath}/${tmp.imagePath}"
											class="card-img-top" alt="...">
										
										<div class="card-body">
											<h5 class="card-title">${tmp.name}</h5>
											<p class="card-text">${tmp.content}</p>
											<p class="btn btn-primary">${tmp.price }원</p>
										</div>
									</div>
								</c:forEach>
							</tbody>
						</table>
					</div>
					
					<div class="table_3" style="display: none;">
						<table style="width: 950px;">
							<tbody>
								<tr>
									<td>평점 : ${grade}</td>
								</tr>
								<tr>
									<td>
										<div class="reviews">
											<ul>
												<c:forEach var="tmp" items="${reviewList }">
													<c:choose>
														<c:when test="${tmp.deleted eq 'yes' }">
															<dt class="row" style="height:152px; border: 1px solid #c9c9c9; border-radius: 10px; padding-top:60px;">
																<li>삭제된 리뷰 입니다.</li>
															</dt>
														</c:when>
														<c:otherwise>
															<c:if test="${tmp.num eq tmp.review_group }">
																<li id="reli${tmp.num }">
															</c:if>

															<dl>
																<dt class="row">
																	<div class="col-2">
																		<c:choose>
																			<c:when
																				test="${empty tmp.imagePath or tmp.imagePath eq 'empty' }">
																				<img class="review_img"
																					src="${pageContext.request.contextPath}/resources/images/photo.png" />
																			</c:when>
																			<c:otherwise>
																				<img class="review_img"
																					src="${pageContext.request.contextPath}${tmp.imagePath}" />
																			</c:otherwise>
																		</c:choose>
																	</div>
																	
																	<div class="col-8">
																		<div class="comment_box" id="pre${tmp.num }">
																			<input class="review_title_box" type="text"
																				name="title" id="spt${tmp.num }"
																				value="${tmp.title}" disabled />

																			<div class="startRadio"
																				style="pointer-events: none; display: inline-block; overflow: hidden; height: 40px; float: right; position: relative; right: 140px; bottom: 5px; z-index: 9;">
																				<label class="startRadio__box"> <input
																					type="radio" name="grade_number" value=0.5
																					${tmp.grade eq 0.5 ? 'class="point"' : '' }>
																					<span class="startRadio__img"><span
																						class="blind">별 0.5개</span></span>
																				</label> <label class="startRadio__box"> <input
																					type="radio" name="grade_number" value=1
																					${tmp.grade eq 1 ? 'class="point"' : '' }>
																					<span class="startRadio__img"><span
																						class="blind">별 1개</span></span>
																				</label> <label class="startRadio__box"> <input
																					type="radio" name="grade_number" value=1.5
																					${tmp.grade eq 1.5 ? 'class="point"' : '' }>
																					<span class="startRadio__img"><span
																						class="blind">별 1.5개</span></span>
																				</label> <label class="startRadio__box"> <input
																					type="radio" name="grade_number" value=2
																					${tmp.grade eq 2 ? 'class="point"' : '' }>
																					<span class="startRadio__img"><span
																						class="blind">별 2개</span></span>
																				</label> <label class="startRadio__box"> <input
																					type="radio" name="grade_number" value=2.5
																					${tmp.grade eq 2.5 ? 'class="point"' : '' }>
																					<span class="startRadio__img"><span
																						class="blind">별 2.5개</span></span>
																				</label> <label class="startRadio__box"> <input
																					type="radio" name="grade_number" value=3
																					${tmp.grade eq 3 ? 'class="point"' : '' }>
																					<span class="startRadio__img"><span
																						class="blind">별 3개</span></span>
																				</label> <label class="startRadio__box"> <input
																					type="radio" name="grade_number" value=3.5
																					${tmp.grade eq 3.5 ? 'class="point"' : '' }>
																					<span class="startRadio__img"><span
																						class="blind">별 3.5개</span></span>
																				</label> <label class="startRadio__box"> <input
																					type="radio" name="grade_number" value=4
																					${tmp.grade eq 4 ? 'class="point"' : '' }>
																					<span class="startRadio__img"><span
																						class="blind">별 4개</span></span>
																				</label> <label class="startRadio__box"> <input
																					type="radio" name="grade_number" value=4.5
																					${tmp.grade eq 4.5 ? 'class="point"' : '' }>
																					<span class="startRadio__img"><span
																						class="blind">별 4.5개</span></span>
																				</label> <label class="startRadio__box"> <input
																					type="radio" name="grade_number" value=5
																					${tmp.grade eq 5 ? 'class="point"' : '' }>
																					<span class="startRadio__img"><span
																						class="blind">별 5개</span></span>
																				</label>
																			</div>
																			<br />
																			<textarea class="review_content_box"
																				id="spc${tmp.num }" name="content" disabled>${tmp.content}</textarea>
																		</div>
																		
																		<!-- 수정폼 -->
																		<c:if test="${tmp.writer eq id }">
																			<form id="updateForm${tmp.num }"
																				class="review-form update-form"
																				action="review_update" method="post">
																				<input type="hidden" name="num" value="${tmp.num }" />
																				<input type="text" name="title"
																					value="${tmp.title }" />
																				<div class="startRadio">
																					<label class="startRadio__box"> <input
																						type="radio" name="grade_number" value=0.5
																						${tmp.grade eq 0.5 ? 'checked' : '' } disabled>
																						<span class="startRadio__img"><span
																							class="blind">별 0.5개</span></span>
																					</label> <label class="startRadio__box"> <input
																						type="radio" name="grade_number" value=1
																						${tmp.grade eq 1 ? 'checked' : '' } disabled>
																						<span class="startRadio__img"><span
																							class="blind">별 1개</span></span>
																					</label> <label class="startRadio__box"> <input
																						type="radio" name="grade_number" value=1.5
																						${tmp.grade eq 1.5 ? 'checked' : '' } disabled>
																						<span class="startRadio__img"><span
																							class="blind">별 1.5개</span></span>
																					</label> <label class="startRadio__box"> <input
																						type="radio" name="grade_number" value=2
																						${tmp.grade eq 2 ? 'checked' : '' } disabled>
																						<span class="startRadio__img"><span
																							class="blind">별 2개</span></span>
																					</label> <label class="startRadio__box"> <input
																						type="radio" name="grade_number" value=2.5
																						${tmp.grade eq 2.5 ? 'checked' : '' } disabled>
																						<span class="startRadio__img"><span
																							class="blind">별 2.5개</span></span>
																					</label> <label class="startRadio__box"> <input
																						type="radio" name="grade_number" value=3
																						${tmp.grade eq 3 ? 'checked' : '' } disabled>
																						<span class="startRadio__img"><span
																							class="blind">별 3개</span></span>
																					</label> <label class="startRadio__box"> <input
																						type="radio" name="grade_number" value=3.5
																						${tmp.grade eq 3.5 ? 'checked' : '' } disabled>
																						<span class="startRadio__img"><span
																							class="blind">별 3.5개</span></span>
																					</label> <label class="startRadio__box"> <input
																						type="radio" name="grade_number" value=4
																						${tmp.grade eq 4 ? 'checked' : '' } disabled>
																						<span class="startRadio__img"><span
																							class="blind">별 4개</span></span>
																					</label> <label class="startRadio__box"> <input
																						type="radio" name="grade_number" value=4.5
																						${tmp.grade eq 4.5 ? 'checked' : '' } disabled>
																						<span class="startRadio__img"><span
																							class="blind">별 4.5개</span></span>
																					</label> <label class="startRadio__box"> <input
																						type="radio" name="grade_number" value=5
																						${tmp.grade eq 5 ? 'checked' : '' } disabled>
																						<span class="startRadio__img"><span
																							class="blind">별 5개</span></span>
																					</label>
																				</div>

																				<textarea name="content">${tmp.content }</textarea>
																				<button type="submit" id="ur${tmp.num }"
																					class=comment_edit_btn>수정</button>
																			</form>
																		</c:if>
																	</div>
																	
																	<div class="review_profile col-2 ">
																		<c:if test="${ empty tmp.profile }">
																			<svg class="profile-image"
																				xmlns="http://www.w3.org/2000/svg" width="16"
																				height="16" fill="currentColor"
																				class="bi bi-person-circle" viewBox="0 0 16 16">
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
																		<br> <span class="col">${tmp.writer }</span> <br>
																		<span style="font-weight: 100;">${tmp.regdate }</span>

																		<br>

																		<c:choose>
																			<c:when
																				test="${ (id ne null) and (tmp.writer eq id) }">
																				<a data-num="${tmp.num }"
																					class="update-link btn btn-warning"
																					href="javascript:">수정</a>
																				<a data-num="${tmp.num }"
																					class="delete-link btn btn-danger"
																					href="javascript:">삭제</a>
																			</c:when>
																			<c:when test="${id eq 'admin' }">
																				<a data-num="${tmp.num }"
																					class="delete-link btn btn-danger"
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
										<div class="comment_form_box">
											<form class="review-form insert-form" action="review_insert"
												method="post">
												<input type="text" name="title" id="title"
													placeholder="한줄평 입력..." />
												<div class="startRadio">
													<label class="startRadio__box"> <input type="radio"
														name="grade_number" value=0.5> <span
														class="startRadio__img"><span class="blind">별
																0.5개</span></span>
													</label> <label class="startRadio__box"> <input
														type="radio" name="grade_number" value=1> <span
														class="startRadio__img"><span class="blind">별
																1개</span></span>
													</label> <label class="startRadio__box"> <input
														type="radio" name="grade_number" value=1.5> <span
														class="startRadio__img"><span class="blind">별
																1.5개</span></span>
													</label> <label class="startRadio__box"> <input
														type="radio" name="grade_number" value=2> <span
														class="startRadio__img"><span class="blind">별
																2개</span></span>
													</label> <label class="startRadio__box"> <input
														type="radio" name="grade_number" value=2.5> <span
														class="startRadio__img"><span class="blind">별
																2.5개</span></span>
													</label> <label class="startRadio__box"> <input
														type="radio" name="grade_number" value=3> <span
														class="startRadio__img"><span class="blind">별
																3개</span></span>
													</label> <label class="startRadio__box"> <input
														type="radio" name="grade_number" value=3.5> <span
														class="startRadio__img"><span class="blind">별
																3.5개</span></span>
													</label> <label class="startRadio__box"> <input
														type="radio" name="grade_number" value=4> <span
														class="startRadio__img"><span class="blind">별
																4개</span></span>
													</label> <label class="startRadio__box"> <input
														type="radio" name="grade_number" value=4.5> <span
														class="startRadio__img"><span class="blind">별
																4.5개</span></span>
													</label> <label class="startRadio__box"> <input
														type="radio" name="grade_number" value=5 checked>
														<span class="startRadio__img"><span class="blind">별
																5개</span></span>
													</label>
												</div>
												
												<!-- 유저가 사진 등록을 위해 클릭하게 될 이미지 -->
												<a id="thumbnailLink" href="javascript:"
													style="float: left;"> <img class="comment_img"
													src="${pageContext.request.contextPath}/resources/images/photo.png"
													alt="" />
												</a>
											
												<!-- 실제 폼에 제출되는 이미지 값 -->
												<input type="hidden" name="imagePath" value="empty" />
												
												<input type="hidden" name="ref_group" value="${dto.num }" />
												<textarea class="regist_comment_box" name="content">${empty id ? '댓글 작성을 위해 로그인이 필요 합니다.' : '' }</textarea>
												<button class="regist_btn" type="submit">등록</button>
											</form>
										</div> 
										
										<!-- 리뷰 테이블에 이미지 업로드를 위한 폼 -->
										<form id="imageForm"
											action="${pageContext.request.contextPath}/shop/review_image_upload"
											method="post" enctype="multipart/form-data">
											사진 <input type="file" id="image" name="image"
												accept=".jpg, .png, .gif, .jpeg" />
											<button type="submit">업로드</button>
										</form>
									</td>
								</tr>
							</tbody>
						</table>
						
						<nav>
							<ul class="pagination" style="margin: 10px;">
								
								<c:if test="${rvStartPageNum ne 1 }">
									<li class="page-item"><a class="page-link"
										href="detail?num=${dto.num}&rvPageNum=${rvStartPageNum - 1 }&condition=${condition}&keyword=${encodedK}">Prev</a>
									</li>
								</c:if>
								
								<c:forEach var="i" begin="${rvStartPageNum }"
									end="${rvEndPageNum }">
									<li class="page-item ${rvPageNum eq i ? 'active' : '' }">
										<a class="page-link"
										href="detail?num=${dto.num }&rvPageNum=${i }&condition=${condition}&keyword=${encodedK}">${i }</a>
									</li>
								</c:forEach>
							
								<c:if test="${rvEndPageNum lt rvTotalPageCount }">
									<li class="page-item"><a class="page-link"
										href="detail?num=${dto.num }&rvPageNum=${rvEndPageNum + 1 }&condition=${condition}&keyword=${encodedK}">Next</a>
									</li>
								</c:if>
							</ul>
						</nav>
					</div>
					
					<div class="table_4" style="display: none;">
						<!-- 임시 페이지 입니다.(추후 기능 구현 시 사용) -->
					</div>
				</div>
			</div>
		</div>
		<div class="bottom"></div>
	</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2b45a7e1f67e033582e03cb02a068e52&libraries=services"></script>
	
	<!-- 지도 생성 script -->
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
	
	<!-- tab menu 컨트롤 코드 -->
	<script>
		window.onload = function() {
			if(sessionStorage.getItem("beforePage")==null){
				var beforePage=1;
			}else{
				var beforePage=sessionStorage.getItem("beforePage");
			}

			if(sessionStorage.getItem("beforePage")==1){
				$("#btn_1").css({"background-color" : "#B2CCFF"})
				$("#btn_2").css({"background-color" : "#D5D5D5"})
				$("#btn_3").css({"background-color" : "#D5D5D5"})
				$("#btn_4").css({"background-color" : "#D5D5D5"})
				$(".table_1").show();
				$(".table_2").hide();
				$(".table_3").hide();
				$(".table_4").hide();
				console.log("온로드 : "+beforePage);
			}else if(sessionStorage.getItem("beforePage")==2){
				$("#btn_1").css({"background-color" : "#D5D5D5"})
				$("#btn_2").css({"background-color" : "#B2CCFF"})
				$("#btn_3").css({"background-color" : "#D5D5D5"})
				$("#btn_4").css({"background-color" : "#D5D5D5"})
				$(".table_1").hide();
				$(".table_2").show();
				$(".table_3").hide();
				$(".table_4").hide();
				console.log("온로드 : "+beforePage);
			}else if(sessionStorage.getItem("beforePage")==3){
				$("#btn_1").css({"background-color" : "#D5D5D5"})
				$("#btn_2").css({"background-color" : "#D5D5D5"})
				$("#btn_3").css({"background-color" : "#B2CCFF"})
				$("#btn_4").css({"background-color" : "#D5D5D5"})
				$(".table_1").hide();
				$(".table_2").hide();
				$(".table_3").show();
				$(".table_4").hide();
				console.log("온로드 : "+beforePage);
			}else if(sessionStorage.getItem("beforePage")==4){
				$("#btn_1").css({"background-color" : "#D5D5D5"})
				$("#btn_2").css({"background-color" : "#D5D5D5"})
				$("#btn_3").css({"background-color" : "#D5D5D5"})
				$("#btn_4").css({"background-color" : "#B2CCFF"})
				$(".table_1").hide();
				$(".table_2").hide();
				$(".table_3").hide();
				$(".table_4").show();
				console.log("온로드 : "+beforePage);
			}
		}
		$(document).ready(function() {
			$(".card-body a").click(function() {
				$("#btn_1").css({"background-color" : "#B2CCFF"})
				$("#btn_2").css({"background-color" : "#D5D5D5"})
				$("#btn_3").css({"background-color" : "#D5D5D5"})
				$("#btn_4").css({"background-color" : "#D5D5D5"})
				$(".table_1").show();
				$(".table_2").hide();
				$(".table_3").hide();
				$(".table_4").hide();
				beforePage=1;
				sessionStorage.setItem("beforePage", beforePage);
				console.log("카드인포 : "+beforePage);
			})
			$("#btn_1").click(function() {
				$("#btn_1").css({"background-color" : "#B2CCFF"})
				$("#btn_2").css({"background-color" : "#D5D5D5"})
				$("#btn_3").css({"background-color" : "#D5D5D5"})
				$("#btn_4").css({"background-color" : "#D5D5D5"})
				$(".table_1").show();
				$(".table_2").hide();
				$(".table_3").hide();
				$(".table_4").hide();
				beforePage=1;
				sessionStorage.setItem("beforePage", beforePage);
				console.log("버튼1 : "+beforePage);
			})
			$("#btn_2").click(function() {
				$("#btn_1").css({"background-color" : "#D5D5D5"})
				$("#btn_2").css({"background-color" : "#B2CCFF"})
				$("#btn_3").css({"background-color" : "#D5D5D5"})
				$("#btn_4").css({"background-color" : "#D5D5D5"})
				$(".table_1").hide();
				$(".table_2").show();
				$(".table_3").hide();
				$(".table_4").hide();
				beforePage=2;
				sessionStorage.setItem("beforePage", beforePage);
				console.log("버튼2 : "+beforePage);
			})
			$("#btn_3").click(function() {
				$("#btn_1").css({"background-color" : "#D5D5D5"})
				$("#btn_2").css({"background-color" : "#D5D5D5"})
				$("#btn_3").css({"background-color" : "#B2CCFF"})
				$("#btn_4").css({"background-color" : "#D5D5D5"})
				$(".table_1").hide();
				$(".table_2").hide();
				$(".table_3").show();
				$(".table_4").hide();
				beforePage=3;
				sessionStorage.setItem("beforePage", beforePage);
				console.log("버튼3 : "+beforePage);
			})
			$("#btn_4").click(function() {
				$("#btn_1").css({"background-color" : "#D5D5D5"})
				$("#btn_2").css({"background-color" : "#D5D5D5"})
				$("#btn_3").css({"background-color" : "#D5D5D5"})
				$("#btn_4").css({"background-color" : "#B2CCFF"})
				$(".table_1").hide();
				$(".table_2").hide();
				$(".table_3").hide();
				$(".table_4").show();
				beforePage=4;
				sessionStorage.setItem("beforePage", beforePage);
				console.log("버튼4 : "+beforePage);
			})
			$(".regist_btn").click(function() {
				$("#btn_1").css({"background-color" : "#D5D5D5"})
				$("#btn_2").css({"background-color" : "#D5D5D5"})
				$("#btn_3").css({"background-color" : "#B2CCFF"})
				$("#btn_4").css({"background-color" : "#D5D5D5"})
				$(".table_1").hide();
				$(".table_2").hide();
				$(".table_3").show();
				$(".table_4").hide();
				beforePage=3;
				sessionStorage.setItem("beforePage", beforePage);
				console.log("등록버튼 : "+beforePage);
			})
			$(".page-link").click(function() {
				$("#btn_1").css({"background-color" : "#D5D5D5"})
				$("#btn_2").css({"background-color" : "#D5D5D5"})
				$("#btn_3").css({"background-color" : "#B2CCFF"})
				$("#btn_4").css({"background-color" : "#D5D5D5"})
				$(".table_1").hide();
				$(".table_2").hide();
				$(".table_3").show();
				$(".table_4").hide();
				beforePage=3;
				sessionStorage.setItem("beforePage", beforePage);
				console.log("페이징버튼 : "+beforePage);
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
				</a> <span class="mb-3 mb-md-0 text-muted">&copy; 2023 Acorn,
					Team 1</span>
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
	
	<!-- 리뷰 관리 script -->
	<script>
      //로그인 여부 확인
      let isLogin=${ not empty id };
      
      document.querySelector(".insert-form")
         .addEventListener("submit", function(e){
            if(!isLogin){
               e.preventDefault();
               location.href=
                  "${pageContext.request.contextPath}/users/loginform?url=${pageContext.request.contextPath}/shop/detail?num=${dto.num}";
            }
         });
      
      //댓글에 이벤트 리스너 등록 하기 
      addUpdateFormListener(".update-form");
      addUpdateListener(".update-link");
      addDeleteListener(".delete-link");
       
      function addUpdateListener(sel){
         let updateLinks=document.querySelectorAll(sel);
         for(let i=0; i<updateLinks.length; i++){
            updateLinks[i].addEventListener("click", function(){
               const num=this.getAttribute("data-num");
               const form = document.querySelector("#updateForm"+num);
               const form2 = document.querySelector("#pre"+num);
               
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
         let deleteLinks=document.querySelectorAll(sel);
         for(let i=0; i<deleteLinks.length; i++){
            deleteLinks[i].addEventListener("click", function(){
               const num=this.getAttribute("data-num");
               const isDelete=confirm("리뷰를 삭제 하시겠습니까?");
               if(isDelete){
                  ajaxPromise("review_delete", "post", "num="+num)
                  .then(function(response){
                     return response.json();
                  })
                  .then(function(data){
                     if(data.isSuccess){
                        document.querySelector("#reli"+num).innerText="삭제된 리뷰입니다.";
                     }
                  });
               }
            });
         }  
      }
      
      function addUpdateFormListener(sel){
         let updateForms=document.querySelectorAll(sel);
         for(let i=0; i<updateForms.length; i++){
            updateForms[i].addEventListener("submit", function(e){
               const form=this;
               e.preventDefault();
               ajaxFormPromise(form)
               .then(function(response){
                  return response.json();
               })
               .then(function(data){
                  if(data.isSuccess){
                     const num = form.querySelector("input[name=num]").value;
                     const title = form.querySelector("input[name=title]").value;
                     const content = form.querySelector("textarea[name=content]").value;
                     document.querySelector("#spt"+num).value=title;
                     document.querySelector("#spc"+num).innerText=content;
                     form.style.display="none";
                  }
               });
            });
         }
      }
      
		document.querySelector("#thumbnailLink").addEventListener("click", function(){
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
				let img = `<img class="comment_img" src="${pageContext.request.contextPath }\${data.imagePath}">`;
				document.querySelector("#thumbnailLink").innerHTML=img;
			});
		});
   </script>
</body>
</html>