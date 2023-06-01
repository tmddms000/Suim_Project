package com.suim.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suim.member.model.service.MemberService;
import com.suim.member.model.vo.Member;

@Controller
@RequestMapping("mypage")
public class MypageController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
    private HttpSession session;

	// 처음 페이지(알림 페이지)로 이동합니다.
	@RequestMapping({ "timeline" })
	public String mypageAlert(HttpServletRequest request) {
		session.setAttribute("originalUrl", request.getRequestURI());
		return "member/mypage/mypage-timeline";
	}

	// 마이페이지의 내 게시글 조회로 이동합니다.
	@RequestMapping("post")
	public String mypageBoard(HttpServletRequest request) {
		session.setAttribute("originalUrl", request.getRequestURI());
		return "member/mypage/mypage-post";
	}

	// 마이페이지의 내 찜목록 조회로 이동합니다.
	@RequestMapping("wish")
	public String mypageWish(HttpServletRequest request) {
		session.setAttribute("originalUrl", request.getRequestURI());
		return "member/mypage/mypage-wish";
	}

	// 마이페이지의 내 셰어하우스 조회로 이동합니다.
	@RequestMapping("house")
	public String mypageHouse(HttpServletRequest request) {
		session.setAttribute("originalUrl", request.getRequestURI());
		return "member/mypage/mypage-house";
	}

	// 마이페이지의 내 예약내역 조회로 이동합니다.
	@RequestMapping("reservation")
	public String mypageReservation(HttpServletRequest request) {
		session.setAttribute("originalUrl", request.getRequestURI());
		return "member/mypage/mypage-reservation";
	}

	// 마이페이지의 내 정보 조회로 이동합니다.
	@RequestMapping("profile")
	public String mypageProfile(HttpServletRequest request) {
		session.setAttribute("originalUrl", request.getRequestURI());
		return "member/mypage/mypage-profile";
	}
	
	
	// 사용자 정보 수정 메소드
	@PostMapping("updateProfile")
	public String updateProfile(Member m, String changePwd1, String changePwd2) {
		System.out.println(m);
		System.out.println(changePwd1);
		System.out.println(changePwd2);
		return "redirect:" + session.getAttribute("originalUrl");
	}
	


}
