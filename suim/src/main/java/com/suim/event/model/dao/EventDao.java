package com.suim.event.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.common.model.vo.PageInfo;
import com.suim.event.model.vo.Eattachment;
import com.suim.event.model.vo.Event;

@Repository
public class EventDao {
	
	public int selectListCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("eventMapper.selectListCount");
				// 완성된 쿼리문이므로 두번째 변수 필요없음
	}
	
	public ArrayList<Event> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
			
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); 

		int limit = pi.getBoardLimit(); // limit ; 조회할 갯수
		
		RowBounds rowBounds = new RowBounds(offset, limit); // 빈에 등록이 되어있지 않기 때문에 직접 생성해야 함
		
		return (ArrayList)sqlSession.selectList("eventMapper.selectList", null, rowBounds);
		
	}
	
	public int increaseCount(SqlSessionTemplate sqlSession, int eno) {
		System.out.println("dao 에서의 eno 는 " + eno);
		return sqlSession.update("eventMapper.increaseCount", eno);
	}
	
	public ArrayList<Eattachment> selectEventFile(SqlSessionTemplate sqlSession, int eatNo) {
		return (ArrayList) sqlSession.selectList("eventMapper.selectEventFile", eatNo);
	}
	
	public Event selectBoard(SqlSessionTemplate sqlSession, int eventNo) {
		return sqlSession.selectOne("eventMapper.selectBoard", eventNo);
	}

	public int selectCategoryListCount(SqlSessionTemplate sqlSession, String category) {
		return sqlSession.selectOne("eventMapper.selectCategoryListCount", category);
	}
	
	public ArrayList<Event> selectCategoryList(SqlSessionTemplate sqlSession, PageInfo pi, String category) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); 

		int limit = pi.getBoardLimit(); // limit ; 조회할 갯수
		
		RowBounds rowBounds = new RowBounds(offset, limit); // 빈에 등록이 되어있지 않기 때문에 직접 생성해야 함
		
		return (ArrayList)sqlSession.selectList("eventMapper.selectCategoryList", category, rowBounds);
	}

}
