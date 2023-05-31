package com.suim.notice.model.service;

import java.util.ArrayList;

import com.suim.common.model.vo.PageInfo;
import com.suim.notice.model.vo.Notice;

public interface NoticeService {

	int selectListCount();

	ArrayList<Notice> selectList(PageInfo pi);

	
	
}
