package com.suim.event.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;
import com.suim.event.model.service.AdminEventService;
import com.suim.event.model.service.EventService;
import com.suim.event.model.vo.Eattachment;
import com.suim.event.model.vo.Event;

@Controller
public class AdminEventController {
	
	@Autowired
	private EventService eventService;
	
	@Autowired
	private AdminEventService adminEventService;
	
	
	@RequestMapping("admin.ev")
	public ModelAndView selectList(
			@RequestParam(value="cPage", defaultValue="1") int currentPage,
			@RequestParam(value = "category", required = false) String category,
			ModelAndView mv) {
		// 페이징처리를 위한 PageInfo 객체 얻어내기
		int listCount = eventService.selectListCount();
		System.out.println(listCount);
		
		int pageLimit = 10;
		int boardLimit = 5;
		
		System.out.println("카테고리 " + category);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		System.out.println(pi);
		System.out.println("이벤트컨트롤러에서의 pi 의 값은");
		System.out.println(pi);
		System.out.println("입니다.");
		
		
		ArrayList<Event> list = eventService.selectList(pi);
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("p")
		  .setViewName("admin/event/adminEvent");
		System.out.println("리스트는 " + list);
		System.out.println(mv);

		return mv;
	}
	
	@RequestMapping("admin/detail.ev")
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
	
	
	// 이벤트 게시글 작성
	@RequestMapping("/enrollForm.ev")
	public String enrollForm() {
		
		// /WEB-INF/views/admin/notice/noticeEnrollForm.jsp
	
		return "admin/event/eventEnrollForm";
	}
	
		
		
		
	
	@RequestMapping("/insert.ev")
	public String insertEventBoard(Event e,
						Eattachment eAttach,
						// Date noticeFileuploadDate,
						MultipartFile upfile,
						HttpSession session,
						Model model) {
	
	System.out.println("호출");
			
	System.out.println("e 는 ");
	System.out.println(e);
	System.out.println("입니다.");
	
	System.out.println("----------upfiles");
	System.out.println(upfile);
	System.out.println("-----upfiles");
	
	int result1 = adminEventService.insertEventBoard(e, eAttach);
	int result2 = 1;
	
	System.out.println(result1);
	System.out.println("---- result1");
	
	if(!upfile.getOriginalFilename().equals("")) { // 넘어온 첨부파일이 있을 경우
	
		String changeName = saveFile(upfile, session);
		
		eAttach.setOriginName(upfile.getOriginalFilename());
		eAttach.setChangeName("/resources/img/event/" + changeName);
		
		result2 = adminEventService.insertEventFile(eAttach);
		
	}
	
	
	if(result1 > 0 && result2 > 0) {
	
		session.setAttribute("alertMsg", "성공적으로 게시글이 등록되었습니다.");
		
		return "redirect:/event.ev"; // 내부적으로 1번 페이지로 향함
		
	}else { // 실패 => 에러 문구를 담아서 에러페이지로 포워딩
		
		model.addAttribute("errorMsg", "게시글 등록 실패");
		
		return "common/errorPage";
	}
	
	
	}
	
	public String saveFile(MultipartFile upfile, HttpSession session) {
		
		// 1. 원본파일명 뽑기
		String originName = upfile.getOriginalFilename(); // "bono.jpg"
		
		// 2. 현재 시간 형식을 문자열로 뽑아내기
		String currentTime = new SimpleDateFormat("yyyyMMddHHss")
								 .format(new Date()); // "20230511104920"
		
		// 3. 뒤에 붙을 5자리 랜덤값 뽑기 (10000 ~ 99999 범위)
		int ranNum = (int)(Math.random() * 90000 + 10000); // 13152
		
		// 4. 원본파일명으로부터 확장자명 뽑기
		String ext = originName.substring(originName.lastIndexOf(".")); // ".jpg"
		
		// 5. 2, 3, 4 단계에서 구한 값을 모두 이어 붙이기
		String changeName = currentTime + ranNum + ext;
		
		// 6. 업로드 하고자 하는 서버의 물리적인 경로 알아내기
		String savePath = session.getServletContext().getRealPath("/resources/img/event/");
		
		// 7. 경로와 수정파일명을 합체 후 파일을 업로드 해주기
		// MultipartFile 객체에서 제공하는 transferTo 메소드
		// [ 표현법 ]
		// upfile.transferTo(업로드하고자하는파일객체);
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("changeName 은 " + changeName);
		return   changeName;
		
		
	}
	
	
	
	
	
	// 관리자용 이벤트 게시판 업데이트폼으로 이동
	@RequestMapping("admin/updateForm.ev")
	public ModelAndView updateForm(int eno 
						 , ModelAndView mv, HttpSession session) { // RequestParam 을 생략하기 위해 bno 를 매개변수로 삼음
		
		System.out.println("eno : " + eno);
		
		// 게시글 상세보기용 selectBoard 요청 재활용
		Event e = eventService.selectBoard(eno);
		
		System.out.println("--------");
		System.out.println(e);
		System.out.println("--------");
		// eAttach = adminNoticeService.selectForUpdateNoticeFile(natNo);
		ArrayList<Eattachment> eAttach = eventService.selectEventFile(eno);
		System.out.println(eAttach);
		System.out.println("--------");
		//  System.out.println(mv);
		mv.addObject("eAttach", eAttach);
		mv.addObject("e", e); // void 를 String 타입으로 바꿔주고매개변수에 model 추가하고 씀
		
		// System.out.println(mv + "입니다.");
		
		mv.setViewName("admin/event/eventUpdateForm");
		return mv;
	}
	
	@RequestMapping("admin/update.ev")
	public String updateEvent(Model model,
								 Event e, 
								MultipartFile reupfile,
								HttpSession session, 
								Eattachment eAttach) {
		
		System.out.println("eAttach 의 원래 originName");
		System.out.println(eAttach);
		System.out.println("입니다.");
		
		System.out.println();
		//n = noticeService.selectBoard(nno);
		System.out.println("--------");
		System.out.println("e 에 대한 것은 " + e + "입니다.");
		System.out.println("--------");
		int result = adminEventService.updateEvent(e);	
		
		// 새로운 첨부파일에 대한 insert
		
			
		
		if(result > 0) { // 성공
				
			// 일회성 알람 문구 담고 게시판 리스트페이지로 url 재요청
			session.setAttribute("alertMsg", "성공적으로 게시글이 수정되었습니다.");
			return "redirect:/detail.ev?eno=" + e.getEventNo();
				
		} else { // 실패
				
			// 에러문구 담아서 에러페이지로 포워딩
			model.addAttribute("errorMsg", "업데이트 실패");
			return "common/errorPage";
	
		}
	}
	
	
	/**
	 * 현재는 파일 삭제만 되고, EATTACH 테이블의 file_status 가 'n' 으로는 바뀌지 않음.
	 * @param eno
	 * @param model
	 * @param filePath
	 * @param session
	 * @return
	 */

	
	@RequestMapping("delete.ev")
	public String deleteEvent(@RequestParam("eno") int eno, Eattachment eAttach, Event e, 

						  Model model, 
						  String filePath,
						  HttpSession session) {
	

	// 그 이벤트 파일의 status 를 n 으로 바꾸기 위해 이벤트 파일을 조회하기 위한 것.

	
	// 해당 이벤트 게시글의 첨부 파일을 조회해서 file_status 를 n 으로 바꾸기 위한 것.	
	int re = adminEventService.deleteEventFile(eno);
	if(re > 0) {
		System.out.println("re 는 " + re);
	}
	int result = adminEventService.deleteEvent(eno);
	
	if(result > 0) { // 삭제 처리 성공
		
		// delete.ev 요청 시 첨부파일이 있었을 경우
		// 서버의 실제 파일이 삭제 되는 코드
	 
		if(filePath != null) {
			System.out.println("파일Path" + filePath);
			// 넘어온 수정파일명이 있다면 == 애초에 해당 게시글에 첨부파일이 있었다면
			// String realPath = session.getServletContext().getRealPath(filePath);
			// new File(realPath).delete();
		}
		
		
		
		session.setAttribute("alertMsg", "성공적으로 이벤트가 삭제되었습니다.");
		
		return "redirect:/event.ev";
		
	} else { // 삭제 처리 실패 => 에러페이지 포워딩
		
		model.addAttribute("errorMsg", "회원 삭제 실패");
		
		return "common/errorPage";
	}
	}
	
	
	
	
	
	
}
