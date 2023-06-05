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
	
	@GetMapping("notice.no")
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
	
	@RequestMapping("/enrollForm.no")
	public String enrollForm() {
		
		// /WEB-INF/views/admin/notice/noticeEnrollForm.jsp
		return "admin/notice/noticeEnrollForm";
	}
	
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
							MultipartFile upfile,
							HttpSession session,
							Model model) {
		
		// 분명히 제대로 전달값을 넘겨받고자 구문을 작성했음에도 불구하고
		// null 이 뜨는 것을 볼 수 있다.
		// => 파일업로드에 필요한 Spring 라이브러리를 아직 연동하지 않았기 때문 (pom.xml)
		// System.out.println(b);
		// System.out.println(upfile);
		// 요청 시 첨부파일을 선택했든 안했든 간에 upfile 이 null 이 아님
		// (어찌되었든 간에 MultipartFile 타입의 객체는 생성이 된 꼴)
		// => 단, 차이점이라고 한다면 filename 필드에 원본파일명이 있냐 없냐의 차이
		//					   size 필드에 또한 사이즈가 0으로 잡히냐 안잡히냐의 차이
		
		// 단, txt 파일의 경우 내용물이 없다면 size 가 0으로 잡힘 (조건으로 기술하기 부적합함)
		// 전달된 파일이 있을 경우 그 경우에만 파일명 수정 작업 후 서버로 업로드 할 수 있게 로직 짜기
		// => filename 필드 기준으로 조건을 짜줄 것
		
		// MultipartFile 객체의 getOriginalFilename() 메소드
		// => MultipartFile 객체로부터 filename 필드값을 리턴해주는 메소드 (getter 메소드)
		
		
		
		if(!upfile.getOriginalFilename().equals("")) { // 넘어온 첨부파일이 있을 경우
		
		
			
			/*
			// 파일명 수정 작업 후 서버에 업로드 시키기
			// => 왠만해선 파일명이 겹치지 않게끔 !!
			
			// MyFileRenamePolicy 에서 지정했던 로직 그대로 재현
			// 예) "bono.jpg" => "20230511104425xxxxx.jpg"
			// 1. 원본파일명 뽑기
			String originName = upfile.getOriginalFilename(); // "bono.jpg"
			
			// 2. 현재 시간 형식을 문자열로 뽑아내기
			String currentTime = new SimpleDateFormat("yyyyMMddHHmmss")
									 .format(new Date()); // "20230511104920"
			
			// 3. 뒤에 붙을 5자리 랜덤값 뽑기 (10000 ~ 99999 범위)
			int ranNum = (int)(Math.random() * 90000 + 10000); // 13152
			
			// 4. 원본파일명으로부터 확장자명 뽑기
			String ext = originName.substring(originName.lastIndexOf(".")); // ".jpg"
			
			// 5. 2, 3, 4 단계에서 구한 값을 모두 이어 붙이기
			String changeName = currentTime + ranNum + ext;
			
			// 6. 업로드 하고자 하는 서버의 물리적인 경로 알아내기
			String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
			
			// 7. 경로와 수정파일명을 합체 후 파일을 업로드 해주기
			// MultipartFile 객체에서 제공하는 transferTo 메소드
			// [ 표현법 ]
			// upfile.transferTo(업로드하고자하는파일객체);
			try {
				upfile.transferTo(new File(savePath + changeName));
			} catch (IOException e) {
				e.printStackTrace();
			}
			*/ 
		
		
			String changeName = saveFile(upfile, session);
			
			// 8. 원본파일명, 서버에 업로드된경로 + 수정파일명을 NoticeAttachment n 에 담기
			nAttach.setOriginName(upfile.getOriginalFilename());
			nAttach.setChangeName("resources/uploadFiles/" + changeName);
		}
		
		
		
		// 이 시점 기준으로
		// 넘어온 첨부파일이 있다면
		// boardTitle, boardWriter, boardContent, originName, changeName
		// 필드에 값들이 담겨 있음
		// 넘어온 첨부파일이 없다면
		// boardTitle, boardWriter, boardContent
		// 필드에 값들이 담겨 있음
		int result = adminNoticeService.insertNoticeBoard(n);
		int result1 = adminNoticeService.insertNoticeFile(nAttach);
		if(result > 0) { // 성공 => 일회성 알람문구 띄운 뒤 게시글 리스트페이지로 url 재요청
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 등록되었습니다.");
			
			return "redirect:/notice.no"; // 내부적으로 1번 페이지로 향함
			
		} else { // 실패 => 에러 문구를 담아서 에러페이지로 포워딩
			
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
			String currentTime = new SimpleDateFormat("yyyyMMddHHmmss")
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
			
			return changeName;
		}
	
	
	
}
