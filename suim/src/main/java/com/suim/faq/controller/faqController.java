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
}
