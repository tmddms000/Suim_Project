package com.suim.common.config;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.suim.member.model.vo.Member;

@WebListener
public class CustomHttpSessionListener implements HttpSessionListener {
    private static final Map<String, HttpSession> sessions = new ConcurrentHashMap<>();
    private static final Map<String, String> previousSessions = new ConcurrentHashMap<>();

    @Override
    public void sessionCreated(HttpSessionEvent hse) {
        sessions.put(hse.getSession().getId(), hse.getSession());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent hse) {
        sessions.remove(hse.getSession().getId());
    }

    public synchronized static String getSessionIdForUser(String userId) {
        for (Map.Entry<String, HttpSession> entry : sessions.entrySet()) {
            HttpSession session = entry.getValue();

            if (session != null && session.getAttribute("loginUser") != null) {
                Member loggedUser = (Member) session.getAttribute("loginUser");
                
                
                
                if (loggedUser != null && loggedUser.getMemberId().equals(userId)) {
                    return entry.getKey();
                }
            }
        }
        return null;
    }

    public synchronized static HttpSession getSessionById(String sessionId) {
        return sessions.get(sessionId);
    }

    public static void expireSession(String sessionId) {
        if (sessionId != null && sessions.containsKey(sessionId)) {
            HttpSession session = sessions.get(sessionId);
            if (session != null) {
                session.invalidate();
            }
            sessions.remove(sessionId);
        }
    }


    public synchronized static boolean hasActiveSession(String userId) {
        for (Map.Entry<String, HttpSession> entry : sessions.entrySet()) {
            HttpSession session = entry.getValue();

            if (session != null && session.getAttribute("loginUser") != null) {
                Member loggedUser = (Member) session.getAttribute("loginUser");
                if (loggedUser != null && loggedUser.getMemberId().equals(userId)) {
                    return true;
                }
            }
        }
        return false;
    }

    public static void recordPreviousSession(String userId, String sessionId) {
        previousSessions.put(userId, sessionId);
    }

    public static String getPreviousSessionId(String userId) {
        return previousSessions.get(userId);
    }

    public static int getSessionCount() {
        return sessions.size();
    }

    public static Map<String, HttpSession> getSessionList() {
        return sessions;
    }


}
