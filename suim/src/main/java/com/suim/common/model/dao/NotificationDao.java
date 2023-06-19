package com.suim.common.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.common.model.vo.Notification;
import com.suim.common.model.vo.PageInfo;

@Repository
public class NotificationDao {

	public int insertNotification(SqlSessionTemplate sqlSession, Notification no) {
		return sqlSession.insert("notificationMapper.insertNotification", no);
	}

	public int notificationCount(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.selectOne("notificationMapper.notificationCount", memberId);
	}

	public List<Notification> selectRecentNotification(SqlSessionTemplate sqlSession, String receiverId, PageInfo pi) {

		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수

		RowBounds rowBounds = new RowBounds(offset, limit);

		return (List) sqlSession.selectList("notificationMapper.selectRecentNotification", receiverId, rowBounds);
	}

	public int notificationDelete(SqlSessionTemplate sqlSession, Notification no) {
		return sqlSession.delete("notificationMapper.notificationDelete", no);
	}

	public int notificationDeleteAll(SqlSessionTemplate sqlSession, String receiverId) {
		return sqlSession.delete("notificationMapper.notificationDeleteAll", receiverId);
	}

}
