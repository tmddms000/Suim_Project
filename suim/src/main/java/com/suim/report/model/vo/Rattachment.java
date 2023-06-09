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
public class Rattachment {

	private int ratNo;
	private String originName;
	private String changeName;
	private Date createDate;
	private String fileStatus;
	private int reportNo;


}
