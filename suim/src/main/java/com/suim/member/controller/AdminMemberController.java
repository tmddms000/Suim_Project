package com.suim.member.controller;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;
import com.suim.member.model.service.AdminMemberService;
import com.suim.member.model.vo.Member;

@Controller
public class AdminMemberController {

	@Autowired
	private AdminMemberService adminMemberService;
	
	
	@RequestMapping("list.me")
	public ModelAndView selectList(
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			ModelAndView mv) {
		
		// 페이징처리를 위한 PageInfo 객체 얻어내기
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
		
		// /WEB-INF/views/board/boardEnrollForm.jsp
		return "admin/member/memberEnrollForm";
	}
	

	
	// 쿼리스트링 방식
	@RequestMapping("detail.me")
	public ModelAndView selectMember(ModelAndView mv,
									@RequestParam("id") String memberId) {
			Member m = adminMemberService.selectMember(memberId);
			
			// 조회된 데이터를 mv 에 담아서 포워딩 페이지 경로를 잡아주기
			mv.addObject("m", m).setViewName("admin/member/member_detail");
		
		return mv;
	}
	
	@RequestMapping("delete.me")
	public String deleteMember(String memberId,
							  Model model,
							  String filePath,
							  HttpSession session) {
		
		
		int result = adminMemberService.deleteMember(memberId);
		
		if(result > 0) { // 삭제 처리 성공
			
			// delete.bo 요청 시 첨부파일이 있었을 경우
			// 서버에 보관중인 첨부 파일 실물 (수정파일명) 을 삭제 처리까지 같이 하고 싶음!!
			if(!filePath.equals("")) {
				// 넘어온 수정파일명이 있다면 == 애초에 해당 게시글에 첨부파일이 있었다면
				String realPath = session.getServletContext().getRealPath(filePath);
				new File(realPath).delete();
			}
			
			// 일회성 알람 문구 담고 게시판 리스트페이지로 url 재요청
			session.setAttribute("alertMsg", "성공적으로 회원이 삭제되었습니다.");
			
			return "redirect:/list.me";
			
		} else { // 삭제 처리 실패 => 에러페이지 포워딩
			
			model.addAttribute("errorMsg", "회원 삭제 실패");
			
			return "common/errorPage";
		}
	}
	
	@RequestMapping("updateForm.me")
	public String updateForm(String memberId,
						   Model model) {
		
		// 게시글 상세보기용 selectMember 요청 재활용
		Member m = adminMemberService.selectMember(memberId);
		
		model.addAttribute("m", m);
		
		return "admin/member/member_update";
	}


	
}
