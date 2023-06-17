package com.suim.member.model.vo;

import java.sql.Timestamp;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class GoogleSignUp {
	
	public GoogleSignUp(String memberId, String memberName, String nickName, String email, String changeName, String googleLogin) {
		super();
		this.memberId = memberId;
		this.memberName = memberName;
		this.nickName = nickName;
		this.email = email;
		this.changeName = changeName;
		this.googleLogin = googleLogin;
	}
	private String memberId;

	@NotBlank(message = "비밀번호를 공백으로 할 수 없습니다.")
	@Pattern(regexp = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$", message = "8글자 이상 20글자 이하 영대소문자,숫자,특수문자를 반드시 포함해야합니다.")
	private String memberPwd;

	@NotBlank(message = "비밀번호 확인을 공백으로 할 수 없습니다.")
	@Pattern(regexp = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$", message = "비밀번호 확인은 위 비밀번호와 일치해야합니다.")
	private String pwdConfirm;

	private String memberName;

	// 랜덤 닉네임 지정
	private String nickName;

	@NotEmpty(message = "번호를 공백으로 할 수 없습니다.")
	@Pattern(regexp = "[0-9]{3}[0-9]{4}[0-9]{4}", message = "유효하지 않는 번호 형식입니다.")
	private String phone;

	private String email;

	@NotBlank(message = "성별을 공백으로 할 수 없습니다.")
	@Pattern(regexp = "^[FM]$", message = "유효하지 않은 성별입니다.")
	private String gender;

	private String area;

	@NotBlank(message = "생일을 공백으로 할 수 없습니다.")
	private String birth;

	private Timestamp enrollDate;
	private Timestamp modifyDate;
	private Timestamp loginDate;
	private String changeName;
	private int memberPoint;
	private String status;
	private String googleLogin;
	private double latitude;
	private double longitude;
}
