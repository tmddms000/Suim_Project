package com.suim.house.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.common.model.vo.PageInfo;
import com.suim.house.model.dao.AdminHouseDao;
import com.suim.house.model.vo.House;
import com.suim.report.model.vo.Report;

@Service
public class AdminHouseServiceImpl implements AdminHouseService {

	@Autowired
	private AdminHouseDao adminHouseDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	// 신고 총 갯수 조회
	@Override
	public int selectListCount() {
		return adminHouseDao.selectListCount(sqlSession);
	}

	// 카테고리용 총 갯수 조회
	@Override
	public int selectListCount(String category) {
		return adminHouseDao.selectListCount(sqlSession, category);
	}
	
	// 전체 조회용
	@Override
	public ArrayList<House> selectList(PageInfo pi) {
		return adminHouseDao.selectList(sqlSession, pi);
	}
	
	// 카테고리용 전체 조회
	@Override
	public ArrayList<House> selectList(PageInfo pi, String category) {
		return adminHouseDao.selectList(sqlSession, pi, category);
	}

	// 카테고리마다 전체 조회
	@Override
	public int selectCategoryListCount(String category) {
		return adminHouseDao.selectCategoryListCount(sqlSession, category);
	}
	@Override
	public ArrayList<House> selectCategoryList(PageInfo pi, String category) {
		return adminHouseDao.selectCategoryList(sqlSession, pi, category);
	}
	
	@Override
	public int insertHouse(House h) {
		return adminHouseDao.insertHouse(sqlSession, h);
	}

	@Override
	public House selectHouse(int houseNo) {
		return adminHouseDao.selectHouse(sqlSession, houseNo);
	}

	@Override
	public int deleteHouse(int houseNo) {
		return adminHouseDao.deleteHouse(sqlSession, houseNo);
	}

	@Override
	public int updateHouse(House h) {
		return adminHouseDao.updateHouse(sqlSession, h);
	}
	
	// 승인/반려 처리용
	@Override
	public int updateHouseStatus(House h) {
		return adminHouseDao.updateHouseStatus(sqlSession, h);
	}
	// 전체선택 승인/반려용
	@Override
	public int updateStatusAll(int[] intArray, String houseStatus) {
		return adminHouseDao.updateStatusAll(sqlSession, intArray, houseStatus);
	}
	
	// 검색용
	@Override
	public int selectSearchCount(HashMap<String, String> map) {
		return adminHouseDao.selectSearchCount(sqlSession, map);
	}
	@Override
	public ArrayList<House> selectSearchList(HashMap<String, String> map, PageInfo pi) {
		return adminHouseDao.selectSearchList(sqlSession, map, pi);
	}

	@Override
	public String selectEmail(String Id) {
		// TODO Auto-generated method stub
		return adminHouseDao.selectEmail(sqlSession, Id);
	}
}
