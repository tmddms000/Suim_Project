package com.suim.house.model.service;

import java.util.ArrayList;

import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Region;

public interface ListHouseService {
	

	// 건물 정보조회 서비스
	ArrayList<House> selectList();
	
	// 지역 정보 조회 서비스
	ArrayList<Region> regionSelectList(String searchKeyword);

}
