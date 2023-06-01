package com.suim.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.suim.member.model.service.MemberService;

@Controller
@RequestMapping("mypage")
public class MypageController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("info")
	public String Mypage() {
		
		return "member/mypage-info";
	}

}
