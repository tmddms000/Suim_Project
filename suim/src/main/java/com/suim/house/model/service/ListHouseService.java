package com.suim.house.model.service;

import java.util.ArrayList;
import java.util.Date;

import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Region;

public interface ListHouseService {
	

	// 건물 정보조회 서비스
	ArrayList<House> selectList(String minValue,
		      String maxValue,
			  String[] genderDivisions,
			  String[] houseType,
			  String[] maxResident,
			  String[] floor,
		      Date openDate);
	
	// 지역 정보 조회 서비스
	ArrayList<Region> regionSelectList(String searchKeyword);
}
