package com.suim.chat.model.service;

import java.util.ArrayList;

import com.suim.chat.model.vo.ChatList;
import com.suim.chat.model.vo.ChatLog;

public interface ChatService {
	
	ChatList insertChat(String muser, String cuser);
	
	ArrayList<ChatList> selectChat(String cuser);
	
	ArrayList<ChatList> selectList();
	
	ChatList selectOne(String muser);
	
	int saveChatLog(ChatLog m);
	
	ArrayList<ChatLog> selectChatLog(int rno);
	
	ChatList selectCheck(String muser, String cuser);
	
	int selectRead(int rno, String Id);
	
	void setRead(int rno, String Id);
	
	void deleteChat(int rno);
	
}
