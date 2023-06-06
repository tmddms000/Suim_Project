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
	
	@GetMapping
	@RequestMapping("/insert.no")
	public String insertNoticeBoard(Notice n,
							Nattachment nAttach,
							// Date noticeFileuploadDate,
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
			nAttach.setChangeName("resources/img/notice/" + changeName);

			System.out.println("upfile 에 해한 정보는 " + upfile + " 입니다");
			
			System.out.println("nAttach 는 " + nAttach + "입니다.");
		}
		
		
		
		// 이 시점 기준으로
		// 넘어온 첨부파일이 있다면
		// boardTitle, boardWriter, boardContent, originName, changeName
		// 필드에 값들이 담겨 있음
		// 넘어온 첨부파일이 없다면
		// boardTitle, boardWriter, boardContent
		// 필드에 값들이 담겨 있음
		// 파일 넘기려면 어떻게 해야 되나 테스트 하기 위해 주석 처리 : int result = adminNoticeService.insertNoticeBoard(n, nAttach);
		int result = adminNoticeService.insertNoticeBoard(n, nAttach);
		
		if(result  > 0) { // 성공 => 일회성 알람문구 띄운 뒤 게시글 리스트페이지로 url 재요청
			// nAttach.setNoticeNo((n.getNoticeNo()));
			System.out.println("ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ" + nAttach);
			
			nAttach.setCreateDate(n.getNoticeDate());
			nAttach.setFileStatus("y");
			nAttach.setNoticeNo(n.getNoticeNo());
			System.out.println(n.getNoticeNo() + "이게 result 가 성공했을 때의 n 에 담겨있는 값이다.");
			
			
			int fileResult = adminNoticeService.insertNoticeFile(nAttach);
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
	public String updateForm(int nno
						 , Model model) { // RequestParam 을 생략하기 위해 bno 를 매개변수로 삼음
		
		System.out.println("nno : " + nno);
		
		// 게시글 상세보기용 selectBoard 요청 재활용
		Notice n = noticeService.selectBoard(nno);
		
		model.addAttribute("n", n); // void 를 String 타입으로 바꿔주고매개변수에 model 추가하고 씀
		System.out.println(model + "입니다.");
		return "admin/notice/noticeUpdateForm";
	}
	

	@RequestMapping("update.no")
	public String update(Notice n,
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
		
	
	
	
}
