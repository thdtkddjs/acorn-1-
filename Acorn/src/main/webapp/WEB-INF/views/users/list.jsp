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
   <div class="container">
      <h3>회원 목록 보기</h3>
      <table class="table table-striped">
         <thead class="table-dark">
            <tr>
               <th>아이디</th>
               <th>이메일</th>
               <th>등록일</th>
               <th>차단</th>
               <th>차단 여부</th>
            </tr>
         </thead>
         <tbody>
         <c:forEach var="tmp" items="${list }">
            <tr>
               <td>${tmp.id }</td>
               <td>${tmp.email }</td>
               <td>${tmp.regdate }</td>
               <td><a href="javascript:ban('${tmp.id }')">차단</a></td>
               <td id="${tmp.id }">${tmp.ban }</td>
            </tr>
         </c:forEach>
         </tbody>
      </table>
      <nav>
         <ul class="pagination">
            <%--
               startPageNum 이 1 이 아닌 경우에만 Prev 링크를 제공한다. 
               &condition=${condition}&keyword=${encodedK}
             --%>
            <c:if test="${startPageNum ne 1 }">
               <li class="page-item">
                  <a class="page-link" href="list?pageNum=${startPageNum-1 }&condition=${condition}&keyword=${encodedK}">Prev</a>
               </li>
            </c:if>
            <c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
               <li class="page-item ${pageNum eq i ? 'active' : '' }">
                  <a class="page-link" href="list?pageNum=${i }&condition=${condition}&keyword=${encodedK}">${i }</a>
               </li>
            </c:forEach>
            <%--
               마지막 페이지 번호가 전체 페이지의 갯수보다 작으면 Next 링크를 제공한다. 
             --%>
            <c:if test="${endPageNum lt totalPageCount }">
               <li class="page-item">
                  <a class="page-link" href="list?pageNum=${endPageNum+1 }&condition=${condition}&keyword=${encodedK}">Next</a>
               </li>
            </c:if>
         </ul>
      </nav>
      <!-- 검색 폼 -->
      <form action="list" method="get">
         <label for="condition">검색조건</label>   
         <select name="condition" id="condition">
            <option value="id" ${condition eq 'id' ? 'selected' : '' }>아이디</option>
         </select>
         <input type="text" name="keyword" placeholder="검색어..." value="${keyword }"/>
         <button type="submit">검색</button>
      </form>
      <c:if test="${not empty condition }">
         <p>
            <strong>${totalRow }</strong> 개의 자료가 검색 되었습니다.
            <a href="list">리셋</a>
         </p>
      </c:if>
   </div>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
   <script>
      function ban(id){
         let isBan=confirm("삭제 하시겠습니까?");
         if(isBan){
           //여기서 id 를 활용해서 페이지 전환 없이 원하는 작업을 한다.
           $.ajax({
        	   url:"${pageContext.request.contextPath}/users/ban",
        	   method:"post",
        	   data:{id:id},
        	   success:function(data){
        		   console.log(data);
        		   if(data.isSuccess){
        			   $("#"+id).text("BAN");
        		   }
        	   }
           });
         }
      }
   </script>
</body>
</html>






