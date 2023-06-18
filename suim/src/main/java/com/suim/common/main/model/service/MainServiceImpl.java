package com.suim.common.main.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.board.model.vo.Find;
import com.suim.board.model.vo.InReview;
import com.suim.common.main.model.dao.MainDao;
import com.suim.house.model.vo.House;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	private MainDao mainDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ArrayList<House> selectHouseList() {
		return mainDao.selectHouseList(sqlSession);
		
	}

	@Override
	public Map<String, Object> selectCountList() {
		return mainDao.selectCountList(sqlSession);
	}

	@Override
	public ArrayList<Find> selectfList() {
		return mainDao.selectfList(sqlSession);
	}

	@Override
	public ArrayList<InReview> selectiList() {
		return mainDao.selectiList(sqlSession);
	}

}
