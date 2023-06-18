package com.suim.house.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.suim.common.model.vo.PageInfo;
import com.suim.house.model.vo.House;
import com.suim.report.model.vo.Report;

public interface AdminHouseService {

	// 쉐어하우스 리스트 조회 서비스 (+ 페이징처리)
	// 쉐어하우스 총 갯수 조회
	int selectListCount();
	// 카테고리용 총 갯수 조회
	int selectListCount(String category);
	
	// 쉐어하우스 리스트 조회
	ArrayList<House> selectList(PageInfo pi);
	// 카테고리용 전체 조회
	ArrayList<House> selectList(PageInfo pi, String category);
	
	// 카테고리마다 전체 조회
	int selectCategoryListCount(String category);
	ArrayList<House> selectCategoryList(PageInfo pi, String category);
	
	// 쉐어하우스 작성하기 서비스
	int insertHouse(House h);
	
	// 쉐어하우스 상세조회 서비스
	// 쉐어하우스 조회수 증가
	// 필요 없어서 삭제
	
	// 쉐어하우스 상세 조회
	House selectHouse(int houseNo);
	
	// 쉐어하우스 삭제 서비스
	int deleteHouse(int houseNo);
	
	// 쉐어하우스 수정 서비스
	int updateHouse(House h);

	// 승인/반려 처리용
	int updateHouseStatus(House h);
	// 전체 선택 승인/반려용
	int updateStatusAll(int[] intArray, String houseStatus);
	
	// 검색용
	int selectSearchCount(HashMap<String, String> map);
	
	ArrayList<House> selectSearchList(HashMap<String, String> map, PageInfo pi);
	
	String selectEmail(String Id);
}
