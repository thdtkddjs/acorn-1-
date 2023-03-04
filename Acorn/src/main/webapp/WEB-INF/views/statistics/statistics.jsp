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
.statistics{
	width : 100%;
	height : 100%;	
	margin : auto;
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
.statistics> canvas{
	display: block;
	border : 1px solid #cecece;
	border-radius : 10px;
	padding : 50px;
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
	    				<td class="uvt_val" id="tuv"></td>
	    			</tr>
	    			<tr>
	    				<td class="uvt_cont">이번달 누적 이용자</td>
	    				<td class="uvt_val" id="muv"></td>
	    			</tr>
	    		</table>
    		</div>
    		<div class="pv_count">
  		    	<table class="pv_table">
		    			<tr>
		    				<td class="pvt_cont">서비스 누적 페이지뷰</td>
		    				<td class="pvt_val" id="tpv"></td>
		    			</tr>
		    			<tr>
		    				<td class="pvt_cont">일일 누적 페이지 뷰</td>
		    				<td class="pvt_val" id="dpv"></td>
		    			</tr>		
		    			<tr>
		    				<td class="pvt_cont">일일 페이지뷰 1위 </td>
		    				<td class="pvt_val"><a href="" id="pvTopTitle"> 음식점명</a></td>
		    			</tr>
    			</table>

    		</div>
    	</div>
    	<br />
  	    <div class="statistics">
   		 	<canvas id="myChart" ref="acquisitions" width="600" height="600"></canvas>
   		 	<br />
   		 	<canvas id="myChart2" ref="acquisitions2" width="600" height="600"></canvas>
   		 	<br />
   		 	<canvas id="myChart3" ref="acquisitions3" width="600" height="600"></canvas>
   		 	<br />
			<canvas id="myChart4" ref="acquisitions4" width="600" height="600"></canvas>
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
    	

	</div>
</body>

<script>
const app = Vue.createApp({

	async mounted() {
		const response = await fetch('http://localhost:9000/es/test', {
			method : 'GET',
			headers : {
				'Content-Type' : 'application/json',
			}
		});
		const viewObject = await response.json();
		console.log(viewObject);
		
		//받아온 데이터 중 어떤 데이터를 사용할지  부분
/* 		const monthPvCount = viewObject.filter(item => {
		    return item.date.startsWith("2024-01");
		});
 */
		document.getElementById("tpv").innerText = viewObject[2].PVTotalCount;
		document.getElementById("dpv").innerText = viewObject[1].PVDayCount;
		document.getElementById("pvTopTitle").innerText = viewObject[3].maxStore;
		
		
	    const data = [
	        { month: '24년 1월', pvMonth : viewObject[0].PVMonthCount+5 },
	        { month: '24년 2월', pvMonth: viewObject[0].PVMonthCount+13 },
	        { month: '24년 3월', pvMonth: viewObject[0].PVMonthCount },
	        { month: '23년 4월', pvMonth: viewObject[0].PVMonthCount+3 },
	        { month: '23년 5월', pvMonth: viewObject[0].PVMonthCount+1 },
	        { month: '23년 6월', pvMonth: viewObject[0].PVMonthCount+12 },
	        { month: '23년 7월', pvMonth: viewObject[0].PVMonthCount-3 },
	        { month: '23년 8월', pvMonth: viewObject[0].PVMonthCount-8 },
	        { month: '23년 9월', pvMonth: viewObject[0].PVMonthCount+9 },
	        { month: '23년 10월', pvMonth: viewObject[0].PVMonthCount-11 },
	        { month: '23년 11월', pvMonth: viewObject[0].PVMonthCount+12 },
	        { month: '23년 12월', pvMonth: viewObject[0].PVMonthCount-33 },	        
	    ];

		console.log(data);
		const ctx = document.getElementById("myChart").getContext("2d");

		const myChart = new Chart(ctx, {
			type: "bar",
	        data: {
	            labels: data.map(row => row.month),
	            datasets: [
	              {
	                label: '월별 PV',
	                data: data.map(row => row.pvMonth)
	              }
	            ]
	          },
			plugins : [ChartDataLabels],
			options: {
				plugins: {
					title: {
						display: true,
						text: '최근 12개월 월별 PV',
						font:{
							size: 20,
						},
						padding: 0,
					},
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
					        color: 'black',
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
		

		
		
		//chart2 값
	    const tPv=[];
		
	    for(var i=0; i<12; i++){
	    	if(i==0){
	    		tPv[i] = viewObject[0].PVMonthCount;
	    	}else{
	    		tPv[i] = tPv[i-1]+viewObject[0].PVMonthCount - 5*(12-i);
	    	}
	    	
	    }
	    const data2 = [
	        { month: '23년 4월', totalPv: tPv[0] },
	        { month: '23년 5월', totalPv: tPv[1] },
	        { month: '23년 6월', totalPv: tPv[2] },
	        { month: '23년 7월', totalPv: tPv[3] },
	        { month: '23년 8월', totalPv: tPv[4] },
	        { month: '23년 9월', totalPv: tPv[5] },
	        { month: '23년 10월', totalPv: tPv[6] },
	        { month: '23년 11월', totalPv: tPv[7] },
	        { month: '23년 12월', totalPv: tPv[8] },
	        { month: '24년 1월', totalPv : tPv[9] },
	        { month: '24년 2월', totalPv: tPv[10]},
	        { month: '24년 3월', totalPv: 3000 },
	    ];
		
		console.log(data2);
		const ctx2 = document.getElementById("myChart2").getContext("2d");
		const myChart2 = new Chart(ctx2, {
			type: "line",
	        data: {
	            labels: data2.map(row => row.month),
	            datasets: [
	              {
	                label: '월별 PV2',
	                data: data2.map(row => row.totalPv)
	              }
	            ]
	          },
			plugins : [ChartDataLabels],
			options: {
				plugins: {
					title: {
						display: true,
						text: '누적 PV 증가 추세',
						font:{
							size: 20,
						},
						padding: 0,
					},
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
			            anchor: 'top',
			            align: 'left',
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
					        color: 'black',
					    	stepSize: 500, // 레이블의 높이를 줄이기 위해 값을 높임
					    },
					},
				},
				responsive: true,
				},
		});
		window.addEventListener('resize', function() {
			myChart2.resize();
		});
		
		
		
		//chart3
		
	    const data3 = [
	        { category: '한식', count: 10 },
	        { category: '중식', count: 20 },
	        { category: '일식', count: 15 },
	        { category: '양식', count: 25 },
	        { category: '분식', count: 22 },
	        { category: '패스트푸드', count: 30 },
	        { category: '기타', count: 28 },
	      ];
	  	const ctx3 = document.getElementById("myChart3").getContext("2d");
	  	
	  	const myChart3 = new Chart(ctx3, {
	  		type: "doughnut",
	          data: {
	              labels: data3.map(row => row.category),
	              datasets: [
	                {
	                  label: '월간 카테고리 별 PV',
	                  data: data3.map(row => row.count)
	                }
	              ]
	            },
	  		plugins : [ChartDataLabels],
	  		options: {
	  			plugins: {
					title: {
						display: true,
						text: '월간 카테고리 별 점유율',
						font:{
							size: 20,
						},
						padding: 0,
					},
	  				legend:{
	  					display: true,
	  					labels: {
	  						font: {
	  						  size: 12,
	  						},
	  						boxWidth: 30
	  					}
	  				},
	  				datalabels: {
	  		            font: {
	  		              size: 15,
	  		              color: 'gray',
	  		            },
	  		            display: function(context) {
	  		                return context.dataset.data[context.dataIndex]>1;
	  		              },
	  		            anchor: 'top',
	  		            align: 'center',
	  		            offset: 2,
	  		            formatter: function(value, context) {
	  		                let sum = 0;
	  		                let dataArr = context.chart.data.datasets[0].data;
	  		                dataArr.map(data => {
	  		                  sum += data;
	  		                });
	  		                let percentage = (value * 100 / sum).toFixed(2) + "%";
	  		                return percentage;
	  		            }
	  				}
	  			},

	  	     },
		});
		window.addEventListener('resize', function() {
			myChart3.resize();
		});
		
		
		//chart4 
		const dataRST =[]
		const dataFRST=[]

		//x는 시간(날짜 1일 ~ 365일)
		//y는 응답시간*날짜
		//정상 응답시간이 보통 0.1 ms로 찍히는데, 테스트 데이터에서는 편의상 1로 표기한다, y값을 계산식을 저렇게 했으므로 날짜가 증가함에 따라 우상향하는 점그래프가 그려진다
		for(var i=0; i<365; i++){
				if(i%10==0){
					dataRST.push({num:i, rst:Math.random()*0.3, frst:Math.random()*1.3, rslt:"timeout"})
				}else 
					dataRST.push({num:i , rst:Math.random()*0.3})
					dataRST.push({num:i , rst:Math.random()*0.3})
		}
		console.log(dataRST);
		console.log(dataFRST);
		console.log(dataRST[0].rslt ? dataRST[0].rslt : '비정상');
		const ctx4 = document.getElementById("myChart4").getContext("2d");
		const myChart4 = new Chart(ctx4, {
			type: "scatter",
	        data: {
	            labels: dataRST.map(row=>row.num),
	            datasets: [
	              {
	                label: '정상',
	                data: dataRST.map(row=>row.rst),
	              },	              
	              {
	                label: dataRST[1].rslt ? dataRST[1].rslt : this.labels,
	                data: dataRST.map(row=>row.frst),
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
	

});
app.mount(".statistics");

</script>
</html>