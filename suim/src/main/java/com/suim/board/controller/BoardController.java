package com.suim.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.suim.board.model.service.BoardService;
import com.suim.board.model.vo.Battachment;
import com.suim.board.model.vo.Board;
import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;




@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("list.bo")
	public ModelAndView selectList(
			@RequestParam(value="cPage", defaultValue="1") int currentPage,
			ModelAndView mv) {
		
		// 페이징처리를 위한 PageInfo 객체 얻어내기
		int listCount = boardService.selectListCount();
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Board> list = boardService.selectList(pi);
		ArrayList<Board> blist = boardService.selectbList();
		

		
		
		
		
		// mv.addObject 메소드는 반환형이 ModelAndView 객체를 다시 리턴하는 형태이기 때문에
		// 다음과 같이 메소드 체이닝을 이용해서 한번에 응답데이터와 응답뷰를 지정할 수 있다.
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("blist", blist)
		  .setViewName("board/free-board");
		
		return mv;
	}
	
	@RequestMapping("enrollForm.bo")
	public String enrollForm() {
		
		// /WEB-INF/views/board/boardEnrollForm.jsp
		return "board/free-boardEnrollForm";
	}
	
	
	   @PostMapping("/board/create")
	    public String createBoard(@ModelAttribute Board board,
	                              @RequestParam("attachmentFile") MultipartFile attachmentFile) {

	        // 게시물 정보 저장 처리
	        board.setBoardDate(new Date(0));
	        board.setStatus("Y");
	        // ... (나머지 필드 설정)
	        // 게시물 저장 로직 실행

	        // 첨부 파일 처리
	        if (!attachmentFile.isEmpty()) {
	            String originalFilename = attachmentFile.getOriginalFilename();
	            String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
	            String savedFileName = UUID.randomUUID().toString() + fileExtension;

	            File saveFile = new File("/resources/uploadFiles" + savedFileName);
	            try {
	                attachmentFile.transferTo(saveFile);

	                // 첨부 파일 정보 저장 처리
	                Battachment attachment = new Battachment();
	                attachment.setOriginName(originalFilename);
	                attachment.setChangeName(savedFileName);
	                attachment.setCreateDate(new Date(0));
	                attachment.setFileStatus("Y");
	                attachment.setBoardNo(board.getBoardNo()); // 게시물 번호 설정
	                // ... (나머지 필드 설정)
	                // 첨부 파일 저장 로직 실행
	            } catch (IOException e) {
	                e.printStackTrace();
	                // 파일 저장 실패 시 예외 처리
	            }
	        }

	        // 게시물 작성 완료 후 페이지 이동 등 필요한 처리

	        return "redirect:/" + board.getBoardNo(); // 예시로 게시물 상세 페이지로 이동하는 URL을 반환합니다.
	    }
	    
	
	@RequestMapping(value="/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request )  {
		JsonObject jsonObject = new JsonObject();
		
        /*
		 * String fileRoot = "C:\\summernote_image\\"; // 외부경로로 저장을 희망할때.
		 */
		
		// 내부경로로 저장
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		String fileRoot = contextRoot+"resources/uploadFiles/";
		
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		
		File targetFile = new File(fileRoot + savedFileName);	
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.addProperty("url", "resources/uploadFiles/"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
			jsonObject.addProperty("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		String a = jsonObject.toString();
		return a;
	}
	
	// 쿼리스트링 방식
		@RequestMapping("detail.bo")
		public ModelAndView selectBoard(ModelAndView mv,
										int bno) {
			// bno 에는 상세조회하고자 하는 해당 게시글의 번호가 담겨있음
			// System.out.println("bno : " + bno);
			
			// 1. 해당 게시글 조회수 증가용 서비스 호출 및 결과 받기 (update 하고 옴)
			int result = boardService.increaseCount(bno);
			
			
			// 2. 만약 게시글 조회수가 성공적으로 증가되었다면 그제서야 select 요청
			if(result > 0) { // 성공
				
				// boardDetiailView.jsp 에서 필요로 하는 응답데이터를 조회
				Board b = boardService.selectBoard(bno);
				
				// 조회된 데이터를 mv 에 담아서 포워딩 페이지 경로를 잡아주기
				mv.addObject("b", b).setViewName("board/free-boardDetail");
				
			} else { // 실패
				
				// 에러문구를 담아서 에러페이지로 포워딩 경로 잡아주기
				mv.addObject("errorMsg", "게시글 상세조회 실패").setViewName("common/errorPage");
			}
			
			return mv;
		}
		
		@RequestMapping("delete.bo")
		public String deleteBoard(int bno,
								  Model model,
								  String filePath,
								  HttpSession session) {
			
			// System.out.println("bno : " + bno);
			
			int result = boardService.deleteBoard(bno);
			
			if(result > 0) { // 삭제 처리 성공
				
				// delete.bo 요청 시 첨부파일이 있었을 경우
				// 서버에 보관중인 첨부 파일 실물 (수정파일명) 을 삭제 처리까지 같이 하고 싶음!!
				if(!filePath.equals("")) {
					// 넘어온 수정파일명이 있다면 == 애초에 해당 게시글에 첨부파일이 있었다면
					String realPath = session.getServletContext().getRealPath(filePath);
					new File(realPath).delete();
				}
				
				// 일회성 알람 문구 담고 게시판 리스트페이지로 url 재요청
				session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
				
				return "redirect:/list.bo";
				
			} else { // 삭제 처리 실패 => 에러페이지 포워딩
				
				model.addAttribute("errorMsg", "게시글 삭제 실패");
				
				return "common/errorPage";
			}
		}
	
	
	
	

}
