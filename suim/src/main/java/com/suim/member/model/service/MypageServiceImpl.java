package com.suim.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.board.model.vo.Board;
import com.suim.common.model.vo.PageInfo;
import com.suim.member.model.dao.MypageDao;

@Service
public class MypageServiceImpl implements MypageService{

	private final SqlSessionTemplate sqlSession;
	private final MypageDao mypageDao;

	@Autowired
	public MypageServiceImpl(SqlSessionTemplate sqlSession, MypageDao mypageDao) {
	    this.sqlSession = sqlSession;
	    this.mypageDao = mypageDao;
	}
	
	@Override
	public int selectBoardListCount() {
		return mypageDao.selectBoardListCount(sqlSession);
	}
	
	@Override
	public ArrayList<Board> selectBoardList(PageInfo pi, String memberId) {
		return mypageDao.selectBoardList(sqlSession, pi, memberId);
	}

	@Override
	public int selectFindListCount() {
		return mypageDao.selectFindListCount(sqlSession);
	}

	@Override
	public ArrayList<Board> selectFindList(PageInfo pi, String memberId) {
		return mypageDao.selectFindList(sqlSession, pi, memberId);
	}

}
