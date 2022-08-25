package com.board.persistence;

import java.util.List;

import com.board.domain.BoardVO;
import com.board.domain.Criteria;

public interface BoardMapper {

	//전체 레코드 검색
	public List<BoardVO> getList();
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	//글 저장 C: create
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	//글 읽기 R : READ
	public BoardVO read(long bno);
	//글 삭제 d :delete
	public int delete(long bno);
	//글 수정 u: update
	public int update(BoardVO board);
	
	//글개수 조회하기 
	public int getTotalCount(Criteria cri);
	
	
	
}
