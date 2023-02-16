<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/index.css">
<link rel="shortcut icon" href="#">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<link rel="stylesheet" type="text/css" href="../resources/css/shop_detail.css">
</head>

<body>
	<jsp:include page="../../views/include/navbar.jsp">
		<jsp:param value="detail" name="thisPage"/>
	</jsp:include>
	<div data-bs-spy="scroll" data-bs-target="#simple-list-example" data-bs-offset="0" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
		<div class="shop">
			<div id="simple-list-item-1" class="shop_board_top">
				<img src="https://i.pinimg.com/736x/59/4f/22/594f229ad803a615c4dc1766829dd13c.jpg" alt="" />
			</div>
			<div class="shop_board_body1">
				<div class="shop_board_title">
				<br />
					<p class="shop_title">${dto.title }</p>
					<p class="shop_desc">${dto.content}</p>
					<p class="shop_review_count"><span style="color:black; font-weight:bold">리뷰</span> ${reviewCount}</p>
					<a class="category_tag btn btn-outline-danger" href="${pageContext.request.contextPath}/shop/list?category=${dto.categorie}">#${dto.categorie}</a>
					<a href="${pageContext.request.contextPath}/shop/updateform?num=${dto.num }">정보 수정</a>
				</div>
	
				<div class="shop_board_info">
					<strong>가게 정보</strong>
					<table class="shop_board_info_table">
						<tbody>
							<tr>
								<td class="table_icon"><img src="${pageContext.request.contextPath}/resources/images/shop_info/address.png" alt="주소" class="shop_info_icon" title="주소"/></td>
								<td class="table_content">${dto.addr}</td>
							</tr>
							<tr>
								<td class="table_icon"><img src="${pageContext.request.contextPath}/resources/images/shop_info/runningtime.png" alt="영업시간" class="shop_info_icon" title="영업 시간"/></td>
								<td class="table_content">영업 시작 : ${startTime}</td>
							</tr>
							<tr>
								<td class="table_icon"></td>
								<td class="table_content">영업 종료 : ${endTime}</td>
							</tr>
							<tr>
								<td class="table_icon"><img src="${pageContext.request.contextPath}/resources/images/shop_info/callnumber.png" alt="전화번호" class="shop_info_icon" title="전화번호"/></td>
								<td class="table_content">${dto.telNum}</td>
							</tr>
							<tr>
								<td class="table_icon"><img src="${pageContext.request.contextPath}/resources/images/shop_info/hashtag.png" alt="대표 키워드" class="shop_info_icon" title="대표 키워드"/></td>
								<td class="table_content">
								<c:if test="${grade gt 4.5}">
									<p class="best_store btn btn-danger">🌟4.5↑</p>
								</c:if>
								<c:if test="${reviewCount gt 50}">
									<p class="best_store btn btn-success">✏️50↑</p>
								</c:if>
								평점 몇점 이상 #맛집, 리뷰 많으면 #이구역최대리뷰 기준은 추가해나갑시다
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="shop_board_separator"></div>
			<div class="shop_board_body2">
					<div class="shop_board_menu">				
					<strong>메뉴</strong>
					<c:if test="${sessionScope.id eq 'admin'}">
						<a
							href="${pageContext.request.contextPath}/shop/menu_insertform?num=${dto.num}"
							class="menu_insert btn btn-outline-warning">+</a>
					</c:if>
					<ul class="shop_board_menu_list">
							<c:forEach var="tmp" items="${menuList }">
								<li class="menu_item">
									<div class="menu_name_price">
										<span class="menu_name">${tmp.name}</span>
										<span class="menu_price">${tmp.price}</span>
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
	
			</div>
			<div class="shop_board_separator"></div>
			<div class="shop_board_body3">
				<div class="shop_board_review">
					<strong>리뷰</strong>
					<div class="table_3">
						<table class="shop_review_table">
							<tbody>
								<tr>
									<c:choose>
										<c:when test="${grade eq 0}">
											<td class="avg_score"><span style="color:gray; font-size:18px;">등록 된 리뷰가 없습니다</span></td>
										</c:when>
										<c:otherwise>
											<td class="avg_score">평점 : <span style="color : red;">${grade}</span>점</td>
										</c:otherwise> 
									</c:choose>
								</tr>
								<tr>
									<td>
										<div class="reviews">
											<ul>
												<c:forEach var="tmp" items="${reviewList }">
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
																		<span class="col">${tmp.writer }</span>
																		<span class="bg_bar"></span>
																		<span style="font-weight: 100; font-size : 13px; color : gray;">${tmp.regdate }</span>
																		<c:choose>
																			<c:when
																				test="${ (id ne null) and (tmp.writer eq id) }">
																				<a data-num="${tmp.num }"
																					class="update-link btn btn-warning"
																					href="javascript:" style="font-size : 13px; padding:0 1px;">EDIT</a>
																				<a data-num="${tmp.num }"
																					class="delete-link btn btn-danger"
																					href="javascript:"  style="font-size : 13px; padding:0 1px;">DELETE</a>
																			</c:when>
																			<c:when test="${id eq 'admin' }">
																				<a data-num="${tmp.num }"
																					class="delete-link btn btn-danger"
																					href="javascript:">삭제</a>
																			</c:when>
																		</c:choose>
																			<div class="startRadio" style="pointer-events: none;">																			<c:forEach var="i" begin="0" end="9">
																					<label class="startRadio__box"> <input
																						type="radio" name="grade_number" value=${i }
																						${tmp.grade eq (i/2+0.5) ? 'class="point"' : '' }>
																						<span class="startRadio__img"> <span
																							class="blind">별 ${(i/2+0.5) }개</span>
																					</span>
																					</label>
																				</c:forEach>
																			</div>
																		<div class="comment_box" id="pre${tmp.num }">
																			<input class="review_title_box" type="text"
																				name="title" id="spt${tmp.num }" value="${tmp.title}"
																				disabled />
																			<textarea class="review_content_box"
																			id="spc${tmp.num }" name="content" disabled>${tmp.content}</textarea>
																		</div>
	
																		<!-- 수정폼 -->
																		<c:if test="${tmp.writer eq id }">
																			<form id="updateForm${tmp.num }"
																				class="review-form update-form"
																				action="review_update" method="post">
																				<input type="hidden" name="num" value="${tmp.num }" />
																				<div class="startRadio">
																					<c:forEach var="i" begin="0" end="9">
																						<label class="startRadio__box"> <input
																							type="radio" name="grade_number" value=${i }
																							${tmp.grade eq (i/2+0.5) ? 'checked' : '' }
																							disabled> <span class="startRadio__img">
																								<span class="blind">별 ${(i/2+0.5) }개</span>
																						</span>
																						</label>
																					</c:forEach>
																				</div>
	
																				<textarea name="content">${tmp.content }</textarea>
																				<button type="submit" id="ur${tmp.num }"
																					class=comment_edit_btn>수정</button>
																			</form>
																		</c:if>
																	</div>
	
																	
																</dt>
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
															</dl>
														</c:otherwise>
													</c:choose>
												</c:forEach>
	
											</ul>
										</div>
									</td>
								</tr>
								<tr class="comment_area">
									<td>
										<!-- 원글에 리뷰를 작성할 폼 -->
										<div class="comment_form_box">
											<form class="review-form insert-form" action="review_insert" method="post">
												<!-- 실제 폼에 제출되는 이미지 값 -->
												<input type="hidden" name="imagePath" value="empty" /> <input
													type="hidden" name="ref_group" value="${dto.num }" />
													
												<div class="startRadio" style="float: left; left: 0%;">
													<c:forEach var="i" begin="0" end="9">
														<label class="startRadio__box"> <input type="radio"
															name="grade_number" value=${i }
															${i eq 9 ? 'checked' : '' }> <span
															class="startRadio__img"> <span class="blind">별
																	${(i/2+0.5) }개</span>
														</span>
														</label>
													</c:forEach>
												</div>
												<button class="regist_btn btn btn-outline-warning" type="submit">등록</button>
												<div class="text_box">
													<textarea class="regist_comment_box" name="content">${empty id ? '댓글 작성을 위해 로그인이 필요 합니다.' : '' }</textarea>
													
													<!-- 유저가 사진 등록을 위해 클릭하게 될 이미지 -->
													<a id="thumbnailLink" href="javascript:" style="margin:auto; text-decoration:none; color:gray;">
														<svg class="camera_img" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-camera" viewBox="0 0 16 16">
														    <path d="M15 12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V6a1 1 0 0 1 1-1h1.172a3 3 0 0 0 2.12-.879l.83-.828A1 1 0 0 1 6.827 3h2.344a1 1 0 0 1 .707.293l.828.828A3 3 0 0 0 12.828 5H14a1 1 0 0 1 1 1v6zM2 4a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2h-1.172a2 2 0 0 1-1.414-.586l-.828-.828A2 2 0 0 0 9.172 2H6.828a2 2 0 0 0-1.414.586l-.828.828A2 2 0 0 1 3.172 4H2z"/>
														    <path d="M8 11a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5zm0 1a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7zM3 6.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0z"/>
													    </svg>
													</a>
												</div>
												<input class="review_title_box" type="text" name="title" id="title"
													placeholder="한줄평 입력..." />
	
											</form>
											<!-- 리뷰 테이블에 이미지 업로드를 위한 폼 -->
											<form id="imageForm"
												action="${pageContext.request.contextPath}/shop/review_image_upload"
												method="post" enctype="multipart/form-data">
												사진 <input type="file" id="image" name="image"
													accept=".jpg, .png, .gif, .jpeg" />
												<button type="submit">업로드</button>
											</form>
										</div> 
									</td>
								</tr>
							</tbody>
						</table>
						<nav>
							<ul class="pagination" style="margin:5% 4% 0 0;">
								
								<c:if test="${rvStartPageNum ne 1 }">
									<li class="page-item" style="border-top:none"><a class="page-link"
										href="detail?num=${dto.num}&rvPageNum=${rvStartPageNum - 1 }&condition=${condition}&keyword=${encodedK}">Prev</a>
									</li>
								</c:if>
								
								<c:forEach var="i" begin="${rvStartPageNum }"
									end="${rvEndPageNum }">
									<li class="page-item ${rvPageNum eq i ? 'active' : '' }" style="border-top:none">
										<a class="page-link"
										href="detail?num=${dto.num }&rvPageNum=${i }&condition=${condition}&keyword=${encodedK}">${i }</a>
									</li>
								</c:forEach>
							
								<c:if test="${rvEndPageNum lt rvTotalPageCount }">
									<li class="page-item" style="border-top:none"><a class="page-link"
										href="detail?num=${dto.num }&rvPageNum=${rvEndPageNum + 1 }&condition=${condition}&keyword=${encodedK}">Next</a>
									</li>
								</c:if>
							</ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>













		<div style="height : 600px;"></div>
	

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
	<script>
		let selector = document.getElementsByClassName("menu_price");
		for(let i=0; i<selector.length; i++){
			document.getElementsByClassName("menu_price")[i].innerText = document.getElementsByClassName("menu_price")[i].innerText.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}
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
      document.querySelector(".insert-form")
         .addEventListener("submit", function(e){
            if(!isLogin){
               e.preventDefault();
               location.href=
                  "${pageContext.request.contextPath}/users/loginform?url=/shop/detail?num=${dto.num}";
            }
         });
      
      //댓글에 이벤트 리스너 등록 하기 
      addUpdateFormListener(".update-form");
      addUpdateListener(".update-link");
      addDeleteListener(".delete-link");
       
      function addUpdateListener(sel){
         let updateLinks = document.querySelectorAll(sel);
         for(let i=0; i<updateLinks.length; i++){
            updateLinks[i].addEventListener("click", function(){
               const num=this.getAttribute("data-num");
               const form = document.querySelector("#updateForm"+num);
               const form2 = document.querySelector("#pre"+num);
               
               let current = this.innerText;
               
               if(current == "EDIT"){
            	   form.style.display="block";
            	   form2.style.display="none";
                   form.classList.add("animate__flash");
                   this.innerText="CANCEL";   
                   form.addEventListener("animationend", function(){
                      form.classList.remove("animate__flash");
                   }, {once:true});
                   document.querySelector("#ur"+num).addEventListener("click", function(){
                	   form2.style.display="block";	
                	   updateLinks[i].innerText = "EDIT";
				   });
                 }else if(current == "CANCEL"){
                    form.classList.add("animate__fadeOut");
                    this.innerText="EDIT";
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
                     const content = form.querySelector("textarea[name=content]").value;
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