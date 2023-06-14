package com.suim.event.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;



@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Eattachment {
	private int eatNo; //	EAT_NO	NUMBER
	private String originName; //	ORIGIN_NAME	VARCHAR2(300 BYTE)
	private String changeName; //	CHANGE_NAME	VARCHAR2(300 BYTE)
	private Date createDate; //	CREATE_DATE	DATE
	private String fileStatus; //	FILE_STATUS	CHAR(1 BYTE)
	private int eventNo; //	EVENT_NO	NUMBER
}
