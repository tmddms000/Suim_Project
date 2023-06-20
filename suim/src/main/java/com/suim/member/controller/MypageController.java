package com.suim.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.suim.board.model.vo.Board;
import com.suim.common.main.controller.MainController;
import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;
import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Reservation;
import com.suim.member.model.service.MemberService;
import com.suim.member.model.service.MypageService;
import com.suim.member.model.vo.Member;
import com.suim.member.model.vo.MyWish;
import com.suim.pay.model.vo.Pay;

@Controller
@RequestMapping("mypage")
public class MypageController {

	private final MemberService memberService;
	private final MypageService mypageService;
	private final HttpSession session;
	private final BCryptPasswordEncoder bcryptPasswordEncoder;
	private final JavaMailSender mailSender;

	@Autowired
	public MypageController(MemberService memberService, MypageService mypageService, HttpSession session,
			BCryptPasswordEncoder bcryptPasswordEncoder, JavaMailSender mailSender) {
		this.mailSender = mailSender;
		this.memberService = memberService;
		this.mypageService = mypageService;
		this.session = session;
		this.bcryptPasswordEncoder = bcryptPasswordEncoder;
	}
	
	// 사용자 정보 수정 메소드
	@PostMapping("/updateProfile")
	public String updateProfile(@RequestParam("file") MultipartFile file, Member m, String changePwd1,
			String changePwd2, HttpServletRequest request, Model model) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser == null) {
			session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
			return "redirect:/member/login";
		}

		if (m.getMemberId() == null || m.getMemberId().trim().isEmpty()) {
			session.setAttribute("toastError", "아이디는 반드시 입력해야합니다.");
			return "redirect:" + session.getAttribute("originalUrl");
		} else if (!m.getMemberId().equals(loginUser.getMemberId())) {
			session.setAttribute("toastError", "아이디는 수정할 수 없습니다.");
			return "redirect:" + session.getAttribute("originalUrl");
		}

		if (m.getEmail() == null || m.getEmail().trim().isEmpty()) {
			session.setAttribute("toastError", "이메일은 반드시 입력해야합니다.");
			return "redirect:" + session.getAttribute("originalUrl");
		} else if (!m.getEmail().equals(loginUser.getEmail())) {
			session.setAttribute("toastError", "이메일은 수정할 수 없습니다.");
			return "redirect:" + session.getAttribute("originalUrl");
		}

		if (m.getMemberName() == null || m.getMemberName().trim().isEmpty()) {
			session.setAttribute("toastError", "이름은 반드시 입력해야합니다.");
			return "redirect:" + session.getAttribute("originalUrl");
		}

		if (m.getBirth() == null || m.getBirth().trim().isEmpty()) {
			session.setAttribute("toastError", "생년월일은 반드시 입력해야합니다.");
			return "redirect:" + session.getAttribute("originalUrl");
		}

		if (memberService.nickCheck(m.getNickName()) > 0 && !loginUser.getNickName().equals(m.getNickName())) {
			session.setAttribute("toastError", "현재 사용중이거나 중복된 닉네임입니다.");
			return "redirect:" + session.getAttribute("originalUrl");
		}
		
		if(!Pattern.matches("^(?!\\s)(.{1,6})$", m.getNickName())) {
			session.setAttribute("toastError", "닉네임은 공백포함 6글자 이하로 해야합니다.");
			return "redirect:" + session.getAttribute("originalUrl");
		}

		if (bcryptPasswordEncoder.matches(m.getMemberPwd(), loginUser.getMemberPwd())) {
			m.setMemberPwd(bcryptPasswordEncoder.encode(m.getMemberPwd()));

			if (!file.getOriginalFilename().isEmpty()) {
				String changeName = saveFile(file);
				m.setChangeName(changeName);
			} else {
				m.setChangeName(loginUser.getChangeName());
			}

			if (changePwd1 != null && !changePwd1.trim().isEmpty()) {
				if (!changePwd1.equals(changePwd2)) {
					session.setAttribute("toastError", "변경확인 비밀번호가 일치하지 않습니다.");
					return "redirect:" + session.getAttribute("originalUrl");
				}
				if (changePwd2 == null || changePwd2.trim().isEmpty()) {
					session.setAttribute("toastError", "변경확인 비밀번호를 입력해주세요.");
					return "redirect:" + session.getAttribute("originalUrl");
				}
				m.setMemberPwd(bcryptPasswordEncoder.encode(changePwd1));
			} else if (changePwd2 != null && !changePwd2.trim().isEmpty()) {
				if (changePwd1 == null || changePwd1.trim().isEmpty()) {
					session.setAttribute("toastError", "변경 비밀번호를 입력해주세요.");
					return "redirect:" + session.getAttribute("originalUrl");
				}
			}
			
			
			if(m.getArea() != null && !m.getArea().equals("")) {
				double[] area = MainController.getCoordinates(m.getArea());
				if(area != null) {
				m.setLongitude(area[0]);
				m.setLatitude(area[1]);
				}
			}

			int result = memberService.updateMember(m);
			session.setAttribute("loginUser", m);

			if (result > 0) {
				session.setAttribute("toastSuccess", "프로필 변경 완료");
			} else {
				session.setAttribute("toastError", "프로필 변경 실패");
			}
		} else {
			session.setAttribute("toastError", "비밀번호가 일치하지 않습니다.");
		}

		return "redirect:" + session.getAttribute("originalUrl");
	}

	private String saveFile(MultipartFile file) {
		String originName = file.getOriginalFilename();
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		int ranNum = (int) (Math.random() * 90000 + 10000);
		String ext = originName.substring(originName.lastIndexOf("."));
		String changeName = currentTime + ranNum + ext;
		String savePath = session.getServletContext().getRealPath("/resources/img/member/uploadFiles/");

		try {
			String filePath = savePath + changeName;
			File dest = new File(filePath);
			file.transferTo(dest);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "/resources/img/member/uploadFiles/" + changeName;
	}


	@GetMapping("board")
	public String boardList(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "type", defaultValue = "board") String type, Model model, HttpServletRequest request) {
		session.setAttribute("originalUrl", request.getRequestURI());
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser == null) {
			session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
			return "redirect:/member/login";
		}

		String memberId = loginUser.getMemberId();
		int pageLimit = 10;
		int boardLimit = 10;

		int listCount;
		ArrayList<Board> list;
		PageInfo pi;

		if (type == null || type.equals("board")) {
			listCount = mypageService.selectBoardListCount(memberId);
			pi = Pagination.getPageInfo(listCount, page, pageLimit, boardLimit);
			list = mypageService.selectBoardList(pi, memberId);
		} else if (type.equals("inreview")) {
			listCount = mypageService.selectInreviewCount(memberId);
			pi = Pagination.getPageInfo(listCount, page, pageLimit, boardLimit);
			list = mypageService.selectInreviewList(pi, memberId);
		} else if (type.equals("find")) {
			listCount = mypageService.selectFindListCount(memberId);
			pi = Pagination.getPageInfo(listCount, page, pageLimit, boardLimit);
			list = mypageService.selectFindList(pi, memberId);
		} else {
			return "redirect:/member/mypage/board"; // 잘못된 type 값일 경우에 대한 처리
		}

		

		model.addAttribute("pi", pi).addAttribute("list", list).addAttribute("type", type);

		return "member/mypage/board";
	}

	@PostMapping(value = "boardDelete")
	@ResponseBody
	public String boardDelete(HttpServletRequest request, @RequestParam("ids") String ids) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser == null) {
			session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
			return "redirect:/member/login";
		}
				
		String memberId = ((Member) session.getAttribute("loginUser")).getMemberId();
		String[] idArray = ids.split(",");
		int[] intArray = new int[idArray.length];

		for (int i = 0; i < idArray.length; i++) {
			intArray[i] = Integer.parseInt(idArray[i]);
		}

		int result = mypageService.deleteBoard(intArray, memberId);
		return result > 0 ? "Y" : "N";
	}

	@GetMapping("wish")
	public String mypageWish(HttpServletRequest request, @RequestParam(value = "page", defaultValue = "1") int page,
			Model model) {
		session.setAttribute("originalUrl", request.getRequestURI());
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser == null) {
			session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
			return "redirect:/member/login";
		}
		
		int pageLimit = 10;
		int boardLimit = 5;
		Member m = (Member) session.getAttribute("loginUser");
		String memberId = m.getMemberId();
		int listCount = mypageService.selectWishListCount(memberId);
		PageInfo pi = Pagination.getPageInfo(listCount, page, pageLimit, boardLimit);

		ArrayList<MyWish> list = mypageService.selectWishList(pi, memberId);

		model.addAttribute("pi", pi).addAttribute("list", list);
		return "member/mypage/wish";
	}

	// 마이페이지의 내 정보 조회로 이동합니다.
	@GetMapping("profile")
	public String mypageProfile(HttpServletRequest request, Model model) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser == null) {
			session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
			return "redirect:/member/login";
		}
		
		
		session.setAttribute("originalUrl", request.getRequestURI());
		int result = mypageService.selectAlarmCheck(loginUser.getEmail());
		model.addAttribute("result", result);
		
		return "member/mypage/profile";
	}

	@PostMapping("deleteMember")
	public String DeleteMember(String memberPwd) {


		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser == null) {
			session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
			return "redirect:/member/login";
		}

		if (bcryptPasswordEncoder.matches(memberPwd, loginUser.getMemberPwd())) {

			int result = memberService.deleteMember(loginUser.getMemberId());

			if (result > 0) {
				session.setAttribute("toastSuccess", "성공적으로 탈퇴처리 되었습니다. 쉼을 이용해주셔서 감사합니다.");
				session.removeAttribute("loginUser");
				return "redirect:/";
			} else {
				session.setAttribute("toastError", "오류가 발생했습니다. 잠시 후에 시도해주세요.");
				return "redirect:/mypage/profile";
			}

		} else {
			// 삭제 실패
			session.setAttribute("toastError", "비밀번호가 일치하지 않습니다.");
			return "redirect:/mypage/profile";
		}
	}
	

	// 마이페이지의 내 셰어하우스 조회로 이동합니다.
	@RequestMapping("house")
	public String mypageHouse(@RequestParam(value = "cPage", defaultValue = "1") int currentPage,
			HttpServletRequest request, Model model) {
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser == null) {
			session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
			return "redirect:/member/login";
		}

		session.setAttribute("originalUrl", request.getRequestURI());

		int pageLimit = 5;
		int boardLimit = 6;

		Member m = (Member) session.getAttribute("loginUser");

		String memberId = m.getMemberId();

		int listCount = 0;
		PageInfo pi = null;
		
		
		listCount = mypageService.selectHouseListCount(memberId);

		pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

		ArrayList<House> list = mypageService.selectHouseList(pi, memberId);

		model.addAttribute("pi", pi).addAttribute("list", list);

		return "member/mypage/house";
	}

	// 마이페이지의 내 예약내역 조회로 이동합니다.
	@RequestMapping("reservation")
	public String mypageReservation(@RequestParam(value="cPage", defaultValue="1") int currentPage,
									HttpServletRequest request, Model model) {
		
		session.setAttribute("originalUrl", request.getRequestURI());
		
		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser == null) {
			session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
			return "redirect:/member/login";
		}
		
		int pageLimit = 10;
	    int boardLimit = 10;
	   
	    Member m = (Member) session.getAttribute("loginUser");
	    
	    String memberId = m.getMemberId();
	    
	    int listCount = 0;
	    PageInfo pi = null;
	   
	    listCount = mypageService.selectRezListCount(memberId);
	    
	    pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

	    ArrayList<Reservation> list = mypageService.selectRezList(pi, memberId);
	    
	    model.addAttribute("pi", pi)
	    	 .addAttribute("list", list);
		
		return "member/mypage/reservation";
	}
	
	// 결제내역 페이지로 이동합니다.
	@RequestMapping("payment")
	public String mypagePay(@RequestParam(value="cPage", defaultValue="1") int currentPage,
								HttpServletRequest request, Model model) {
		
		session.setAttribute("originalUrl", request.getRequestURI());
		
		int pageLimit = 10;
	    int boardLimit = 10;
	    
	    int listCount = 0;
	    PageInfo pi = null;
	    
	    Member m = (Member) session.getAttribute("loginUser");
	    
		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser == null) {
			session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
			return "redirect:/member/login";
		}
		
	    String memberId = m.getMemberId();
	    
		 listCount = mypageService.selectPayListCount(memberId);
		 
		 pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

		 ArrayList<Pay> list = mypageService.selectPayList(pi, memberId);
		 
		 model.addAttribute("pi", pi)
		      .addAttribute("list", list);
			
		 return "member/mypage/payment";
		

	}
	
	@ResponseBody
	@RequestMapping("setAlarm")
	public int setAlarm(String email) {
		int result = mypageService.updateAlarmCheck(email);
		Member loginUser = new Member();
		
		loginUser.setMemberId(((Member)session.getAttribute("loginUser")).getMemberId());
		
		loginUser = memberService.loginMember(loginUser);
		
		session.setAttribute("loginUser", loginUser);
		return result;
	}

}
