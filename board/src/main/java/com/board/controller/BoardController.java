package com.board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
<<<<<<< HEAD
import org.springframework.web.bind.annotation.ResponseBody;
=======
>>>>>>> branch 'master' of https://github.com/qwe82466/springLee.git
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.board.domain.BoardVO;
import com.board.domain.Criteria;
import com.board.domain.LocationVO;
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
	public void list(Model model, Criteria cri) {
		log.info("list!!!!!!!");
		// model로 list jsp에 뿌려줄 글 목록 전달 
		model.addAttribute("list", service.getList(cri)); 
		log.info("************ cri : " + cri);
		
		int total = service.getTotal(cri); // 게시글 개수 가져오기 
		log.info("******************* total : " + total);
		model.addAttribute("pager", new PageDTO(cri, total)); 
		
	}
	
	@GetMapping("read") 
	public void read(Long bno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("read!!!!!!!");
		model.addAttribute("board", service.get(bno));
	}
	
	@PreAuthorize("isAuthenticated()") // 로그인한 사용자만 접근 가능하게 
	@GetMapping("modify")
	public void modifyForm(Long bno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("modifyForm!!!!!!!");
		model.addAttribute("board", service.get(bno));
	}
	
	@PreAuthorize("principal.useranme == #board.writer") // 작성자와 로그인한 사람이 같은지 확인 
	@PostMapping("modify")
	public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr) {
		// 수정처리 
		if(service.modify(board)) {
			log.info("************ 수정성공!!!!!!!!!!!!! ************");
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@PreAuthorize("principal.useranme == #writer") // 작성자와 로그인한 사람이 같은지 확인 
	@PostMapping("delete")
	public String delete(Long bno, String writer, Criteria cri, RedirectAttributes rttr) {
		// 삭제 처리 
		if(service.delete(bno)) {
			log.info("*********** 삭제 성공!!!!!!! ************");
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list" + cri.getListLink();
	}
	
	// 글 등록 폼 
	@GetMapping("write")
	@PreAuthorize("isAuthenticated()") // 로그인한 사용자만 접근 가능하게 
	public void write() {
	}
	// 글 등록 처리 
	@PreAuthorize("isAuthenticated()") // 로그인한 사용자만 접근 가능하게 
	@PostMapping("write")
	public String writeBoard(BoardVO board, RedirectAttributes rttr) {
		log.info("write 처리 : " + board);
		
		service.register(board);
		// RedirectAttributes : Model처럼 스프링MVC가 자동으로 전달해주는 객체 
		// addFlashAttribute(key, value) : url뒤에 데이터가 붙지 않고, 
		//		일회성 데이터로 페이지를 새로고침하면 데이터 날라감.
		//		값 1개만 전달가능, 2개이상은 데이터가 소멸하므로 Map 이용해 한번에 보내야함.
		// addAttribute(key, value)
		// 위와 같은 메서드를 이용하여 리다이렉트되는 jsp 페이지에 데이터 전달할수 있다. 
		
		rttr.addFlashAttribute("result", board.getBno());
		// 등록처리후 글 고유번호 속성으로 추가해서 전달 (list에서 사용) 
		
		return "redirect:/board/list"; 
	}
	
	@GetMapping("map")
	public void map() {
		
	}
<<<<<<< HEAD
	
	@GetMapping("mapfocus")
	public void mapfocus() {
		 
	}
	
	
	
	@GetMapping("mapfocus2")
	public void mapfocus2() {
		//마커에 메모저장기능
		
		
	}
	
	@GetMapping("mapfocus3")
	public void mapfocus3() {
		
	}
	
	
	@GetMapping("mapfocusPro")
	public void mapfocusPro(LocationVO location, Model model)   {
		model.addAttribute("latitude", location.getLatitude());
		model.addAttribute("longitude", location.getLongitude());
	    service.location(location);
		log.info(location.toString());

	}
	
	@GetMapping("mapfocus4")
	public void mapfocus4(Model model) {
		
		log.info(service.locationList());
		model.addAttribute("list", service.locationList()); 
		
		
		 // List<LocationVO> list = service.locationList();
		 //return list;
	}
	
	@RequestMapping("mapfocus5")
	@ResponseBody
	public List<LocationVO> mapfocus5(){
		List<LocationVO> list = service.locationList();
		//난에이작스로줌...
		
		return list;
	}
	
	

	
	@GetMapping("map2")
	public void map2() {
		
	}
	
	@PostMapping
	public String map2pro(@RequestParam("name")String name ) {
		
		System.out.print(name);
		
	 	return "";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
