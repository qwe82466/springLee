package com.board.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

public class TestController {
	@RequestMapping(value = "/test2", method = RequestMethod.POST)
	@ResponseBody
	public void test2(String fromYear, String fromMonth, String fromDay,String toYear, String toMonth, String toDay){
		System.out.println(fromYear+fromMonth+fromDay);
	}
}
