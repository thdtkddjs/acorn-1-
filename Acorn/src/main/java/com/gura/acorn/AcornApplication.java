
package com.gura.acorn;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;


@EnableScheduling
@SpringBootApplication
public class AcornApplication {
	
	public static void main(String[] args) {
		SpringApplication.run(AcornApplication.class, args);
	}
	
}
