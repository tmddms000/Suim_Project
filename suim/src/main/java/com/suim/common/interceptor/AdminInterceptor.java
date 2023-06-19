package com.suim.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.suim.member.model.service.AdminMemberService;
import com.suim.member.model.vo.Member;

public class AdminInterceptor implements HandlerInterceptor{

	@Autowired
	AdminMemberService adminMemberService;
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 관리자 인증 체크 로직
        HttpSession session = request.getSession();
        Member loginUser = (Member)session.getAttribute("loginUser");
        
        if (loginUser != null) {
        	int result = adminMemberService.checkAdminLogin(loginUser.getEmail());
        	
        	if(result != 1) {
    			session.setAttribute("alertMsg", "관리자 권한이 없습니다.");
        		response.sendRedirect("/member/login"); // 인증되지 않은 경우 로그인 페이지로 이동
        		return false;
        	}
        } else {
        	session.setAttribute("alertMsg", "관리자 권한이 없습니다.");
    		response.sendRedirect("/member/login"); // 인증되지 않은 경우 로그인 페이지로 이동
        	return false;
        }
        
        return true;
    }
}
