package com.suim.notice.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.notice.model.dao.AdminNoticeDao;
import com.suim.notice.model.dao.NoticeDao;
import com.suim.notice.model.vo.Nattachment;
import com.suim.notice.model.vo.Notice;

@Service
public class AdminNoticeServiceImpl implements AdminNoticeService {

	@Autowired
	private AdminNoticeDao adminNoticeDao;
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertNoticeBoard(Notice n, Nattachment nAttach) {
		return adminNoticeDao.insertNoticeBoard(sqlSession, n, nAttach);
	}

	/*
	@Override
	public int insertNoticeFile(int nFileNo) {
		return adminNoticeDao.insertNoticeFile(sqlSession, nFileNo);
	}
	*/


	@Override
	public Notice selectBoard(int noticeNo) {
		return adminNoticeDao.selectBoard(sqlSession, noticeNo);
	}

	@Override
	public int increaseCount(int nno) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertNoticeFile(Nattachment nAttach) {
		return adminNoticeDao.insertNoticeFile(sqlSession, nAttach);

	}

	
	

	
	

	

	

}
