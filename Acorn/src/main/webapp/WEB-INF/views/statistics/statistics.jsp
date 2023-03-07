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
<script src="https://cdn.jsdelivr.net/npm/dayjs@1/dayjs.min.js"></script>
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
		
		//받아온 데이터 중 어떤 데이터를 사용할지  부분
/* 		const monthPvCount = viewObject.filter(item => {
		    return item.date.startsWith("2024-01");
		});
 */
		document.getElementById("tpv").innerText = viewObject[2].PVTotalCount;
		document.getElementById("dpv").innerText = viewObject[1].PVDayCount;
		document.getElementById("pvTopTitle").innerText = viewObject[3].maxStore;

		const data=[];
		const data2=[];
		var pvTotalVal = 0;
		
		for(var i=0; i<12; i++){
			var monthKey = Object.keys(viewObject[0])[i];
			if(monthKey != null){
				pvMonthVal = viewObject[0][monthKey];
				pvTotalVal = pvTotalVal+viewObject[0][monthKey];
			}

			//chart 1의 데이터
			data.push({month:monthKey, pvMonth:pvMonthVal});
			//chart 2의 데이터
			data2.push({month:monthKey, totalPv : pvTotalVal});
			
			monthKey, pvMonthVal = 0;
			
		}
		
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
		
		var dataRST =[];
		const response4 = await fetch('http://localhost:9000/es/test2', {
			method : 'GET',
			headers : {
				'Content-Type' : 'application/json',
			}
		});
		
		const viewObject4 = await response4.json();
		var currTime2 = 0;
		var secData=[];
		var timeData=[];
		var timeObj = {};
		var currTime= dayjs().valueOf()-90000;
	
		if(viewObject4.length==0){
			console.log("아무 것도 없다")
		}else{
			//response4를 활용해서 "time" ket의 초 부분을 뽑아서 배열에 저장한다
 			for (var k = 0; k < viewObject4.length; k++) {
 				  objTime = viewObject4[k].time;
 				  timeObj[dayjs(objTime).$s] = dayjs(objTime).valueOf();
 				  timeData.push(timeObj);
 				  secData[k] = dayjs(objTime).$s;
 			}
		}
		
		for(var n=0; n<90 ;n++){
			const currList=[];
			const resTime = Math.random() *10;
			if(secData.includes(n)){
				currList.push({x: timeObj[n], y:resTime, rslt: (n%3==0) ? "success" : "failure"})
			}
			else{
				currList.push({x: currTime, y:null, rslt:null})
			}
			currTime=currTime+1000;
			dataRST.push(currList);
			
		}
		

		
		function manfData(dataArr) {
			return dataArr.map(d => {
				return {
					data: d,
					label: d[0].x,
					backgroundColor: function(context) {
					    var responseType = context.dataset.data[context.dataIndex].rslt;
					    var responseTime = context.dataset.data[context.dataIndex].y;
					    return responseType === "success" && responseTime > 6 ? 'orange' : (responseType === "success" ? 'skyblue' : 'red');
					}
				}
			})
		}
		
		const ctx4 = document.getElementById("myChart4").getContext("2d");
		const dataLabels = [];

		const myChart4 = new Chart(ctx4, {
			type: "scatter",
	        data: {
	            datasets: manfData(dataRST),
	          },
			options: {
				plugins: {
					tooltip: {
						  callbacks: {
						    title: function(tooltipItem, data) {
						    	if(tooltipItem[0].dataset.data[0].rslt != "success"){
						    		return 'Abnormal Response';
						    	}
						    	else if(tooltipItem[0].dataset.data[0].y>6){
						    		return 'Pending Response';
						    	}else{
						    		return 'Normal Response';
						    	}
						    },
						    label: function(tooltipItem, data) {
						      return 'Request Time : ' + dayjs(tooltipItem.dataset.data[0].x).$d;
						    },
						    afterLabel: function(tooltipItem, data) {
						    	console.log(tooltipItem.dataset.data[0])
						      return 'Response Time : '+ tooltipItem.dataset.data[0].y.toFixed(2) + "(ms)";
						    }
						  }
						},
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
					},
				},
				animation : {
					duration : 0,
				},
				scales: {
					x:{
			    	ticks: {
				    		font : {
				    			size : 12,
				    		},
							display: true,
							maxTicksLimit: 40,	
							stepSize: 100,
							// 눈금 값 설정
					        callback: function(value, index, values) {
					        	/* 
					            var currH = dayjs().hour();
					            var currM = dayjs().minute();
					            var currS = dayjs().second();
					            var currTime = dayjs().startOf('day').add(currH, 'hour').add(currM, 'minute').add(currS, 'second');
					            var tickTime = currTime;
					            var ticks = [];
					            for (var i = 10; i > 0; i--) {
									tickTime = currTime.subtract(30 * (i-1), 'second');
									ticks.push(Number(tickTime.format('HHmmss')));
									//values[i] = tickTime.format('HH:mm:ss');
					            }
					            console.log("======")
					            console.log(ticks);
					            */
					            return dayjs(value).$H+":"+dayjs(value).$m+":"+dayjs(value).$s;
					          },
					         
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
					    	stepSize: 1, // 레이블의 높이를 줄이기 위해 값을 높임
					    },
					},
				},
				responsive: true,

			},
			
		});
		window.addEventListener('resize', function() {
			myChart.resize();
		});
		
 		setInterval(async function (){
 			const dataRST = []
 			var secData=[];
 			var timeData=[];
 			var timeObj = {};
 			const response4 = await fetch('http://localhost:9000/es/test2', {
 				method : 'GET',
 				headers : {
 					'Content-Type' : 'application/json',
 				}
 			});
 			const viewObject4 = await response4.json();
 			
 			if(viewObject4.length==0){
 				console.log("아무 것도 없다")
 			}else{
 	 			for (var k = 0; k < viewObject4.length; k++) {
 	 				  objTime = viewObject4[k].time;
 	 				  timeObj[dayjs(objTime).$s] = dayjs(objTime).valueOf();
 	 				  timeData.push(timeObj);
 	 				  secData[k] = dayjs(objTime).$s;
 	 			}
 			}
 			
 			var currTime= dayjs().valueOf()-90000;
 			for(var n=0; n<90 ;n++){
 				const currList=[];
 				const resTime = Math.random() *10;
 				if(secData.includes(n)){
 					currList.push({x: timeObj[n], y:resTime, rslt:"success"})
 				}
 				else{
 					currList.push({x: currTime, y:null, rslt:null})
 					currTime = currTime+1000;
 				}
				dataRST.push(currList);
 			}
			myChart4.data.datasets = manfData(dataRST)
			myChart4.update();
		
		} , 5000);
	},
	

});
app.mount(".statistics");

</script>
</html>