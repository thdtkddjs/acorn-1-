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
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/index.css">
<link rel="shortcut icon" type="image/x-icon" href="data:image/x-icon;,">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<link rel="stylesheet" type="text/css" href="../resources/css/shop_detail.css">
<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.2.1/chart.umd.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.0.0/dist/chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
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
					<c:if test="${sessionScope.id eq 'admin'}">
						<div class="shop_info_edit">
							<a href="${pageContext.request.contextPath}/shop/updateform?num=${dto.num }">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
									<path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
									<path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
								</svg>
							</a>
						</div>
					</c:if>
					

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
								<td class="table_content">영업 시작 : ${dto.startTime}</td>
							</tr>
							<tr>
								<td class="table_icon"></td>
								<td class="table_content">영업 종료 : ${dto.endTime}</td>
							</tr>
							<tr>
								<td class="table_icon"><img src="${pageContext.request.contextPath}/resources/images/shop_info/callnumber.png" alt="전화번호" class="shop_info_icon" title="전화번호"/></td>
								<td class="table_content">${dto.telNum}</td>
							</tr>
							<tr>
								<td class="table_icon"><img src="${pageContext.request.contextPath}/resources/images/shop_info/hashtag.png" alt="대표 키워드" class="shop_info_icon" title="대표 키워드"/></td>
								<td class="table_content">
									<c:if test="${grade ge 4 && reviewCount ge 5}">
										<p class="best_store btn btn-danger">🌟4.0↑</p>
									</c:if>
									<c:if test="${reviewCount ge 30}">
										<p class="best_store btn btn-success">✏️30↑</p>
									</c:if>
									<c:if test="${reviewCount lt 30 && grade lt 4}">
										<span style="color:gray;">* 평점이 4.0 이상(리뷰 5개 이상)이면 별 마크가, 리뷰가 50개 이상이면 리뷰 마크가 표시됩니다</span>
									</c:if>
								
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
										<img src="${pageContext.request.contextPath}${tmp.imagePath}" id="${tmp.menuNum }" class="gallery" height="50px" alt="small_image" hidden/>
										<span class="menu_name" id="/shop/images/${tmp.imagePath}" data-image="${tmp.content}" >${tmp.name}</span>
										<span class="menu_price">${tmp.price}</span>
										
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
	
			</div>
			
				<script type="text/javascript">
				    $(document).ready(function() {
				        var xOffset = 10;
				        var yOffset = 30;
				        
				        //마우스 오버시 preview 생성
				        $(document).on("mouseover",".menu_name",function(e){
				        	var image_data = $(this).data("image");
				            var add_caption = (image_data != undefined) ? "<br/>" + "ℹ️" +image_data : "" ;
				            $("body").append("<p id='preview'><img src='" + $(this).attr("id") + "' width='400px'/>"+ add_caption +"</p>");
				            $("#preview")
				            .css("position", "fixed")
				            .css("top", "25%")
				            .css("left","35%")
				            .css("z-index", 5)
				          	.css("border", "1px solid #cecece")
				            .fadeIn("slow");
				        });
				        //마우스 아웃시 preview 제거
				        $(document).on("mouseout",".menu_name",function(){
				            $("#preview").remove();
				        });
				    });
				</script>
			<div class="shop_board_separator"></div>
			<div class="shop_board_body3">
				<div class="shop_board_review">
					<strong>리뷰</strong>
					<div class="table_3" style="position:relative;">
						<table class="shop_review_table">
							<tbody>
								<tr style="height : 150px;">
									<c:choose>
										<c:when test="${grade eq 0}">
											<td class="avg_score"><span style="color:gray; font-size:18px;">등록 된 리뷰가 없습니다</span></td>
										</c:when>
										<c:otherwise>
											<td class="avg_score">평점 : <span style="color : red;">${grade}</span>점</td>
										</c:otherwise> 
									</c:choose>
									<div class="" style="width:250px;height:150px;float: right;position: absolute;right: 0%;" >
								    	<div class="statistics" >
								   		 		<canvas id="myChart" ref="acquisitions" style="display: block;box-sizing: border-box;height: 150px;width: 250px;padding: 10px;"></canvas>
								    	</div>
								    	
								    	<!-- 리뷰 별점 데이터 받아오기 -->
								    	<c:forEach var="tmp" items="${testList}">
								    		<li hidden>
								    			<input value="${tmp.gCount}" class="score_count_${tmp.grade}"></input>
								    		
								    		</li>
								    	</c:forEach>
									</div>
								</tr>
								<tr>
									<td>
										<div class="reviews">
											<ul>
												<c:forEach var="tmp" items="${reviewList}">
													<c:choose>
														<c:when test="${tmp.deleted eq 'yes' }">
															<dt class="row" style="border-top: 1px solid #f2f2f2; height : 75px; item-align : center; text-align:center; align-items: center;">
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
																					src="${pageContext.request.contextPath}/shop/images/${tmp.profile }" />
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
																					href="javascript:">DELETE</a>
																			</c:when>
																		</c:choose>
																			<div class="startRadio" style="pointer-events: none;">																			
																				<c:forEach var="i" begin="0" end="9">
																					<label class="startRadio__box" > 
																					<input type="radio" name="grade_number" value=${i }
																						${tmp.grade eq (i/2+0.5) ? 'class="point"' : ''} >
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
																						<label class="startRadio__box" hidden> <input
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
																		</c:when>
																		<c:otherwise>
																			<img class="review_img"
																				src="${pageContext.request.contextPath}/shop/images/${tmp.imagePath}" />
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
															${i eq 9 ? 'checked' : '' }
															${i%2 eq 0  ? 'disabled' : ''} > 
															<span
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
	
	

		

	
<script>
const app = Vue.createApp({
	setup() {
		const arr = Vue.ref([0, 0, 0, 0, 0]); // arr를 ref로 만들어서 반응성을 추가
		const chartData = Vue.reactive({
				labels: ["★", "★★", "★★★", "★★★★", "★★★★★"],
				datasets: [{
					label: "리뷰 별점 수",
					axis: 'y',
					barThickness: 10,
					backgroundColor: "rgba(255, 99, 132, 0.2)",
					borderColor: "rgba(255,99,132,1)",
					borderWidth: 1,
					data: arr.value, // arr의 값을 참조
				},
				],
			});
			// window.onload 대신에 Vue.watchEffect를 사용
			// arr의 값이 변경될 때마다 chartData.datasets[0].data도 변경
			Vue.watchEffect(() => {
				arr.value = [0, 0, 0, 0, 0]; // 초기화
				console.log(arr.value[0]);
				for (let i=1; i < 6; i++) {
					if(document.getElementsByClassName("score_count_"+i+".0")[0]==null){
						
					}
					else{
						arr.value[i-1] = Number(document.getElementsByClassName("score_count_"+i+".0")[0].value);
					}
					
			  	}
				chartData.datasets[0].data = arr.value; // 데이터 갱신
			});
	
			return {
		    	chartData,
			};
	},
	async mounted() {
		const response = await fetch('http://localhost:9000/es/test', {
			method : 'GET',
			headers : {
				'Content-Type' : 'application/json',
			}
		});
		
		const ctx = document.getElementById("myChart").getContext("2d");
		const myChart = new Chart(ctx, {
			type: "bar",
			data: this.chartData,
			plugins : [ChartDataLabels],
			options: {
				plugins: {
					legend: {
						display: false
						},
					datalabels: {
			            font: {
			              size: 12,
			            },
			            display: function(context) {
			                return context.dataset.data[context.dataIndex]>1;
			              },
			            anchor: 'end',
			            align: 'right',
			            offset: 2,
			            formatter: function(value, context) {
			              return value;
			            }
					}
				},
				indexAxis: 'y',
				scales: {
					x:{
				        ticks: {
				        	display: false,
				        	stepSize: 1,
				        },
			            grid: {display: false},
					},
					y: {
						beginAtZero: true, // y축이 0부터 시작하도록 설정
						offset: true,
						grid: {
						    display: false
					  	},
					    ticks: {
					        color: '#ffc107',
					    	stepSize: 10, // 레이블의 높이를 줄이기 위해 값을 높임
					    },
					},
				},
				layout: {
					padding: {
						top: 0,
						bottom: 0,
						left: 0,
						right: 20
					},
				},
			},
		});
		window.addEventListener('resize', function() {
			myChart.resize();
		});
	  },
});
app.mount(".statistics");
</script>


	<script>
		let selector = document.getElementsByClassName("menu_price");
		for(let i=0; i<selector.length; i++){
			document.getElementsByClassName("menu_price")[i].innerText = document.getElementsByClassName("menu_price")[i].innerText.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}
	</script>

	
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
				let img = `<img class="comment_img" src="${pageContext.request.contextPath }/shop/images/\${data.imagePath}">`;
				document.querySelector("#thumbnailLink").innerHTML=img;
			});
		});
   </script>
</body>
</html>