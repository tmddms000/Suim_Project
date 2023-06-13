package com.suim.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.suim.member.model.service.MemberService;
import com.suim.member.model.service.MypageService;
import com.suim.member.model.vo.Member;

@Controller
public class ProfileController {

	private final MemberService memberService;
	private final MypageService mypageService;
	private final HttpSession session;

	@Autowired
	public ProfileController(MemberService memberService, MypageService mypageService, HttpSession session) {
		this.memberService = memberService;
		this.mypageService = mypageService;
		this.session = session;
	}
	
	
	//상대 프로필 보기
    @GetMapping("/profile/{memberId}")
    public String getMapping(@PathVariable String memberId, Model model) {
   
    	Member loginUser = (Member) session.getAttribute("loginUser");
		
    	if(loginUser.equals(null)) {
			return "redirect:/mypage/timeline";
		}
		if(memberId.equals(loginUser.getMemberId())) {
			return "redirect:/mypage/timeline";
		}
		
		
		Member m = memberService.selectMember(memberId);
		System.out.println(m);
		model.addAttribute("m", m);
		return "member/mypage/member-profile";
		
    }
}
