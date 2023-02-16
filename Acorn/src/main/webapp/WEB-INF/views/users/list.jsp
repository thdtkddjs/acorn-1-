<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="../resources/css/index.css">
<title>list.jsp</title>
<style>
.container{
	width : 624px !important;
	height : 700px;
	border : 1px solid #CECECE;
	padding-top : 50px;
	margin-bottom:50px;
}
h1{
	text-align : center;
}
.submit_btn{
	width : 100px;
}
.form-control{
	width : 400px;
	margin-left:100px;
	
}
label{
	width : 150px;
	text-align:left;
}
input{
	border : 1px solid #000000;
	border-radius:5px;
}
.pagination{
	width : 500px;
}
a{
	text-decoration : none;
}
select{
	border-radius : 5px;
}
ul{
	margin:auto;
}

</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<body class="text-center">
	<jsp:include page="../../views/include/navbar.jsp">
		<jsp:param value="admin01" name="thisPage"/>
	</jsp:include>
	<div data-bs-spy="scroll" data-bs-target="#simple-list-example" data-bs-offset="0" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
   <div id="simple-list-item-1" class="container">
		
		<br />
		<br />
		<h3>USER ADMIN</h3>
      	<br />
      	<div style="    border-radius: 10px;
					    border: solid 1px white;
					    overflow: hidden;">
      	<table class="table table-striped" style="width : auto; margin : 0px;">
         <thead class="table-dark">
            <tr>
               <th>ID</th>
               <th>E-MAIL</th>
               <th>REGIST DATE</th>
               <th>BAN</th>
               <th>STATUS</th>
            </tr>
         </thead>
         <tbody>
         <c:forEach var="tmp" items="${list }">
            <tr>
               <td style="width:150px;">${tmp.id }</td>
               <td style="width:250px;">${tmp.email }</td>
               <td style="width:200px;">${tmp.regdate }</td>
               <td style="width:100px;"><a href="javascript:ban('${tmp.id }')" class="btn btn-outline-danger">BAN</a></td>
               <td style="width:100px;" id="${tmp.id }">${tmp.ban }</td>
            </tr>
         </c:forEach>
         </tbody>
      </table>
      </div>
      <br />
      <nav>
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="${startPageNum ne 1 }">
					<li class="page-item">
	               		<a class="page-link" href="list?pageNum=${startPageNum - 1}&category=${category }&condition=${condition}&keyword=${encodedK}">◀</a>
	            	</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
	               		<a class="page-link" href="javascript:">◀</a>
	            	</li>
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
				<li class="page-item ${pageNum eq i ? 'active' : '' }">
					<a class="page-link" href="list?pageNum=${i }&category=${category }&condition=${condition}&keyword=${encodedK}">${i }</a>
				</li>
			</c:forEach>
			<c:choose>
				<c:when test="${endPageNum lt totalPageCount }">
					<li class="page-item">
	               		<a class="page-link" href="list?pageNum=${endPageNum + 1}&category=${category }&condition=${condition}&keyword=${encodedK}"">▶</a>
	            	</li>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
	               		<a class="page-link" href="javascript:">▶</a>
	            	</li>
				</c:otherwise>
			</c:choose>
	      </ul>
	   </nav>
      
      <!-- 검색 폼 -->
      <form action="list" method="get"> 
         <select name="condition" id="condition" style="display:none;">
            <option value="id" ${condition eq 'id' ? 'selected' : '' }>아이디</option>
         </select>
         
         <input type="text" name="keyword" placeholder="검색어..." value="${keyword }"/>
         <button type="submit" style="border-radius : 5px;">검색</button>
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
         let isBan=confirm("해당 계정을 정지 처리하시겠습니까?");
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






