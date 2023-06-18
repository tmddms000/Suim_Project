package com.suim.event.model.dao;

import java.util.ArrayList;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.event.model.vo.Eattachment;
import com.suim.event.model.vo.Event;

@Repository
public class AdminEventDao {

	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminEventMapper.selectListCount");
	}
	
	public int insertEventBoard(SqlSessionTemplate sqlSession, Event e, Eattachment eAttach) {
		return sqlSession.insert("adminEventMapper.insertEventBoard", e);
	
	}
	
	public int insertEventFile(SqlSessionTemplate sqlSession, Eattachment eAttach) {
		System.out.println(eAttach + "입니다.");
		return sqlSession.insert("adminEventMapper.insertEventFile", eAttach);
	}
	
	public int updateEventBoard(SqlSessionTemplate sqlSession, Event e) {
		return sqlSession.update("adminEventMapper.updateEventBoard", e);
	}
	
	public Eattachment selectEventFile(SqlSessionTemplate sqlSession, int eAttach) {
		return (Eattachment) sqlSession.selectList("adminEventMapper.selectEventFile", eAttach);
	}
	
	public int deleteEvent(SqlSessionTemplate sqlSession, int eno) {
		return sqlSession.update("adminEventMapper.deleteEvent", eno);
	}
	
	public int deleteEventFile(SqlSessionTemplate sqlSession, int eno) {
		return sqlSession.update("adminEventMapper.deleteEventFile", eno);
	}

	

}
