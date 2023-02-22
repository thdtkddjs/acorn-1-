<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/users/info.jsp</title>
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
/* 프로필 이미지를 작은 원형으로 만든다 */
#profileImage {
	width: 50px;
	height: 50px;
	border: 1px solid #cecece;
	border-radius: 50%;
}

.container {
	width: 624px;
	height: 600px;
	border : 1px solid #CECECE;
	padding-top: 50px;
	margin-bottom:50px;
}

h1 {
	text-align: center;
}

.submit_btn {
	width: 100px;
}

table {
	width: 300px;
	margin-left: 150px;
}

tr {
	height: 30px;
}

th {
	border-right: 1px solid black;
	text-align: left;
	height: 30px;
}

a {
	text-decoration: none;
}

#imageForm {
	display: none;
}

#edit_email_box {
	border-radius: 10px;
	border: 1px solid gray;
	text-align: center;
}
</style>
</head>
<body class="text-center">
	<jsp:include page="../../views/include/navbar.jsp">
		<jsp:param value="user04" name="thisPage"/>
	</jsp:include>
	<div data-bs-spy="scroll" data-bs-target="#simple-list-example" data-bs-offset="0" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
	<div id="simple-list-item-1" class="container">
		<br /><br />
		<h1>INFO</h1>
		<br>
		<table>
			<tr>
				<th>ID</th>
				<td>${id }</td>
			</tr>
			<tr style="height: 10px;"></tr>
			<tr>
				<th>PROFILE</th>
				<td><a id="profileLink" href="javascript:"> <c:choose>
							<c:when test="${empty dto.profile }">
								<svg id="profileImage" xmlns="http://www.w3.org/2000/svg"
									width="16" height="16" fill="currentColor"
									class="bi bi-person-circle" viewBox="0 0 16 16">
			                 <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" />
			                 <path fill-rule="evenodd"
										d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z" />
			               </svg>
							</c:when>
							<c:otherwise>
								<img id="profileImage"
									src="${pageContext.request.contextPath}/users/images/${dto.profile}" />
							</c:otherwise>
						</c:choose>
				</a></td>
			</tr>
			<tr style="height: 10px;"></tr>
			<tr>
				<th>비밀번호</th>
				<td><a
					href="${pageContext.request.contextPath}/users/pwd_updateform"
					class="btn btn-outline-info" style="padding: 2px;">수정하기</a></td>
			</tr>
			<tr style="height: 10px;"></tr>
			<tr>
				<th>이메일</th>
				<td><input id="edit_email_box" type="text" value="${dto.email}" /></td>
			</tr>
			<tr style="height: 10px;"></tr>
			<tr>
				<th>가입일</th>
				<td>${dto.regdate }</td>
			</tr>
			<tr style="height: 10px;"></tr>
		</table>
		<br> <br> 
			<c:choose>
				<c:when test="${sessionScope.id eq 'admin'}">
					<a href="${pageContext.request.contextPath}/shop/insertform" class="btn btn-outline-success">INSERT SHOP</a> 
					<a href="${pageContext.request.contextPath}/users/list" class="btn btn-outline-secondary">USER LIST</a>
				</c:when>
			</c:choose>
			<a href="javascript:" id="edit_link" class="btn btn-outline-warning">EDIT</a>
			<a href="javascript:deleteConfirm()" class="btn btn-outline-danger">DROP-OUT</a>

		<form id="imageForm"
			action="${pageContext.request.contextPath}/users/profile_upload"
			method="post" enctype="multipart/form-data">
			프로필 사진 <input type="file" id="image" name="image"
				accept=".jpg, .png, .gif" />
			<button type="submit">업로드</button>
		</form>

		<form id="imageForm"
			action="${pageContext.request.contextPath}/users/update"
			method="post">
			<input type="hidden" name="profile"
				value="${ empty dto.profile ? 'empty' : dto.profile }" />
			<div>
				<label for="id">아이디</label> <input type="text" id="id"
					value="${dto.id }" disabled />
			</div>
			<div>
				<label for="email">이메일</label> <input type="text" id="email"
					name="email" value="${dto.email }" />
			</div>
			<button id="edit_submit" type="submit">수정</button>
			<button type="reset">취소</button>
		</form>
	</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.slim.js"
		integrity="sha256-HwWONEZrpuoh951cQD1ov2HUK5zA5DwJ1DNUXaM6FsY="
		crossorigin="anonymous"></script>
	<script
		src="${pageContext.request.contextPath }/resources/js/gura_util.js"></script>
	<script>
		var oldVal;
		function deleteConfirm() {
			const isDelete = confirm("${id} 님 탈퇴 하시겠습니까?");
			if (isDelete) {
				location.href = "${pageContext.request.contextPath}/users/delete";
			}
		}
		document.querySelector("#edit_link").addEventListener("click",
				function() {
					document.querySelector("#edit_submit").click();
					alert("PROFILE 수정 완료")
				});

		//프로필 이미지 링크를 클릭하면 
		document.querySelector("#profileLink").addEventListener("click",
				function() {
					// input type="file" 을 강제 클릭 시킨다. 
					document.querySelector("#image").click();
				});

		//프로필 이미지를 선택하면(바뀌면) 실행할 함수 등록
		document
				.querySelector("#image")
				.addEventListener(
						"change",
						function() {
							//ajax 전송할 폼의 참조값 얻어오기
							const form = document.querySelector("#imageForm");
							//gura_util.js 에 있는 함수를 이용해서 ajax 전송하기 
							ajaxFormPromise(form)
									.then(function(response) {
										return response.json();
									})
									.then(
											function(data) {
												console.log(data);
												// input name="profile" 요소의 value 값으로 이미지 경로 넣어주기
												document
														.querySelector("input[name=profile]").value = data.imagePath;

												// img 요소를 문자열로 작성한 다음 
												let img = `<img id="profileImage" 
               src="${pageContext.request.contextPath }/users/images/\${data.imagePath}">`;
												//id 가 profileLink 인 요소의 내부(자식요소)에 덮어쓰기 하면서 html 형식으로 해석해 주세요 라는 의미 
												document
														.querySelector("#profileLink").innerHTML = img;
											});
						});

		$("#edit_email_box").on("propertychange change keyup paste input",
				function() {
					var currentVal = $(this).val();
					$("#email").val(currentVal);
				});
	</script>
</body>
</html>