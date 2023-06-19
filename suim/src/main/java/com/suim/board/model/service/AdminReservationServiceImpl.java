package com.suim.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.board.model.dao.AdminReservationDao;
import com.suim.common.model.vo.PageInfo;
import com.suim.house.model.vo.Reservation;

@Service
public class AdminReservationServiceImpl implements AdminReservationService {
	
	@Autowired
	private AdminReservationDao adminReservationDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int adminRezCount() {
		return adminReservationDao.adminRezCount(sqlSession);
	}

	@Override
	public ArrayList<Reservation> adminRezList(PageInfo pi) {
		return adminReservationDao.adminRezList(sqlSession, pi);		
	}

	@Override
	public Reservation adminRezDetail(int rno) {
		return adminReservationDao.adminRezDetail(sqlSession, rno);
	}

	@Override
	public int adminRezUpdate(HashMap<String, Object> map) {
		return adminReservationDao.adminRezUpdate(sqlSession, map);
	}

	@Override
	public int adminRezDeSearchCount(HashMap<String, Object> map) {
		return adminReservationDao.adminRezDeSearchCount(sqlSession, map);
	}

	@Override
	public ArrayList<Reservation> adminRezDeSearch(HashMap<String, Object> map, PageInfo pi) {
		return adminReservationDao.adminRezDeSearch(sqlSession, map, pi);
	}

	@Override
	public int adminRezKeySearchCount(HashMap<String, String> map) {
		return adminReservationDao.adminRezKeySearchCount(sqlSession, map);
	}

	@Override
	public ArrayList<Reservation> adminRezKeySearch(HashMap<String, String> map, PageInfo pi) {
		return adminReservationDao.adminRezKeySearch(sqlSession, map, pi);
	}

	@Override
	public int deleteRezBoard(int rno) {
		return adminReservationDao.deleteRezBoard(sqlSession, rno);
	}

	@Override
	public int deleteRezCanBoard(int rno) {
		return adminReservationDao.deleteRezCanBoard(sqlSession, rno);
	}

}
