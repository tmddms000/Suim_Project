package com.suim.common.model.service;

import java.util.List;

import com.suim.common.model.vo.Notification;
import com.suim.common.model.vo.PageInfo;

public interface NotificationService {

	//알림 생성
	int insertNotification(Notification no);
	
	//알림 갯수 카운팅
	int notificationCount(String memberId);
	
	//최근 알림 업데이트
	List<Notification> selectRecentNotification(String receiverId, PageInfo pi);
	// 
	int notificationDelete(Notification no);

	int notificationDeleteAll(String receiverId);

	
	
}
