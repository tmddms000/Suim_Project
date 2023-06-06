package com.suim.notice.model.service;

import java.util.ArrayList;

import com.suim.common.model.vo.PageInfo;
import com.suim.notice.model.vo.Nattachment;
import com.suim.notice.model.vo.Notice;

/**
 * ArrayList<Notice> selectList(PageInfo pi);
 * -> 공지사항 리스트 조회
 * 
 * Notice selectBoard(int noticeNo);
 * -> 공지사항 상세 조회
 * @author jihwan
 *
 */
public interface NoticeService {

	int selectListCount();

	ArrayList<Notice> selectList(PageInfo pi);

	int increaseCount(int nno);
	
	Notice selectBoard(int noticeNo);

	ArrayList<Nattachment> selectNoticeFile(int nno);
	
}
