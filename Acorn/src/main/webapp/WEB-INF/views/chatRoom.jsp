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

<div id="chat_box"></div>
    <input type="text" id="msg">
    <button id="msg_process">전송</button>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
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
    //웹소켓을 연결
    const ws = new WebSocket('ws://34.125.190.255:8011/');
	//const ws = new WebSocket('ws://localhost:8011/');
	
	//연결 성공 시에 띄워준다.
    ws.onopen = function() {
      console.log('Connected to server!');
      addChatRoom('Connected to server!');
    };
    
    ws.onmessage = function(event) {
	    console.log('Received message: ' + event.data);

//	    const data = JSON.stringify(result);
	    
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
        document.querySelector("#msg").value="";
    }
	
	function addChatRoom(text){
		const chatBox = document.querySelector('#chat_box');
        const messageElement = document.createElement('div');
        messageElement.innerText = text;
        chatBox.appendChild(messageElement);
	}
</script>

</body>
</html>