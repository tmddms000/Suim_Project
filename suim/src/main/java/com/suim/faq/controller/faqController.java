package com.suim.faq.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class faqController {
	@GetMapping("/faqList")
	public String faqList() {
		
		return "faq/faqList";
	}
	
	@GetMapping("/faq_howToSignUp")
	public String faq_howToSignUp() {
		return "faq/faq_howToSignUp";
	}
	
	@GetMapping("/faq_howTo1to1")
	public String faq_howTo1to1() {
		return "faq/faq_howTo1to1";
	}
	
	@GetMapping("/faq_emergency")
	public String faq_emergency() {
		return "faq/faq_emergency";
	}
	
	@GetMapping("/faq_eventReward")
	public String faq_eventReward() {
		return "faq/faq_eventReward";
	}
	
	@GetMapping("/faq_afterChat")
	public String faq_afterChat() {
		return "faq/faq_afterChat";
	}
	
	@GetMapping("/faq_iForgetIdAndPassword")
	public String iForgetIdAndPassword() {
		return "faq/faq_iForgetIdAndPassword";
	}
}
