package com.suim.common.socket;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.messaging.Message;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.suim.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class EchoHandler extends TextWebSocketHandler {
	private static final Logger logger = LoggerFactory.getLogger(WebSocketHandler.class);
	//로그인 한 인원 전체
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1:1로 할 경우
	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {//클라이언트와 서버가 연결
		// TODO Auto-generated method stub
		sessions.add(session);
		logger.info(currentUserName(session));//현재 접속한 사람
		String senderId = currentUserName(session);
		userSessionsMap.put(senderId,session);
	}
	
	
	public void broadcastMessage(String memberId, String message) {
	    for (WebSocketSession session : sessions) {
	        Member loggedUser = (Member) session.getAttributes().get("loginUser");
	        if (loggedUser != null && loggedUser.getMemberId().equals(memberId)) {
	            try {
	                session.sendMessage(new TextMessage(message));
	                log.info("메세지 보냄");
	            } catch (IOException e) {
	                // Handle exception
	            }
	        }
	    }
	}
	
	
	public void adminBroadcastMessage(String jsonData) {
	    for (WebSocketSession session : sessions) {
	        try {
	            session.sendMessage(new TextMessage(jsonData));
	            log.info("메세지 보냄");
	        } catch (IOException e) {
	            // Handle exception
	        }
	    }
	}
	
	
	
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {// 메시지
		// TODO Auto-generated method stub
		logger.info("ssesion"+currentUserName(session));
		String msg = message.getPayload();//자바스크립트에서 넘어온 Msg
		logger.info("msg="+msg);
		
		if (StringUtils.isNotEmpty(msg)) {
			String[] strs = msg.split(",");
			if(strs != null && strs.length == 6) {
				
				String cmd = strs[0];
				String replyWriter = strs[1];
				String boardWriter = strs[2];
				String bno = strs[3];
				String title = strs[4];
				String content = strs[5];
				
				WebSocketSession replyWriterSession = userSessionsMap.get(replyWriter);
				WebSocketSession boardWriterSession = userSessionsMap.get(boardWriter);
				logger.info("boardWriterSession="+userSessionsMap.get(boardWriter));
				logger.info("boardWirterSession"+boardWriterSession);
				
				if (boardWriterSession != null) {
					logger.info("메시지 보냄");
					TextMessage tmpMsg = new TextMessage(replyWriter + "님이"
							+ "<a href='/detail.bo?bno="+ bno + "'  style=\"color: black\">"
							+ title+"에 댓글을 달았습니다. 내용 : " + content + "</a>");
					boardWriterSession.sendMessage(tmpMsg);
				}	
			}
			
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {//연결 해제
		sessions.remove(session);
		userSessionsMap.remove(currentUserName(session),session);
	}

	
	private String currentUserName(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		Member loginUser = (Member)httpSession.get("loginUser");
		
		if(loginUser == null) {
			String mid = session.getId();
			return mid;
		}
		String mid = loginUser.getMemberId();
		return mid;
		
	}
}