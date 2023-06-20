package com.suim.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.board.model.vo.Board;
import com.suim.common.model.vo.PageInfo;
import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Reservation;
import com.suim.member.model.dao.MypageDao;
import com.suim.member.model.vo.MyWish;
import com.suim.pay.model.vo.Pay;

@Service
public class MypageServiceImpl implements MypageService {

	private final SqlSessionTemplate sqlSession;
	private final MypageDao mypageDao;

	@Autowired
	public MypageServiceImpl(SqlSessionTemplate sqlSession, MypageDao mypageDao) {
		this.sqlSession = sqlSession;
		this.mypageDao = mypageDao;
	}

	@Override
	public int selectBoardListCount(String memberId) {
		return mypageDao.selectBoardListCount(sqlSession, memberId);

	}

	@Override
	public ArrayList<Board> selectBoardList(PageInfo pi, String memberId) {
		return mypageDao.selectBoardList(sqlSession, pi, memberId);
	}

	@Override

	public int selectFindListCount(String memberId) {
		return mypageDao.selectFindListCount(sqlSession, memberId);

	}

	@Override
	public ArrayList<Board> selectFindList(PageInfo pi, String memberId) {
		return mypageDao.selectFindList(sqlSession, pi, memberId);
	}

	@Override
	public int selectHouseListCount(String memberId) {
		return mypageDao.selectHouseListCount(sqlSession, memberId);
	}

	@Override
	public ArrayList<House> selectHouseList(PageInfo pi, String memberId) {
		return mypageDao.selectHouseList(sqlSession, pi, memberId);
	}

	@Override
	public int deleteBoard(int[] intArray, String memberId) {
		return mypageDao.deleteBoard(sqlSession, intArray, memberId);

	}

	@Override
	public int selectWishListCount(String memberId) {
		return mypageDao.selectWishListCount(sqlSession, memberId);
	}

	@Override
	public ArrayList<MyWish> selectWishList(PageInfo pi, String memberId) {
		return mypageDao.selectWishList(sqlSession, pi, memberId);
	}

	@Override
	public int selectInreviewCount(String memberId) {
		return mypageDao.selectInreviewCount(sqlSession, memberId);
	}

	@Override
	public ArrayList<Board> selectInreviewList(PageInfo pi, String memberId) {
		return mypageDao.selectInreviewList(sqlSession, pi, memberId);
	}

	@Override
	public int selectRezListCount(String memberId) {
		return mypageDao.selectRezListCount(sqlSession, memberId);
	}

	@Override
	public ArrayList<Reservation> selectRezList(PageInfo pi, String memberId) {
		return mypageDao.selectRezList(sqlSession, pi, memberId);
	}

	@Override
	public int selectPayListCount(String memberId) {
		return mypageDao.selectPayListCount(sqlSession, memberId);
	}

	@Override
	public ArrayList<Pay> selectPayList(PageInfo pi, String memberId) {
		return mypageDao.selectPayList(sqlSession, pi, memberId);
	}

	@Override
	public int selectAlarmCheck(String email) {
		return mypageDao.selectAlarmCheck(sqlSession, email);
	}

	@Override
	public int updateAlarmCheck(String email) {
		return mypageDao.updateAlarmCheck(sqlSession, email);
	}

}
