package com.suim.notice.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;
import com.suim.notice.model.service.NoticeService;
import com.suim.notice.model.vo.Nattachment;
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
		  .addObject("p")
		  .setViewName("notice/notice");
		System.out.println("리스트는 " + list);
		System.out.println(mv);

		return mv;
	}

	@RequestMapping("/detail.no")
	public ModelAndView selectBoard(ModelAndView mv, int nno, HttpSession session) {
	
	
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
		
		System.out.println("-------");
		System.out.println(result);
		
		// 2. 만약 게시글 조회수가 성공적으로 증가되었다면 그제서야 select 요청
		if(result> 0) { // 성공
			// NoticeDetailView.jsp 에서 필요로 하는 응답데이터를 조회
		
			ArrayList<Nattachment> nAttach = noticeService.selectNoticeFile(nno);
			
			// System.out.println(nAttach);
			
			Notice n = noticeService.selectBoard(nno);
			
			System.out.println("----");
			System.out.println(n);
			
			mv.addObject("nAttach", nAttach);
			// System.out.println("n은 " + n + "입니다.");
			//	   새로 넘어온 첨부파일에 대한 원본명, 수정파일명을 덮어씌우기 (필드값 셋팅)
			
			
			// 주의사항 : changeName 은 currentTime + ranNum + ext; 을 모두 이어붙인 것이기 때문에
			//		       경로를 지정하여 정확하게 뽑아야 함
			
			// mv.addObject("n", ndn);
			// 조회된 데이터를 mv 에 담아서 포워딩 페이지 경로를 잡아주기
			mv.addObject("n", n).setViewName("notice/noticeDetailView");
			// System.out.println(mv);
		} else { // 실패
			// 에러문구를 담아서 에러페이지로 포워딩 경로 잡아주기
			mv.addObject("errorMsg", "게시글 상세조회 실패")
			   .setViewName("common/errorPage");
			
		}
		mv.setViewName("notice/noticeDetailView");
		// System.out.println("mv 는" + mv);
		return mv;
	}
	
	/*
	public String saveFile(MultipartFile upfile, HttpSession session, Notice n) {
		// 1. 원본파일명 뽑기
		String originName = upfile.getOriginalFilename(); // "bono.jpg"
					
		// 2. 현재 시간 형식을 문자열로 뽑아내기(SimpleDateFormat객체 이용해서 문자열로 뽑아내면 됨)
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss")
											 .format(new Date()); // "20230511104920"
					
		// 3. 뒤에 붙을 5자리 랜덤값 뽑기 (10000 ~ 99999 범위)
		int ranNum = (int)(Math.random() * 90000 + 10000); // 13152
					
		// 4. 원본파일명으로부터 확장자명 뽑기(. 이 파일명에 여러 개 있을 수 있기 때문에 뒤에서부터 인덱스 수를 알려주는 lastIndexOf를 사용)
		String ext = originName.substring(originName.lastIndexOf(".")); // ".jpg"
					
		// 5. 2, 3, 4 단계에서 뽑은 값을 모두 이어붙이기
		String changeName = currentTime + ranNum + ext;
					
		// 6.업로드 하고자 하는 서버의 물리적인 경로 알아내기
		// => 서블릿 때 썻던 그 구문 그대로 쓸 거임
		// ** 참고 : application Scope 알아내는 방법 2가지 중 session 객체를 이용해서 알아냄
		String savePath = session.getServletContext().getRealPath("/resources/img/notice/");
					
		upfile.equals(new File(savePath + changeName));
					
		return changeName;
		
		// n.setChangeName("/resources/img/notice/" + changeName);
	}
	*/
	
	
	
	

	
	
	
	
	
	
	
}


	
