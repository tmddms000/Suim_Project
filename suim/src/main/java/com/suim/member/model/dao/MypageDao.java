package com.suim.member.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.board.model.vo.Board;
import com.suim.common.model.vo.PageInfo;

@Repository
public class MypageDao {

	public int selectBoardListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("mypageMapper.selectBoardListCount");
	}

	public ArrayList<Board> selectBoardList(SqlSessionTemplate sqlSession, PageInfo pi, String memberId) {

		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수

		RowBounds rowBounds = new RowBounds(offset, limit);

		return (ArrayList) sqlSession.selectList("mypageMapper.selectBoardList", memberId, rowBounds);
	}

	public int selectFindListCount(SqlSessionTemplate sqlSession) {

		return sqlSession.selectOne("mypageMapper.selectFindListCount");
	}

	public ArrayList<Board> selectFindList(SqlSessionTemplate sqlSession, PageInfo pi, String memberId) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("mypageMapper.selectFindList", memberId, rowBounds);
	}

}
