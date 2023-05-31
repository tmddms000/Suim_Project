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
public class Battachment {
	
	//	BAT_NO	NUMBER
	//	ORIGIN_NAME	VARCHAR2(300 BYTE)
	//	CHANGE_NAME	VARCHAR2(300 BYTE)
	//	CREATE_DATE	DATE
	//	FILE_STATUS	CHAR(1 BYTE)
	//	BOARD_NO	NUMBER

	private int batNo;
	private String originName;
	private String changeName;
	private Date createDate;
	private String fileStatus;
	private int boardNo;


}
