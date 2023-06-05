package com.suim.notice.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.notice.model.vo.Nattachment;
import com.suim.notice.model.vo.Notice;

@Repository
public class AdminNoticeDao {


	/* 공지사항 게시글 상세조회 시 해당 공지사항 게시글 증가 */
	public int increseCount(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.update("noticeMapper.increaseCount", noticeNo);
	}
	
	public int insertNoticeBoard(SqlSessionTemplate sqlSession, Notice n, Nattachment nAttach) {
		return sqlSession.insert("adminNoticeMapper.insertNoticeBoard", n);
	
	}

	public int insertNoticeFile(SqlSessionTemplate sqlSession, Nattachment nAttach) {
		System.out.println(nAttach + "입니다.");
		return sqlSession.insert("adminNoticeMapper.insertNoticeFile", nAttach);
	}
	
	public int insertBoard(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.insert("noticeMapper.insertNotice", n);
		
	}

	public Notice selectBoard(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.selectOne("noticeMapper.selectBoard", noticeNo);
	}

	public int updateNoticeBoard(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.update("adminNoticeMapper.updateNoticeBoard", n);
	}

}