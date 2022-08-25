package com.board.controller;

import java.io.File;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.support.RequestPartServletServerHttpRequest;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/upload/*")
@Log4j
public class UploadController {
	
		@GetMapping("uploadForm")
		public void upload() {
			log.info("***** upload  *****");
		}
		
		@PostMapping("uploadPro")
		public void uploadPro(String msg, MultipartHttpServletRequest request) {	//msg(text) ,img(file) 
			log.info("***************uploadPro***************");
			log.info("**msg**"+msg);
			log.info("**파일의 타입**: "+request.getContentType());
			log.info("**파일정보 꺼내기**"+request.getFile("img"));
			
			
			try {
			//전송한 파일 정보 꺼내기
			MultipartFile mf = request.getFile("img");
			log.info("****"+mf.getOriginalFilename());
			log.info("****"+mf.getSize());
			log.info("****"+mf.getContentType());
			
			//파일 저장 경로 구하기
			String path=request.getRealPath("/resources/save"); //서버상 save 폴더 위치
			log.info("*********** save path: " +path);
			
			//새 파일명 생성
			//범용공유 식별자 이름이- 중복되면 안되는 것을 스스로 랜덤으로 붙혀줌
			String uuid = UUID.randomUUID().toString().replace("-","").toUpperCase();
			log.info("*****************uuid :"+uuid);
			
			//업로드한 파일 확장자만 가져오기
			String orgName = mf.getOriginalFilename();
			
			//beach.jpg  ---> .의 인덱스번호를 돌려줌 --> 서브스트링이 점부터 잘라준다.
			String ext = orgName.substring(orgName.lastIndexOf("."));
			log.info("*****************ext :"+ext);
			//저장할 파일명
			String newFileName = uuid +ext;
			log.info("*****************newFileName :"+newFileName);
			
			//저잘할 파일 전체 경로
			String imgPath= path+ "\\" + newFileName;
			log.info("*****************imgPath :"+imgPath);
			
			//파일 저장
			
			File copyfile = new File(imgPath);
			mf.transferTo(copyfile);
			
			}catch (Exception e) {
				e.printStackTrace();
			}
			
			//파일업로드 끝
			
		}
		
		// *********** 다운로드들 ***********
		
		// 다운로드 버튼 띄운 하면 
		@GetMapping("helloDown")
		public void helloDown() {
			
		}
		
		//다운 요청 처리
		@GetMapping("download")
		public ModelAndView down(int fileNum) {
			// 다운시킬 파일
			File f = new File("E:\\leeminhyoung\\something\\5ri.jpg");
			if(fileNum ==1) {
				f= new File("E:\\leeminhyoung\\something\\52.jpg");
			}
			
			
			//생성자 매개변수
			//String viewName		:view 이름 -> xml 지정한 DownloadView 빈의 id값 ->  jsp페이지가 아니라 자바클래스를 줌fileDown
			//String modelName		: 파라미터명 지정 (이름)
			//Object modelObject	: 데이터 (다운시킬 파일)
			ModelAndView mv = new ModelAndView("fileDown","downloadFile", f);
			return mv;
		}
		
		
		
		
		
		
		
		
		
		
		
}
