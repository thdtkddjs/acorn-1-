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
   <a href="${pageContext.request.contextPath}/">인덱스로</a>
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
      
     <nav>
         <ul class="pagination justify-content-center">
         <c:choose>
            <c:when test="${rvstartPageNum ne 1 }">
               <li class="page-item">
                        <a class="page-link" href="review_list?pageNum=${rvstartPageNum - 1}&category=${category }&condition=${condition}&keyword=${encodedK}">Prev</a>
                  </li>
            </c:when>
            <c:otherwise>
               <li class="page-item disabled">
                        <a class="page-link" href="javascript:">Prev</a>
                  </li>
            </c:otherwise>
         </c:choose>
         <c:forEach var="i" begin="${rvstartPageNum }" end="${rvendPageNum }">
            <li class="page-item ${rvpageNum eq i ? 'active' : '' }">
               <a class="page-link" href="review_list?pageNum=${i }&category=${rvcategory }&condition=${rvcondition}&keyword=${rvencodedK}">${i }</a>
            </li>
         </c:forEach>
         <c:choose>
            <c:when test="${rvendPageNum lt rvtotalPageCount }">
               <li class="page-item">
                        <a class="page-link" href="review_list?pageNum=${rvendPageNum + 1}&category=${category }&condition=${condition}&keyword=${encodedK}"">Next</a>
                  </li>
            </c:when>
            <c:otherwise>
               <li class="page-item disabled">
                        <a class="page-link" href="javascript:">Next</a>
                  </li>
            </c:otherwise>
         </c:choose>
         </ul>
      </nav>
</body>
</html>