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
		return sqlSession.selectOne("adminNoticeMapper.selectBoard", noticeNo);
	}

	
	public int updateNoticeBoard(SqlSessionTemplate sqlSession, Notice n) {
		return sqlSession.update("adminNoticeMapper.updateNoticeBoard", n);
	}
	
	// 공지사항 업데이트를 위해 파일 조회용 dao문
	public Nattachment selectForUpdateNoticeFile(SqlSessionTemplate sqlSession, int natNo) {
		return sqlSession.selectOne("adminNoticeMapper.selectNoticeFile", natNo);
	}
	
	public int updateNoticeFile(SqlSessionTemplate sqlSession, Nattachment nAttach) {
		return sqlSession.update("adminNoticeMapper.updateNoticeFile", nAttach);
	}
	
	public int changeFileStatus(SqlSessionTemplate sqlSession, Nattachment nAttach) {
		return sqlSession.update("adminNoticeMapper.chageFileStatus", nAttach);
	}
	
	public int deleteNotice(SqlSessionTemplate sqlSession, int nno) {
		return sqlSession.update("adminNoticeMapper.deleteNotice", nno);
	}
	

}