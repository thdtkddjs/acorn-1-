<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>list.jsp</title>
<style>
.container{
	width : 624px !important;
	height : 800px;
	box-shadow: 0px 5px 20px 0px grey;
	margin-top : 50px;
	border-radius : 20px;
	padding-top : 50px;
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
form{
	width : 624px;
}
a{
	text-decoration : none;
}
select{
	border-radius : 5px;
}

</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<body class="text-center">
   <div class="container">
		<a href="${pageContext.request.contextPath}/index" class="logo_text">
			<img class="logo"
			src="${pageContext.request.contextPath}/resources/images/logos/angry_cloud.png"
			alt="" style="height: 50px;" />
		</a>
		<br />
		<br />
		<h3>USER ADMIN.</h3>
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
         <select name="condition" id="condition">
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






