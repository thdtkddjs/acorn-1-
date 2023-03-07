<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/users/loginform.jsp</title>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="../resources/css/index.css">
<style>
html,body {
  height: 100%;
}

body {
  display: flex;
  align-items: center;
  padding-top: 40px;
  padding-bottom: 40px;
  background-color: #f5f5f5;
}

.form-signin {
  max-width: 330px;
  padding: 15px;
}

.form-signin .form-floating:focus-within {
  z-index: 2;
}

.form-signin input[type="text"] {
  margin-bottom: -1px;
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
}

.form-signin input[type="password"] {
  margin-bottom: 10px;
  border-top-left-radius: 0;
  border-top-right-radius: 0;
}
body::-webkit-scrollbar {
	width: 5px;
	height: 0px;
}
body::-webkit-scrollbar-thumb {
	background-color: #2f3542;
	border-radius: 10px;
}

.cloud_effect{
	height: 50px;
	animation-duration: 20s;
	animation-name: cloudLink;
	animation-iteration-count: infinite;
	display: flex;
	place-items: center;
}
.logo_text{
    place-content: center;
    width: 300px;
    HEIGHT: 50PX;
    display: flex;
    margin-bottom: 50px;
    text-decoration: none;
    font-size: 30px;
    font-weight: bold;
}

@keyframes cloudLink {     
 0% { color: #FFA7A7; }
 7% { color: #FFC19E; }
 14% { color: #FFE08C; }
 21% { color: #FAED7D; }
 28% { color: #CEF279; }
 35% { color: #B7F0B1; }
 42% { color: #B2EBF4; } 
 49% { color: #B2CCFF; }
 56% { color: #D1B2FF; }
 63% { color: #FFB2F5; }
 70% { color: #FFB2D9; }
 77% { color: #B2CCFF; }
 84% { color: #D5D5D5; }
 91% { color: #BDBDBD; }
 100% { color: #353535; }
}
	
</style>
</head>
<body class="text-center">
	<main class="form-signin w-100 m-auto">

	  <form action="${pageContext.request.contextPath}/users/login" method="post">
	  	<a href="../" class="logo_text">
			<p class="cloud_effect">FOOD CLOUD</p>
		</a>
		  <c:choose>
              <c:when test="${ empty param.url }">
                 <input type="hidden" name="url" value="${pageContext.request.contextPath}/"/>
              </c:when>
              <c:otherwise>
                 <input type="hidden" name="url" value="${param.url }"/>
              </c:otherwise>
          </c:choose>

	
	    <div class="form-floating">
	      <input name="id" value="${cookie.savedId.value }" type="text" class="form-control" id="floatingInput" placeholder="id">
	      <label for="floatingInput">아이디</label>
	    </div>
	    <div class="form-floating">
	      <input name="pwd" value="${cookie.savedPwd.value }" type="password" class="form-control" id="floatingPassword" placeholder="password">
	      <label for="floatingPassword">비밀번호</label>
	    </div>
	
	    <div class="checkbox mb-3">
	      <label>
      		<!-- 체크박스를 체크하지 않으면 isSave 라는 파라미터 값으로 넘어오는 문자열은 null 이고
      		체크를 하면 isSave 라는 파라미터 값으로 넘어오는 문자열은 "yes" 이다. -->
	        <input name="isSave" type="checkbox" value="yes" ${empty cookie.savedId ? '' : 'checked' }> 로그인 정보 저장
	      </label>
	    </div>
	    <button class="w-100 btn btn-lg btn-primary" type="submit">로그인</button>
	    <a href="${pageContext.request.contextPath}/users/signup_form" class="w-100 btn btn-lg btn-success" style="margin-top:10px;">회원가입</a>
	    <p class="mt-5 mb-3 text-muted">&copy; 2023 ACORN TEAM1</p>
	  </form>
	</main>
</body>
</html>