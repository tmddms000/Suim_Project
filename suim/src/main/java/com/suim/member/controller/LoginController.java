package com.suim.member.controller;


import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.suim.common.api.NaverLoginBO;
import com.suim.member.model.service.MemberService;
import com.suim.member.model.vo.Member;
 
/**
 * Handles requests for the application home page.
 */
@Controller
public class LoginController {
 
	/* NaverLoginBO */
	
	@Autowired
	private NaverLoginBO naverLoginBO;
	
	@Autowired
	private MemberService memberService;
	
	private String apiResult = null;
	
 
	//로그인 첫 화면 요청 메소드
	@RequestMapping(value = "/member/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {
		
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		
		//https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		//redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		
		//네이버 
		model.addAttribute("url", naverAuthUrl);
 
		return "/member/login";
	}
 
	@RequestMapping(value="/member/loginNaver",  method = {RequestMethod.GET,RequestMethod.POST})
	public String userNaverLoginPro(Model model,@RequestParam Map<String,Object> paramMap, @RequestParam String code, @RequestParam String state,HttpSession session) throws SQLException, Exception {
		Map <String, Object> resultMap = new HashMap<String, Object>();

		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		//로그인 사용자 정보를 읽어온다.
		String apiResult = naverLoginBO.getUserProfile(oauthToken);
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		Map<String, Object> apiJson = (Map<String, Object>) objectMapper.readValue(apiResult, Map.class).get("response");
		
		System.out.println(apiJson);
		
		String email = (String) apiJson.get("email");
//		
		Map<String, Object> naverConnectionCheck = memberService.naverConnectionCheck(email);
		
		System.out.println(naverConnectionCheck);
//		
		if(naverConnectionCheck == null) { //일치하는 이메일 없으면 가입
//			
			Member m = new Member();
			m.setEmail((String)apiJson.get("email"));
			m.setMemberPwd((String)apiJson.get("id"));
			m.setMemberName((String)apiJson.get("name"));
			m.setPhone((String)apiJson.get("mobile"));
			String birthday = (String) apiJson.get("birthyear") + ((String)apiJson.get("birthday")).replace("-", "");
			m.setBirth(birthday);
			m.setGender((String) apiJson.get("gender"));
			m.setNickName(new MemberController().generateUniqueNickname());
			
			
			//회원가입 되는걸로 유도하고 insert문 넣기
			return "user/setNickname";
			
		}else if(naverConnectionCheck.get("NAVERLOGIN") == null && naverConnectionCheck.get("EMAIL") != null) { //이메일 가입 되어있고 네이버 연동 안되어 있을시
			memberService.setNaverConnection(apiJson);
			
			Map<String, Object> loginUser = memberService.userNaverLoginPro(apiJson);
			session.setAttribute("loginUser", loginUser);
		}else { //모두 연동 되어있을시
			Map<String, Object> loginUser = memberService.userNaverLoginPro(apiJson);
			session.setAttribute("loginUser", loginUser);
		}

		return "redirect:/";
	}
	

	//로그아웃
	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logout(HttpSession session)throws IOException {
			System.out.println("여기는 logout");
			session.invalidate();
 
	        
			return "/";
		}
	
}