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
public class findReply {


	
	private int freNo;
    private String freContent;
    private Date freDate;
    private String status;
    private int findNo;
    private String freId;
    private String memberId;
    private String nickName;

}
	


