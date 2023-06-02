package com.suim.house.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class Photo {
	
	private int photoNo;// PHOTO_NO	NUMBER
	private String originName; // ORIGIN_NAME	VARCHAR2(300 BYTE)
	private String changeName;// CHANGE_NAME	VARCHAR2(300 BYTE)
	private Date createDate;// CREATE_DATE	DATE
	private String fileLevel;// FILE_LEVEL	CHAR(1 BYTE)
	private String fileStatus;// FILE_STATUS	CHAR(1 BYTE)
	private int houseNo;// HOUSE_NO	NUMBER

}
