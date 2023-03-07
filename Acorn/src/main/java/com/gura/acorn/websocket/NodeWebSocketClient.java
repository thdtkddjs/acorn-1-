package com.gura.acorn.websocket;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.client.standard.StandardWebSocketClient;
import org.springframework.web.socket.handler.AbstractWebSocketHandler;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.net.URI;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

@Component
public class NodeWebSocketClient extends AbstractWebSocketHandler implements DisposableBean {
    private static final Logger logger = LoggerFactory.getLogger(NodeWebSocketClient.class);

//  private static final String SERVER_URI = "ws://localhost:8011/";
    private static final String SERVER_URI = "ws://34.125.190.255:8011/";
    
    private final StandardWebSocketClient webSocketClient;
    private WebSocketSession webSocketSession;

    private final CountDownLatch connectLatch = new CountDownLatch(1);

    @Autowired
    public NodeWebSocketClient() {
        this.webSocketClient = new StandardWebSocketClient();
    }

    @PostConstruct
    public void connect() throws InterruptedException {
        logger.info("Connecting to {}", SERVER_URI);

        this.webSocketClient.doHandshake(this, SERVER_URI);
        this.connectLatch.await(10, TimeUnit.SECONDS);
    }

    public void send(String message) throws IOException {
        if (this.webSocketSession != null && this.webSocketSession.isOpen()) {
            logger.info("Sending message: {}", message);

            this.webSocketSession.sendMessage(new TextMessage(message));
        }
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        logger.info("Connected to {}", SERVER_URI);

        this.webSocketSession = session;
        this.connectLatch.countDown();
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        logger.info("Disconnected from {}: {}", SERVER_URI, status);
    }

    @Override
    public void destroy() throws Exception {
        logger.info("Disconnecting from {}", SERVER_URI);

        if (this.webSocketSession != null && this.webSocketSession.isOpen()) {
            this.webSocketSession.close();
        }
    }
}