<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점포 등록</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/index.css">
<link rel="stylesheet" type="text/css" href="../resources/css/shop_insert_form.css">
<style>
body::-webkit-scrollbar {
	width: 5px;
	height: 0px;
}
body::-webkit-scrollbar-thumb {
	background-color: #2f3542;
	border-radius: 10px;
}

</style>
</head>

<body class="text-center">
	<jsp:include page="../../views/include/navbar.jsp">
		<jsp:param value="admin03" name="thisPage"/>
	</jsp:include>
	<div class="container">
	<br />
		<h1>REGIST STORE</h1>
		<br />
		<form action="${pageContext.request.contextPath}/shop/insert" method="post" id="insertForm">
			<!-- 실제 제출 될 이미지 값 -->
			<input type="hidden" name="imagePath" value="empty" />

			<!-- 점포명 input -->
			<div class="row">
				<div class = "col-4">
					<label class="form-label" for="title">NAME</label>					
				</div>
				<div class = "col-8">
					<input class="form-control" type="text" name="title" id="title" />
				</div>
			</div>
			<br/>
			<!-- 카테고리 input -->
			<div class="row">
				<div class="col-4" style="text-align: right;">
					<label class="form-label" for="categorie">CATEGORIES</label>
				</div>
				<div class="col-8" style="text-align: left; padding-left: 20px;">
					<select class="dropdown" name="categorie" id="categorie">
						<option value="" selected>선택</option>
						<option value="한식">한식</option>
						<option value="분식">분식</option>
						<option value="일식">일식</option>
						<option value="양식">양식</option>
						<option value="중식">중식</option>
						<option value="패스트푸드">패스트푸드</option>
						<option value="기타">기타</option>
					</select>
				</div>
			</div>
			<br />
			<!-- 번호 input -->
			<div class="row">
				<div class = "col-4">
					<label class="form-label" for="telNum">TEL NO.</label>					
				</div>
				<div class = "col-8">
					<input class="form-control" type="text" name="telNum" id="telNum" />
				</div>
			</div>
			<br/>
			
			<!-- 주소 input -->			
			<div class="row">
				<div class = "col-4">
					<label class="form-label" for="addr">ADDRESS</label>				
				</div>
				<div class = "col-8">
					<input	class="form-control" type="text" name="addr" id="addr" />
				</div>
			</div>
			<br/>
			
			<!-- 영업 시간 -->
			<div class="row">
				<div class = "col-4">
					<label class="form-label" for="startTime">OPEN</label>			
				</div>
				<div class = "col-8">
					<input	class="form-control" type="time" name="startTime" />
				</div>
			</div>
			<br/>
			<div class="row">
				<div class = "col-4">
					<label	class="form-label" for="endTime">CLOSE</label> 	
				</div>
				<div class = "col-8">
					<input	class="form-control" type="time" name="endTime" />
				</div>
			</div>
			<br />
			<!-- 설명 입력 textbox -->
			<div class="row">
				<!-- 가게 섬네일 등록을 위해 클릭하게 될 이미지 -->
				<div class = "col-4">
					<label class="form-label" for="content" style="inline-size: -webkit-fill-available;">EXPAIN</label>
					<a id="thumbnailLink" href="javascript:">
						<svg class="camera_img" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="upload_img bi bi-camera" viewBox="0 0 16 16">
						    <path d="M15 12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V6a1 1 0 0 1 1-1h1.172a3 3 0 0 0 2.12-.879l.83-.828A1 1 0 0 1 6.827 3h2.344a1 1 0 0 1 .707.293l.828.828A3 3 0 0 0 12.828 5H14a1 1 0 0 1 1 1v6zM2 4a2 2 0 0 0-2 2v6a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2h-1.172a2 2 0 0 1-1.414-.586l-.828-.828A2 2 0 0 0 9.172 2H6.828a2 2 0 0 0-1.414.586l-.828.828A2 2 0 0 1 3.172 4H2z"/>
						    <path d="M8 11a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5zm0 1a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7zM3 6.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0z"/>
					    </svg>
					</a>
				</div>
				<div class = "col-8">
					<textarea class="form-control" name="content" id="content"></textarea>
				</div>
			</div>
			<br />
			<button class="btn btn-outline-success" type="submit">REGIST</button>
		</form>

		<!-- 가게 섬네일 등록을 위한 폼 -->
		<form id="imageForm"
			action="${pageContext.request.contextPath}/shop/image_upload"
			method="post" enctype="multipart/form-data">
			프로필 사진 <input type="file" id="image" name="image"
				accept=".jpg, .png, .gif, .jpeg" />
			<button type="submit">업로드</button>
		</form>
	</div>

	<script src="${pageContext.request.contextPath }/resources/js/gura_util.js"></script>

	<!-- 섬네일 등록 script -->
	<script>
		document.querySelector("#thumbnailLink").addEventListener("click", function() {
			document.querySelector("#image").click();
		});

		document.querySelector("#image").addEventListener("change", function() {
			const form = document.querySelector("#imageForm");
			ajaxFormPromise(form)
			.then(function(response) {
				return response.json();
			})
			.then(function(data) {
				document.querySelector("input[name=imagePath]").value = data.imagePath;
				let img = `<img class="upload_img" src="${pageContext.request.contextPath }\${data.imagePath}">`;
				document.querySelector("#thumbnailLink").innerHTML = img;
			});
		});
	</script>

	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		window.onload = function() {
			document.getElementById("addr").addEventListener("click", function() { //주소입력칸을 클릭하면
				//카카오 주소 창 오픈
				new daum.Postcode({oncomplete : function(data) { //선택시 입력값 세팅
					document.getElementById("addr").value = data.address; // 주소 넣기
					document.querySelector("input[name=addr]").focus(); //상세입력 포커싱
				}
			}).open();
			});
		}
	</script>
</body>
</html>