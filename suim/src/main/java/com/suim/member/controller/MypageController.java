package com.suim.member.controller;

import java.io.File;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.suim.member.model.service.MemberService;
import com.suim.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("mypage")
@Slf4j
public class MypageController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
    private HttpSession session;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;

	// 처음 페이지(알림 페이지)로 이동합니다.
	@RequestMapping("timeline")
	public String mypageAlert(HttpServletRequest request) {
		session.setAttribute("originalUrl", request.getRequestURI());
		return "member/mypage/timeline";
	}

	// 마이페이지의 내 게시글 조회로 이동합니다.
	@RequestMapping("post")
	public String mypageBoard(HttpServletRequest request) {
		session.setAttribute("originalUrl", request.getRequestURI());
		return "member/mypage/post";
	}

	// 마이페이지의 내 찜목록 조회로 이동합니다.
	@RequestMapping("wish")
	public String mypageWish(HttpServletRequest request) {
		session.setAttribute("originalUrl", request.getRequestURI());
		return "member/mypage/wish";
	}

	// 마이페이지의 내 셰어하우스 조회로 이동합니다.
	@RequestMapping("house")
	public String mypageHouse(HttpServletRequest request) {
		session.setAttribute("originalUrl", request.getRequestURI());
		return "member/mypage/house";
	}

	// 마이페이지의 내 예약내역 조회로 이동합니다.
	@RequestMapping("reservation")
	public String mypageReservation(HttpServletRequest request) {
		session.setAttribute("originalUrl", request.getRequestURI());
		return "member/mypage/reservation";
	}

	// 마이페이지의 내 정보 조회로 이동합니다.
	@RequestMapping("profile")
	public String mypageProfile(HttpServletRequest request) {
		session.setAttribute("originalUrl", request.getRequestURI());
		return "member/mypage/profile";
	}
	
	
	// 사용자 정보 수정 메소드
	@PostMapping("updateProfile")
	public String updateProfile(@RequestParam("file") MultipartFile file, Member m, String changePwd1, String changePwd2, 
			HttpServletRequest request, Model model) {
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		
		
		if (bcryptPasswordEncoder.matches(m.getMemberPwd(), loginUser.getMemberPwd()) || m.getMemberPwd().equals(loginUser.getMemberPwd())) {
			log.info("패스워드가 일치함");
			
			// 비밀번호가 일치하고, 파일이 비어있지 않음
			if (!file.isEmpty()) {
				
				try {
					
					String originalFilename = StringUtils.cleanPath(file.getOriginalFilename());
	                String fileName = new Date().getTime() + "-" + originalFilename;

	                // 파일 용량 체크 (5MB 제한)
	                if (file.getSize() > 5 * 1024 * 1024) {
	                    // 용량 초과 처리
	                	model.addAttribute("errorMsg", "회원가입 실패");
	    				return "common/errorPage";
	                }

	                // 파일 저장 경로
	                String uploadDir = session.getServletContext().getRealPath("/resources/uploadFiles/");

	                // 디렉토리 생성
	                File uploadDirFile = new File(uploadDir);
	                if (!uploadDirFile.exists()) {
	                    uploadDirFile.mkdirs();
	                }

	                // 파일 저장
	                String filePath = uploadDir + fileName;
	                File dest = new File(filePath);
	                file.transferTo(dest);
	                
	                
	                log.info(filePath);
	                m.setChangeName(filePath);
					
					
				} catch (Exception e) {
					e.printStackTrace();
				}	
			}
			
			// 비밀번호 변경을 할수도 있고 안할수도 있기 때문에 조건 걸어준다
			// 비밀번호가 null이 아니고, 비밀번호가 
			if (changePwd1 != null && !changePwd1.trim().isEmpty() && changePwd2 != null && !changePwd2.trim().isEmpty()) {
			   
				// 만약 변경비밀번호1과 변경비밀번호2가 같다면? => 일치하므로 changePwd1을 암호화하여 updte 해준다
				if(changePwd1.equals(changePwd2)) {
					log.info("비밀번호 변경 로직 시작");
					m.setMemberPwd(bcryptPasswordEncoder.encode(changePwd1));
				}
			}
			int result = memberService.updateMember(m);
			
			session.setAttribute("loginUser", m);
			
			if(result > 0) {
				log.info("정보 변경 성공");
			} else {
				log.info("정보 변경 실패");
			}
		}
		
		log.info("넘어옴");
		
		return "redirect:" + (String) session.getAttribute("originalUrl");
	}
	


}
