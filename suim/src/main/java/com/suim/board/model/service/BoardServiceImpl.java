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

	//------------------자유게시판-----------------------
	
	@Override
	public int selectListCount() {
		return boardDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<Board> selectList(PageInfo pi) {
		return boardDao.selectList(sqlSession, pi);
	}

	@Override
	public int insertBoard(Board b) {
		return boardDao.insertBoard(sqlSession, b);
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
	
	//------------------------------------------------
	
	//------------------사람구해요-----------------------

	@Override
	public int selectfListCount() {
		return boardDao.selectfListCount(sqlSession);
	}

	@Override
	public ArrayList<Board> selectfList(PageInfo pi) {
		return boardDao.selectfList(sqlSession, pi);
	}
	
	

}
