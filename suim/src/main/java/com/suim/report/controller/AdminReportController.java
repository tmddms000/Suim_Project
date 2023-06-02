package com.suim.report.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;
import com.suim.report.model.service.AdminReportService;
import com.suim.report.model.vo.Report;

@RequestMapping("/admin")
@Controller
public class AdminReportController {

	@Autowired
	private AdminReportService adminReportService;
	
	// 신고 리스트 조회 포워딩용
	@RequestMapping("list.re")
	public ModelAndView selectList(
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			ModelAndView mv) {
		
		// 페이징처리를 위한 PageInfo 객체 얻어내기
		int listCount = adminReportService.selectListCount();
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Report> list = adminReportService.selectList(pi);

		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .setViewName("admin/report/report");
		
		return mv;
	}
	
	
	@ResponseBody
	// 카테고리용 전체 조회용
	@RequestMapping(value = "category.re", produces = "application/json; charset=UTF-8")
	public ArrayList<Report> selectList(
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			ModelAndView mv,
			String category) {
		
		// 페이징처리를 위한 PageInfo 객체 얻어내기
		int listCount = adminReportService.selectListCount();
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Report> list = new ArrayList<>();
		
		if(category == null || category.equals("A")) {
			list = adminReportService.selectList(pi);
		} else {
			list = adminReportService.selectList(pi, category);
		}
		
		return list;
	}

	
	@RequestMapping("detail.re")
	public ModelAndView selectReport(ModelAndView mv,
									@RequestParam(value="rno") int reportNo) {
			Report r = adminReportService.selectReport(reportNo);
			
			// 조회된 데이터를 mv 에 담아서 포워딩 페이지 경로를 잡아주기
			mv.addObject("r", r).setViewName("admin/report/report_detail");
		
		return mv;
	}
	
	@RequestMapping("delete.re")
	public String deleteReport(@RequestParam("rno") int reportNo,
							  Model model,
							  String filePath,
							  HttpSession session) {
		
		
		int result = adminReportService.deleteReport(reportNo);
		
		if(result > 0) { // 삭제 처리 성공
			
			// delete.bo 요청 시 첨부파일이 있었을 경우
			// 서버에 보관중인 첨부 파일 실물 (수정파일명) 을 삭제 처리까지 같이 하고 싶음!!
			if(!filePath.equals("")) {
				// 넘어온 수정파일명이 있다면 == 애초에 해당 게시글에 첨부파일이 있었다면
				String realPath = session.getServletContext().getRealPath(filePath);
				new File(realPath).delete();
			}
			
			// 일회성 알람 문구 담고 게시판 리스트페이지로 url 재요청
			session.setAttribute("alertMsg", "성공적으로 OO가 삭제되었습니다.");
			
			return "redirect:/admin/list.re";
			
		} else { // 삭제 처리 실패 => 에러페이지 포워딩
			
			model.addAttribute("errorMsg", "회원 삭제 실패");
			
			return "common/errorPage";
		}
	}
	
	@RequestMapping("updateForm.re")
	public String updateForm(@RequestParam("rno") int reportNo,
						   Model model) {
		
		// 게시글 상세보기용 selectMember 요청 재활용
		Report r = adminReportService.selectReport(reportNo);
		
		model.addAttribute("r", r);
		
		return "admin/report/report_update";
	}
	
	// 승인/반려 처리용
	@RequestMapping("updateStatus.re")
	public String updateReportStatus(Report r,
							HttpSession session,
							Model model) {
		
		int result = adminReportService.updateReportStatus(r);
		
		if(result > 0) { // 성공
			
			// 일회성 알람문구를 담아서 게시판 상세보기 페이지로 url 재요청
			session.setAttribute("alertMsg", "성공적으로 상태가 수정되었습니다.");
			
			return "redirect:/detail.re?rno=" + r.getReportNo();
			
		} else { // 실패
			
			// 에러문구 담아서 에러페이지로 포워딩
			model.addAttribute("errorMsg", "게시글 수정 실패");
			
			return "common/errorPage";
		}
	}
}
