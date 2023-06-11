package com.suim.admin.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class AdminMain {

	private int male;
	private int female;
	
	private String enrollDate;
	
	private int reportCount_m;
	private int reportCount_h;
	private int reportCount_b;
	private int reportCount_br;
	private int reportCount_f;
	private int reportCount_fr;
	private int reportCount_c;
	
	private int boardCount;
}
