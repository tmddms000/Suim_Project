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
public class InReview {
	
	private int inrNo;

	private String inrTitle;
	private String inrContent;

	private int inrView;
	private Date inrDate;
	private String status;
	private String memberId;
    private String nickName;
    private int replyCount;
    
    // 첨부파일 필드
	private String originName;
	private String changeName;
	private String thumbnail;

}
