package com.suim.notice.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.notice.model.dao.AdminNoticeDao;
import com.suim.notice.model.vo.Nattachment;
import com.suim.notice.model.vo.Notice;

@Service
public class AdminNoticeServiceImpl implements AdminNoticeService {

	@Autowired
	private AdminNoticeDao adminNoticeDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int insertNoticeBoard(Notice n) {
		return adminNoticeDao.insertNoticeBoard(sqlSession, n);
	}

	@Override
	public int insertNoticeFile(Nattachment nAttach) {
		return adminNoticeDao.insertNoticeFile(sqlSession, nAttach);
	}

	

	

}
