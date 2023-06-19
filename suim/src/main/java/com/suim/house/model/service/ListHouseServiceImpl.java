package com.suim.house.model.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.common.model.vo.PageInfo;
import com.suim.house.model.dao.ListHouseDao;
import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Region;
import com.suim.house.model.vo.Reservation;

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
	public int selectHouseRezListCount(int houseNo) {
		return listHouseDao.selectHouseRezListCount(sqlSession, houseNo);
	}
	
	@Override
	public ArrayList<Reservation> selectHouseRezList(PageInfo pi, int houseNo) {
		return listHouseDao.selectHouseRezList(sqlSession, pi, houseNo);
	}
	@Override
	public ArrayList<Reservation> selectRezOne(int rezNo) {
		return listHouseDao.selectRezOne(sqlSession, rezNo);
	}
	@Override
	public int confirmRez(int rno) {
		return listHouseDao.confirmRez(sqlSession, rno);
	}

	@Override
	public int rezCancel(Map<String, Object> rezCancel) {
		return listHouseDao.rezCancel(sqlSession, rezCancel);
	}

	@Override
	public String memberEmail(String memberId) {
		return listHouseDao.memberEmail(sqlSession, memberId);
	}

	
	@Override
	public int rezChCount(Map<String, Object> rezCheck) {
		return listHouseDao.rezChCount(sqlSession, rezCheck);
	}

	@Override
	public int loginRno(Map<String, Object> rezCheck) {
		return listHouseDao.loginRno(sqlSession, rezCheck);
	}

	@Override
	public ArrayList<House> keyCenterAd(String searchKeyword) {
		return listHouseDao.keyCenterAd(sqlSession, searchKeyword);
	}

}
