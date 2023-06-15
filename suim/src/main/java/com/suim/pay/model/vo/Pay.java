package com.suim.pay.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Pay {
	

	
	private int paymentNo;
	private String tid;
	private String price;
	private Date paymentDate;
	private String paymentStatus;
	private int houseNo;
	private String pgToken;
	
	private String memberId;
	private String houseName;
	private int deposit;

}
