package com.gura.acorn.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.gura.acorn.Interceptor.LoggingInterceptor;

//설정과 관련된 java파일에는 @Configuration 어노테이션을 ㅊ가한다.
@Configuration
public class WebConfig implements WebMvcConfigurer{

	@Autowired
    LoggingInterceptor loggingInterceptor;
	
	@Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loggingInterceptor)
        .addPathPatterns("/users/*", "/shop/*", "/error/*", "/statistics/*","/search/*" , "/")
        .excludePathPatterns("/users/signup_form", "/users/loginform", "/users/pwd_updateform",
        		"/shop/insertform", "/shop/insert", "/shop/menu_insert", "/shop/menu_insertform", "/shop/update", "/shop/updateform");
    }
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		
		registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
	}

}