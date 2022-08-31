package com.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.board.domain.ReplyVO;
import com.board.persistence.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyMapper mapper;
	
	@Override
	public int add(ReplyVO vo) {
		
		return mapper.add(vo);
	}

	@Override
	public ReplyVO getReply(long repno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int modifyReply(ReplyVO vo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(long repno) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<ReplyVO> getList(long bno) {
		
		return mapper.getList(bno);
	}

}
