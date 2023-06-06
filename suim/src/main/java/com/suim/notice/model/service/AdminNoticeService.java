package com.suim.notice.model.service;

import com.suim.notice.model.vo.Nattachment;
import com.suim.notice.model.vo.Notice;

public interface AdminNoticeService {

	int increaseCount(int noticeNo);

	Notice selectBoard(int noticeNo);

	// 파일과 공지사항을 둘 다 넘겨서 db 에 저장하려는 용도
	int insertNoticeBoard(Notice n, Nattachment nAttach);

	int insertNoticeFile(Nattachment nAttach);

	int updateBoard(Notice n);

	

	
	

	


	

	
	
}
