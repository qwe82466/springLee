package com.board.aop;

import org.aspectj.lang.ProceedingJoinPoint;

import lombok.extern.log4j.Log4j;

@Log4j
public class Advice {

	public void beforeL() {
		log.info("-------------------------before advice");
		log.info("-------------------------before advice");
		log.info("-------------------------before advice");
	}
	
	public void afterL() {
		log.info("-------------------------afterL advice");
		log.info("-------------------------afterL advice");
		log.info("-------------------------afterL advice");
	}
	
	public void afterReturning() {
		log.info("-------------------------afterRetuning advice");
		log.info("-------------------------afterRetuning advice");
		log.info("-------------------------afterRetuning advice");
	}
	
	public void afterT() {
		log.info("-------------------------afterT advice");
		log.info("-------------------------afterT advice");
		log.info("-------------------------afterT advice");
	}
	
	/*
	 around 메서드 구현방벙
	 첫번째 매개변수ProceedingJoinPoint j 지정
	 리턴타입 Object 타입으로, 가던길가라(타겟으로~) j.proceed() 호출하여
	 리턴받은값을 리턴해주는 형태로 작성
	 
	  */
	public Object around(ProceedingJoinPoint j) throws Throwable {
		log.info("-------------------------around before 발생 ---------------------");
		log.info("-------------------------around before 발생 ---------------------");
		log.info("-------------------------around before 발생 ---------------------");
		
		Object obj=j.proceed(); // 가던길 가라
		
		log.info("-------------------------around after 발생---------------------------");
		log.info("-------------------------around after 발생---------------------------");
		log.info("-------------------------around after 발생---------------------------");
		
		return obj;
	}
	
	
}
