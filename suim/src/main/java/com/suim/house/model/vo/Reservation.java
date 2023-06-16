package com.suim.house.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Getter
@Setter
@ToString
public class Reservation {
	
	private int rezNo;
	private Date rezDate;
	private String rezHour;
	private String sendMemberId;
	private String recMemberId;
	private String rezStatus;
	private Date rezRequestDate;
	private String cancelContent;
	private String delStatus;
	private int houseNo;
	
	// 하우스 테이블에서 불러올 구문
    private String houseName; // Photo테이블의 changeName
    private String nickName;

}
