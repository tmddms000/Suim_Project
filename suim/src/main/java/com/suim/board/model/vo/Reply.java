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
public class Reply {
	
//	BRE_NO	NUMBER
//	BRE_COTENT	VARCHAR2(300 BYTE)
//	BRE_DATE	DATE
//	STATUS	CHAR(1 BYTE)
//	BOARD_NO	NUMBER
	
	private int breNo;
    private String breContent;
    private Date breDate;
    private String status;
    private int boardNo;
    private String breId;
    private String memberId;
    private String nickName;

}
