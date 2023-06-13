package com.suim.house.model.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Region;
import com.suim.house.model.vo.Reservation;
import com.suim.house.model.vo.Wish;

public interface ListHouseService {
	

	// 지도와 셰어하우스 리스트 상세 검색 서비스
	ArrayList<House> selectList(String minValue,
		      String maxValue,
			  String[] genderDivisions,
			  String[] houseType,
			  String[] maxResident,
			  String[] floor,
		      Date openDate);
	
	// 지역 정보 조회 서비스
	ArrayList<Region> regionSelectList(String searchKeyword);
	
	// 예약 정보 입력 서비스
	int rezInsert(Map<String, Object> reservation);
	
	// 셰어하우스 별 예약 신청 리스트
	ArrayList<Reservation> myHouseRezSelect(int houseNo);
	
	// 셰어하우스 예약 확인
	int confirmRez(int rno);
	
}
