package com.suim.common.socket;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.Message;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suim.common.model.service.NotificationService;
import com.suim.common.model.vo.Notification;
import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class NotificationController {

	@Autowired
	private NotificationService service;

	// 알람
	@ResponseBody
	@RequestMapping(value = "/insertNotification", method = RequestMethod.POST)
	public int insertNotification(Notification no) throws Exception {
		int alram = 1;
		service.insertNotification(no);
		return alram;
	}

	// 알람목록
	@ResponseBody
	@RequestMapping(value = "/selectRecentNotification", method = RequestMethod.GET)
	public Map<String, Object> selectRecentNotification(String receiverId,
			@RequestParam(value = "page", defaultValue = "1") int currentPage) throws Exception {

		int listCount = service.notificationCount(receiverId);

		int pageLimit = 5;
		int boardLimit = 5;

		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

		List<Notification> notificationList = service.selectRecentNotification(receiverId, pi);

		Map<String, Object> response = new HashMap<>();
		response.put("list", notificationList);
		response.put("pi", pi);
		response.put("listCount", listCount);

		return response;
	}

	// 알람클릭
	@ResponseBody
	@RequestMapping(value = "/notificationDelete", method = RequestMethod.POST)
	public int notificationDelete(Notification no) throws Exception {
		int result = service.notificationDelete(no);

		return result;
	}

	@ResponseBody
	@RequestMapping(value = "/notificationDeleteAll", method = RequestMethod.POST)
	public int notificationDeleteAll(String receiverId) throws Exception {
		int result = service.notificationDeleteAll(receiverId);

		return result;
	}

	

}
