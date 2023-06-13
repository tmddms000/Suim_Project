package com.suim.chat.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.chat.model.vo.ChatList;
import com.suim.chat.model.vo.ChatLog;

@Repository
public class ChatDao {
	
    public ChatList insertChat(SqlSessionTemplate sqlSession, String muser, String cuser) {
        Map<String, Object> params = new HashMap<>();
        params.put("muser", muser);
        params.put("cuser", cuser);
        sqlSession.insert("chatMapper.insertChat", params);
        
        return sqlSession.selectOne("chatMapper.selectIchat", params);
    }
    
    public ArrayList selectChat(SqlSessionTemplate sqlSession, String cuser) {
        return (ArrayList)sqlSession.selectList("chatMapper.selectChat", cuser);
    }
    
    public ArrayList selectList(SqlSessionTemplate sqlSession) {
        return (ArrayList)sqlSession.selectList("chatMapper.selectList");
    }
    
    public ChatList selectOne(SqlSessionTemplate sqlSession, String muser) {
    	return sqlSession.selectOne("chatMapper.selectOne", muser);
    }
    
	public int saveChatLog(SqlSessionTemplate sqlSession, ChatLog m) {	
		return sqlSession.insert("chatMapper.saveChatLog", m);
	}
	
	public ArrayList<ChatLog> selectChatLog(SqlSessionTemplate sqlSession, int rno) {
		return (ArrayList)sqlSession.selectList("chatMapper.selectChatLog", rno);
	}
    
	public ChatList selectCheck(SqlSessionTemplate sqlSession, String muser, String cuser) {
        Map<String, Object> params = new HashMap<>();
        params.put("muser", muser);
        params.put("cuser", cuser);
        
       return sqlSession.selectOne("chatMapper.selectIchat", params);
	}	
    
    public int selectRead(SqlSessionTemplate sqlSession, int rno, String Id) {
        Map<String, Object> params = new HashMap<>();
        params.put("rno", rno);
        params.put("Id", Id);
        return sqlSession.selectOne("chatMapper.selectRead", params);
    }
    
    public void setRead(SqlSessionTemplate sqlSession, int rno, String Id) {
        Map<String, Object> params = new HashMap<>();
        params.put("rno", rno);
        params.put("Id", Id);
        sqlSession.insert("chatMapper.setRead", params);
    }
    
    public void deleteChat(SqlSessionTemplate sqlSession, int rno) {
    	sqlSession.update("chatMapper.deleteChat", rno);
    }
    
}
