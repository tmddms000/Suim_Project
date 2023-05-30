package com.suim.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Set;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suim.member.model.service.MemberService;
import com.suim.member.model.vo.SignUp;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	// 회원가입 페이지 이동
	@RequestMapping("/join")
	public String signUp(Model theModel) {

		theModel.addAttribute("member", new SignUp());
		return ("member/signup");
	}
	
	@ResponseBody
	@RequestMapping(value = "/idCheck", produces = "text/html; charset=UTF-8")
	public String idCheck(@RequestParam("id") String checkId) {
		
		int count = memberService.idCheck(checkId);
		
		return (count > 0) ? "Duplicate" : "Available";
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/emailCheck", produces = "text/html; charset=UTF-8")
	public String emailCheck(String email) {
		
		int count = memberService.emailCheck(email);
		
		return (count > 0) ? "Duplicate" : "Available";
		
	}
	
	
	
	
	
	
	
	

	// 회원가입 성공
	@RequestMapping("/joinSuccess")
	public String insertMember(@Valid @ModelAttribute("member") SignUp member, BindingResult theBindingResult)
			throws IOException {

		if (theBindingResult.hasErrors()) {
			System.out.println(theBindingResult);
			return "member/signup";
		} else {

			String nickName = generateUniqueNickname();
			member.setNickName(nickName);
			System.out.println(member);
			return "member/sign-success";
		}
	}

	public String generateUniqueNickname() throws IOException {
	    String nickname = randomNickName();
	    int nicknameCount = memberService.nickCheck(nickname);

	    System.out.println(nicknameCount);
	    if (nicknameCount > 1) {
	        System.out.println("닉네임 " + nickname + " 이미 존재하는 닉네임입니다.");
	        return generateUniqueNickname();
	    }


	    System.out.println(nickname);
	    return nickname;
	}

	public String randomNickName() throws IOException {
	    String url = "https://nickname.hwanmoo.kr/?format=text&max_length=6";

	    URL requestURL = new URL(url);
	    HttpURLConnection urlConnection = (HttpURLConnection) requestURL.openConnection();
	    urlConnection.setRequestMethod("GET");

	    try (BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()))) {
	        String line;
	        StringBuilder responseText = new StringBuilder();

	        while ((line = br.readLine()) != null) {
	            responseText.append(line);
	        }

	        return responseText.toString();
	    } finally {
	        urlConnection.disconnect();
	    }
	}

}
