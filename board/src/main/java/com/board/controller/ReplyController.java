package com.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.board.domain.ReplyVO;
import com.board.service.ReplyService;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/reply/*")
@Log4j
public class ReplyController {
	
	@Autowired
	private ReplyService service;
	
	//PRODUCES => 인코딩... 헤더정보를 추가해주는 것! , 서버에서 생산하여 부라우저에 리턴해주는 데이터의 형태를 지정(서버 ->브)
	//					브라우저에서 요청 시 지정한 accept 요청 헤더값과 일치
	//consumes: 브라우저에서 요청시 지정한 Content-Type 과 일치하게 작성. (브 -> 서버)
	//댓글 추가 요청 매핑
	@PostMapping(value="add" , consumes = "application/json"
			,produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> add(@RequestBody ReplyVO vo){
		log.info("**********vo:"+vo); 
		int result=service.add(vo);
		
		
		
		return result ==1 ? new ResponseEntity<String>("sucess", HttpStatus.OK)
				:new ResponseEntity<String>("fail", HttpStatus.INTERNAL_SERVER_ERROR)
				;
	}
	//댓글 목록 요청 매핑
	@GetMapping(value="list/{bno}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.APPLICATION_XML_VALUE}) 
	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("bno") long bno){//bno 꺼내주기위해 패스 배리어블
		
		log.info("*************** get reply list bno :"+bno);
		List<ReplyVO> list= service.getList(bno);
		log.info("*************** get reply list  :"+list); 
		
		return new ResponseEntity<List<ReplyVO>>(list, HttpStatus.OK); 
		
	}
	
}
