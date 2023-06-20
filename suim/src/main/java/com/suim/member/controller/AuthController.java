package com.suim.member.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.CompletableFuture;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.suim.common.api.NaverLoginBO;
import com.suim.common.config.CustomHttpSessionListener;
import com.suim.common.mail.MailHandler;
import com.suim.common.mail.TempKey;
import com.suim.common.main.controller.MainController;
import com.suim.common.model.vo.GoogleOAuthRequest;
import com.suim.common.socket.EchoHandler;
import com.suim.member.model.service.MemberService;
import com.suim.member.model.vo.Email;
import com.suim.member.model.vo.GoogleSignUp;
import com.suim.member.model.vo.Member;
import com.suim.member.model.vo.SignUp;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("member")
@Slf4j
public class AuthController {

	private final MemberService memberService;
	private final BCryptPasswordEncoder bcryptPasswordEncoder;
	private final JavaMailSender mailSender;
	private final NaverLoginBO naverLoginBO;
	private final HttpSession session;
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private EchoHandler echoHandler;

	@Autowired
	public AuthController(MemberService memberService, BCryptPasswordEncoder bcryptPasswordEncoder,
			JavaMailSender mailSender, NaverLoginBO naverLoginBO, HttpSession session) {
		this.memberService = memberService;
		this.bcryptPasswordEncoder = bcryptPasswordEncoder;
		this.mailSender = mailSender;
		this.naverLoginBO = naverLoginBO;
		this.session = session;
	}

	// 회원가입 페이지 이동
	@RequestMapping("join")
	public String signUp(Model theModel, String agree1, String agree2) {

		if (agree1 == null || agree2 == null) {
			session.setAttribute("toastError", "동의약관을 진행해야합니다.");
			return "redirect:/member/term";
		}

		if (agree1.equals(agree2)) {
			theModel.addAttribute("member", new SignUp());
			return "member/signup";
		} else {
			session.setAttribute("toastError", "동의약관을 진행해야합니다.");
			return "redirect:/member/term";
		}

	}

	@ResponseBody
	@RequestMapping(value = "idCheck", produces = "text/html; charset=UTF-8")
	public String idCheck(@RequestParam("id") String checkId) {
		return checkDuplicate("id", checkId);
	}

	@ResponseBody
	@RequestMapping(value = "emailCheck", produces = "text/html; charset=UTF-8")
	public String emailCheck(String email) {
		return checkDuplicate("email", email);
	}

	@ResponseBody
	@RequestMapping(value = "phoneCheck", produces = "text/html; charset=UTF-8")
	public String phoneCheck(String phone) {
		return checkDuplicate("phone", phone);
	}

	// 회원가입 성공
	@RequestMapping("joinSuccess")
	public String insertMember(@Valid @ModelAttribute("member") SignUp member, BindingResult bindingResult, Model model)
			throws Exception {

		if (bindingResult.hasErrors()) {
			return "member/signup";
		}

		if (checkDuplicate("id", member.getMemberId()).equals("Duplicate")) {
			session.setAttribute("toastError", "중복된 아이디가 존재합니다.");
			return "member/signup";
		}

		if (checkDuplicate("email", member.getEmail()).equals("Duplicate")) {
			session.setAttribute("toastError", "중복된 이메일이 존재합니다.");
			return "member/signup";
		}

		if (checkDuplicate("phone", member.getPhone()).equals("Duplicate")) {
			session.setAttribute("toastError", "중복된 번호가 존재합니다.");
			return "member/signup";
		}

		String nickName = generateUniqueNickname();
		String encPwd = bcryptPasswordEncoder.encode(member.getMemberPwd());

		member.setNickName(nickName);
		member.setMemberPwd(encPwd);

		if (member.getArea() != null || !member.getArea().equals("")) {
			double[] area = MainController.getCoordinates(member.getArea());
			if (area != null) {
				member.setLongitude(area[0]);
				member.setLatitude(area[1]);
			}
		}

		int result = memberService.insertMember(member);
		String mailKey = new TempKey().getKey(30, false);
		Email email = new Email(mailKey, member.getEmail());
		int result2 = memberService.insertEmail(email);
		int result3 = memberService.setEmailCode(email);

		CompletableFuture.runAsync(() -> {
			try {
				mailSendAsync(mailKey, member.getEmail());
			} catch (Exception e) {
				log.error("메일 전송 중 에러 발생: {}", e.getMessage());
			}
		});

		session.setAttribute("toastSuccess", "성공적으로 회원가입이 되었습니다.");
		session.setAttribute("verifyPage", "이메일 인증");
		return "redirect:/member/verifyPage";
	}

	// 로그인 페이징
	@RequestMapping(value = "login", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		// 네이버
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();

		OAuth2Parameters googleOAuth2Parameters = new OAuth2Parameters();
		googleOAuth2Parameters.setRedirectUri("http://localhost:8006/member/loginGoogle");
		googleOAuth2Parameters.setScope("openid email profile"); // Modify the scope as required

		String googleUrl = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);

		model.addAttribute("google_url", googleUrl);
		model.addAttribute("naver_url", naverAuthUrl);
		return "member/login";
	}

	// 일반 로그인
	@PostMapping("doLogin")
	public String loginMember(Member m, HttpSession session, Model model, HttpServletResponse response, String saveId,
	        HttpServletRequest request) {
	    Member loginUser = memberService.loginMember(m);

	    if (loginUser == null) {
	        session.setAttribute("toastError", "로그인 할 수 없는 계정입니다.");
	        return "redirect:/member/login";
	    }

	    if (bcryptPasswordEncoder.matches(m.getMemberPwd(), loginUser.getMemberPwd())) {

	        int result = memberService.checkEmailLogin(loginUser.getEmail());
	        if (result > 0) {
	            String memberId = loginUser.getMemberId();
	            String sessionIdToInvalidate = CustomHttpSessionListener.getSessionIdForUser(memberId);

	            if (sessionIdToInvalidate != null) {
	                // Retrieve the previous session
	                HttpSession previousSession = CustomHttpSessionListener.getSessionById(sessionIdToInvalidate);

	                if (previousSession != null) {
	                    // Send message to the previous user
	                    String message = "다중 로그인이 감지되어 로그아웃 됩니다.";
	                    echoHandler.broadcastMessage(memberId, message);
	                    log.info("메세지 보냄");

	                    // Invalidate the previous session
	                    previousSession.invalidate();
	                    CustomHttpSessionListener.expireSession(sessionIdToInvalidate);
	                }
	            }

	            // Record the previous session for the logged-in user
	            CustomHttpSessionListener.recordPreviousSession(memberId, session.getId());

	            // Create a new session for the logged-in user
	            session.invalidate();
	            session = request.getSession(true);
	        }

	        if (saveId != null && saveId.equals("y")) {
	            Cookie cookie = new Cookie("saveId", m.getMemberId());
	            cookie.setMaxAge(24 * 60 * 60 * 1); // 유효기간 1일 (초단위)
	            response.addCookie(cookie);
	        } else {
	            Cookie cookie = new Cookie("saveId", m.getMemberId());
	            cookie.setMaxAge(0);
	            response.addCookie(cookie);
	        }

	        // Set session attributes and perform any necessary actions
	        session.setAttribute("loginUser", loginUser);
	        session.setAttribute("toastSuccess", "로그인에 성공했습니다.");
	        memberService.updateLoginDate(loginUser.getMemberId());

	        return "redirect:/";
	    } else {
	        session.setAttribute("toastError", "비밀번호를 확인해주세요.");
	        return "redirect:/member/login";
	    }
	}


	// 메일 전송됐다고 알려지는 창
	@RequestMapping("verifyPage")
	public String verifyPage() {
		if (session.getAttribute("verifyPage") == null) {
			return "redirect:/";
		}

		session.removeAttribute("verifyPage");
		return "member/sign-success";
	}

	@GetMapping("verifySuccess")
	public String verifySuccess() {

		if (session.getAttribute("verifySuccess") == null) {
			return "redirect:/";
		}

		session.setAttribute("toastSuccess", "이메일 인증이 완료됐습니다.");
		session.removeAttribute("verifySuccess");
		return "/member/verifySuccess";
	}

	// 이메일 링크
	@GetMapping("verifyEmail")
	public String verifyEmail(String email, String mailKey) {
		if (email == null || mailKey == null) {
			return "redirect:/";
		}

		int result = memberService.updateEmail(new Email(mailKey, email));

		if (result > 0) {
			session.setAttribute("verifySuccess", "이메일 인증 성공");
			return "redirect:/member/verifySuccess";
		} else {
			session.setAttribute("toastError", "오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
			return "redirect:/member/login";
		}

	}

	// 네이버 로그인
	@RequestMapping(value = "loginNaver", method = { RequestMethod.GET, RequestMethod.POST })
	public String userNaverLoginPro(Model model, @RequestParam Map<String, Object> paramMap, @RequestParam String code,
			@RequestParam String state, HttpSession session) throws Exception {
		OAuth2AccessToken oauthToken = naverLoginBO.getAccessToken(session, code, state);
		String apiResult = naverLoginBO.getUserProfile(oauthToken);

		ObjectMapper objectMapper = new ObjectMapper();
		Map<String, Object> apiJson = objectMapper.readValue(apiResult, new TypeReference<Map<String, Object>>() {
		});
		Map<String, Object> response = (Map<String, Object>) apiJson.get("response");

		String email = (String) response.get("email");

		Map<String, Object> naverConnectionCheck = memberService.naverConnectionCheck(email);
		String mailKey = new TempKey().getKey(30, false);
		Email sendEmail = new Email(mailKey, email);

		// 네이버 계정이 없다 => 회원가입
		if (naverConnectionCheck == null) {
			Member m = createNewMemberFromNaverAPI(response);
			int result = memberService.insertApiMember(m);
			if (result > 0) {
				int result2 = memberService.insertEmail(sendEmail);
				int result3 = memberService.setEmailCode(sendEmail);

				CompletableFuture<Void> emailTask = mailSendAsync(mailKey, email);

				session.setAttribute("toastSuccess", "성공적으로 회원가입이 되었습니다.");
				session.setAttribute("verifyPage", "이메일 인증");
				return "redirect:/member/verifyPage";
			} else {
				session.setAttribute("toastError", "오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
				return "redirect:/member/login";
			}
		} else {
			memberService.setNaverConnection(response);
			Member loginUser = memberService.userNaverLoginPro(response);
			if (loginUser == null) {
				session.setAttribute("toastError", "탈퇴되거나 블랙리스트 처리된 계정입니다.");
				return "redirect:/";
			}
			session.setAttribute("loginUser", loginUser);

			int result = memberService.checkEmailLogin(loginUser.getEmail());

			if (result > 0) {

				session.setAttribute("toastSuccess", "로그인에 성공했습니다.");
				session.setAttribute("loginUser", loginUser);
				memberService.updateLoginDate(loginUser.getMemberId());

				return "redirect:/";

			} else {
				session.setAttribute("toastError", "아이디 인증이 되지 않았습니다");

				int result3 = memberService.setEmailCode(sendEmail);
				CompletableFuture<Void> emailTask = mailSendAsync(mailKey, email);
				session.setAttribute("emailPage", "이메일 인증");
				return "redirect:/member/verifyPage";
			}
		}
	}

	@RequestMapping(value = "loginGoogle", method = { RequestMethod.GET, RequestMethod.POST })
	public String oauth_google(@RequestParam(value = "code") String authCode, Model model,
			RedirectAttributes redirectAttributes) throws Exception {
		// RestTemplate 호출
		RestTemplate restTemplate = new RestTemplate();

		GoogleOAuthRequest googleOAuthRequestParam = GoogleOAuthRequest.builder()
				.clientId("973249404961-glcrhac5dh3lall32j4fdgcti4qemf4d.apps.googleusercontent.com")
				.clientSecret("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").code(authCode)
				.redirectUri("http://localhost:8006/member/loginGoogle").grantType("authorization_code").build();

		ResponseEntity<JSONObject> apiResponse = restTemplate.postForEntity("https://oauth2.googleapis.com/token",
				googleOAuthRequestParam, JSONObject.class);
		JSONObject responseBody = apiResponse.getBody();

		// id_token은 jwt 형식
		String jwtToken = (String) responseBody.get("id_token");
		String requestUrl = "https://oauth2.googleapis.com/tokeninfo?id_token=" + jwtToken;
		ResponseEntity<JSONObject> resultResponse = restTemplate.getForEntity(requestUrl, JSONObject.class);
		JSONObject resultJson = resultResponse.getBody();

		String googleNo = (String) resultJson.get("sub");
		String email = (String) resultJson.get("email");
		Member m = new Member();

		String mailKey = new TempKey().getKey(30, false);
		Email sendEmail = new Email(mailKey, email);

		int randomNumber = new Random().nextInt(1000000);
		String naverID = "google" + String.format("%05d", randomNumber);

		String name = (String) resultJson.get("name");
		String changeName = (String) resultJson.get("picture");
		String nickName = randomNickName();

		m.setMemberId(naverID);
		m.setEmail(email);
		m.setMemberName(name);
		m.setChangeName((String) resultJson.get("picture"));
		m.setNickName(nickName);
		m.setGoogleLogin(googleNo);

		int result1 = memberService.googleConnectionCheck(email);

		if (result1 > 0) {
			int result2 = memberService.setGoogleConnection(m);
			Member loginUser = memberService.userGoogleoginPro(m);
			if (loginUser == null) {
				session.setAttribute("toastError", "탈퇴되거나 블랙리스트 처리된 계정입니다.");
				return "redirect:/";
			}

			session.setAttribute("loginUser", loginUser);

			int result = memberService.checkEmailLogin(loginUser.getEmail());

			if (result > 0) {
				session.setAttribute("toastSuccess", "로그인에 성공했습니다.");
				session.setAttribute("loginUser", loginUser);
				memberService.updateLoginDate(loginUser.getMemberId());
				return "redirect:/";
			} else {
				session.setAttribute("toastError", "이메일 인증이 되지 않았습니다");
				int result3 = memberService.setEmailCode(sendEmail);
				CompletableFuture<Void> emailTask = mailSendAsync(mailKey, email);
				session.setAttribute("emailPage", "이메일 인증");
				return "redirect:/member/verifyPage";
			}
		} else { // 이메일이 일치하는 사람이없다 = 회원가입 유도
			// 부가 요구사항 작성 후 회원가입 되게 유도하기
			session.setAttribute("toastSuccess", "회원가입에 필요한 정보를 입력해야합니다.");

			session.setAttribute("googleMember",
					new GoogleSignUp(naverID, name, nickName, email, changeName, googleNo));
			session.setAttribute("joinGoogle", "구글 회원가입");
			return "redirect:/member/joinGoogle";
		}
	}

	@GetMapping("joinGoogle")
	public String joinGooglePage(Model model) {

		if (session.getAttribute("joinGoogle") == null || session.getAttribute("googleMember") == null) {
			session.setAttribute("alertMsg", "접근할 수 없는 페이지입니다.");
			return "redirect:/";
		}

		model.addAttribute("member", (GoogleSignUp) session.getAttribute("googleMember"));
		return "/member/google-signup";
	}

	// 회원가입 성공
	@PostMapping("joinGoogle")
	public String insertGoogleMember(@Valid @ModelAttribute("member") SignUp member, BindingResult bindingResult,
			Model model) throws Exception {

		if (bindingResult.hasErrors()) {
			return "member/google-signup";
		}

		if (checkDuplicate("id", member.getMemberId()).equals("Duplicate")) {
			session.setAttribute("toastError", "중복된 아이디가 존재합니다.");
			return "member/google-signup";
		}

		if (checkDuplicate("email", member.getEmail()).equals("Duplicate")) {
			session.setAttribute("toastError", "중복된 이메일이 존재합니다.");
			return "member/google-signup";
		}

		if (checkDuplicate("phone", member.getPhone()).equals("Duplicate")) {
			session.setAttribute("toastError", "중복된 번호가 존재합니다.");
			return "member/google-signup";
		}

		String nickName = generateUniqueNickname();
		String encPwd = bcryptPasswordEncoder.encode(member.getMemberPwd());

		member.setNickName(nickName);
		member.setMemberPwd(encPwd);

		if (member.getArea() != null && !member.getArea().equals("")) {
			double[] area = MainController.getCoordinates(member.getArea());
			if (area != null) {
				member.setLongitude(area[0]);
				member.setLatitude(area[1]);
			}
		}

		int result = memberService.insertMember(member);
		String mailKey = new TempKey().getKey(30, false);
		Email email = new Email(mailKey, member.getEmail());
		int result2 = memberService.insertEmail(email);
		int result3 = memberService.setEmailCode(email);

		CompletableFuture.runAsync(() -> {
			try {
				mailSendAsync(mailKey, member.getEmail());
			} catch (Exception e) {
				log.error("메일 전송 중 에러 발생: {}", e.getMessage());
			}
		});

		session.removeAttribute("googleMember");
		session.removeAttribute("joinGoogle");
		session.setAttribute("toastSuccess", "성공적으로 회원가입이 되었습니다.");
		session.setAttribute("verifyPage", "이메일 인증");
		return "redirect:/member/verifyPage";
	}

	@PostMapping("logout")
	public String logoutMember(HttpSession session) {
		Member m = (Member) session.getAttribute("loginUser");
		if (m == null) {
			return "redirect:/";
		}
		memberService.updateLoginDate(m.getMemberId());

		session.removeAttribute("loginUser");
		return "redirect:/";
	}

	// 아이디 찾기 이동
	@GetMapping("findId")
	public String findMemberId() {
		return "/member/find-id";
	}

	@PostMapping("findId")
	@ResponseBody
	public String findMemberId(Member m) {

		String memberId = memberService.findMemberId(m);
		return memberId;
	}

	@GetMapping("findPw")
	public String findMemberPw() {
		return "/member/find-pw";
	}

	@PostMapping("findPw")
	@ResponseBody
	public int findMemberPw(Member m) {
		int result = memberService.findMemberPw(m);
		if (result > 0) {
			mailSendAsync(m);
		}
		return result;
	}

	@GetMapping("term")
	public String joinTerm() {
		return "/member/term";
	}

	// Auth 관련 메소드들

	private String generateUniqueNickname() throws IOException {
		String nickname = randomNickName();
		int nicknameCount = memberService.nickCheck(nickname);

		if (nicknameCount > 1) {
			return generateUniqueNickname();
		}

		return nickname;
	}

	// 랜덤 닉네임 url 호출
	private String randomNickName() throws IOException {
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

	private Member createNewMemberFromNaverAPI(Map<String, Object> response) throws IOException {
		Member m = new Member();
		Random random = new Random();
		int randomNumber = random.nextInt(1000000);
		String naverID = "naver" + String.format("%05d", randomNumber);

		m.setMemberId(naverID);
		m.setEmail((String) response.get("email"));
		m.setMemberPwd(bcryptPasswordEncoder.encode((String) response.get("email")));
		m.setMemberName((String) response.get("name"));
		m.setPhone(((String) response.get("mobile")).replace("-", ""));
		String birthday = (String) response.get("birthyear") + ((String) response.get("birthday")).replace("-", "");
		m.setBirth(birthday);
		m.setGender((String) response.get("gender"));
		m.setNickName(generateUniqueNickname());

		return m;

	}

	private CompletableFuture<Void> mailSendAsync(String mailKey, String email) {

		return CompletableFuture.runAsync(() -> {
			try {
				MailHandler sendMail = new MailHandler(mailSender);
				sendMail.setText("<h1>쉐어하우스 쉼 메일인증</h1>" + "<br>쉼(SUIM)에 오신 것을 환영합니다!" + "<br>아래 [이메일 인증 확인]을 눌러주세요."
						+ "<br><a href='http://localhost:8006/member/verifyEmail?email=" + email + "&mailKey=" + mailKey
						+ "' target='_blank'>이메일 인증 확인</a>");
				sendMail.setFrom("suimm012@gmail.com", "쉼");
				sendMail.setSubject("쉼 이메일 인증번호입니다");
				sendMail.setTo(email);
				sendMail.send();
			} catch (MessagingException e) {
				log.error("메일 전송 중 에러 발생: {}", e.getMessage());
			} catch (Exception e) {
				log.error("기타 에러 발생: {}", e.getMessage());
			}
		});
	}

	private CompletableFuture<Void> mailSendAsync(Member m) {

		return CompletableFuture.runAsync(() -> {
			try {
				MailHandler sendMail = new MailHandler(mailSender);

				sendMail.setFrom("suimm012@gmail.com", "쉼");
				sendMail.setSubject("쉼 임시 비밀번호 발급입니다");
				sendMail.setTo(m.getEmail());

				String temporaryPassword = generateTemporaryPassword();
				sendMail.setText("<h1>쉐어하우스 쉼 비밀번호찾기</h1>" + "<p>임시 비밀번호: " + temporaryPassword + "</p>"
						+ "<p>임시 비밀번호로 로그인 후 바로 비밀번호를 변경해주세요</p>");
				m.setMemberPwd(bcryptPasswordEncoder.encode(temporaryPassword));
				memberService.updateMember(m);
				sendMail.send();
			} catch (MessagingException e) {
				log.error("메일 전송 중 에러 발생: {}", e.getMessage());
			} catch (Exception e) {
				log.error("기타 에러 발생: {}", e.getMessage());
			}
		});
	}

	private String generateTemporaryPassword() {
		int length = 8;

		// 임시 비밀번호 문자열을 구성할 문자들
		String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

		// 임시 비밀번호 문자열 생성
		StringBuilder password = new StringBuilder();
		Random random = new Random();

		for (int i = 0; i < length; i++) {
			int index = random.nextInt(characters.length());
			char character = characters.charAt(index);
			password.append(character);
		}

		return password.toString();
	}

	private String checkDuplicate(String field, String value) {
		int count = 0;

		switch (field) {
		case "id":
			count = memberService.idCheck(value);
			break;
		case "email":
			count = memberService.emailCheck(value);
			break;
		case "phone":
			count = memberService.phoneCheck(value);
			break;

		}
		return (count > 0) ? "Duplicate" : "Available";

	}

}
