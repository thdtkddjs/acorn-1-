<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/shop/insertform.jsp</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
<style>
.container {
	width: 624px;
	height: 800px;
	box-shadow: 0px 5px 20px 0px grey;
	margin-top: 50px;
	border-radius: 20px;
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

input {
	display: inline !important;
	width: 250px !important;
	margin: 0px !important;
	border: 1px solid #000000;
	border-radius: 5px;
}

select {
	display: inline !important;
	width: 250px !important;
	height: 36px;
	margin: 0px !important;
	border: 1px solid #ced4da;
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
	<div class="container">
		<a href="${pageContext.request.contextPath}" class="logo_text">
			<img class="logo"
			src="${pageContext.request.contextPath}/resources/images/logos/logo_A1.png"
			alt="" style="height: 50px;" />
		</a>
		<br />
		<br />
		<h1>REGIST STORE</h1>
		<br />
		<form action="${pageContext.request.contextPath}/shop/insert"
			method="post" id="insertForm">
			<!-- 실제 제출 될 이미지 값 -->
			<input type="hidden" name="imagePath" value="empty" />

			<!-- 점포명 input -->
			<div class="mb-3">
				<label class="form-label" for="title">NAME</label> <input
					class="form-control" type="text" name="title" id="title" />
			</div>

			<!-- 카테고리 input -->
			<div class="mb-3">
				<label class="form-label" for="categorie">CATEGORIES</label> <select
					class="dropdown" name="categorie" id="categorie">
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

			<!-- 번호 input -->
			<div class="mb-3">
				<label class="form-label" for="telNum">TEL NO.</label> <input
					class="form-control" type="text" name="telNum" id="telNum" />
			</div>

			<!-- 주소 input -->
			<div class="mb-3">
				<label class="form-label" for="addr">ADDRESS</label> <input
					class="form-control" type="text" name="addr" id="addr" />
			</div>

			<!-- 영업 시간 -->
			<div class="mb-3">
				<label class="form-label" for="startTime">개점 시간</label> <input
					class="form-control" type="time" name="startTime" /> <br /> <label
					class="form-label" for="endTime">폐점 시간</label> <input
					class="form-control" type="time" name="endTime" />
			</div>

			<!-- 설명 입력 textbox -->
			<div class="mb-3" style="position: relative;">
				<label class="form-label" for="content"
					style="top: -130px; position: relative;">EXPLAIN</label> 
				
				<!-- 가게 섬네일 등록을 위해 클릭하게 될 이미지 -->
				<a id="thumbnailLink" href="javascript:"> 
					<img src="${pageContext.request.contextPath}/resources/images/photo.png"
					alt="" class="upload_img" />
				</a>
				
				<textarea class="form-control" name="content" id="content"></textarea>
			</div>
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