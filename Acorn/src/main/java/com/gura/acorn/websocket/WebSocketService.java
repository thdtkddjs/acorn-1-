package com.gura.acorn.websocket;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WebSocketService {
	
    private final NodeWebSocketClient webSocketClient;

    @Autowired
    public WebSocketService(NodeWebSocketClient webSocketClient) {
        this.webSocketClient = webSocketClient;
    }
    
    public void sendMessage(String message) {
    	try {
            this.webSocketClient.send(message);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
