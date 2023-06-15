package com.suim.common.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.chat.model.dao.ChatDao;
import com.suim.common.model.dao.NotificationDao;
import com.suim.common.model.vo.Notification;
import com.suim.common.model.vo.PageInfo;

@Service
public class NotificationServiceImpl implements NotificationService{

	@Autowired
	private NotificationDao notificationDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	

	@Override
	public int insertNotification(Notification no) {
		return notificationDao.insertNotification(sqlSession, no);
	}

	@Override
	public int notificationCount(String receiverId) {
		return notificationDao.notificationCount(sqlSession, receiverId);
	}

	@Override
	public List<Notification> selectRecentNotification(String receiverId, PageInfo pi) {
		return notificationDao.selectRecentNotification(sqlSession, receiverId, pi);
	}
	

	@Override
	public int notificationDelete(Notification no) {
		return notificationDao.notificationDelete(sqlSession, no);
	}

	@Override
	public int notificationDeleteAll(String receiverId) {
		return notificationDao.notificationDeleteAll(sqlSession, receiverId);
	}



	
	
}
