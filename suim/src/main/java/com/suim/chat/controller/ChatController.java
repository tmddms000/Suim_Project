package com.suim.chat.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.suim.chat.model.service.ChatService;
import com.suim.chat.model.vo.ChatList;
import com.suim.chat.model.vo.ChatLog;
import com.suim.member.model.vo.Member;
import com.suim.report.model.vo.Report;

@Controller
public class ChatController {

	@Autowired
	private ChatService chatService;

	@RequestMapping("house.ch")
	public ModelAndView selectChat(ModelAndView mv, String muser, HttpSession session) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		
		if (loginUser == null) {
			session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
			mv.setViewName("redirect:/member/login");
			return mv;
		}
		
		String cuser = loginUser.getNickName();
		ChatList c = null;

		ChatList ch1 = chatService.selectCheck(muser, cuser);
		ChatList ch2 = chatService.selectCheck(cuser, muser);

		if (ch1 != null || ch2 !=null) {
			c = chatService.selectOne(cuser);
		} else {
			
			c = chatService.insertChat(muser, cuser);
		}

		ArrayList<ChatList> list = chatService.selectList();

		// 대화 목록에 대한 안 읽은 메시지 수를 조회하여 ChatList 객체에 저장
		for (ChatList chat : list) {
			int rc = 0;
			try {
				rc = chatService.selectRead(c.getChatNo(), muser);

			} catch (NullPointerException e) {
				rc = 0; // 널 값이 발생하면 0으로 초기화
			}
			chat.setUnreadCount(rc);
		}

		mv.addObject("Id", cuser);
		mv.addObject("c", c);
		mv.addObject("list", list);
		mv.setViewName("/chat/chat");
		return mv;
	}

	@RequestMapping("chat.ch")
	public ModelAndView selectChat(ModelAndView mv, HttpSession session) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		
		if (loginUser == null) {
			session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
			mv.setViewName("redirect:/member/login");
			return mv;
		}
		
		String muser = loginUser.getNickName();
		ChatList c = chatService.selectOne(muser);
		ArrayList<ChatList> list = chatService.selectList();

		// 대화 목록에 대한 안 읽은 메시지 수를 조회하여 ChatList 객체에 저장
		for (ChatList chat : list) {
			int rc = 0;
			try {
				rc = chatService.selectRead(chat.getChatNo(), muser);
			} catch (NullPointerException e) {
				rc = 0;
			}
			chat.setUnreadCount(rc);
		}

		mv.addObject("Id", muser);
		mv.addObject("c", c);
		mv.addObject("list", list);
		mv.setViewName("/chat/chat");
		return mv;
	}

	@MessageMapping("/chat/{rno}")
	@SendTo("/topic/{rno}")
	public ChatLog handleMessage(ChatLog message) {
		// 받은 메시지 처리 로직을 구현합니다.
		// Message 객체를 ChatLog 객체로 변환하거나 필요한 로직을 수행합니다.
		ChatLog chatLog = new ChatLog();
		chatLog.setChatNo(message.getChatNo());
		chatLog.setContent(message.getContent());
		chatLog.setSendUser(message.getSendUser());
		chatLog.setSendDate(message.getSendDate());
		chatLog.setRstatus(message.getRstatus());
		chatService.saveChatLog(message);

		return chatLog;
	}

	@RequestMapping("/loadChat")
	public ResponseEntity<ArrayList<ChatLog>> loadChat(String chatNo) {
		int rno = Integer.parseInt(chatNo);
		ArrayList<ChatLog> chatHistory = chatService.selectChatLog(rno);
		return new ResponseEntity<>(chatHistory, HttpStatus.OK);
	}

    @RequestMapping("/setRead")
    public ResponseEntity<ArrayList<ChatLog>> setRead(String chatNo, HttpSession session) {
    	int rno = Integer.parseInt(chatNo);
    	Member loginUser = (Member) session.getAttribute("loginUser");
	    String Id = loginUser.getNickName();
        chatService.setRead(rno, Id);  
        return new ResponseEntity<>(HttpStatus.OK);
    }
    
    @RequestMapping("deleteChat.ch")
	public ModelAndView deleteChat(ModelAndView mv, int rno) {
		chatService.deleteChat(rno);
		mv.setViewName("redirect:/chat.ch");
		return mv;
	}
    
    @RequestMapping("report.ch")
	public ModelAndView reportChat(@RequestParam("value") int chatNo, 
			@RequestParam("value2") String memberId, ModelAndView mv) {
	  
	  Report r = new Report();
	  r.setTypeNo(chatNo);
	  r.setReportId(memberId);
	  r.setReportType("chat");
	  
	  mv.addObject("r", r);
	  mv.setViewName("report/reportUpdateForm");
	    
	  return mv;
	}
}
