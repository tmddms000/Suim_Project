package com.suim.member.controller;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;
import com.suim.member.model.service.AdminMemberService;
import com.suim.member.model.vo.Member;

@RequestMapping("/admin")
@Controller
public class AdminMemberController {

	@Autowired
	private AdminMemberService adminMemberService;
	
	
	@RequestMapping("list.me")
	public ModelAndView selectList(
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			ModelAndView mv) {
		
		int listCount = adminMemberService.selectListCount();
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Member> list = adminMemberService.selectList(pi);

		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .setViewName("admin/member/member");
		
		return mv;
	}
	
	@RequestMapping("enrollForm.me")
	public String enrollForm() {
		
		return "admin/member/memberEnrollForm";
	}
	

	
	@RequestMapping("detail.me")
	public ModelAndView selectMember(ModelAndView mv,
									@RequestParam("id") String memberId) {
			Member m = adminMemberService.selectMember(memberId);
			
			mv.addObject("m", m).setViewName("admin/member/member_detail");
		
		return mv;
	}
	
	@RequestMapping("delete.me")
	public String deleteMember(@RequestParam("id") String memberId,
							  Model model,
//							  String filePath,
							  HttpSession session) {
		
		
		int result = adminMemberService.deleteMember(memberId);
		
		if(result > 0) { 
			
//			if(!filePath.equals("")) {
//				String realPath = session.getServletContext().getRealPath(filePath);
//				new File(realPath).delete();
//			}
			
			session.setAttribute("alertMsg", "성공적으로 삭제되었습니다.");
			
			return "redirect:/list.me";
			
		} else { 
			
			model.addAttribute("errorMsg", "삭제 실패");
			
			return "common/errorPage";
		}
	}
	
	@RequestMapping("updateForm.me")
	public String updateForm(@RequestParam("id") String memberId,
						   Model model) {
		
		Member m = adminMemberService.selectMember(memberId);
		model.addAttribute("m", m);
		
		return "admin/member/member_update";
	}

	@RequestMapping("update.me")
	public String updateMember(Member m,
							// MultipartFile reupfile,
							HttpSession session,
							Model model) {

	/*
		// 새로 넘어온 첨부파일이 있을 경우 
		if(!reupfile.getOriginalFilename().equals("")) {
			// 즉, filename 필드값 (원본파일명) 이 있을 경우
			
			// 1. 기존에 첨부파일이 있었을 경우 => 기존의 첨부파일을 찾아서 삭제
			if(m.getChangeName() != null) {
				
				String realPath = session.getServletContext().getRealPath(m.getChangeName());
				new File(realPath).delete();
			}
			
			// 2. 새로 넘어온 첨부파일을 서버에 업로드 시키기
			// String changeName = saveFile(reupfile, session);
			
			// 3. b 에 새로 넘어온 첨부파일에 대한 원본명, 수정파일명을 덮어씌우기 (필드값 셋팅)
			// m.setOriginName(reupfile.getOriginalFilename());
			m.setChangeName("resources/uploadFiles/" + m.getChangeName());
		}
 */	
		int result = adminMemberService.updateMember(m);

		System.out.println(m);
		if(result > 0) { // 성공
			
			// 일회성 알람문구를 담아서 게시판 상세보기 페이지로 url 재요청
			session.setAttribute("alertMsg", "성공적으로 게시글이 수정되었습니다.");
			
			return "redirect:/detail.me?id=" + m.getMemberId();
			
		} else { // 실패
			
			// 에러문구 담아서 에러페이지로 포워딩
			model.addAttribute("errorMsg", "게시글 수정 실패");
			
			return "common/errorPage";
		}
	}
	
	
	
	// 회원 상세보기 - 가맹 신청 조회용

	// 회원 상세보기 - 예치금 조회용
	@RequestMapping("payment.me")
	public ModelAndView selectMemberPayment(ModelAndView mv,
					@RequestParam("id") String memberId) {
		Member m = adminMemberService.selectMember(memberId);
		
		mv.addObject("m", m).setViewName("admin/member/member_detail");
		
		return mv;
	}
	
	
}
