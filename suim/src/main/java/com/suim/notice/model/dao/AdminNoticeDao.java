package com.suim.notice.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.notice.model.vo.Nattachment;
import com.suim.notice.model.vo.Notice;

@Repository
public class AdminNoticeDao {

	public int insertNoticeBoard(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.insert("AdminNoticeMapper.insertNoticeBoard", n);
	}

	public int insertNoticeFile(SqlSessionTemplate sqlSession, Nattachment nAttach) {
		return sqlSession.insert("AdminNoticeMapper.insertNoticeFile", nAttach);
	}
}
