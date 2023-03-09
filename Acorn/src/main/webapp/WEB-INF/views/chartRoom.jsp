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
		  //dataÀÇ length°¡ °ğ graphÀÇ ÃÖ´ë »çÀÌÁîÀÌ´Ù. ÀÌº¸´Ù Ä¿Áú °æ¿ì ¿À·¡µÈ ¼ø¼­´ë·Î ÀÚ¸¥´Ù.
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
	    //³»ºÎ¿¡¼­ ¾²±â À§ÇØ À¥¼ÒÄÏ¿¡ ¿¬°á
	    //¼­¹ö¿¡ ¿Ã¶ó°¡ ÀÖ´Â ¹é±×¶ó¿îµå À¥¼ÒÄÏ
	    //const ws = new WebSocket('ws://34.125.190.255:8011/data');
	    //Å×½ºÆ®¿ë ·ÎÄÃ À¥¼ÒÄÏ
	    const ws = new WebSocket('ws://localhost:8011/data');
	    ws.onmessage = function(event) {
	        //¹Ş¾Æ¿Â µ¥ÀÌÅÍ¸¦ parsingÇÏ¿© ±×·¡ÇÁÀÇ data¿¡ ³Ö¾îÁØ´Ù.
	        event.data.text().then((jsonString) => {
	            const jsonObj = JSON.parse(jsonString);
	            if(jsonObj.type=="data"){
	            	const newdata = {
	    	                time: jsonObj.date,
	    	                count: jsonObj.text
	    	              };
	            	//³Ê¹« ±æ¾îÁö´Â °æ¿ì(À§¿¡¼­ data ÆÄÀÏÀÇ length¸¸Å­. ¾Æ¸¶ 25ÀÏ °Í)
	            	//»èÁ¦ÇÏ°í ±×·¡ÇÁ¸¦ shiftingÇÑ´Ù.
	            	data = data.slice(1);
					data.push(newdata);
		            chart.data.labels = data.map(row => row.time);
		            chart.data.datasets[0].data = data.map(row => row.count);
		            //ÀÛ¾÷ÀÌ ³¡³µÀ¸´Ï Â÷Æ®¸¦ ¾÷µ¥ÀÌÆ®ÇØÁØ´Ù.
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
		  //dataì˜ lengthê°€ ê³§ graphì˜ ìµœëŒ€ ì‚¬ì´ì¦ˆì´ë‹¤. ì´ë³´ë‹¤ ì»¤ì§ˆ ê²½ìš° ì˜¤ë˜ëœ ìˆœì„œëŒ€ë¡œ ìë¥¸ë‹¤.
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
	    //ë‚´ë¶€ì—ì„œ ì“°ê¸° ìœ„í•´ ì›¹ì†Œì¼“ì— ì—°ê²°
	    //ì„œë²„ì— ì˜¬ë¼ê°€ ìˆëŠ” ë°±ê·¸ë¼ìš´ë“œ ì›¹ì†Œì¼“
	    const ws = new WebSocket('ws://34.125.190.255:8011/data');
	    //í…ŒìŠ¤íŠ¸ìš© ë¡œì»¬ ì›¹ì†Œì¼“
	    //const ws = new WebSocket('ws://localhost:8011/data');
	    ws.onmessage = function(event) {
	        //ë°›ì•„ì˜¨ ë°ì´í„°ë¥¼ parsingí•˜ì—¬ ê·¸ë˜í”„ì˜ dataì— ë„£ì–´ì¤€ë‹¤.
	        event.data.text().then((jsonString) => {
	            const jsonObj = JSON.parse(jsonString);
	            if(jsonObj.type=="data"){
	            	const newdata = {
	    	                time: jsonObj.date,
	    	                count: jsonObj.text
	    	              };
	            	//ë„ˆë¬´ ê¸¸ì–´ì§€ëŠ” ê²½ìš°(ìœ„ì—ì„œ data íŒŒì¼ì˜ lengthë§Œí¼. ì•„ë§ˆ 25ì¼ ê²ƒ)
	            	//ì‚­ì œí•˜ê³  ê·¸ë˜í”„ë¥¼ shiftingí•œë‹¤.
	            	data = data.slice(1);
					data.push(newdata);
		            chart.data.labels = data.map(row => row.time);
		            chart.data.datasets[0].data = data.map(row => row.count);
		            //ì‘ì—…ì´ ëë‚¬ìœ¼ë‹ˆ ì°¨íŠ¸ë¥¼ ì—…ë°ì´íŠ¸í•´ì¤€ë‹¤.
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