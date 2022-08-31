package com.board.domain;



import java.sql.Timestamp;

import lombok.Data;


@Data
public class ReplyVO {
	private long repno;
	private long bno;
	private String reply;
	private String replyer;
	private Timestamp reg;

}
