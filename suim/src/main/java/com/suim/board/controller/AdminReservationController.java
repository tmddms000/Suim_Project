package com.suim.board.controller;

import java.util.Date;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.suim.board.model.service.AdminReservationService;
import com.suim.board.model.vo.Find;
import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;
import com.suim.house.model.vo.Reservation;

@RequestMapping("/admin")
@Controller
public class AdminReservationController {
	
	@Autowired
	private AdminReservationService adminReservationService;

	// 예약 리스트
	@RequestMapping("/adminRez.ho")
	public ModelAndView adminFindList(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
										ModelAndView mv) {
		
	
			int listCount = adminReservationService.adminRezCount();

			int pageLimit = 10;
			int boardLimit = 10;
		        
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

			ArrayList<Reservation> list =  adminReservationService.adminRezList(pi);
			
			mv.addObject("pi", pi)
	          .addObject("list", list)
			  .setViewName("admin/board/reservation"); 

		return mv;
	}
	
	
	// 예약리스트 내용 밑 수정 페이지 
	@RequestMapping("adminRezDetail.ho")
	public ModelAndView adminRezDetail(ModelAndView mv, HttpServletRequest request,
									int rno) {

		Reservation r = adminReservationService.adminRezDetail(rno);
		
		mv.addObject("r", r)
		  .setViewName("admin/board/reservationDetail");
						
		return mv;
	}
	
	// 예약내용 수정 
	@RequestMapping("adminRezUpdate.ho")
	public String adminRezUpdate(Model model, HttpSession session, @RequestParam("rezNo") int rezNo, @RequestParam("rezDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date rezDate, String rezHour,
									   String rezStatus, String delStatus, String cancelContent) {
		
		HashMap<String, Object> map = new HashMap<>();
				
				map.put("rezNo", rezNo);
				map.put("rezDate", rezDate);
				map.put("rezHour", rezHour);
				map.put("rezStatus", rezStatus);
				map.put("delStatus", delStatus);
				map.put("cancelContent", cancelContent);
				
		
		int result = adminReservationService.adminRezUpdate(map);
		
		if(result > 0 ) {
		
			session.setAttribute("adRezMsg", "성공적으로 게시글이 수정되었습니다.");
		
			model.addAttribute("rno", rezNo);
			
			return "redirect:/admin/adminRezDetail.ho";
			
		} else {
			
			model.addAttribute("errorMsg", "게시글 등록 실패");
			
			return "common/errorPage";
			
		}
	}
	
	@RequestMapping("adminRezDeSearch.bo")
	public ModelAndView adminFindDeSearchList(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
											  @RequestParam(value="rezStatus") String rezStatus,
											  @RequestParam(value="del") String del,
											  @RequestParam(value="dc") String dc,
											  ModelAndView mv) {

		HashMap<String, Object> map = new HashMap<>();
	
		map.put("rezStatus", rezStatus);
		map.put("del", del);
		map.put("dc", dc);
		map.put("currentDate", new Date());
		
		int listCount = adminReservationService.adminRezDeSearchCount(map);
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Reservation> list =  adminReservationService.adminRezDeSearch(map, pi);
		
		mv.addObject("pi", pi)
		.addObject("list", list)
		.addObject("rezStatus", rezStatus)
		.addObject("del", del)
		.addObject("dc", dc)		
		.setViewName("admin/board/reservation"); 
		
		return mv;
		}	
	
	// 키워드 검색
	@RequestMapping("adminRezKeySearch.bo")
	public ModelAndView adminFindKeySearchList(@RequestParam(value="condition") String condition,
			 							 @RequestParam(value="keyword") String keyword,
										 @RequestParam(value="currentPage", defaultValue="1") int currentPage,
										 ModelAndView mv) {
	
		HashMap<String, String> map = new HashMap<>();
		
		map.put("condition", condition);
		map.put("keyword", keyword);

		
		int listCount = adminReservationService.adminRezKeySearchCount(map);
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Reservation> list = adminReservationService.adminRezKeySearch(map, pi);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("keyword", keyword)
		  .addObject("condition", condition)
		  .setViewName("admin/board/reservation");
		
		return mv;
	}
	
	// 관리자 페이지에서 글 삭제 및 되살리기
			@RequestMapping("adminRezDelete.bo")
			public String adminFindDelete(@RequestParam(value="checkboxName", required = false) int[] rezNo,
										 	 @RequestParam(value="deleteControl") String delCon,
										     Model model, HttpSession session, HttpServletRequest request) {
					
				if(rezNo != null && rezNo.length > 0) {
					
					if("삭제".equals(delCon)){
						
						for(int rno : rezNo) {
							
							int result1 = adminReservationService.deleteRezBoard(rno);
							
							if(result1 > 0) {
								
								session.setAttribute("alertMsg", "선택된 예약내역을 삭제에 성공했습니다.");
								
							} else {
								
								session.setAttribute("alertMsg", "선택된 예약내역 삭제에 실패했습니다.");
								
							}
							
						}
						
					} else if("복구".equals(delCon)) {
						
							for(int rno : rezNo) {
							
								int result2 = adminReservationService.deleteRezCanBoard(rno);
								
								if(result2 > 0) {
									
									session.setAttribute("alertMsg", "선택된 예약내역을 복구에 했습니다.");
									
								} else {
									
									session.setAttribute("alertMsg", "선택된 예약내역 복구에 실패했습니다.");
									
								}
							}
					}
					
				} else {
					
					session.setAttribute("alertMsg", "체크된 사람구해요 게시판이 없습니다.");
					
				}
				
				return "redirect:/admin/adminRez.ho";
				
			}
		
	
}
