package com.suim.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.SQLException;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.suim.common.api.NaverLoginBO;
import com.suim.member.model.service.MemberService;
import com.suim.member.model.vo.Member;
import com.suim.member.model.vo.SignUp;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("member")
@Slf4j
public class AuthController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private NaverLoginBO naverLoginBO;
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	// 회원가입 페이지 이동
	@RequestMapping("join")
	public String signUp(Model theModel) {

		theModel.addAttribute("member", new SignUp());
		return ("member/signup");
	}

	// 회원가입 아이디 체크
	@ResponseBody
	@RequestMapping(value = "idCheck", produces = "text/html; charset=UTF-8")
	public String idCheck(@RequestParam("id") String checkId) {

		int count = memberService.idCheck(checkId);

		return (count > 0) ? "Duplicate" : "Available";

	}

	// 회원가입 이메일 체크
	@ResponseBody
	@RequestMapping(value = "emailCheck", produces = "text/html; charset=UTF-8")
	public String emailCheck(String email) {

		int count = memberService.emailCheck(email);

		return (count > 0) ? "Duplicate" : "Available";

	}

	// 회원가입 핸드폰 체크
	@ResponseBody
	@RequestMapping(value = "phoneCheck", produces = "text/html; charset=UTF-8")
	public String phoneCheck(String phone) {

		int count = memberService.phoneCheck(phone);

		return (count > 0) ? "Duplicate" : "Available";

	}

	// 회원가입 성공
	@RequestMapping("joinSuccess")
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

	// 로그인 페이징
	@RequestMapping(value = "login", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {

		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

		// https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		// redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125

		// 네이버
		model.addAttribute("url", naverAuthUrl);

		return "/member/login";
	}

	// 일반 로그인
	@PostMapping("doLogin")
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

	// 네이버 로그인
	@RequestMapping(value = "loginNaver", method = { RequestMethod.GET, RequestMethod.POST })
	public String userNaverLoginPro(Model model, @RequestParam Map<String, Object> paramMap, @RequestParam String code,
			@RequestParam String state, HttpSession session) throws SQLException, Exception {

		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);

		String apiResult = naverLoginBO.getUserProfile(oauthToken);

		ObjectMapper objectMapper = new ObjectMapper();

		Map<String, Object> apiJson = (Map<String, Object>) objectMapper.readValue(apiResult, Map.class)
				.get("response");

		String email = (String) apiJson.get("email");

		Map<String, Object> naverConnectionCheck = memberService.naverConnectionCheck(email);

		if (naverConnectionCheck == null) { // 일치하는 이메일 없으면 가입

			Member m = new Member();

			Random random = new Random();
			int randomNumber = random.nextInt(100000); // 0부터 99999까지의 랜덤 숫자 생성

			String naverID = "naver" + String.format("%05d", randomNumber); // 5자리 숫자로 포맷팅
			
			System.out.println(apiJson);
			
			m.setMemberId(naverID);
			m.setEmail((String) apiJson.get("email"));
			m.setMemberPwd(bcryptPasswordEncoder.encode((String) apiJson.get("email")));
			m.setMemberName((String) apiJson.get("name"));
			m.setPhone((String) apiJson.get("mobile"));
			String birthday = (String) apiJson.get("birthyear") + ((String) apiJson.get("birthday")).replace("-", "");
			m.setBirth(birthday);
			m.setGender((String) apiJson.get("gender"));
			m.setNickName(generateUniqueNickname());
			
			

			int result = memberService.insertApiMember(m);
			if (result > 0) {
				session.setAttribute("alertMsg", "회원가입에 성공했습니다.");
				return "redirect:/";
			} else {
				session.setAttribute("alertMsg", "오류가 발생했습니다. 잠시 후 시도해주세요.");
				return "redirect:/";
			}

		} else if (naverConnectionCheck.get("NAVERLOGIN") == null && naverConnectionCheck.get("EMAIL") != null) {

			memberService.setNaverConnection(apiJson);
			
			System.out.println(apiJson);

			Member loginUser = memberService.userNaverLoginPro(apiJson);
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "로그인에 성공했습니다.");
		} else {
			Member loginUser = memberService.userNaverLoginPro(apiJson);
			session.setAttribute("loginUser", loginUser);
			session.setAttribute("alertMsg", "로그인에 성공했습니다.");
		}

		return "redirect:/";
	}

	// 로그아웃
	@PostMapping("logout")
	public String logoutMember(HttpSession session) {

		session.setAttribute("alertMsg", "로그아웃 되었습니다.");
		session.removeAttribute("loginUser");
		return "redirect:/";

	}

	// 닉네임 존재하면 반복하여 닉 생성
	public String generateUniqueNickname() throws IOException {
		String nickname = randomNickName();
		int nicknameCount = memberService.nickCheck(nickname);

		if (nicknameCount > 1) {
			System.out.println("닉네임 " + nickname + " 이미 존재하는 닉네임입니다.");
			return generateUniqueNickname();
		}

		return nickname;
	}

	// 랜덤 닉네임 url 호출
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
