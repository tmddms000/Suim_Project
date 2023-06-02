package com.suim.notice.model.service;

import com.suim.notice.model.vo.Nattachment;
import com.suim.notice.model.vo.Notice;

public interface AdminNoticeService {

	int insertNoticeBoard(Notice n);

	int insertNoticeFile(Nattachment nAttach);

	

	
	
}
