package com.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.board.domain.BoardVO;
import com.board.domain.Criteria;
import com.board.domain.PageDTO;
import com.board.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	@GetMapping("list")
	public void list(Model model , Criteria cri) {
		log.info("listpage");
		log.info(cri);
		model.addAttribute("list",service.getList(cri));
		
		int total = service.getTotal(cri);
		log.info("total"+total);
		model.addAttribute("pager", new PageDTO(cri, total));
	}
	
	@GetMapping({"read", "modify"})
	public void read(Long bno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("*********************read*********************");
		model.addAttribute("board", service.get(bno));
	}
	
	@PostMapping("modify")
	public String modify(BoardVO board, RedirectAttributes rttr, Criteria cri) {
		//수정처리 
		if(service.modify(board)) {
			log.info("****수정성공****");
			rttr.addFlashAttribute("result","success");
		}
		
		
		return "redirect:/board/list" + cri.getListLink();
	}
	  
	@PostMapping("delete")
	public String delete(long bno, RedirectAttributes rttr , Criteria cri) {
		if(service.delete(bno)) {
			log.info("****************삭제성공*****************");
				rttr.addFlashAttribute("result","success");
		}
		
		return "redirect:/board/list" + cri.getListLink();
	}
	

	@GetMapping("write")
	public void write() {
		
	}
	
	@PostMapping("write")
	public String writeBoard(BoardVO board, RedirectAttributes rttr) {
		
		log.info("write처리*******");
		
		service.register(board);
		// RedirectAttributes: model 처럼 스프링 MVC 가 자동으로 전달해주는 객체
		// addFlashAttributes(key,value) : url뒤에 데이터가 붙지 않고, 일회성 데이터로 페이지를 새로고침하며 데이터 날라감.
		//									단, 값1개만 전달 가능. (2개이상은 데이터 소멸 map타입으로 한번에 보내자)
		// addAttribute(key,value)
		// 위와 같은 메서드를 이용하여 리다이렉트되는 jsp 페이지에 데이터 전달할 수 있다.
		
		rttr.addFlashAttribute("result",board.getBno());
		//등록처리후 글 고유번호 속성으로 추가해서 전달 (list 에서 사용)
		
		
		return "redirect:/board/list";
	}
	
	
	
	
}
