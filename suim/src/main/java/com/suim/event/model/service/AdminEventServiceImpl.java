package com.suim.event.model.service;



import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.event.model.dao.AdminEventDao;

import com.suim.event.model.vo.Eattachment;
import com.suim.event.model.vo.Event;

@Service
public class AdminEventServiceImpl implements AdminEventService {

	
	
	@Autowired
	private AdminEventDao adminEventDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertEventBoard(Event e, Eattachment eAttach) {
		return adminEventDao.insertEventBoard(sqlSession, e, eAttach);
	}

	@Override
	public int insertEventFile(Eattachment eAttach) {
		return adminEventDao.insertEventFile(sqlSession, eAttach);
	}

	@Override
	public int updateEvent(Event e) {

		return adminEventDao.updateEventBoard(sqlSession, e);

	}

	
	
	@Override
	public int deleteEvent(int eno) {

		return adminEventDao.deleteEvent(sqlSession, eno);

	}

	@Override
	public int deleteEventFile(int eno) {
		
		return adminEventDao.deleteEventFile(sqlSession, eno);
	}

}
