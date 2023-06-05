package com.suim.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class AuthInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        // 세션에서 로그인 여부 확인
        if (request.getSession().getAttribute("loginUser") != null) {
            // 이미 로그인 된 경우 로그인 페이지와 회원가입 페이지로의 접근 막기
        	response.sendRedirect("/");
            return false;
        }
        return true;
    }

    // 이후의 메서드는 필요에 따라 오버라이드하여 사용할 수 있습니다
}