<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/index.css">
<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.2.1/chart.umd.js"></script>
<title>statistics.jsp</title>
<style>
.category_bar>.row{
	padding :0 20%;
	height : 50px;
	align-content : center;
	background-color : #ffd9d9;
}
.category_bar>.row>a{
	flex : 1;
	text-decoration : none;
	color : black;
	font-weight : bold;
	text-align : center;
}
.container{
	width : 75%;
}
.statistics_top{
	background : #F2FFED;
	display: flex;
    justify-content: center;
    height: 150px;
    align-items: center;
}
.statistics_mid>.row{
    place-content: center;
}
.statistics_topic{
    display: contents;
}
.statistics_topic>a>img{
	width : 250px;
	height : 250px;
	border : 1px solid #cecece;
	border-radius : 10px;
}
.statistics_topic>a{
	margin : 5%;
}
.statistics_bot{
	width : 600px;
	display:flex;
	margin : auto;
}
</style>
</head>
<body>
	<jsp:include page="../../views/include/navbar.jsp">
		<jsp:param value="statistics" name="thisPage"/>
	</jsp:include>
	<div data-bs-spy="scroll" data-bs-target="#simple-list-example" data-bs-offset="0" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
    <div id="simple-list-item-1" class="block_content_top"></div>
    <div class="category_bar">
    	<div class="row">
				<a href="">메인</a>
				<a href="">주제1</a>
				<a href="">주제2</a>
				<a href="">주제3</a>
				<a href="">주제4</a>
    	</div>

    </div>
    
	<div class="container">
    	<div class="statistics_top">
    		이곳은 통계 페이지 임을 보여주는 것
    	</div>
    	<div class="statistics_mid">
    	<div class="row">
		    <div class="statistics_topic">
		    	<a href="${pageContext.request.contextPath}/statistics/example_1">
	    			<img src="https://youthpress.net/xe/files/attach/images/9794/484/657/24886b2473d0171dfa8b7e82c10486e4.jpg" alt="" />
	    		</a>
	    	</div>
	    	<div class="statistics_topic">
	    		<a href="">
	    			<img src="https://blog.kakaocdn.net/dn/b6bbD5/btqDc3E1G6F/2dQiURlRhkefcuI3CfF6X1/img.jpg" alt="" />
	    		</a>
	    	</div>
    	</div>
		<div class="row">
		   	<div class="statistics_topic">
		   		<a href="">
		   			<img src="https://img.freepik.com/free-vector/world-food-set_1284-12898.jpg" alt="" />
		   		</a>
		   	</div>
		   	<div class="statistics_topic">
		   		<a href="">
		   			<img src="https://en.pimg.jp/062/773/146/1/62773146.jpg" alt="" />
	   			</a>
		   	</div>
		</div>

    	</div>
    	
    	<div class="statistics_bot">
    		<canvas ref="acquisitions"></canvas>
    	</div>
	</div>
</body>
<script>
  const { createApp } = Vue

  createApp({
    data() {
      return {
        message: 'Hello Vue!'
      }
    },
    mounted() {
      const data = [
        { year: 2010, count: 10 },
        { year: 2011, count: 20 },
        { year: 2012, count: 15 },
        { year: 2013, count: 25 },
        { year: 2014, count: 22 },
        { year: 2015, count: 30 },
        { year: 2016, count: 28 },
      ];

      new Chart(
        this.$refs.acquisitions,
        {
          type: 'bar',
          data: {
            labels: data.map(row => row.year),
            datasets: [
              {
                label: 'Acquisitions by year',
                data: data.map(row => row.count)
              }
            ]
          }
        }
      );
    }
    
  }).mount('.statistics_bot')
</script>
</html>