<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>chatRoom</title>

<style>
#chat_box {
    width: 800px;
    min-width: 800px;
    height: 500px;
    min-height: 500px;
    border: 1px solid black;
}
#msg {
    width: 700px;
}
#msg_process {
    width: 90px;
}
</style>

</head>
<body>

  <div id="indexPage">
    {{ message }}
    <br />
    <input type="text" class="border w-64 h-12" id="ClientID" v-model="message">
    <div style="width: 800px;"><canvas ref="acquisitions"></canvas></div>
  </div>

<div id="chat_box"></div>
    <input type="text" id="msg">
    <button id="msg_process">전송</button>
<footer>
	<p>저작권 정보</p>
	<input type="text" id="ID"/>
	<button id="ID_change">변경</button>
</footer>
    
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.2.1/chart.umd.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
<script>

	//ClientID를
	//ID가 있다면 읽어오고
	//없다면 후보군 중 랜덤한 하나를 지정한다.
	sessionStorage.setItem("clientID", "Tom");
	const guests = ['Tom', 'Jerry', 'Mickey', 'Donald', 'Goofy', 'Snoopy'];
	

	if(sessionStorage.getItem("id") != null){
        sessionStorage.setItem("clientID", sessionStorage.getItem("id"));
	} else {
		const clientID = guests[Math.floor(Math.random() * guests.length)];
		sessionStorage.setItem("clientID", clientID);
	}

	console.log(sessionStorage.getItem("clientID"));	
	//id를 임의로 변경한다.
	document.querySelector("#ID_change").addEventListener("click", function(){
		const id = document.querySelector("#ID").value;
		sessionStorage.setItem("clientID", id);
		console.log(id);
		
  	});
	
	
    //웹소켓을 연결
    const ws = new WebSocket('ws://34.125.190.255:8011/');
	//const ws = new WebSocket('ws://localhost:8011/');
	
	//연결 성공 시에 실행되는 function
    ws.onopen = function() {
      console.log('Connected to server!');
      addChatRoom('Connected to server!');
    };
    //데이터를 받아올 때 실행되는 function
    ws.onmessage = function(event) {
	    console.log('Received message: ' + event.data);

//	    const data = JSON.stringify(result);
	    //받아온 데이터가 JSON 데이터이므로 parsing 해준다.
	    event.data.text().then((jsonString) => {
	        const jsonObj = JSON.parse(jsonString);
	        if(jsonObj.type=="message"){
		        console.log(jsonObj.text);
		        const text = jsonObj.text;
		        const id = jsonObj.id;
		        addChatRoom(id+": "+text);
		    }else if(jsonObj.type=="data"){
		    	console.log(jsonObj.text);
		    }
	    }).catch((error) => {
	        console.error('Error parsing message as JSON:', error);
	    });
    };
    

  	//클릭 할 필요 없이 msg입력 후 enter로 send하게 해주는 이벤트 리스너
  	document.querySelector("#msg").addEventListener("keydown", function(key){
	  	//해당하는 키가 엔터키(13) 일떄
	     if(key.keyCode == 13){
	         //msg_process를 클릭해준다.
	         document.querySelector("#msg_process").click();
	     }
  	})
  	
  	//msg를 websocket 측에 쏴주는 이벤트리스너
  	document.querySelector("#msg_process").addEventListener("click", function(){
  		sendMessages();
  	});
    //type = chatting에 참여한 client임을 알림
    //text = 메시지 데이터
    //id = 아이디
    //date = 혹시 필요할지 몰라서 시간 정보도 포함
  	function sendMessages() {
        const msg = document.querySelector("#msg").value;
        var clientID = sessionStorage.getItem("clientID");
        var msg1 = {
        	    type: "message",
        	    text: msg,
        	    id:   clientID,
        	    date: Date.now()
        	  };
        
        ws.send(JSON.stringify(msg1))
        //메시지를 보낸 후 msg 인풋을 초기화.
        document.querySelector("#msg").value="";
    }
	//chatRoom, 즉 채팅창에 메시지를 띄운다.
	//현재는 자신의 정보를 별도로 표기하고 있지는 않다.
	function addChatRoom(text){
		const chatBox = document.querySelector('#chat_box');
        const messageElement = document.createElement('div');
        messageElement.innerText = text;
        chatBox.appendChild(messageElement);
	}
	
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
	    const ws = new WebSocket('ws://34.125.190.255:8011/');
	    ws.onmessage = function(event) {
	        //받아온 데이터를 parsing하여 그래프의 data에 넣어준다.
	        event.data.text().then((jsonString) => {
	            const jsonObj = JSON.parse(jsonString);
	            console.log('Received json: ' + jsonObj);
	            if(jsonObj.type=="data"){
	            	const newdata = {
	    	                time: jsonObj.date,
	    	                count: jsonObj.text
	    	              };
	            	console.log(chart.data.labels.length);
// 	            	if(chart.data.labels.length >= 3){
	              	  data = data.slice(1);
// 	            	  chart.data.labels.push(newdata.time);
// 		              chart.data.datasets[0].data.push(newdata.count);
					  data.push(newdata);
		              chart.data.labels = data.map(row => row.time);
		              chart.data.datasets[0].data = data.map(row => row.count);
		              chart.update();
// 	            	}else{
// 	            	  chart.data.labels.push(newdata.time);
// 		              chart.data.datasets[0].data.push(newdata.count);
// 		              chart.update();
// 	            	}
	            }
	        })
	    }.bind(this);
		
		
	  }
	}).mount('#indexPage');
</script>

</body>
</html>