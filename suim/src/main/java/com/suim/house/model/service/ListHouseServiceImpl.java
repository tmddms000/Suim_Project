package com.suim.house.model.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.house.model.dao.ListHouseDao;
import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Region;
import com.suim.house.model.vo.Reservation;
import com.suim.house.model.vo.Wish;

@Service
public class ListHouseServiceImpl implements ListHouseService{

	@Autowired
	private ListHouseDao listHouseDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<House> selectList(String minValue, String maxValue, String[] genderDivisions,
										String[] houseType, String[] maxResident,  String[] floor, Date openDate) {
		return listHouseDao.selectList(sqlSession, minValue,maxValue,genderDivisions,houseType,maxResident,floor,openDate);
	}

	@Override
	public ArrayList<Region> regionSelectList(String searchKeyword) {
		return listHouseDao.regionSelectList(sqlSession, searchKeyword);
	}

	@Override
	public int rezInsert(Map<String, Object> reservation) {
		return listHouseDao.rezInsert(sqlSession, reservation);
	}

	@Override
	public ArrayList<Reservation> myHouseRezSelect(int houseNo) {
		return listHouseDao.myHouseRezSelect(sqlSession, houseNo);
	}

	@Override
	public int confirmRez(int rno) {
		return listHouseDao.confirmRez(sqlSession, rno);
	}
	



	

	


	
	

}
