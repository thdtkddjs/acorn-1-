<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
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
	        type: 'bar',
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
	    //const ws = new WebSocket('ws://34.125.190.255:8011/data');
	    //테스트용 로컬 웹소켓
	    const ws = new WebSocket('ws://localhost:8011/data');
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
=======
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
		  //data�쓽 length媛� 怨� graph�쓽 理쒕�� �궗�씠利덉씠�떎. �씠蹂대떎 而ㅼ쭏 寃쎌슦 �삤�옒�맂 �닚�꽌���濡� �옄瑜몃떎.
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
	    //�궡遺��뿉�꽌 �벐湲� �쐞�빐 �쎒�냼耳볦뿉 �뿰寃�
	    //�꽌踰꾩뿉 �삱�씪媛� �엳�뒗 諛깃렇�씪�슫�뱶 �쎒�냼耳�
	    const ws = new WebSocket('ws://34.125.190.255:8011/data');
	    //�뀒�뒪�듃�슜 濡쒖뺄 �쎒�냼耳�
	    //const ws = new WebSocket('ws://localhost:8011/data');
	    ws.onmessage = function(event) {
	        //諛쏆븘�삩 �뜲�씠�꽣瑜� parsing�븯�뿬 洹몃옒�봽�쓽 data�뿉 �꽔�뼱以��떎.
	        event.data.text().then((jsonString) => {
	            const jsonObj = JSON.parse(jsonString);
	            if(jsonObj.type=="data"){
	            	const newdata = {
	    	                time: jsonObj.date,
	    	                count: jsonObj.text
	    	              };
	            	//�꼫臾� 湲몄뼱吏��뒗 寃쎌슦(�쐞�뿉�꽌 data �뙆�씪�쓽 length留뚰겮. �븘留� 25�씪 寃�)
	            	//�궘�젣�븯怨� 洹몃옒�봽瑜� shifting�븳�떎.
	            	data = data.slice(1);
					data.push(newdata);
		            chart.data.labels = data.map(row => row.time);
		            chart.data.datasets[0].data = data.map(row => row.count);
		            //�옉�뾽�씠 �걹�궗�쑝�땲 李⑦듃瑜� �뾽�뜲�씠�듃�빐以��떎.
>>>>>>> refs/remotes/Upstream/master
		            chart.update();
	            }
	        })
	    }.bind(this);
	  }
	}).mount('#indexPage');
</script>
</body>
</html>