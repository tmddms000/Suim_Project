package com.suim.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.board.model.vo.Battachment;
import com.suim.board.model.vo.Board;
import com.suim.board.model.vo.Find;
import com.suim.board.model.vo.InReview;
import com.suim.board.model.vo.InReviewReply;
import com.suim.board.model.vo.Reply;
import com.suim.board.model.vo.findReply;
import com.suim.common.model.vo.PageInfo;


@Repository
public class BoardDao {
	
	//-----------------------------자유게시판----------------------------------
	
	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.selectListCount");
	}
	
	public ArrayList<Board> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectList", null, rowBounds);
	}
	
	public int insertBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertBoard", b);
	}
	public int insertBattachment(SqlSessionTemplate sqlSession, Battachment ba) {
		return sqlSession.insert("boardMapper.battachment", ba);
	}
	
	public ArrayList<Board> selectbList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("boardMapper.selectbList");
	}
	public int increaseCount(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("boardMapper.increaseCount", boardNo);
	}
	
	public Board selectBoard(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("boardMapper.selectBoard", boardNo);
	}
	public int deleteBoard(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.update("boardMapper.deleteBoard", boardNo);
	}
	public ArrayList<Reply> selectReplyList(SqlSessionTemplate sqlSession, int boardNo) {
		return (ArrayList)sqlSession.selectList("boardMapper.selectReplyList", boardNo);
	}
	
	public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
		return sqlSession.insert("boardMapper.insertReply", r);
	}
	public int ReplyCount(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("boardMapper.ReplyCount", boardNo);
	}
	
	public int  deleteReply(SqlSessionTemplate sqlSession, int breNo) {
		return sqlSession.update("boardMapper.deleteReply", breNo);
	}
	
    public int updateReply(SqlSessionTemplate sqlSession,int bre, String content) {
        Map<String, Object> params = new HashMap<>();
        params.put("bre", bre);
        params.put("content", content);
        return sqlSession.update("updateReply", params);
    }
	
	//------------------------------------------------------------------------------
	
	//---------------------------사람구해요---------------------------------------------
	
	public int selectfListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.selectfListCount");
	}

	public int selectfcListCount(SqlSessionTemplate sqlSession, HashMap<String, String> fin) {
		return sqlSession.selectOne("boardMapper.selectfcListCount");

	}
	
	public ArrayList<Find> selectfList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectfList",null, rowBounds);
	}
	public ArrayList<Find> selectfList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> fin) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectfList", fin ,rowBounds);
	}
	public int increasefCount(SqlSessionTemplate sqlSession, int findNo) {
		return sqlSession.update("boardMapper.increasefCount", findNo);
	}
	
	public Find selectFind(SqlSessionTemplate sqlSession, int findNo) {
		return sqlSession.selectOne("boardMapper.selectFind", findNo);
	}
	public int deleteFind(SqlSessionTemplate sqlSession, int findNo) {
		return sqlSession.update("boardMapper.deleteFind", findNo);
	}
	public ArrayList<findReply> selectfReplyList(SqlSessionTemplate sqlSession, int findNo) {
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectfReplyList", findNo);
	}
	
	public int insertfReply(SqlSessionTemplate sqlSession, findReply fr) {
		return sqlSession.insert("boardMapper.insertfReply", fr);
	
	}
	
	public int updateBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.update("boardMapper.updateBoard", b);
	}
	
	public Board updateBoardList(SqlSessionTemplate sqlSession, int boardNo) {
		return sqlSession.selectOne("boardMapper.selectBoard", boardNo);
	}
	public int insertFind(SqlSessionTemplate sqlSession, Find f) {
		return sqlSession.insert("boardMapper.insertFind", f);
	}
	public int updateFind(SqlSessionTemplate sqlSession, Find f) {
		return sqlSession.update("boardMapper.updateFind", f);
	}
	
	public Find updateFindList(SqlSessionTemplate sqlSession, int findNo) {
		return sqlSession.selectOne("boardMapper.selectFind", findNo);
	}
	
	public int  deletefReply(SqlSessionTemplate sqlSession, int freNo) {
		return sqlSession.update("boardMapper.deletefReply", freNo);
	}
	
    public int updatefReply(SqlSessionTemplate sqlSession,int fre, String content) {
        Map<String, Object> params = new HashMap<>();
        params.put("fre", fre);
        params.put("content", content);
        return sqlSession.update("updatefReply", params);
    }


	//------------------------------------------------------------------------------
	
	//---------------------------이용후기---------------------------------------------
	public int selectiListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.selectiListCount");
	}
	
	public ArrayList<InReview> selectiList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectiList",null, rowBounds);
	}
	public ArrayList<InReview> selectiList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> fin) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectiList", fin ,rowBounds);
	}
	

	public int increaseInCount(SqlSessionTemplate sqlSession, int inrNo) {
		return sqlSession.update("boardMapper.increaseInCount", inrNo);
	}
	
	public InReview selectInReview(SqlSessionTemplate sqlSession, int inrNo) {
		return sqlSession.selectOne("boardMapper.selectInReview", inrNo);
	
	}
	
	public int deleteInReview(SqlSessionTemplate sqlSession, int inrNo) {
		return sqlSession.update("boardMapper.deleteInReview", inrNo);
	}
	public int insertInReview(SqlSessionTemplate sqlSession, InReview i) {
		return sqlSession.insert("boardMapper.insertInReview", i);
	}
	public int updateInReivew(SqlSessionTemplate sqlSession, InReview i) {
		return sqlSession.update("boardMapper.updateInReivew", i);
	}
	
	public InReview updateInReivewList(SqlSessionTemplate sqlSession, int inrNo) {
		return sqlSession.selectOne("boardMapper.selectInReview", inrNo);
	}
	
	public ArrayList<InReviewReply> selectInReviewReplyList(SqlSessionTemplate sqlSession, int inrNo) {
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectInReviewReplyList", inrNo);
	}
	
	public int insertInReviewReply(SqlSessionTemplate sqlSession, InReviewReply ir) {
		return sqlSession.insert("boardMapper.insertInReviewReply", ir);
	
	}
	
	public int  deleteiReply(SqlSessionTemplate sqlSession, int inrNo) {
		return sqlSession.update("boardMapper.deleteiReply", inrNo);
	}
	
    public int updateiReply(SqlSessionTemplate sqlSession,int ireNo, String content) {
        Map<String, Object> params = new HashMap<>();
        params.put("ireNo", ireNo);
        params.put("content", content);
        return sqlSession.update("updateiReply", params);
    }


}
