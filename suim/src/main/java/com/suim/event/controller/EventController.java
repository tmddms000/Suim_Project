package com.suim.event.controller;

import java.util.ArrayList;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;
import com.suim.event.model.service.EventService;
import com.suim.event.model.vo.Eattachment;
import com.suim.event.model.vo.Event;

@Controller
public class EventController {

	@Autowired
	private EventService eventService;
	
	
	/*
	@RequestMapping("/event.ev")
	public ModelAndView selectList(
			@RequestParam(value="cPage", defaultValue="1") int currentPage,
			@RequestParam(value = "category", required = false) String category,
			ModelAndView mv) {
		// 페이징처리를 위한 PageInfo 객체 얻어내기
		int listCount = eventService.selectListCount();
		System.out.println(listCount);
		
		int pageLimit = 10;
		int boardLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		System.out.println(pi);
		System.out.println("이벤트컨트롤러에서의 pi 의 값은");
		System.out.println(pi);
		System.out.println("입니다.");
		
		
		ArrayList<Event> list = eventService.selectList(pi);
		
		
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("p")
		  .setViewName("event/event");
		System.out.println("리스트는 " + list);
		System.out.println(mv);

		return mv;
	}
	*/
	
	
	@RequestMapping("/event.ev")
	public ModelAndView selectList(
			@RequestParam(value="cPage", defaultValue="1") int currentPage,
	//		@RequestParam(value = "category", required = false) String category,
			ModelAndView mv) {
		
		
		// 페이징처리를 위한 PageInfo 객체 얻어내기
		int listCount = eventService.selectListCount();
		System.out.println(listCount);
		
		int pageLimit = 10;
		int boardLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		System.out.println(pi);
		System.out.println("이벤트컨트롤러에서의 pi 의 값은");
		System.out.println(pi);
		System.out.println("입니다.");
		
		// 카테고리에 따른 PageInfo 객체 얻어내기
		// String category = eventService.selectEventCategory(pi, category);
		
		
		ArrayList<Event> list = eventService.selectList(pi);
	
		System.out.println("list -------------- ");
		System.out.println(list);
		System.out.println("000000000000000000000000000000000000");
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("p")
		  .setViewName("event/event");
		System.out.println("리스트는 " + list);
		System.out.println(mv);

		return mv;
	}
	
	
	/*
	@RequestMapping("/event.ev")
	public ModelAndView selectList(
			@RequestParam(value="cPage", defaultValue="1") int currentPage,
			@RequestParam(value = "category", required = false) String category,
			ModelAndView mv) {
		
		
		// 페이징처리를 위한 PageInfo 객체 얻어내기
		int listCount = eventService.selectListCount();
		System.out.println(listCount);
		
		int pageLimit = 10;
		int boardLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		System.out.println(pi);
		System.out.println("이벤트컨트롤러에서의 pi 의 값은");
		System.out.println(pi);
		System.out.println("입니다.");
		
		// 카테고리에 따른 PageInfo 객체 얻어내기
		category = eventService.selectEventCategory(pi, category);
		
		
		ArrayList<Event> list = eventService.selectList(pi);
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("p")
		  .setViewName("event/event");
		System.out.println("리스트는 " + list);
		System.out.println(mv);

		return mv;
	}
	*/
	
	@RequestMapping("/detail.ev")
	public ModelAndView selectBoard(ModelAndView mv, int eno, HttpSession session) {
	
		
		// 1. 해당 게시글 조회수 증가용 서비스 호출 및 결과 받기 (update 하고 옴)
		int result = eventService.increaseCount(eno);
		
		System.out.println("-------");
		System.out.println(result);
		
		// 2. 만약 게시글 조회수가 성공적으로 증가되었다면 그제서야 select 요청
		if(result> 0) { // 성공
			// NoticeDetailView.jsp 에서 필요로 하는 응답데이터를 조회
		
			ArrayList<Eattachment> eAttach = eventService.selectEventFile(eno);
			
			// System.out.println(nAttach);
			
			Event e = eventService.selectBoard(eno);
			
			System.out.println("----");
			System.out.println(e);
			
			mv.addObject("eAttach", eAttach);
			// System.out.println("n은 " + n + "입니다.");
			//	   새로 넘어온 첨부파일에 대한 원본명, 수정파일명을 덮어씌우기 (필드값 셋팅)
			
			
			// 주의사항 : changeName 은 currentTime + ranNum + ext; 을 모두 이어붙인 것이기 때문에
			//		       경로를 지정하여 정확하게 뽑아야 함
			
			// mv.addObject("n", ndn);
			// 조회된 데이터를 mv 에 담아서 포워딩 페이지 경로를 잡아주기
			mv.addObject("e", e).setViewName("event/eventDetailView");
			// System.out.println(mv);
		} else { // 실패
			// 에러문구를 담아서 에러페이지로 포워딩 경로 잡아주기
			mv.addObject("errorMsg", "이벤트 게시글 상세조회 실패")
			   .setViewName("common/errorPage");
			
		}
		mv.setViewName("event/eventDetailView");
		return mv;
	}
}
