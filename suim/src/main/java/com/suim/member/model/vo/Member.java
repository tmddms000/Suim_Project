package com.suim.member.model.vo;


import java.io.Serializable;
import java.sql.Timestamp;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class Member {
	//회원의 정보를 받아오기 위한 VO 입니다

	/**
	 * 
	 */
	private String memberId;
	private String memberPwd;
	private String memberName;
	private String nickName;
	private String phone;
	private String email;
	private String gender;
	private String area;
	private String birth;
	private Timestamp enrollDate;
	private Timestamp modifyDate;
	private Timestamp loginDate;
	private String changeName;

	private int memberPoint;
	private String status;
	private String blacklistFlag;
	
	private String memberComment;
	private String naverLogin;
	private String googleLogin;
	
	private double latitude;
	private double longitude;
	
	private int adminAuth;
	private int setAlarm;
}
