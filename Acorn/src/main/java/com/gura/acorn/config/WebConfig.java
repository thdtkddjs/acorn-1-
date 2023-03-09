package com.gura.acorn.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

import com.gura.acorn.Interceptor.LoggingInterceptor;

@Configuration
@EnableWebSocketMessageBroker
public class WebConfig implements WebMvcConfigurer{
	
	
	@Autowired
    LoggingInterceptor loggingInterceptor;
	
	
	@Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loggingInterceptor)
        .addPathPatterns("/users/*", "/shop/*", "/error/*", "/statistics/*","/search/*" , "/")
        .excludePathPatterns("/users/signup_form", "/users/loginform", "/users/pwd_updateform",
        		"/shop/insertform", "/shop/insert", "/shop/menu_insert", "/shop/menu_insertform", "/shop/update", "/shop/updateform", "/es/test");
    }
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}

}