<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/index.css">
<link rel="stylesheet" type="text/css" href="../resources/css/shop_detail.css">
</head>
<style>
.review_search_result{
	width : 60%;
	padding-top : 100px;
	height : 200px;
	margin : auto;
	text-align : center;
}
.review_list{
	width : 60%;
	margin : auto;
	background : white;
}
.keyword_style{
	font-size : 20px;
	font-weight : bold; 
	color : red;
}
.result_style{
	font-size : 20px;
	font-weight : bold; 
	color : blue;
}
</style>
<body>
	<%@include file="../../views/include/navbar.jsp"%>
	<div class="review_search_result">
		<p style="font-weight : bold">
			<span class="keyword_style">"${rvencodedK}"</span>
			에 대해 리뷰리스트 검색 결과 총 
			<span class="result_style">${rvtotalRow}건</span>
			이 검색 되었습니다.
		</p>
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
												<textarea class="review_content_box"
													id="spc${tmp.num }" name="content" disabled>${tmp.content}</textarea>
																													<div class="comment_box" id="pre${tmp.num }">
												<input class="review_title_box" type="text"
													name="title" id="spt${tmp.num }" value="${tmp.title}"
													disabled />
											</div>
	
											<!-- 수정폼 -->
											<c:if test="${tmp.writer eq id }">
												<form id="updateForm${tmp.num }"
													class="review-form update-form"
													action="review_update" method="post">
													<input type="hidden" name="num" value="${tmp.num }" />
													<input type="text" name="title" value="${tmp.title }" />
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
			<nav>
			    <ul class="pagination justify-content-center">
			    <c:choose>
			      <c:when test="${rvstartPageNum ne 1 }">
			         <li class="page-item">
			                  <a class="page-link" href="review_list?pageNum=${rvstartPageNum - 1}&category=${category }&condition=${condition}&keyword=${encodedK}">Prev</a>
			            </li>
			      </c:when>
			      <c:otherwise>
			         <li class="page-item disabled">
			                  <a class="page-link" href="javascript:">Prev</a>
			            </li>
			      </c:otherwise>
			   </c:choose>
			   <c:forEach var="i" begin="${rvstartPageNum }" end="${rvendPageNum }">
			      <li class="page-item ${rvpageNum eq i ? 'active' : '' }">
			         <a class="page-link" href="review_list?pageNum=${i }&category=${rvcategory }&condition=${rvcondition}&keyword=${rvencodedK}">${i }</a>
			      </li>
			   </c:forEach>
			   <c:choose>
			      <c:when test="${rvendPageNum lt rvtotalPageCount }">
			         <li class="page-item">
			                  <a class="page-link" href="review_list?pageNum=${rvendPageNum + 1}&category=${category }&condition=${condition}&keyword=${encodedK}"">Next</a>
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