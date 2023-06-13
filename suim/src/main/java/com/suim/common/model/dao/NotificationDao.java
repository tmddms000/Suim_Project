package com.suim.common.model.dao;



import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.common.model.vo.Notification;




@Repository
public class NotificationDao {

	public int insertNotification(SqlSessionTemplate sqlSession, Notification no) {
		return sqlSession.insert("notificationMapper.insertNotification", no);
	}

	public int notificationCount(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.selectOne("notificationMapper.notificationCount", memberId);
	}

	public List<Notification> selectRecentNotification(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.selectList("notificationMapper.selectRecentNotification", memberId);
	}

	public int notificationDelete(SqlSessionTemplate sqlSession, Notification no) {
		return sqlSession.delete("notificationMapper.notificationDelete", no);
	}


}
