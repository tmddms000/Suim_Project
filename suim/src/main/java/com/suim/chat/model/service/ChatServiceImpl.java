package com.suim.chat.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.chat.model.dao.ChatDao;
import com.suim.chat.model.vo.ChatList;
import com.suim.chat.model.vo.ChatLog;

@Service
public class ChatServiceImpl implements ChatService {
	@Autowired
	private ChatDao chatDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public ChatList insertChat(String muser, String cuser) {
		return chatDao.insertChat(sqlSession, muser, cuser);
	}

	@Override
	public ArrayList<ChatList> selectChat(String cuser) {
		return chatDao.selectChat(sqlSession, cuser);
	}
	
	@Override
	public ArrayList<ChatList> selectList() {
		return chatDao.selectList(sqlSession);
	}
	
	@Override
	public ChatList selectOne(String muser) {
		return chatDao.selectOne(sqlSession, muser);
	}
	
	@Override
	public int saveChatLog(ChatLog m) {
		return chatDao.saveChatLog(sqlSession, m);
	}

	@Override
	public ArrayList<ChatLog> selectChatLog(int rno) {
		return chatDao.selectChatLog(sqlSession, rno);
	}
	
	@Override
	public ChatList selectCheck(String muser, String cuser) {
		return chatDao.selectCheck(sqlSession, muser, cuser);
	}

	@Override
	public int selectRead(int rno, String Id) {
		return chatDao.selectRead(sqlSession, rno, Id);
	}

	@Override
	public void setRead(int rno, String Id) {
		chatDao.setRead(sqlSession, rno, Id);
	}

	@Override
	public void deleteChat(int rno) {
		chatDao.deleteChat(sqlSession, rno);
		
	}
}
