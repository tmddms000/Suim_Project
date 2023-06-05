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

//	fre_NO	NUMBER
//	fre_COTENT	VARCHAR2(300 BYTE)
//	fre_DATE	DATE
//	STATUS	CHAR(1 BYTE)
//	BOARD_NO	NUMBER
	
	private int freNo;
    private String freContent;
    private Date freDate;
    private String status;
    private int findNo;
    private String freId;
    private String memberId;
    private String nickName;

}
	


