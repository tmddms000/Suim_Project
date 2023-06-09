package com.suim.board.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@NoArgsConstructor
@Setter
@Getter
@ToString
public class InReviewReply {
	

	
	private int ireNo;
	private String ireContent;
	private Date ireDate;
	private String status;
	private int inrNo;
	private String ireId;
    private String memberId;
    private String nickName;
}
