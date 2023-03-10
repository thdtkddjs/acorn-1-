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
	    	const blob = event.data;
	    	const reader = new FileReader();
	    	reader.onload = function(event) {
	    	  const buffer = event.target.result;
	    	  console.log(buffer); // Output: ArrayBuffer(5) {}
	    	  const arrayBuffer = buffer;
	    	  const dataView = new DataView(arrayBuffer);
	    	  const decoder = new TextDecoder();
	    	  const text = decoder.decode(dataView);
	    	  const json = JSON.parse(text);
			  console.log(json);
	    	};
	    	reader.readAsArrayBuffer(blob);
	        //받아온 데이터를 parsing하여 그래프의 data에 넣어준다.
	       
	    }.bind(this);
	  }
	}).mount('#indexPage');
</script>
</body>
</html>