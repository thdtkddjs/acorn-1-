package com.gura.acorn.statistics;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StatisticsController {

	
	@RequestMapping("statistics/statistics")
	public String statistics(HttpServletRequest request) {
		return "statistics/statistics";
	}
	@RequestMapping("statistics/sample")
	public String sample(HttpServletRequest request) {
		return "statistics/sample";
	}
}
