package com.board.aop;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.junit.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Component 	//스프링 빈으로 등록되기 위한 어노테이션(aop와는 관계x)
@Aspect		// 해당 클래스가 Aspect를 구현한 것임을 나타냄 (aop 관련 클래스)
@Log4j
public class AnnoAdvice {
	
	/*
	@Pointcut("execution(* test(..))")
	private void testPC() {}
	
	@Before("testPC()")  //포인트컷의 메서드 이름 을 적어주면 적용
	public void before() {
		//공통기능 구현 코드
	}
	*/
	/*
	@Before("execution(* test*(..))")
	public void before() {
		
	}
	*/
	
	@Around("execution(* com.board.service.TestService*.*(..))")
	public Object around(ProceedingJoinPoint j) throws Throwable{
		log.info("************ 비포 어라운드 ************");
		
		Object[] args = j.getArgs();
		for(Object o :args) {
			if(o instanceof HttpServletRequest) {
				log.info("김계정의 계정탈퇴");
				HttpServletRequest request = (HttpServletRequest)o;
				request.getSession();
			}
		}
		
		
		
		
		Object obj = j.proceed();
		
		log.info("************ 애프터 어라운드 ************");
		
		return obj;
	}
	
	@AfterThrowing("execution(* com.board.service.TestService*.*(..))")
	public void aftTh(Throwable e) {
		log.info(e.getMessage());
	}
	
	
	
	
	
	
	
	
	

}
