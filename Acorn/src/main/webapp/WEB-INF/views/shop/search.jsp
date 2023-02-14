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
</head>
<body>
   <div>
   
   <a href="${pageContext.request.contextPath}/">인덱스로</a>
      <h3>가게 목록</h3>
      <table class="table table-striped">
         <thead class="table-dark">
            <tr>
               <th>번호</th>
               <th>상호명</th>
               <th>소개</th>
               <th>분류</th>
               <th>주소</th>
            </tr>
         </thead>
         <tbody>
            <c:forEach var="tmp" items="${list }">
               <tr>
                  <td>${tmp.num }</td>
                  <td>
                     <a href="detail?num=${tmp.num }&condition=${condition}&keyword=${encodedK}">${tmp.title }</a>
                  </td>
                  <td>${tmp.content }</td>
                  <td>${tmp.categorie }</td>
                  <td>${tmp.addr }</td>
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