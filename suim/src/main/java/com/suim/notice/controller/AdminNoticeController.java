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
import com.suim.notice.model.vo.Notice;

@Controller
public class AdminNoticeController {
	
	@Autowired
	private AdminNoticeService adminNoticeService;
	
	@RequestMapping("/enrollForm.no")
	public String enrollForm() {
		
		// 포워딩 테스트
		// /WEB-INF/views/board/boardEnrollForm.jsp
		return "/admin/notice/noticeInsert";
		
	}
	
	@RequestMapping("/insert.no")
	public String adminNoticeInsertForm(Notice no,
										MultipartFile upfile,
										HttpSession session,
										Model model) {
		
		if(!upfile.getOriginalFilename().equals("")) { // 넘어온 첨부파일이 있을 경우
			
			// 파일명 수정 작업 후 서버에 업로드 시키기
			// => 왠만해선 파일명이 겹치지 않게끔 !!
			
			// MyFileRenamePolicy 에서 지정했던 로직 그대로 재현
			// 예) "bono.jpg" => "20230511104425xxxxxx.jpg"
			/*
			// 1. 원본파일명 뽑기
			String originName = upfile.getOriginalFilename(); // "bono.jpg"
			
			// 2. 현재 시간 형식을 문자열로 뽑아내기(SimpleDateFormat객체 이용해서 문자열로 뽑아내면 됨)
			String currentTime = new SimpleDateFormat("yyyyMMdd")
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
			String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
			
			// 7. 경로와 수정파일명을 합체 후 업로드 해주기
			// MultipartFile 객체에서 제공하는 transferTo 메소드
			// [ 표현법 ]
			// upfile.transferTo(업로드하고자하는파일객체);
			try {
				upfile.transferTo(new File(savePath + changeName));
			} catch (IOException e) {
				e.printStackTrace();
			}
			*/
			
			String changeName = saveFile(upfile, session); // 매개변수의 두번째인 session은 application Scope를 넘겨주기 위해 담음
			
			// 8. 원본파일명 , 서버에 업로드된 경로, 수정파일명을 Board b에 에 담기
			n.setOriginName(upfile.getOriginalFilename()); // 원본은 b.setOriginName(originName); 이였음
			n.setChangeName("resources/uploadFiles/" + changeName);
			// resources/uploadFiles/ 경로에 있는 changeName 만 담음)
		}
		int result = AdminNoticeService.insertBoard(n);
		
		if(result > 0) { // 성공 => 일회성 알람문구 띄운 뒤 공지사항 게시글 리스트 페이지로 url 재요청
			
			session.setAttribute("alertMsg", "성공적으로 공지사항 게시글이 등록되었습니다.");
			
			return "redirect:/list.bo"; // 내부적으로 1번 페이지로 향함
			
		} else { // 실패 => 에러 문구를 담아서 에러문구로 포워딩
			
			model.addAttribute("errorMsg", "게시글 등록에 실패하였습니다.");
			
			return "common/errorPage";
		}	
	}
	
	
	/**
	 * 공지사항에 작성한 파일을 수정하는 것.
	 * @param upfile
	 * @param session
	 * @return
	 */
	public String saveFile(MultipartFile upfile, HttpSession session) {
		// 1. 원본파일명 뽑기
		String originName = upfile.getOriginalFilename(); // "bono.jpg"
					
		// 2. 현재 시간 형식을 문자열로 뽑아내기(SimpleDateFormat객체 이용해서 문자열로 뽑아내면 됨)
		String currentTime = new SimpleDateFormat("yyyyMMdd")
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
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
					
		// 7. 경로와 수정파일명을 합체 후 업로드 해주기
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
