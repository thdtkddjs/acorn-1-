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
               <th>제목</th>
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
      <nav>
         <ul class="pagination justify-content-center">
         <c:choose>
            <c:when test="${startPageNum ne 1 }">
               <li class="page-item">
                        <a class="page-link" href="search?pageNum=${startPageNum - 1}&category=${category }&condition=${condition}&keyword=${encodedK}">Prev</a>
                  </li>
            </c:when>
            <c:otherwise>
               <li class="page-item disabled">
                        <a class="page-link" href="javascript:">Prev</a>
                  </li>
            </c:otherwise>
         </c:choose>
         <c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
            <li class="page-item ${pageNum eq i ? 'active' : '' }">
               <a class="page-link" href="search?pageNum=${i }&category=${category }&condition=${condition}&keyword=${encodedK}">${i }</a>
            </li>
         </c:forEach>
         <c:choose>
            <c:when test="${endPageNum lt totalPageCount }">
               <li class="page-item">
                        <a class="page-link" href="search?pageNum=${endPageNum + 1}&category=${category }&condition=${condition}&keyword=${encodedK}"">Next</a>
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
                  <td>${tmp.content }</td>
                  <td>${tmp.regdate }</td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
      
      <c:choose>
         <c:when test="${rvlist.size() gt 4}">
            <a href="${pageContext.request.contextPath}/shop/review_list?keyword=${rvkeyword}">더보기</a>
         </c:when>
      </c:choose>
      
     <nav>
         <ul class="pagination justify-content-center">
         <c:choose>
            <c:when test="${rvstartPageNum ne 1 }">
               <li class="page-item">
                        <a class="page-link" href="search?pageNum=${rvstartPageNum - 1}&category=${category }&condition=${condition}&keyword=${encodedK}">Prev</a>
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
               <a class="page-link" href="search?pageNum=${i }&category=${category }&condition=${condition}&keyword=${encodedK}">${i }</a>
            </li>
         </c:forEach>
         <c:choose>
            <c:when test="${rvendPageNum lt rvtotalPageCount }">
               <li class="page-item">
                        <a class="page-link" href="search?pageNum=${rvendPageNum + 1}&category=${category }&condition=${condition}&keyword=${encodedK}"">Next</a>
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
   
   
      <!-- 검색 폼 -->
      <form method="get">
         <label for="condition">검색조건</label>   
         <select name="condition" id="condition">
            <option value="title_content" ${condition eq 'title_content' ? 'selected' : '' }>제목 + 내용</option>
            <option value="title" ${condition eq 'title' ? 'selected' : '' }>제목</option>
            <option value="writer" ${condition eq 'writer' ? 'selected' : '' }>작성자</option>
         </select>
         <input type="text" name="keyword" placeholder="검색어..." value="${keyword }" id="inputMsg"/>
         <button type="submit" id="sendBtn">검색</button>
      </form>
      <c:if test="${not empty condition }">
         <p>
            <strong>${totalRow+rvtotalRow }</strong> 개의 자료가 검색 되었습니다.
            <a href="list">리셋</a>
         </p>
      </c:if>
   </div> 
</body>
</html>