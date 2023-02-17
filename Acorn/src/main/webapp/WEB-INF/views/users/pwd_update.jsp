<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/users/pwd_update.jsp</title>
</head>
<body>
<div class="container">
   <c:choose>
      <c:when test="${isSuccess }">
         <script>
	         	window.location.href = '${pageContext.request.contextPath}/users/loginform';
         </script>
      </c:when>
      <c:otherwise>
         <p>
            이전 비밀번호가 일치하지 않습니다.
            <a href="${pageContext.request.contextPath}/users/pwd_updateform">다시 시도</a>
         </p>
      </c:otherwise>
   </c:choose>
</div>
</body>
</html>