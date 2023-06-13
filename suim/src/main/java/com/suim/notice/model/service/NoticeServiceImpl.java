package com.suim.notice.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.common.model.vo.PageInfo;
import com.suim.notice.model.dao.NoticeDao;
import com.suim.notice.model.vo.Nattachment;
import com.suim.notice.model.vo.Notice;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int selectListCount() {
		return noticeDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<Notice> selectList(PageInfo pi) {
		return noticeDao.selectList(sqlSession, pi);
	}

	@Override
	public int increaseCount(int nno) {
		return noticeDao.increseCount(sqlSession, nno);
	}

	@Override
	public Notice selectBoard(int noticeNo) {
		return noticeDao.selectBoard(sqlSession, noticeNo);
	}

	
	@Override
	public ArrayList<Nattachment> selectNoticeFile(int nno) {
		return noticeDao.selectNoticeFile(sqlSession, nno);
	}
	

}
