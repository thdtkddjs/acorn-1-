package com.gura.acorn.scheduled;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gura.acorn.users.service.UsersService;

@Component
public class LoginCheckedScheduled {

	@Autowired
	private UsersService service;
	
	@Scheduled(cron = "0 0 0 1/1 * ?") // 매일 자정에 실행
    public void resetLoginChecked() {
        service.loggedInReset();
    }
}