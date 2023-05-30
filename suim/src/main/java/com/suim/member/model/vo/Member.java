package com.suim.member.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Member {
	//회원의 정보를 받아오기 위한 VO 입니다

	private String memberId;
	private String memberPwd;
	private String memberName;
	private String nickName;
	private String phone;
	private String email;
	private String gender;
	private String area;
	private String birth;
	private Date enrollDate;
	private Date modifyDate;
	private Date loginDate;
	private String changeName;
	private String status;
}
