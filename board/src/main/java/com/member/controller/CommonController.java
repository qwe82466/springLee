package com.member.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.member.domain.MemberVO;
import com.member.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/common/*")
@Log4j
public class CommonController {

	@Autowired
	private MemberService service;
	
	@GetMapping("main")
	public void main() {
		log.info("************** main!!!! *************");
	}
	
	// 로그인 폼 요청 (처리는 시큐리티가) 
	@GetMapping("login")
	public void login() {
		log.info("************** login!!!! *************");
	}
	
	// 회원가입 폼 
	@GetMapping("signup")
	public void signup() {
		log.info("************** signup!!!! *************");
	}
	// 회원가입 처리 
	@PostMapping("signup")
	public String signupPro(MemberVO member, String au, RedirectAttributes rttr) {
		
		log.info("*********** signupPro MemberVO : " + member);
		log.info("*********** signupPro au : " + au);
		
		int result = service.addMember(member);  // 회원 추가 
		service.addAuth(au, member.getId());	// 권한 추가 
		
		if(result == 1) {
			rttr.addFlashAttribute("msg", "success");
		}
		
		return "redirect:/common/main";
	}
	
	
	
	
	
	
	
	
}
