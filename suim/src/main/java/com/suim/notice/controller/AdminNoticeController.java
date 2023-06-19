package com.suim.notice.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;
import com.suim.notice.model.service.AdminNoticeService;
import com.suim.notice.model.service.NoticeService;
import com.suim.notice.model.vo.Nattachment;
import com.suim.notice.model.vo.Notice;

@Controller
public class AdminNoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	@Autowired
	private AdminNoticeService adminNoticeService;
	
	@RequestMapping("admin.no")
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
		  .setViewName("admin/notice/adminNotice");
		System.out.println("리스트는 " + list);
		System.out.println("mv 는 "  + mv);
		System.out.println("adminNoticeController 에서 작성");
		System.out.println("이건 admin.no 로 가는 컨트롤러");
		return mv;
	}
	
	@RequestMapping("admin/detail.no")
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
	
	@RequestMapping("enrollForm.no")
	public String enrollForm() {
		
		// /WEB-INF/views/admin/notice/noticeEnrollForm.jsp
	
		return "admin/notice/noticeEnrollForm";
	}
		
	
	
////////////////
////////////////
				// 공지사항 작성용 테스트 
////////////////
////////////////

	
/*	
	public ModelAndView selectNoticeBoard(ModelAndView mv, int noticeNo) {
*/
	
	// pathContext 방식
	/*
	@RequestMapping("detail.bo/{nno}")
	public ModelAndView selctBoard(@PathVariable int nno,
								   ModelAndView mv) {
	*/							   

		// nno 에는 상세조회하고자하는 해당 게시글의 번호가 담겨있음
		// System.out.println(nno);

	/*
		// 1. 해당 게시글 조회수 증가용 서비스 호출 및 결과 받기 (update 하고 옴)
		int result = adminNoticeService.increaseCount(noticeNo);
		
		// 2. 만약 게시글 조회수가 성공적으로 증가되었다면 그제서야 select 요청
		if(result> 0) { // 성공
			System.out.println(result + "값");
			// NoticeDetailView.jsp 에서 필요로 하는 응답데이터를 조회
			Notice n= adminNoticeService.selectBoard(noticeNo);
			
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
	*/
	
	/*
	 * * 단일 파일 업로드 (한번에 첨부파일 하나만 넘어오는 구조)
	 * => input type="file" 로 하나 넘어온 파일 정보를 MultipartFile 객체 하나로 받음
	 * 
	 * * 다중 파일 업로드 (한번에 첨부파일 여러개가 넘어오는 구조)
	 * => input type="file" name="upfile"
	 *    input type="file" name="upfile"
	 *    input type="file" name="upfile"
	 *    이런 식으로 한번에 넘기고자 하는 input type="file" 요소의 name 속성값을 일치시킨 후
	 *    Controller 단에서 MultipartFile[] upfile 로 얻어낼 수 있다.
	 *    			    또는 ArrayList<MultipartFile> upfile 로 얻어낼 수 있다.
	 */
	
	@RequestMapping("/insert.no")
	public String insertNoticeBoard(Notice n,
							Nattachment nAttach,
							// Date noticeFileuploadDate,
							MultipartFile upfile,
							HttpSession session,
							Model model) {
		
		System.out.println("호출");
							
	
		System.out.println("----------upfiles");
		System.out.println(upfile);
		System.out.println("-----upfiles");
		
		int result1 = adminNoticeService.insertNoticeBoard(n, nAttach);
		int result2 = 1;
		
		System.out.println(result1);
		System.out.println("---- result1");
		
		if(!upfile.getOriginalFilename().equals("")) { // 넘어온 첨부파일이 있을 경우
		
			String changeName = saveFile(upfile, session);
			
			nAttach.setOriginName(upfile.getOriginalFilename());
			nAttach.setChangeName("resources/img/notice/" + changeName);
			
			result2 = adminNoticeService.insertNoticeFile(nAttach);
			
		}
		
		
		if(result1 > 0 && result2 > 0) {

			session.setAttribute("alertMsg", "성공적으로 게시글이 등록되었습니다.");
			
			return "redirect:/notice.no"; // 내부적으로 1번 페이지로 향함
			
		}else { // 실패 => 에러 문구를 담아서 에러페이지로 포워딩
			
			model.addAttribute("errorMsg", "게시글 등록 실패");
			
			return "common/errorPage";
		}
		
		
	}
		
	public String saveFile(MultipartFile upfile, HttpSession session) {
			
			// 파일명 수정 작업 후 서버에 업로드 시키기
			// => 왠만해선 파일명이 겹치지 않게끔 !!
			
			// MyFileRenamePolicy 에서 지정했던 로직 그대로 재현
			// 예) "bono.jpg" => "20230511104425xxxxx.jpg"
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
			String savePath = session.getServletContext().getRealPath("/resources/img/notice/");
			
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
	
	
	
	
	
	// 공지사항 업데이트폼으로 이동
		@RequestMapping("/updateForm.no")
		public ModelAndView updateForm(int nno 
							 , ModelAndView mv, HttpSession session) { // RequestParam 을 생략하기 위해 bno 를 매개변수로 삼음
			
			System.out.println("nno : " + nno);
			
			// 게시글 상세보기용 selectBoard 요청 재활용
			Notice n = noticeService.selectBoard(nno);
			
			System.out.println("--------");
			System.out.println(n);
			System.out.println("--------");
			// nAttach = adminNoticeService.selectForUpdateNoticeFile(natNo);
			ArrayList<Nattachment> nAttach = noticeService.selectNoticeFile(nno);
			System.out.println(nAttach);
			System.out.println("--------");
			//  System.out.println(mv);
			mv.addObject("nAttach", nAttach);
			mv.addObject("n", n); // void 를 String 타입으로 바꿔주고매개변수에 model 추가하고 씀
			
			// System.out.println(mv + "입니다.");
			
			mv.setViewName("admin/notice/noticeUpdateForm");
			return mv;
		}
		
		@RequestMapping("/update.no")
		public String updateNotice(Model model,
									 Notice n, 
									MultipartFile reupfile,
									HttpSession session, 
									Nattachment nAttach) {
			
			System.out.println("nAttach 의 원래 originName");
			System.out.println(nAttach);
			System.out.println("입니다.");
			
			System.out.println();
			//n = noticeService.selectBoard(nno);
			System.out.println("--------");
			System.out.println("n 에 대한 것은 " + n + "입니다.");
			System.out.println("--------");
			int result = adminNoticeService.updateNotice(n);	
			
			// 새로운 첨부파일에 대한 insert
			
			// 새로운 첨부파일이 잇을 경우
			/*
			if(!reupfile.getOriginalFilename().equals("")) {
				System.out.println("reupfile 이 있었을 경우의 reupfile 에 대한 정보 : " + reupfile);
				// 1. 기존에 첨부파일이 있었을 경우 => 기존의 첨부파일을 찾아서 FILE_STATUS 를 'N' 으로 바꿔야 함.
				if(nAttach.getOriginName() != null) {
					System.out.println("기존에 첨부파일이 있었을 경우 " + nAttach);
				// nAttach = adminNoticeService.selectForUpdateNoticeFile(nAttach);
					
					int deleteResult = adminNoticeService.changeFileStatus(nAttach);
					System.out.println("deleteResult 의 값은 : " + deleteResult + " 입니다.");
				}
					
				// 2. 새로 넘어온 첨부파일을 서버에 업로드 시키기
				String changeName = saveFile(reupfile, session);
				
				
				nAttach.setOriginName(reupfile.getOriginalFilename());
				
				// 주의사항 : changeName 은 currentTime + ranNum + ext; 을 모두 이어붙인 것이기 때문에
				//		       경로를 지정하여 정확하게 뽑아야 함
				nAttach.setChangeName("resources/img/notice/" + changeName);
				
				// System.out.println("nAttach 에 바뀐 파일 정보들이 담겼나에 대한 정보 " + nAttach);
				// nattachment 테이블에 insert 해야함
				
				
			}
			
			*/
				
			
			if(result > 0) { // 성공
					
				// 일회성 알람 문구 담고 게시판 리스트페이지로 url 재요청
				session.setAttribute("alertMsg", "성공적으로 게시글이 수정되었습니다.");
				return "redirect:/detail.no?nno=" + n.getNoticeNo();
					
			} else { // 실패
					
				// 에러문구 담아서 에러페이지로 포워딩
				model.addAttribute("errorMsg", "업데이트 실패");
				return "common/errorPage";

			}
		}
		
	
	/**
	 * 현재는 파일 삭제만 되고 database 에는 해당 nAttachtable 의 행의 filestatus 가 n 으로 바뀌지 않음.
	 * @param NoticeNo
	 * @param model
	 * @param filePath : 파일 경로
	 * @param session
	 * @return
	 */
	@RequestMapping("delete.no")
	public String deleteHouse(@RequestParam("nno") int nno,
							  Model model, 
							  String filePath,
							  HttpSession session) {
		
		// 삭제하려는 해당 공지사항 번호를 조회하기 위한 것
		Notice n = noticeService.selectBoard(nno);
		
		// 해당 공지사항의 첨부 파일을 조회해서 file_status 를 n 으로 바꾸기 위한 것.
		//Nattachment nAttach = adminoticeService.selectNoticeFile(nno);
		
		int result = adminNoticeService.deleteNotice(nno);
		
		if(result > 0) { // 삭제 처리 성공
			
	//	int result2 = adminNoticeService.changeFileStatus(nAttach);
			
			// delete.no 요청 시 첨부파일이 있었을 경우
			// 서버의 실제 파일이 삭제 되는 코드
			 
			if(filePath != null) {
				// 넘어온 수정파일명이 있다면 == 애초에 해당 게시글에 첨부파일이 있었다면
				String realPath = session.getServletContext().getRealPath(filePath);
				new File(realPath).delete();
			}
			
			
			
			session.setAttribute("alertMsg", "성공적으로 공지사항이 삭제되었습니다.");
			
			return "redirect:/notice.no";
			
		} else { // 삭제 처리 실패 => 에러페이지 포워딩
			
			model.addAttribute("errorMsg", "회원 삭제 실패");
			
			return "common/errorPage";
		}
	}
	
	
	
	
	/* 업데이트 할 때 매개변수 뭘 해야 할 지 몰라 새로 작성하기 위해 주석 처리
	 * 
	@RequestMapping("update.no")
	public String update(int nno, Notice n,
			           Nattachment nAttach,	
					   MultipartFile reupfile,
					   HttpSession session,
					   Model model) {
		
		// System.out.println(b);
		// System.out.println(reupfile);
		
		// 새로 넘어온 첨부파일이 있을 경우
		if(!reupfile.getOriginalFilename().equals("")) {
			// 즉, filename 필드값 (원본파일명) 이 있을 경우
			
			// 1. 기존에 첨부파일이 있었을 경우 => 기존의 첨부파일을 찾아서 삭제
			if(nAttach.getOriginName() != null) {
				
				// session 객체가 필요하므로 매개변수에 HttpSession session 추가하고 작성
				String realPath = session.getServletContext().getRealPath(nAttach.getChangeName());
				new File(realPath).delete();
			}
			
			// 2. 새로 넘어온 첨부파일을 서버에 업로드 시키기
			String changeName = saveFile(reupfile, session);
			
			// 3. 커맨드 객체 방식으로 넘겨받은 b 라는 객체에
			//	   새로 넘어온 첨부파일에 대한 원본명, 수정파일명을 덮어씌우기 (필드값 셋팅)
			nAttach.setOriginName(reupfile.getOriginalFilename());
			
			// 주의사항 : changeName 은 currentTime + ranNum + ext; 을 모두 이어붙인 것이기 때문에
			//		       경로를 지정하여 정확하게 뽑아야 함
			nAttach.setChangeName("resources/img/notice/" + changeName);
		}
		
		int result = adminNoticeService.updateBoard(n);
				
		if(result > 0) { // 성공
			
			// 일회성 알람 문구 담고 게시판 리스트페이지로 url 재요청
			session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
			
			return "redirect:/notice.no?nno=" + n.getNoticeNo();
			
		} else { // 실패
			
			// 에러문구 담아서 에러페이지로 포워딩
			model.addAttribute("errorMsg", "업데이트 실패");
			
			return "common/errorPage";
			
			
		}
	}
	*/
		
	
	
	
}
