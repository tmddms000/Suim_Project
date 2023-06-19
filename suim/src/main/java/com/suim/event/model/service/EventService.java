package com.suim.event.model.service;

import java.util.ArrayList;

import com.suim.common.model.vo.PageInfo;
import com.suim.event.model.vo.Eattachment;
import com.suim.event.model.vo.Event;

public interface EventService {

	// 페이징 처리를 위한 게시글 수 조회
	int selectListCount();
	
	ArrayList<Event> selectList(PageInfo pi);

	int increaseCount(int eno);

	ArrayList<Eattachment> selectEventFile(int eno);
	
	Event selectBoard(int eventNo);

	int selectCategoryListCount(String category);

	ArrayList<Event> selectCategoryList(PageInfo pi, String category);

	
	
}
