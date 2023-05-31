package com.suim.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.suim.member.model.service.MemberService;
import com.suim.member.model.vo.Member;
import com.suim.member.model.vo.SignUp;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	@GetMapping("/login")
	public String loginForm() {
		return "member/login";

	}

	@PostMapping("/login")
	public ModelAndView loginMember(Member m, HttpSession session, ModelAndView mv, HttpServletResponse response) {

		Member loginUser = memberService.loginMember(m);

		if (loginUser != null && bcryptPasswordEncoder.matches(m.getMemberPwd(), loginUser.getMemberPwd())) {

			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "로그인에 성공했습니다.");

			mv.setViewName("redirect:/");

		} else { // 로그인 실패 처리

			mv.addObject("errorMsg", "로그인 실패");

			mv.setViewName("common/errorPage");
		}

		return mv;
	}

	@PostMapping("/logout")
	public String logoutMember(HttpSession session) {

		session.setAttribute("alertMsg", "로그아웃 되었습니다.");
		session.removeAttribute("loginUser");
		return "redirect:/";

	}

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

	@ResponseBody
	@RequestMapping(value = "/phoneCheck", produces = "text/html; charset=UTF-8")
	public String phoneCheck(String phone) {

		int count = memberService.phoneCheck(phone);

		return (count > 0) ? "Duplicate" : "Available";

	}

	// 회원가입 성공
	@RequestMapping("/joinSuccess")
	public String insertMember(@Valid @ModelAttribute("member") SignUp member, BindingResult theBindingResult,
			Model model, HttpSession session) throws IOException {

		if (theBindingResult.hasErrors()) {
			return "member/signup";
		} else {

			// id, email, phone 중복 체크
			int id = memberService.idCheck(member.getMemberId());
			int email = memberService.emailCheck(member.getEmail());
			int phone = memberService.phoneCheck(member.getPhone());

			if (id > 0) {
				session.setAttribute("alertMsg", "중복된 아이디가 존재합니다.");
				return "member/signup";
			} else if (email > 0) {
				session.setAttribute("alertMsg", "중복된 이메일이 존재합니다.");
				return "member/signup";
			} else if (phone > 0) {
				session.setAttribute("alertMsg", "중복된  번호가 존재합니다.");
				return "member/signup";
			}

			String nickName = generateUniqueNickname();
			String encPwd = bcryptPasswordEncoder.encode(member.getMemberPwd());
			member.setNickName(nickName);
			member.setMemberPwd(encPwd);

			int result = memberService.insertMember(member);

			if (result > 0) {

				session.setAttribute("alertMsg", "성공적으로 회원가입이 되었습니다.");

				// 이메일 인증 받아야함
				return "member/sign-success";

			} else {

				model.addAttribute("errorMsg", "회원가입 실패");
				return "common/errorPage";

			}
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
