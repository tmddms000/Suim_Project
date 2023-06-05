package com.suim.notice.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Nattachment {
	private int natNo;	// NUMBER	NOT NULL,
	private String originName;	// VARCHAR2(300)		NOT NULL,
	private String changeName;	// VARCHAR2(300)		NOT NULL,
	private String createDate;	// DATE	DEFAULT SYSDATE	NOT NULL,
	private String fileStatus;	// CHAR(1)	DEFAULT 'Y'	NOT NULL,
	private int noticeNo;	// NUMBER	NOT NULL, FOREIGN KEY (NOTICE_NO) REFERENCES NOTICE(NOTICE_NO) ON DELETE CASCADE
}
