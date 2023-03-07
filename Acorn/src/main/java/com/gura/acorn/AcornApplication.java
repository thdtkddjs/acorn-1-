
package com.gura.acorn;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.scheduling.annotation.EnableScheduling;

import com.gura.acorn.websocket.WebSocketService;



@SpringBootApplication
@EnableScheduling
public class AcornApplication {
	
	public static void main(String[] args) {
		ConfigurableApplicationContext context = SpringApplication.run(AcornApplication.class, args);
		
		WebSocketService webSocketService = context.getBean(WebSocketService.class);
	}
	
}
