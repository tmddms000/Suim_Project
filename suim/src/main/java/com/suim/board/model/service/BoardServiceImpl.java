package com.suim.board.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.board.model.dao.BoardDao;
import com.suim.board.model.vo.Battachment;
import com.suim.board.model.vo.Board;
import com.suim.board.model.vo.Reply;
import com.suim.common.model.vo.PageInfo;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;


	@Override
	public int selectListCount() {
		return boardDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<Board> selectList(PageInfo pi) {
		return boardDao.selectList(sqlSession, pi);
	}

	@Override
	public int insertBoard(Board b, Battachment ba) {
	    int result = 0;
	    SqlSessionTemplate sqlSession = null;

	    try {
	        sqlSession = getSqlSession();  // 메소드를 통해 SqlSessionTemplate을 가져옵니다.
	        sqlSession.getConnection().setAutoCommit(false);  // 트랜잭션 시작

	        result = sqlSession.insert("boardMapper.insertBoard", b);  // 첫 번째 쿼리 실행
	        result += sqlSession.insert("boardMapper.battachment", ba);  // 두 번째 쿼리 실행

	        sqlSession.getConnection().commit();  // 트랜잭션 커밋
	    } catch (Exception e) {
	        sqlSession.getConnection().rollback();  // 에러 발생 시 롤백
	        e.printStackTrace();
	    } finally {
	        if (sqlSession != null) {
	            sqlSession.getConnection().setAutoCommit(true);  // 자동 커밋 설정 복원
	            sqlSession.close();  // SqlSessionTemplate 종료
	        }
	    }

	    return result;
	}
	@Override
	public int insertBattachment(Battachment ba) {
		return boardDao.insertBattachment(sqlSession, ba);
	}

	@Override
	public ArrayList<Board> selectbList() {
		return boardDao.selectbList(sqlSession);
	}

	@Override
	public int increaseCount(int boardNo) {
		return boardDao.increaseCount(sqlSession, boardNo);
	}

	@Override
	public Board selectBoard(int boardNo) {
		return boardDao.selectBoard(sqlSession, boardNo);
	}

	@Override
	public int deleteBoard(int boardNo) {
		return boardDao.deleteBoard(sqlSession, boardNo);
	}

	@Override
	public ArrayList<Reply> selectReplyList(int boardNo) {
		return boardDao.selectReplyList(sqlSession, boardNo);
	}

	@Override
	public int insertReply(Reply r) {
		return boardDao.insertReply(sqlSession, r);
	}

	@Override
	public int ReplyCount(int boardNo) {
		return boardDao.ReplyCount(sqlSession, boardNo);
	}
	
	

}
