package com.suim.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.suim.member.model.service.MemberService;
import com.suim.member.model.vo.Member;

public class LoginInterceptor implements HandlerInterceptor {

    @Autowired
    MemberService memberService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession();
        Member loginUser = (Member) session.getAttribute("loginUser");

        if (loginUser != null) {
            int result = memberService.checkEmailLogin(loginUser.getEmail());
            if (result != 1) {
                String requestURI = request.getRequestURI();
                if (!requestURI.equals("/member/verifyPage") && !requestURI.equals("/member/verifyEmail")) {
                    response.sendRedirect("/member/verifyPage");
                    return false;
                }
            }
        }

        return true;
    }
}