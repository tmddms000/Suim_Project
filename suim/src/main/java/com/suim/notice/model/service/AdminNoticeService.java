package com.suim.notice.model.service;

import com.suim.notice.model.vo.Notice;

public interface AdminNoticeService {

	// 게시글 작성하기 서비스
		int insertBoard(Notice n);
	
}
