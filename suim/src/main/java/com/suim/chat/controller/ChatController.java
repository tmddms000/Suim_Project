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
import org.springframework.web.servlet.ModelAndView;

import com.suim.chat.model.service.ChatService;
import com.suim.chat.model.vo.ChatList;
import com.suim.chat.model.vo.ChatLog;
import com.suim.member.model.vo.Member;

@Controller
public class ChatController {
	
	@Autowired
	private ChatService chatService;
	
    @RequestMapping("house.ch")
    public ModelAndView selectChat(ModelAndView mv, String muser, HttpSession session){
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    String cuser = loginUser.getMemberId(); 
	    ChatList c = null;
	    
	    ChatList ch = chatService.selectCheck(muser, cuser);
	    
	    if(ch != null) {
	    	c = chatService.selectOne(cuser);
	    } else {
	    	c = chatService.insertChat(muser, cuser);
	    }
	    
	    ArrayList<ChatList> list = chatService.selectChat(cuser);
	    
	    mv.addObject("Id", cuser);
		mv.addObject("c", c);
		mv.addObject("list", list);
		mv.setViewName("/chat/chat");
		return mv;
    }
    
    @RequestMapping("chat.ch")
    public ModelAndView selectChat(ModelAndView mv, HttpSession session){
    	Member loginUser = (Member) session.getAttribute("loginUser");
	    String muser = loginUser.getMemberId();  
	    ChatList c = chatService.selectOne(muser);
	    ArrayList<ChatList> list = chatService.selectList();
	    
	    mv.addObject("Id", muser);
	    mv.addObject("c", c);
		mv.addObject("list", list);
		mv.setViewName("/chat/chat");
		return mv;
    }
    
    
    @MessageMapping("/chat/{rno}")
    @SendTo("/topic/{rno}")
    public ChatLog handleMessage(String rno, ChatLog message) {
        // 받은 메시지 처리 로직을 구현합니다.
        // Message 객체를 ChatLog 객체로 변환하거나 필요한 로직을 수행합니다.
        ChatLog chatLog = new ChatLog();
        chatLog.setContent(message.getContent());
        chatLog.setSendUser(message.getSendUser());
        int result = chatService.saveChatLog(message);

        return chatLog;
    }
    
    
    @RequestMapping("/loadChat")
    public ResponseEntity<ArrayList<ChatLog>> loadChat(String chatNo) {
    	int rno = Integer.parseInt(chatNo);
        ArrayList<ChatLog> chatHistory = chatService.selectChatLog(rno);
        return new ResponseEntity<>(chatHistory, HttpStatus.OK);
    }
}
