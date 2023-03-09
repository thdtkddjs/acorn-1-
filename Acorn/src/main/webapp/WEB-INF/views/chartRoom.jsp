<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>chartRoom</title>
</head>
<body>
	<div id="indexPage">
	   {{ message }}
	   <br />
	   <input type="text" class="border w-64 h-12" id="ClientID" v-model="message">
	    <div style="width: 800px;"><canvas ref="acquisitions"></canvas></div>
	</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.2.1/chart.umd.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script>
	const { createApp } = Vue
	createApp({
	  data() {
	    return {
	      message: 'Hello Vue!',
	      }
	  },
	  async mounted() {
		  //data의 length가 곧 graph의 최대 사이즈이다. 이보다 커질 경우 오래된 순서대로 자른다.
		  var data = [
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	          { time: 0, count: 0 },
	        ];
		 
	    const chart = new Chart(
	      this.$refs.acquisitions,
	      {
	        type: 'scatter',
	        data: {
	            labels: data.map(row => row.time),
	            datasets: [
	              {
	                label: 'Acquisitions by time',
	                data: data.map(row => row.count)
	              }
	            ]
	          }
	      }
	    );
	    //내부에서 쓰기 위해 웹소켓에 연결
	    //서버에 올라가 있는 백그라운드 웹소켓
	    const ws = new WebSocket('ws://34.125.190.255:8011/data');
	    //테스트용 로컬 웹소켓
	    //const ws = new WebSocket('ws://localhost:8011/data');
	    ws.onmessage = function(event) {
	        //받아온 데이터를 parsing하여 그래프의 data에 넣어준다.
	        event.data.text().then((jsonString) => {
	            const jsonObj = JSON.parse(jsonString);
	            if(jsonObj.type=="data"){
	            	const newdata = {
	    	                time: jsonObj.date,
	    	                count: jsonObj.text
	    	              };
	            	//너무 길어지는 경우(위에서 data 파일의 length만큼. 아마 25일 것)
	            	//삭제하고 그래프를 shifting한다.
	            	data = data.slice(1);
					data.push(newdata);
		            chart.data.labels = data.map(row => row.time);
		            chart.data.datasets[0].data = data.map(row => row.count);
		            //작업이 끝났으니 차트를 업데이트해준다.
		            chart.update();
	            }
	        })
	    }.bind(this);
	  }
	}).mount('#indexPage');
</script>
</body>
</html>