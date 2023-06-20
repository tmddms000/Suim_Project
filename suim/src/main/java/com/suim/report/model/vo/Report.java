package com.suim.report.model.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Report {

	private int reportNo;
	private String reportTitle;
	private String reportContent;
	private String reportType;
	private String reportId;
	private Date reportDate;
	private String reportStatus;
	
	private String memberId;
	private int typeNo;
	
	private String thumbnail;
	
	private int isDuplicate;
}
