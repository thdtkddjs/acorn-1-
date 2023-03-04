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
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
<title>sample page.jsp</title>
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
.statistics_mid{
	width : 600px;
	display:flex;
	margin : auto;
}
.statistics_bot{
	height : 100px;
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
   		 	<canvas id="myChart" ref="acquisitions" width="400" height="400"></canvas>
    	</div>
    	
    	<div class="statistics_bot">

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
  async mounted() {
		const response = await fetch('http://localhost:9000/es/test', {
			method : 'GET',
			headers : {
				'Content-Type' : 'application/json',
			}
		});
		const viewObject = await response.json();

		
		//받아온 데이터 중 어떤 데이터를 사용할지  부분
		const tpvm_jan = viewObject.filter(item => {
		    return item.date.startsWith("2024-01");
		});
		const tpvm_feb = viewObject.filter(item => {
		    return item.date.startsWith("2024-02");
		});
		const tpvm_mar = viewObject.filter(item => {
		    return item.date.startsWith("2024-03");
		});
		const tpvm_apr = viewObject.filter(item => {
		    return item.date.startsWith("2023-04");
		});
		const tpvm_may = viewObject.filter(item => {
		    return item.date.startsWith("2023-05");
		});
		const tpvm_jun = viewObject.filter(item => {
		    return item.date.startsWith("2023-06");
		});
		const tpvm_jul = viewObject.filter(item => {
		    return item.date.startsWith("2023-07");
		});
		const tpvm_aug = viewObject.filter(item => {
		    return item.date.startsWith("2023-08");
		});
		const tpvm_sep = viewObject.filter(item => {
		    return item.date.startsWith("2023-09");
		});
		const tpvm_oct = viewObject.filter(item => {
		    return item.date.startsWith("2023-10");
		});
		const tpvm_nov = viewObject.filter(item => {
		    return item.date.startsWith("2023-11");
		});
		const tpvm_dec = viewObject.filter(item => {
		    return item.date.startsWith("2023-12");
		});
		
		const filteredData = viewObject.filter(item => {
		    return item.date.startsWith("2023-12");
		});
		const dailyPv = viewObject.filter(item => {
		    return item.date.startsWith("2023-12-25");
		});
		
		console.log(tpvm_jan);
		console.log("dd" +filteredData.length);
		
	    const data = [];
	    for(var i=0; i<tpvm_jan.length; i++){
	    	tpvm_jan[i].date = tpvm_jan[i].date.slice(11,13)*i;
	    	tpvm_jan[i].id = i+1;
	    	console.log(tpvm_jan[i].date);
	    	data[i] = tpvm_jan[i];
	    }
	    const data2 = [];
	    for(var i=0; i<tpvm_feb.length; i++){
	    	tpvm_feb[i].date = tpvm_feb[i].date.slice(9,11)*i;
	    	tpvm_feb[i].id = i;
	    	data2[i] = tpvm_feb[i];
	    }	    
		console.log(data);
		const ctx = document.getElementById("myChart").getContext("2d");
		const myChart = new Chart(ctx, {
			type: "scatter",
	        data: {
	            labels: data.map(row => row.id),
	            datasets: [
	              {
	                label: '정상',
	                data: data.map(row => row.date)
	              },
	              {
	                label: '실패',
	                data: data2.map(row => row.date)
	              },	              
	              
	            ]
	          },
			plugins : [ChartDataLabels],
			options: {
				plugins: {
					legend: {
						display: false
						},
					datalabels: {
			            font: {
			              size: 0,
			            },
			            display: function(context) {
			                return context.dataset.data[context.dataIndex]>1;
			              },
			            anchor: 'top',
			            align: 'center',
			            offset: 2,
			            formatter: function(value, context) {
			              return value;
			            }
					}
				},
				scales: {
					x:{
				    	ticks: {
							display: true,
							stepSize: 1,
				        },
			            grid: {display: false},
					},
					y:{
						beginAtZero: true, // y축이 0부터 시작하도록 설정
						offset: true,
						grid: {
						    display: false
					  	},
					    ticks: {
					        color: '#ffc107',
					    	stepSize: 10, // 레이블의 높이를 줄이기 위해 값을 높임
					    },
					},
				},
				responsive: true,
				},
		});
		window.addEventListener('resize', function() {
			myChart.resize();
		});
  },
}).mount('.statistics_mid')
</script>

</html>