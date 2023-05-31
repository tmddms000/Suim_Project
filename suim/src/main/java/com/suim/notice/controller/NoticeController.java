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
	
 @RequestMapping("/notice")
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
 	
}


	
