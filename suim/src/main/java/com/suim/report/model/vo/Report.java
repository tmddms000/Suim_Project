package com.suim.report.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@Setter
@Getter
@ToString
public class Report {

	private int reportNo;
	private String reportTitle;
	private String reportContent;
	private String reportType;
	private String reportId;
	private Date reportDate;
	private String reportStatus;
}
