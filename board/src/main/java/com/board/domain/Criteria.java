package com.board.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Criteria {

	private int pageNum; //페이지 번호
	private int listQty; // 한페이지에 보여줄 게시물 개수
	
	private String sel;  	//검색조건 t w c tw tc wc tcw
	private String keyword;	//검색 키워드
	
	
	public Criteria() {
		this(1, 10);   // 아무것도 안넘겨주면 1이고 10개씩 보여주겠다
		
	}
	
	public Criteria(int pageNum, int listQty) {
		
		this.pageNum = pageNum;
		this.listQty = listQty;
	}
	
	// 검색 조건을 배열로 만들어 한번에 처리하기 위한 메서드 추가
	public String[] getSelArr() {
		return sel == null ?  new String[] {} : sel.split("");
	}
	
	
	
	
	
	
	//url 링크에 붙이는 쿼리 스트링 자동 생성해주는 메서드
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("listQty", this.listQty)
				.queryParam("sel", this.sel)
				.queryParam("keyword", this.keyword)
				;
		
		return builder.toUriString();  // ?pageNum=1&listQty=10
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
