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
</head>
<body>
	<jsp:include page="../../views/include/navbar.jsp">
		<jsp:param value="search01" name="thisPage"/>
	</jsp:include>
   <div data-bs-spy="scroll" data-bs-target="#simple-list-example" data-bs-offset="0" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
   <div id="simple-list-item-1"></div>
   <a href="${pageContext.request.contextPath}/">인덱스로</a>
      <h3>가게 목록</h3>
      <table class="table table-striped">
         <thead class="table-dark">
            <tr>
               <th>분류</th>
               <th>상호명</th>
               <th>평점</th>
               <th>리뷰수</th>
               <th>전화번호</th>
               <th>pv</th>
            </tr>
         </thead>
         <tbody>
            <c:forEach var="tmp" items="${list }">
               <tr>
                  <td>${tmp.categorie }</td>
                  <td>
                     <a href="detail?num=${tmp.num }&condition=${condition}&keyword=${encodedK}">${tmp.title }</a>
                  </td>
                  <td>${tmp.grade }</td>
                  <td>${tmp.reviewCount }</td>
                  <td>${tmp.telNum }</td>
                  <td>pv</td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
      
      <c:if test="${not empty keyword }">
         <p>
            <strong>${totalRow }</strong> 개의 자료가 검색 되었습니다.
         </p>
      </c:if>
      
      <c:choose>
         <c:when test="${totalRow gt 5}">
            <a href="${pageContext.request.contextPath}/shop/list?keyword=${keyword}">더보기</a>
         </c:when>
      </c:choose>
      
      <h3>리뷰 목록</h3>
      <table class="table table-striped">
         <thead class="table-dark">
            <tr>
               <th>번호</th>
               <th>내용</th>
               <th>등록일</th>
            </tr>
         </thead>
         <tbody>
            <c:forEach var="tmp" items="${rvlist }">
               <tr>
                  <td>${tmp.num }</td>
				  <td>
				  	<a href="detail?num=${tmp.ref_group }">${tmp.content }</a>
				  </td>
                  <td>${tmp.regdate }</td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
      <c:if test="${not empty keyword }">
         <p>
            <strong>${rvtotalRow }</strong> 개의 자료가 검색 되었습니다.
         </p>
      </c:if>
      
      <c:choose>
         <c:when test="${rvtotalRow gt 5}">
            <a href="${pageContext.request.contextPath}/shop/review_list?keyword=${rvkeyword}">더보기</a>
         </c:when>
      </c:choose>
   </div> 
</body>
</html>