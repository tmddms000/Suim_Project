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
	public int increaseCount(int nno) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int insertNoticeFile(Nattachment nAttach) {
		return adminNoticeDao.insertNoticeFile(sqlSession, nAttach);

	}

	@Override
	public int updateNotice(Notice n) {
		return adminNoticeDao.updateNoticeBoard(sqlSession, n);
	}


	@Override
	public int updateNoticeFile(Nattachment nAttach) {
		return adminNoticeDao.updateNoticeFile(sqlSession, nAttach);
	}

	@Override
	public Nattachment selectForUpdateNoticeFile(Nattachment nAttach) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int changeFileStatus(Nattachment nAttach) {
		return adminNoticeDao.changeFileStatus(sqlSession, nAttach);
	}

	@Override
	public int deleteNotice(int nno) {
		return adminNoticeDao.deleteNotice(sqlSession, nno);
	}

	

	
	

	

	

}
