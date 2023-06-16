package com.suim.event.model.vo;

import java.util.Date;

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
public class Event {
	private int eventNo; //	EVENT_NO	NUMBER
	private String eventTitle; //	EVENT_TITLE	VARCHAR2(300 BYTE)
	private String eventCategory;// EVENT_CATEGORY VARCHAR2(100)
	private String eventContent; //	EVENT_CONTENT	VARCHAR2(3000 BYTE)
	private Date eventDate; //	EVENT_DATE	DATE
	private int eventView; //	EVENT_VIEW	NUMBER
	private String eventStatus; //	EVENT_STATUS	CHAR(1 BYTE)
}
