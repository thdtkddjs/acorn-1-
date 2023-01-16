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
.upload_img{
    width: 75px;
    height: 75px;
    position: absolute;
    left: 122px;
    top: 60px;
    border-radius : 10px !important;
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
	display : inline !important;
	width : 250px !important;
	margin : 0px !important;
	border: 1px solid #000000;
	border-radius: 5px;
}

textarea {
	display : inline !important;
	margin : 0px !important;
	border: 1px solid #000000;
	border-radius: 5px;
	width: 250px !important;
	height: 150px !important;
}
/* 이미지 업로드 폼을 숨긴다 */
#imageForm {
	display: none;
}

#profileImage {
    width: 75px;
    height: 75px;
    position: absolute;
    left: 122px;
    top: 60px;
    border-radius : 10px !important;
}
</style>
</head>

<body class="text-center">
	<div class="container">
		<a href="${pageContext.request.contextPath}/index" class="logo_text">
			<img class="logo"
			src="${pageContext.request.contextPath}/resources/images/1_acorn_logo.png"
			alt="" />
		</a>
		<br />
		<br />
		<h1>REGIST STORE</h1>
		<br />
		<form action="${pageContext.request.contextPath}/shop/insert"
			method="post" id="insertForm">
			<!-- 숨겨진 imageform을 통해 등록된 이미지를 폼에 제출할 수 있도록 하는 hidden input -->
			<input type="hidden" name="imagePath" value="empty" />
		
			<!-- 점포명 input -->
			<div class="mb-3">
				<label class="form-label" for="title">NAME</label> <input
					class="form-control" type="text" name="title" id="title" />
			</div>
			<br />
			<!-- 카테고리 input -->
			<div class="mb-3">
				<label class="form-label" for="categorie">CATEGORIES</label> <input
					class="form-control" type="text" name="categorie" id="categorie" />
			</div>
			<br />
			<!-- 번호 input -->
			<div class="mb-3">
				<label class="form-label" for="telNum">TEL NO.</label> <input
					class="form-control" type="text" name="telNum" id="telNum" />
			</div>
			<br />
			<!-- 주소 input -->
			<div class="mb-3">
				<label class="form-label" for="addr">ADDRESS</label> <input
					class="form-control" type="text" name="addr" id="addr" />
			</div>
			<br />
      <!-- 영업 시간 -->
      <div class="mb-3">
      	 <label for="startTime">개점 시간</label>
      	 <input type="time" name="startTime" />
      	 <label for=""> ~ </label>
      	 <label for="endTime">폐점 시간</label>
      	 <input type="time" name="endTime" />
      </div>
      <br />
			<!-- 설명 입력 textbox -->
			<div class="mb-3" style="position: relative;">
				<label class="form-label" for="content" style="top: -130px; position: relative;">EXPLAIN</label>
				<a id="profileLink" href="javascript:"> 
					<img src="${pageContext.request.contextPath}/resources/images/photo.png" alt="" class="upload_img" />
				</a>
				<textarea class="form-control" name="content" id="content"></textarea>
			</div>
			<button class="btn btn-outline-success" type="submit"
				onclick="submitContents(this)">REGIST</button>
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

	<script>

      //프로필 이미지 링크를 클릭하면 
      document.querySelector("#profileLink").addEventListener("click", function(){
         // input type="file" 을 강제 클릭 시킨다. 
         document.querySelector("#image").click();
      });   
      
      //프로필 이미지를 선택하면(바뀌면) 실행할 함수 등록
      document.querySelector("#image").addEventListener("change", function(){
         //ajax 전송할 폼의 참조값 얻어오기
         const form=document.querySelector("#imageForm");
         //gura_util.js 에 있는 함수를 이용해서 ajax 전송하기 
         ajaxFormPromise(form)
         .then(function(response){
            return response.json();
         })
         .then(function(data){
            console.log(data);
            // input name="profile" 요소의 value 값으로 이미지 경로 넣어주기
            document.querySelector("input[name=imagePath]").value = data.imagePath;
            
            // img 요소를 문자열로 작성한 다음 
            let img=`<img id="profileImage" 
               src="${pageContext.request.contextPath }\${data.imagePath}">`;
            //id 가 profileLink 인 요소의 내부(자식요소)에 덮어쓰기 하면서 html 형식으로 해석해 주세요 라는 의미 
            document.querySelector("#profileLink").innerHTML=img;
         });
      });      
      
   </script>

	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		window.onload = function(){
		    document.getElementById("addr").addEventListener("click", function(){ //주소입력칸을 클릭하면
		        //카카오 주소 창 오픈
		        new daum.Postcode({
		            oncomplete: function(data) { //선택시 입력값 세팅
		                document.getElementById("addr").value = data.address; // 주소 넣기
		                document.querySelector("input[name=addr]").focus(); //상세입력 포커싱
		            }
		        }).open();
		    });
		}
	</script>
</body>
</html>