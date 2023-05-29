package com.suim.member.controller;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.suim.member.model.vo.SignUp;

@Controller
public class MemberController {
	
	@RequestMapping("/join")
	public String SignUp(Model theModel) {
		
		theModel.addAttribute("member", new SignUp());
		return("member/sign");
	}
	
	
	@RequestMapping("/processForm")
	public String processForm(@Valid @ModelAttribute("member") SignUp member, BindingResult theBindingResult) {

		if (theBindingResult.hasErrors()) {
			return "member/sign";
		} else {
			System.out.println(member);
			return "member/sign-success";
			
		}
	}

}
