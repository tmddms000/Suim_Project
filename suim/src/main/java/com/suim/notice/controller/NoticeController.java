package com.suim.notice.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;
import com.suim.notice.model.service.NoticeService;
import com.suim.notice.model.vo.Notice;

@Controller
public class NoticeController {

	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("/notice.no")
	public ModelAndView selectList(
			@RequestParam(value="cPage", defaultValue="1") int currentPage,
			ModelAndView mv) {
		// 페이징처리를 위한 PageInfo 객체 얻어내기
		int listCount = noticeService.selectListCount();
	
		
		int pageLimit = 10;
		int boardLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Notice> list = noticeService.selectList(pi);
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .setViewName("notice/notice");
		System.out.println("리스트는 " + list);
		System.out.println(mv);
		System.out.println("11");
		return mv;
	}

	@RequestMapping("/detail.no")
	public ModelAndView selectBoard(ModelAndView mv, int nno) {
		System.out.println(nno);
	
	// pathContext 방식
	/*
	@RequestMapping("detail.bo/{nno}")
	public ModelAndView selctBoard(@PathVariable int nno,
								   ModelAndView mv) {
	*/							   

		// nno 에는 상세조회하고자하는 해당 게시글의 번호가 담겨있음
		// System.out.println(nno);
		
		// 1. 해당 게시글 조회수 증가용 서비스 호출 및 결과 받기 (update 하고 옴)
		int result = noticeService.increaseCount(nno);
		
		// 2. 만약 게시글 조회수가 성공적으로 증가되었다면 그제서야 select 요청
		if(result> 0) { // 성공
			System.out.println(result + "값");
			// NoticeDetailView.jsp 에서 필요로 하는 응답데이터를 조회
			Notice n= noticeService.selectBoard(nno);
			
			// 조회된 데이터를 mv 에 담아서 포워딩 페이지 경로를 잡아주기
			mv.addObject("n", n).setViewName("notice/noticeDetailView");
			System.out.println(mv);
		} else { // 실패
			// 에러문구를 담아서 에러페이지로 포워딩 경로 잡아주기
			mv.addObject("errorMsg", "게시글 상세조회 실패")
			   .setViewName("common/errorPage");
			
		}
		mv.setViewName("notice/noticeDetailView");
		System.out.println("mv 는" + mv);
		return mv;
	}
	
	
}


	
