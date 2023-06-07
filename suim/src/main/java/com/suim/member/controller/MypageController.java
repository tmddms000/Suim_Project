package com.suim.member.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.suim.board.model.vo.Board;
import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;
import com.suim.member.model.service.MemberService;
import com.suim.member.model.service.MypageService;
import com.suim.member.model.vo.Member;
import com.suim.member.model.vo.MyWish;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("mypage")
@Slf4j
public class MypageController {

	private final MemberService memberService;
	private final MypageService mypageService;
	private final HttpSession session;
	private final BCryptPasswordEncoder bcryptPasswordEncoder;

	@Autowired
	public MypageController(MemberService memberService, MypageService mypageService, HttpSession session,
			BCryptPasswordEncoder bcryptPasswordEncoder) {
		this.memberService = memberService;
		this.mypageService = mypageService;
		this.session = session;
		this.bcryptPasswordEncoder = bcryptPasswordEncoder;
	}

	// 사용자 정보 수정 메소드
	@PostMapping("updateProfile")
	public String updateProfile(@RequestParam("file") MultipartFile file, Member m, String changePwd1,
			String changePwd2, HttpServletRequest request, Model model) {

		Member loginUser = (Member) session.getAttribute("loginUser");

		if (bcryptPasswordEncoder.matches(m.getMemberPwd(), loginUser.getMemberPwd())) {

			m.setMemberPwd(bcryptPasswordEncoder.encode(m.getMemberPwd()));

			// 비밀번호가 일치하고, 파일이 비어있지 않음
			if (!file.getOriginalFilename().equals("") && !file.isEmpty()) {

				String changeName = saveFile(file, session);

				m.setChangeName(changeName);

			} else {
				m.setChangeName(loginUser.getChangeName());
			}

			// 비밀번호 변경을 할수도 있고 안할수도 있기 때문에 조건 걸어준다
			// 비밀번호가 null이 아니고, 비밀번호가
			if (changePwd1 != null && !changePwd1.trim().isEmpty() && changePwd2 != null
					&& !changePwd2.trim().isEmpty()) {

				// 만약 변경비밀번호1과 변경비밀번호2가 같다면? => 일치하므로 changePwd1을 암호화하여 updte 해준다
				if (changePwd1.equals(changePwd2)) {

					m.setMemberPwd(bcryptPasswordEncoder.encode(changePwd1));
				} else {
					session.setAttribute("toastError", "확인 비밀번호가 일치하지 않습니다.");
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

		return "redirect:" + (String) session.getAttribute("originalUrl");
	}

	public String saveFile(MultipartFile file, HttpSession session) {

		// 파일명 수정 작업 후 서버에 업로드 시키기
		// => 왠만해선 파일명이 겹치지 않게끔 !!

		// MyFileRenamePolicy 에서 지정했던 로직 그대로 재현
		// 예) "bono.jpg" => "20230511104425xxxxx.jpg"
		// 1. 원본파일명 뽑기
		String originName = file.getOriginalFilename(); // "bono.jpg"

		// 2. 현재 시간 형식을 문자열로 뽑아내기
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); // "20230511104920"

		// 3. 뒤에 붙을 5자리 랜덤값 뽑기 (10000 ~ 99999 범위)
		int ranNum = (int) (Math.random() * 90000 + 10000); // 13152

		// 4. 원본파일명으로부터 확장자명 뽑기
		String ext = originName.substring(originName.lastIndexOf(".")); // ".jpg"

		// 5. 2, 3, 4 단계에서 구한 값을 모두 이어 붙이기
		String changeName = currentTime + ranNum + ext;

		String savePath = session.getServletContext().getRealPath("/resources/img/member/uploadFiles/");

		// 7. 경로와 수정파일명을 합체 후 파일을 업로드 해주기
		try {
			String filePath = savePath + changeName;
			File dest = new File(filePath);
			file.transferTo(dest);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "/resources/img/member/uploadFiles/" + changeName;
	}

	// 처음 페이지(알림 페이지)로 이동합니다.
	@RequestMapping({ "timeline", "" })
	public String mypageAlert(HttpServletRequest request) {
		session.setAttribute("originalUrl", request.getRequestURI());
		return "member/mypage/timeline";
	}

	

	// 마이페이지의 BoardList를 조회합니다.
	@RequestMapping("board")
	public String boardList(@RequestParam(value = "page", defaultValue = "1") int page,
			HttpServletRequest request, @RequestParam(value = "type", defaultValue="board") String type, Model model) {
		session.setAttribute("originalUrl", request.getRequestURI());
		int pageLimit = 10;
		int boardLimit = 10;

		Member m = (Member) session.getAttribute("loginUser");
		
		if (m == null) {
			return "redirect:/";
		}
		ArrayList<Board> list = new ArrayList<Board>();

		String memberId = m.getMemberId();

		// listCount 는 게시판 종류에 따라 달라지게 하기(조건문에 집어넣을거임)
		int listCount = 0;
		PageInfo pi = null;

		if (type == null || type.equals("board")) {

			listCount = mypageService.selectBoardListCount(memberId);
			pi = Pagination.getPageInfo(listCount, page, pageLimit, boardLimit);
			list = mypageService.selectBoardList(pi, memberId);

		} else if (type.equals("inreview")) {

			listCount = mypageService.selectBoardListCount(memberId);

			pi = Pagination.getPageInfo(listCount, page, pageLimit, boardLimit);
			list = mypageService.selectBoardList(pi, memberId);

		} else if (type.equals("find")) {

			listCount = mypageService.selectFindListCount(memberId);
			pi = Pagination.getPageInfo(listCount, page, pageLimit, boardLimit);
			list = mypageService.selectFindList(pi, memberId);

		}

		model.addAttribute("pi", pi).addAttribute("list", list).addAttribute("type", type);

		return "member/mypage/board";
	}

	@RequestMapping(value = "boardDelete", method = RequestMethod.POST)
	@ResponseBody
	public String boardDelete(HttpServletRequest request, @RequestParam("ids") String ids) {
		String memberId = ((Member) session.getAttribute("loginUser")).getMemberId();
		String[] idArray = ids.split(",");

		int[] intArray = new int[idArray.length];

		for (int i = 0; i < idArray.length; i++) {
			intArray[i] = Integer.parseInt(idArray[i]);
		}

		int result = mypageService.deleteBoard(intArray, memberId);
		if (result > 0) {
			return "Y";
		} else {
			return "N";
		}

	}

	// 마이페이지의 내 찜목록 조회로 이동합니다.
	@RequestMapping("wish")
	public String mypageWish(HttpServletRequest request, @RequestParam(value = "page", defaultValue = "1") int page, Model model) {
		session.setAttribute("originalUrl", request.getRequestURI());
		
		int pageLimit = 10;
		int boardLimit = 5;

		Member m = (Member) session.getAttribute("loginUser");
		
		String memberId = m.getMemberId();
		
		int listCount = mypageService.selectWishListCount(memberId);
		PageInfo pi = Pagination.getPageInfo(listCount, page, pageLimit, boardLimit);
		
		ArrayList<MyWish> list = mypageService.selectWishList(pi, memberId);

		model.addAttribute("pi", pi).addAttribute("list", list);
		
		System.out.println(pi);
		
		return "member/mypage/wish";
	}

	// 마이페이지의 내 정보 조회로 이동합니다.
	@RequestMapping("profile")
	public String mypageProfile(HttpServletRequest request) {
		session.setAttribute("originalUrl", request.getRequestURI());
		return "member/mypage/profile";
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

}
