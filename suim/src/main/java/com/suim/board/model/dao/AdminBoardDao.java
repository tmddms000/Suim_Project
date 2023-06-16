package com.suim.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.suim.board.model.vo.Board;
import com.suim.board.model.vo.Find;
import com.suim.board.model.vo.InReview;
import com.suim.common.model.vo.PageInfo;

@Repository
public class AdminBoardDao {

	// 자유게시판 관리자페이지 Dao(Repository)
	
	public int adminBoardCountA(SqlSession sqlSession) {
		return sqlSession.selectOne("adminBoardMapper.selectBoardCountA");
	}
	
	public ArrayList<Board> adminBoardListA(SqlSession sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수

		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminBoardMapper.selectBoardListA", null , rowBounds);
	}
	
	
	public int adminBoardCount(SqlSession sqlSession, String category) {
		return sqlSession.selectOne("adminBoardMapper.selectBoardCount", category);
	}
	
	public ArrayList<Board> adminBoardList(SqlSession sqlSession, PageInfo pi, String category) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수

		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminBoardMapper.selectBoardList", category, rowBounds);
	}
	
	public Board adminDetailBoard(SqlSession sqlSession, int boardNo) {
		return sqlSession.selectOne("adminBoardMapper.adminDetailBoard", boardNo);
	}
	
	public int deleteBoard(SqlSession sqlSession, int bno) {
		return sqlSession.update("adminBoardMapper.deleteBoard", bno);
	}
	
	public int deleteCanBoard(SqlSession sqlSession, int bno) {
		return sqlSession.update("adminBoardMapper.deleteCanBoard", bno);
	}
	
	public int adminBoardSearchCount(SqlSession sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("adminBoardMapper.adminBoardSearchCount", map);
	}
	
	public ArrayList<Board> adminBoardSearch(SqlSession sqlSession, HashMap<String, String> map, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수

		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminBoardMapper.adminBoardSearch", map, rowBounds);
	}
	
	// 사람구해요 관리자페이지 Dao(Repository)

	public int adminFindCount(SqlSession sqlSession) {
		return sqlSession.selectOne("adminBoardMapper.adminFindCount");
	}
	
	public ArrayList<Find> adminFindList(SqlSession sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수

		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminBoardMapper.adminFindList", null , rowBounds);
	}
	
	public int adminFreeDeSearchCount(SqlSession sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("adminBoardMapper.adminFreeDeSearchCount", map);
	}
	
	public ArrayList<Find> adminFreeDeSearch(SqlSession sqlSession, HashMap<String, String> map, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수

		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminBoardMapper.adminFreeDeSearch", map, rowBounds);
	}
	
	public Find adminFindDetail(SqlSession sqlSession, int findNo) {
		return sqlSession.selectOne("adminBoardMapper.adminFindDetail", findNo);
	}
	
	public int adminFreeKeySearchCount(SqlSession sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("adminBoardMapper.adminFreeKeySearchCount", map);
	}
	
	public ArrayList<Find> adminFreeKeySearch(SqlSession sqlSession, HashMap<String, String> map, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수

		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminBoardMapper.adminFreeKeySearch", map, rowBounds);
	}
	
	public int deleteFreeBoard(SqlSession sqlSession, int fno) {
		return sqlSession.update("adminBoardMapper.deleteFreeBoard", fno);
	}
	
	public int deleteFreeCanBoard(SqlSession sqlSession, int fno) {
		return sqlSession.update("adminBoardMapper.deleteFreeCanBoard", fno);
	}
	
	// 사이트이용후기 관리자페이지 Dao(Repository)
	
		public int adminInReviewCountA(SqlSession sqlSession) {
			return sqlSession.selectOne("adminBoardMapper.adminInReviewCountA");
		}
		
		public ArrayList<InReview> adminInReviewListA(SqlSession sqlSession, PageInfo pi) {
			
			int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
			int limit = pi.getBoardLimit(); // limit : 조회할 갯수

			RowBounds rowBounds = new RowBounds(offset, limit);
			
			return (ArrayList)sqlSession.selectList("adminBoardMapper.adminInReviewListA", null , rowBounds);
		}
		
		
		public int adminInReviewCount(SqlSession sqlSession, String category) {
			return sqlSession.selectOne("adminBoardMapper.adminInReviewCount", category);
		}
		
		public ArrayList<InReview> adminInReviewList(SqlSession sqlSession, PageInfo pi, String category) {
			
			int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
			int limit = pi.getBoardLimit(); // limit : 조회할 갯수

			RowBounds rowBounds = new RowBounds(offset, limit);
			
			return (ArrayList)sqlSession.selectList("adminBoardMapper.adminInReviewList", category, rowBounds);
		}
	
		public int deleteInrBoard(SqlSession sqlSession, int ino) {
			return sqlSession.update("adminBoardMapper.deleteInrBoard", ino);
		}
		
		public int deleteInrCanBoard(SqlSession sqlSession, int ino) {
			return sqlSession.update("adminBoardMapper.deleteInrCanBoard", ino);
		}
		
		public int adminInrSearchCount(SqlSession sqlSession, HashMap<String, String> map) {
			return sqlSession.selectOne("adminBoardMapper.adminInrSearchCount", map);
		}
		
		public ArrayList<InReview> adminInrSearch(SqlSession sqlSession, HashMap<String, String> map, PageInfo pi) {
			
			int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
			int limit = pi.getBoardLimit(); // limit : 조회할 갯수

			RowBounds rowBounds = new RowBounds(offset, limit);
			
			return (ArrayList)sqlSession.selectList("adminBoardMapper.adminInrSearch", map, rowBounds);
		}
		
		public InReview detailInReview(SqlSession sqlSession, int inrNo) {
			return sqlSession.selectOne("adminBoardMapper.detailInReview", inrNo);
		}
		
	
}
