package com.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.board.domain.Bank;
import com.board.domain.BoardVO;
import com.board.domain.SampleVO;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/sample/*")
@Log4j
public class SampleController {
	//단순 문자열 리턴
	//하나만적으면 당연히 밸류라고 인식하는데 ,를 적으면 밸류인지 모름, 적어줘야함
	//PRODUCES => 인코딩... 헤더정보를 추가해주는 것! , 서버에서 생산하여 부라우저에 리턴해주는 데이터의 형태를 지정(서버 ->브)
	//					브라우저에서 요청 시 지정한 accept 요청 헤더값과 일치
	//consumes: 브라우저에서 요청시 지정한 Content-Type 과 일치하게 작성. (브 -> 서버)
		
	@GetMapping(value="getText", produces="text/plain;charset=UTF-8")
	public String getText() {
		log.info("**************텍스트");
		log.info("**************"+ MediaType.TEXT_PLAIN_VALUE);
		
		//기존의 @Controller는 문자열로 리턴하는 경우 jsp 파일 이름으로 처리하지만 
		//@RestController의 경우에는 순수한 데이터가 리턴된다.
		//produces="text/plain;charset=UTF-8" 속성은 해당 메서드가 생산하는 MINE 타입을 의미한다.
		//위와 같이 문자열로 직접 지정할 수도 있고, MediaType.으로 클래스를 이용하여 지정할 수도 있다.
		
		return "hello rest";
	}
	
	//객체 리턴
	@GetMapping(value="getVO", produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
	public SampleVO getVO() {
		
		log.info("*************get VO***********");
		return new SampleVO(11,"user","home");
	}
	
	//컬렉션 타입 리턴
	
	@GetMapping("getList")
	public List<SampleVO> getList(){
		List<SampleVO> list = new ArrayList<SampleVO>();
		for(int i=0; i< 10; i++) {
			list.add(new SampleVO(i, "Name-"+i, "Addr-"+i));
			
		}
		return list;
	}
	
	//컬렉션 타입 리턴 :map
	@GetMapping("getMap")
	public Map<String, SampleVO> getMap(){
		Map<String, SampleVO> map = new HashMap<String, SampleVO>();
		map.put("one", new SampleVO(111, "그루트","지구"));
		
		return map;
		
	}
	
	//responseEntity 타입 리턴
	//영어와 수학점수를 요청 파라미터로 받아서, 60점 미만이면 상태코드를 달리 전송?
	@GetMapping(value="gradeCheck" , params= {"english","math" }) 
		//파라미터가 와야하고 오지 않으면  500 에러 -> 400에러 처리방식이 다름.  
		//없으면 연산처리하다가 문법 500 에러
		//있으면 연산처리 없이 잘못요청한것이다 하고 400에러
	public ResponseEntity<SampleVO> gradeCheck(int english, int math) {
		//전송해줄 데이터 타입 한개
		//여거개 보내주고 싶으면 리스트타입안에 샘플VO넣자..
		SampleVO vo = new SampleVO(0, english+"", math+"");
		ResponseEntity<SampleVO> result = null;
		if( english < 60 || math <60) {
			//상태코드502 추가, 몸체에 데이터추가
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
			
		}else {
			//상태코드 200 추가, 몸체에 데이터 추가
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
			
		}
		//NetWork-Status
		//나중에 상태코드를 사용할 수 있음... 코드가 몇번이면 어떻게 해야한다 등 상태코드 예외처리 가능.
		//상태코드는 뷰에서 응답했을때 사용가능. (브라우저에서 체크하는 용도)
		
		
		return result;
		
	}
	
	//2)파라미터
	
	//@PathVariable 사용 - 주소에 있는 값을 꺼내고 싶을때 사용가능
	@GetMapping("/news/{cat}/{nid}")
	//@GetMapping("/read/{bno}")  //board/read/30   -->주소자체가 달라짐 물음표 안씀!(쓸수는 있지만;;)
	public String[] getPathVar(@PathVariable("cat") String cat,@PathVariable("nid") Integer nid) {
		//@PathVariable() 중괄호 안에 있는 이름을 괄호안에 넣어서 명시하기
		//주소에 있는 값들은 변수로 넣어줘야하는 작업
		log.info("***************"+cat );
		log.info("***************"+nid );
		
		return new String [] {"categor: "+cat, "news Id: "+nid};// 문자열 두개 배열로 만들어 리턴
	}
	
	
	//@RequsetBody : 요청시 데이터를 json으로 보내고 , 여기서버에서는 Bank 자바 객체로 변환해 받기
	@PostMapping(value="bank", consumes="application/json"
			, produces = {MediaType.TEXT_PLAIN_VALUE}) 
	//받는쪽에서 application/json으로 받겠다는 것!
	public Bank convertBank(@RequestBody Bank bank) {
		
		log.info("conber to Bank obj:" +bank);
		
		
		return bank;
	}
	
	
}
		