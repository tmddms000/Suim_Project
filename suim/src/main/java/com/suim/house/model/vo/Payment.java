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
public class Payment {
	private int paymentNo;
	private int tid;
	private int price;
	private Date paymentDate;
	private String paymentStatus;
}
