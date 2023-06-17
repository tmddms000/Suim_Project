package com.suim.event.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.common.model.vo.PageInfo;
import com.suim.event.model.dao.EventDao;
import com.suim.event.model.vo.Eattachment;
import com.suim.event.model.vo.Event;

@Service
public class EventServiceImpl implements EventService {

	@Autowired
	private EventDao eventDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int selectListCount() {
		return eventDao.selectListCount(sqlSession);
	}
	
	@Override
	public ArrayList<Event> selectList(PageInfo pi) {
		return eventDao.selectList(sqlSession, pi);
	}

	@Override
	public int increaseCount(int eno) {
		return eventDao.increaseCount(sqlSession, eno);
	}

	@Override
	public ArrayList<Eattachment> selectEventFile(int eno) {
		return eventDao.selectEventFile(sqlSession, eno);
	}

	// 게시판 조회
	@Override
	public Event selectBoard(int eventNo) {
		return eventDao.selectBoard(sqlSession, eventNo);
	}


	@Override
	public int selectCategoryListCount(String category) {
		return eventDao.selectCategoryListCount(sqlSession, category);
	}

	@Override
	public ArrayList<Event> selectCategoryList(PageInfo pi, String category) {
		return eventDao.selectCategoryList(sqlSession, pi, category);
	}


	
}
