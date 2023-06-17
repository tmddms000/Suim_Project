package com.suim.member.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MyWish {

	private int houseNo;
	private String memberId;
	private String houseAddress;
	private String houseName;
	private String resGender;
	private int deposit;
	private int rent;
	private String changeName;
	private String houseWriter;
	
}
