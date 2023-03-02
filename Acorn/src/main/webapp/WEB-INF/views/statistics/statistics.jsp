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
	display: flex;
    justify-content: center;
    height: 150px;
    align-items: center;
    font-size: 15px;
   	border : 1px solid #cecece;
   	border-top : none;
}
.uv_count{
	display : flex;
	width : 30%;
	height : 100px;
	margin-right : 50px;
	padding : 0 20px;
}
.pv_count{
	display : flex;
	width : 30%;
	height : 100px;
	margin-left : 50px;
	padding : 0 20px;
}
.pv_count>span>a{
	text-decoration : none;
}
.uv_table, .pv_table{
	width : 100%;
}
.uvt_cont, .pvt_cont{
	text-align:left;
}
.uvt_val, .pvt_val{
	text-align:right;
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
    		<div class="uv_count">
	    		<table class="uv_table">
	    			<tr>
	    				<td class="uvt_cont">서비스 누적 이용자</td>
	    				<td class="uvt_val">NNNN명</td>
	    			</tr>
	    			<tr>
	    				<td class="uvt_cont">이번달 누적 이용자</td>
	    				<td class="uvt_val">mmmm명</td>
	    			</tr>
	    		</table>
    		</div>
    		<div class="pv_count">
  		    	<table class="pv_table">
		    			<tr>
		    				<td class="pvt_cont">서비스 누적 페이지뷰</td>
		    				<td class="pvt_val" id="app1"></td>
		    			</tr>
		    			<tr>
		    				<td class="pvt_cont">1일 누적 페이지 뷰</td>
		    				<td class="pvt_val" id="app2"></td>
		    			</tr>		
		    			<tr>
		    				<td class="pvt_cont">1일 페이지뷰 1위 </td>
		    				<td class="pvt_val"><a href=""> 음식점명</a></td>
		    			</tr>
    			</table>

    		</div>
    	</div>
    	<div class="statistics_mid">
    	<div class="row">
		    <div class="statistics_topic">
		    	<a href="${pageContext.request.contextPath}/statistics/sample">
	    			<img src="${pageContext.request.contextPath}/resources/images/month.jpg" alt="" />
	    			<br />
	    			<b style="display: flex; place-content: center;">월간 카테고리 통계</b>
	    		</a>
	    	</div>
    	</div>
    	</div>
    	
    	<div class="statistics">
    		<canvas id="myChart" ref="acquisitions"></canvas>
    	</div>
	</div>
</body>

<script>
const app = Vue.createApp({
	setup() {
		const arr = Vue.ref([0, 0, 0, 0, 0]); // arr를 ref로 만들어서 반응성을 추가
		const chartData = Vue.reactive({
				labels: ["★", "★★", "★★★", "★★★★", "★★★★★"],
				datasets: [{
					label: "리뷰 별점 수",
					axis: 'y',
					barThickness: 10,
					backgroundColor: "rgba(255, 99, 132, 0.2)",
					borderColor: "rgba(255,99,132,1)",
					borderWidth: 1,
					data: arr.value, // arr의 값을 참조
				},
				],
			});
			// window.onload 대신에 Vue.watchEffect를 사용
			// arr의 값이 변경될 때마다 chartData.datasets[0].data도 변경
			Vue.watchEffect(() => {
				arr.value = [0, 0, 0, 0, 0]; // 초기화
				console.log(arr.value[0]);
				for (let i=1; i < 6; i++) {
					if(document.getElementsByClassName("score_count_"+i+".0")[0]==null){
						
					}
					else{
						arr.value[i-1] = Number(document.getElementsByClassName("score_count_"+i+".0")[0].value);
					}
					
			  	}
				chartData.datasets[0].data = arr.value; // 데이터 갱신
			});
	
			return {
		    	chartData,
			};
	},
	async mounted() {
		const response = await fetch('http://localhost:9000/es/test', {
			method : 'GET',
			headers : {
				'Content-Type' : 'application/json',
			}
		});
		
		//받아온 데이터 중 어떤 데이터를 사용할지  부분
		const viewObject = await response.json();
		console.log(viewObject.length);
		
		const ctx = document.getElementById("myChart").getContext("2d");
		const myChart = new Chart(ctx, {
			type: "bar",
			data: this.chartData,
			options: {
				plugins: {
					legend: {
						display: false
						},
					datalabels: {
			            font: {
			              size: 12,
			            },
			            display: function(context) {
			                return context.dataset.data[context.dataIndex]>1;
			              },
			            anchor: 'end',
			            align: 'right',
			            offset: 2,
			            formatter: function(value, context) {
			              return value;
			            }
					}
				},
				indexAxis: 'y',
				scales: {
					x:{
				        ticks: {
				        	display: false,
				        	stepSize: 1,
				        },
			            grid: {display: false},
					},
					y: {
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
				layout: {
					padding: {
						top: 0,
						bottom: 0,
						left: 0,
						right: 20
					}
				},
		     },
		   });
	  },
});
app.mount(".statistics");
</script>
</html>