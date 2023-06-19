package com.suim.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.suim.board.model.vo.Board;
import com.suim.board.model.vo.Find;
import com.suim.common.model.vo.PageInfo;
import com.suim.house.model.vo.Reservation;

@Repository
public class AdminReservationDao {
	
	// 예약 내용 리스트
	public int adminRezCount(SqlSession sqlSession) {
		return sqlSession.selectOne("adminReservationMapper.adminRezCount");
	}
	
	public ArrayList<Reservation> adminRezList(SqlSession sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수

		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminReservationMapper.adminRezList", null , rowBounds);
	}
	
	// 예약 상세페이지
	public Reservation adminRezDetail(SqlSession sqlSession, int rno) {
		return sqlSession.selectOne("adminReservationMapper.adminRezDetail", rno);
	}
	
	// 예약 수정
	public int adminRezUpdate(SqlSession sqlSession ,HashMap<String, Object> map) {
		return sqlSession.update("adminReservationMapper.adminRezUpdate", map);
	}
	
	// 예약 조건 검색
	public int adminRezDeSearchCount(SqlSession sqlSession, HashMap<String, Object> map) {
		return sqlSession.selectOne("adminReservationMapper.adminRezDeSearchCount", map);
	}
	
	public ArrayList<Reservation> adminRezDeSearch(SqlSession sqlSession, HashMap<String, Object> map, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수

		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminReservationMapper.adminRezDeSearch", map, rowBounds);
	}
	
	// 키워드 검색
	public int adminRezKeySearchCount(SqlSession sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("adminReservationMapper.adminRezKeySearchCount", map);
	}
	
	public ArrayList<Reservation> adminRezKeySearch(SqlSession sqlSession, HashMap<String, String> map, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수

		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminReservationMapper.adminRezKeySearch", map, rowBounds);
	}
	
	// 삭제 복구
	
	public int deleteRezBoard(SqlSession sqlSession, int rno) {
		return sqlSession.update("adminReservationMapper.deleteRezBoard", rno);
	}
	
	public int deleteRezCanBoard(SqlSession sqlSession, int rno) {
		return sqlSession.update("adminReservationMapper.deleteRezCanBoard", rno);
	}
	
	
}
