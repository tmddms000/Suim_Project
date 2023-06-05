package com.suim.member.model.vo;

import lombok.Data;

import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Email {

	private int mailAuth;
	private String mailKey;
	private String email;
	
	
	public Email(String mailKey, String email) {
		super();
		this.mailKey = mailKey;
		this.email = email;
	}
	
	
}
