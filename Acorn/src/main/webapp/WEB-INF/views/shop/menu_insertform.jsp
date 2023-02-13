<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/shop/menu_insertform.jsp</title>
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
<style>
.container {
	width: 624px;
	height: 650px;
	border : 1px solid #CECECE;
	padding-top: 50px;
}

h1 {
	text-align: center;
}

.upload_img {
	width: 75px;
	height: 75px;
	position: absolute;
	left: 122px;
	top: 60px;
	border-radius: 10px !important;
}

.submit_btn {
	width: 100px;
}

.form-control {
	width: 400px;
	margin-left: 100px;
}

label {
	width: 100px;
	text-align: left;
}

.form-control {
	display: inline !important;
	width: 250px !important;
	margin: 0px !important;
	border-radius: 5px;
}

textarea {
	display: inline !important;
	margin: 0px !important;
	border: 1px solid #000000;
	border-radius: 5px;
	width: 250px !important;
	height: 150px !important;
}
/* 이미지 업로드 폼을 숨긴다 */
#imageForm {
	display: none;
}
</style>
</head>
<body class="text-center">
<%@include file ="../../views/include/navbar.jsp"%>
	<div class="container">
		<br />
		<br />
		<h1>REGIST MENU</h1>
		<br />
		<form action="${pageContext.request.contextPath}/shop/menu_insert"
			method="get" id="insertForm">
			
			<!-- 실제 폼에 제출될 이미지 값 -->
			<input type="hidden" name="imagePath" value="empty" /> 
			
			<input type="hidden" name="num" value="${param.num }" />

			<!-- 메뉴명 input -->
			<div class="mb-3">
				<label class="form-label" for="name">MENU</label> 
				<input class="form-control" type="text" name="name" id="name" />
			</div>
			<br />

			<!-- 가격 input -->
			<div class="mb-3">
				<label class="form-label" for="price">PRICE</label> 
				<input class="form-control" type="text" name="price" id="price" />
			</div>
			<br />

			<!-- 사진 및 메뉴소개 -->
			<div class="mb-3" style="position: relative;">
				<label class="form-label" for="content"
					style="top: -130px; position: relative;">EXPLAIN</label> 
				
				<!-- 섬네일 등록을 위해 클릭할 이미지 -->
				<a id="thumbnailLink" href="javascript:"> 
					<img src="${pageContext.request.contextPath}/resources/images/photo.png"
						alt="" class="upload_img" />
				</a>

				<textarea class="form-control" name="content" id="content"></textarea>
			</div>
			<button class="btn btn-outline-success" type="submit">REGIST</button>
		</form>

		<!-- 이미지 등록용 숨겨진 form -->
		<form id="imageForm"
			action="${pageContext.request.contextPath}/shop/image_upload"
			method="post" enctype="multipart/form-data">
			프로필 사진 <input type="file" id="image" name="image"
				accept=".jpg, .png, .gif, .jpeg" />
			<button type="submit">업로드</button>
		</form>
	</div>

	<script src="${pageContext.request.contextPath }/resources/js/gura_util.js"></script>

	<!-- 이미지 등록 script -->
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
</body>
</html>