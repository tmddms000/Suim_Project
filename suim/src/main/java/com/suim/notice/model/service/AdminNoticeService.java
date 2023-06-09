package com.suim.notice.model.service;

import com.suim.notice.model.vo.Nattachment;
import com.suim.notice.model.vo.Notice;

public interface AdminNoticeService {

	int increaseCount(int noticeNo);

	

	// 파일과 공지사항을 둘 다 넘겨서 db 에 저장하려는 용도
	int insertNoticeBoard(Notice n, Nattachment nAttach);

	int insertNoticeFile(Nattachment nAttach);

	// int updateBoard(Notice n, Nattachment nAttach);

	int updateNotice(Notice n);
	
	Nattachment selectForUpdateNoticeFile(Nattachment nAttach);
	
	int updateNoticeFile(Nattachment nAttach);

	int changeFileStatus(Nattachment nAttach);

	// detailNotice 로부터 nno 를 받아서 해당 공지사항과 파일도 삭제
	int deleteNotice(int nno);




	
	


	

	
	
}
