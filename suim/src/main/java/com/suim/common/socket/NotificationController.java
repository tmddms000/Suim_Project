package com.suim.common.socket;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suim.common.model.service.NotificationService;
import com.suim.common.model.vo.Notification;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class NotificationController {
	
	@Autowired
	private NotificationService service;
	
	//알람
	@ResponseBody
	@RequestMapping(value = "/insertNotification", method=RequestMethod.POST)
	public int insertNotification (Notification no) throws Exception{
		log.info("알림 insert");
		int alram = 1;
		
		service.insertNotification(no);
		
		return alram;
	}

//알람수
	@ResponseBody
	@RequestMapping(value = "/notificationCount", method=RequestMethod.GET)
	public int notificationCount (String receiverId) throws Exception{
		
		int alram = service.notificationCount(receiverId);
		
		return alram;
	}	
	
	
	//알람목록
	@ResponseBody
	@RequestMapping(value = "/selectRecentNotification", method=RequestMethod.GET)
	public List<Notification> selectRecentNotification(String receiverId) throws Exception{
							
		return service.selectRecentNotification(receiverId);
	}	
	
	
	//알람클릭
	@ResponseBody
	@RequestMapping(value = "/notificationDelete", method=RequestMethod.POST)
	public String alramClick(Notification no) throws Exception{
		log.info("알람클릭");
		service.notificationDelete(no);
		
		return null;
	}

}
