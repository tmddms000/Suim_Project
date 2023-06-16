package com.suim.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.board.model.dao.AdminBoardDao;
import com.suim.board.model.vo.Board;
import com.suim.board.model.vo.Find;
import com.suim.board.model.vo.InReview;
import com.suim.common.model.vo.PageInfo;

@Service
public class AdminBoardServiceImpl implements AdminBoardService {

	@Autowired
	private AdminBoardDao adminBoardDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 자유게시판 관리자페이지 Service
	
	@Override
	public int adminBoardCountA() {
		return adminBoardDao.adminBoardCountA(sqlSession);
	}

	@Override
	public ArrayList<Board> adminBoardListA(PageInfo pi) {
		return adminBoardDao.adminBoardListA(sqlSession, pi);
	}
	
	@Override
	public int adminBoardCount(String category) {
		return adminBoardDao.adminBoardCount(sqlSession, category);
	}
	
	@Override
	public ArrayList<Board> adminBoardList(PageInfo pi, String category) {
		return adminBoardDao.adminBoardList(sqlSession, pi, category);
	}

	@Override
	public Board adminDetailBoard(int boardNo) {
		return adminBoardDao.adminDetailBoard(sqlSession, boardNo);
	}

	@Override
	public int deleteBoard(int bno) {
		return adminBoardDao.deleteBoard(sqlSession, bno);
	}

	
	@Override
	public int deleteCanBoard(int bno) {
		return adminBoardDao.deleteCanBoard(sqlSession, bno);
	}

	@Override
	public int adminBoardSearchCount(HashMap<String, String> map) {
		return adminBoardDao.adminBoardSearchCount(sqlSession, map);
	}

	@Override
	public ArrayList<Board> adminBoardSearch(HashMap<String, String> map, PageInfo pi) {
		return adminBoardDao.adminBoardSearch(sqlSession, map, pi);
	}
	
	// 사람구해요 게시판 관리자페이지 Service
	
	@Override
	public int adminFindCount() {
		return adminBoardDao.adminFindCount(sqlSession);
	}

	@Override
	public ArrayList<Find> adminFindList(PageInfo pi) {
		return adminBoardDao.adminFindList(sqlSession, pi);
	}

	@Override
	public int adminFreeDeSearchCount(HashMap<String, String> map) {
		return adminBoardDao.adminFreeDeSearchCount(sqlSession, map);
	}

	@Override
	public ArrayList<Find> adminFreeDeSearch(HashMap<String, String> map, PageInfo pi) {
		return adminBoardDao.adminFreeDeSearch(sqlSession, map, pi);
	}
	
	@Override
	public Find adminFindDetail(int findNo) {
		return adminBoardDao.adminFindDetail(sqlSession, findNo);
	}

	@Override
	public int adminFreeKeySearchCount(HashMap<String, String> map) {
		return adminBoardDao.adminFreeKeySearchCount(sqlSession, map);
	}

	@Override
	public ArrayList<Find> adminFreeKeySearch(HashMap<String, String> map, PageInfo pi) {
		return adminBoardDao.adminFreeKeySearch(sqlSession, map, pi);
	}

	@Override
	public int deleteFreeBoard(int fno) {
		return adminBoardDao.deleteFreeBoard(sqlSession, fno);
	}

	@Override
	public int deleteFreeCanBoard(int fno) {
		return adminBoardDao.deleteFreeCanBoard(sqlSession, fno);
	}
	
	// 플랫폼 이용후기 게시판 관리자페이지 Service
	
	@Override
	public int adminInReviewCountA() {
		return adminBoardDao.adminInReviewCountA(sqlSession);
	}

	@Override
	public ArrayList<InReview> adminInReviewListA(PageInfo pi) {
		return adminBoardDao.adminInReviewListA(sqlSession, pi);
	}

	@Override
	public int adminInReviewCount(String category) {
		return adminBoardDao.adminInReviewCount(sqlSession, category);
	}

	@Override
	public ArrayList<InReview> adminInReviewList(PageInfo pi, String category) {
		return adminBoardDao.adminInReviewList(sqlSession, pi, category);
	}

	@Override
	public int deleteInrBoard(int ino) {
		return adminBoardDao.deleteInrBoard(sqlSession, ino);
	}

	@Override
	public int deleteInrCanBoard(int ino) {
		return adminBoardDao.deleteInrCanBoard(sqlSession, ino);
	}

	@Override
	public int adminInrSearchCount(HashMap<String, String> map) {
		return adminBoardDao.adminInrSearchCount(sqlSession, map);
	}

	@Override
	public ArrayList<InReview> adminInrSearch(HashMap<String, String> map, PageInfo pi) {
		return adminBoardDao.adminInrSearch(sqlSession, map, pi);
	}

	@Override
	public InReview detailInReview(int inrNo) {
		return adminBoardDao.detailInReview(sqlSession, inrNo);

	}

	


	



}
