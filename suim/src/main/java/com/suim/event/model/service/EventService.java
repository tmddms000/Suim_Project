package com.suim.event.model.service;

import java.util.ArrayList;

import com.suim.common.model.vo.PageInfo;
import com.suim.event.model.vo.Eattachment;
import com.suim.event.model.vo.Event;

public interface EventService {

	int selectListCount();
	
	ArrayList<Event> selectList(PageInfo pi);

	int increaseCount(int eno);

	ArrayList<Eattachment> selectEventFile(int eno);
	
	Event selectBoard(int eventNo);
}
