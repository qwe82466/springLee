package com.board.service;

import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class TestServiceImpl implements TestService 	{
	
	//핵심기능
	@Override
	public void helloAop() {
			log.info("***********hello Aop!!!!!*************");
	}

}
