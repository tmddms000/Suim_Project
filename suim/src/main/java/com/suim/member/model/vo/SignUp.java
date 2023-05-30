package com.suim.member.model.vo;

import java.sql.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class SignUp {
	// 회원 가입을 위한 VO입니다

	@NotEmpty
	@Pattern(regexp= "^[a-zA-Z0-9]{6,15}$")
	private String memberId;

	@NotEmpty
	@Size(min = 8, max = 20, message = "8자 이상 20자 이하로 입력해주세요.")
	private String memberPwd;

	@NotEmpty
	private String memberName;
	
	private String nickName;

	@NotEmpty
	@Pattern(regexp = "[0-9]{3}[0-9]{4}[0-9]{4}", message = "유효한 전화번호 형식이 아닙니다.")
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
