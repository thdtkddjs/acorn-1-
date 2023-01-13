
package com.gura.acorn;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;

//import com.gura.acorn.users.service.UsersEmailSenderService;

@SpringBootApplication
public class AcornApplication {
	//@Autowired
	//private UsersEmailSenderService senderService;
	
	public static void main(String[] args) {
		SpringApplication.run(AcornApplication.class, args);
	}
	
	/* 회원가입할때 이메일인증을 거치는 코드 추후 구현하겠음
	@EventListener(ApplicationReadyEvent.class)
	public void sendMail() {
		senderService.sendEmail("xxx@gmail.com",
								"This is Subject",
								"This is Body of Email");
	}
	*/
}
