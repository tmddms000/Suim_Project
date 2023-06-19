package com.suim.house.model.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.suim.common.model.vo.PageInfo;
import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Region;
import com.suim.house.model.vo.Reservation;

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
	
	// 셰어하우스 별 예약 신청 리스트 갯수
	int selectHouseRezListCount(int houseNo);
	
	// 셰어하우스 별 예약 신청 리스트
	ArrayList<Reservation> selectHouseRezList(PageInfo pi, int houseNo);
	
	// 예약 취소를 위한 셰어하우스 정보 select
	ArrayList<Reservation> selectRezOne(int rezNo);

	// 셰어하우스 예약 확인
	int confirmRez(int rno);
	
	// 셰어하우스 예약 취소
	int rezCancel(Map<String, Object> rezCancel);
	
	// 멤버의 이메일 확인
	String memberEmail(String memberId);

	// 로그인 유저의 셰어하우스 예약정보 체크
	int rezChCount(Map<String, Object> rezCheck);
	
	// 로그인 유저의 예약 번호 받아오기
	int loginRno(Map<String, Object> rezCheck);
	
	// 중심좌표 셰어하우스 이름 키워드 검색
	ArrayList<House> keyCenterAd(String searchKeyword);
	
}
