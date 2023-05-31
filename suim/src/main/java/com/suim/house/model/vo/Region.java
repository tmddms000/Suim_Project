package com.suim.house.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Region {
	
	private int regionNo;// REGION_NO	NUMBER
	private String regionName; // REGION_NAME	VARCHAR2(300 BYTE)
	private double latitude; // LATITUDE	NUMBER
	private double longitude;// LONGITUDE	NUMBER

}

