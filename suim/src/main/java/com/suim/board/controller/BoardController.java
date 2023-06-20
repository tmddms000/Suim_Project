package com.suim.board.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.suim.board.model.service.BoardService;
import com.suim.board.model.vo.Battachment;
import com.suim.board.model.vo.Board;
import com.suim.board.model.vo.Find;
import com.suim.board.model.vo.InReview;
import com.suim.board.model.vo.InReviewReply;
import com.suim.board.model.vo.Reply;
import com.suim.board.model.vo.findReply;
import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;
import com.suim.member.model.vo.Member;
import com.suim.report.model.vo.Report;




@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping("list.bo")
	public ModelAndView selectList(
			@RequestParam(value="cPage", defaultValue="1") int currentPage,
			ModelAndView mv) {
		
		

		int listCount = boardService.selectListCount();
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Board> list = boardService.selectList(pi);
		ArrayList<Board> blist = boardService.selectbList();
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("blist", blist)
		  .setViewName("board/free-board");
		
		return mv;
	}
	
	@RequestMapping("enrollForm.bo")
	public String enrollForm() {
		
		return "board/free-boardEnrollForm";
	}

	@RequestMapping("detail.bo")
	public ModelAndView selectBoard(ModelAndView mv, int bno, HttpSession session) {

	    Member loginUser = (Member) session.getAttribute("loginUser");

	    // 이미 조회한 게시글인지 확인하기 위해 세션 사용
	    Set<Integer> viewedPosts = (Set<Integer>) session.getAttribute("viewedPosts");
	    if (viewedPosts == null) {
	        viewedPosts = new HashSet<>();
	    }

	    // 게시글을 이전에 조회한 경우 조회수를 증가하지 않음
	    if (!viewedPosts.contains(bno)) {
	        int result = boardService.increaseCount(bno);
	        if (result > 0) { // 성공
	            viewedPosts.add(bno);
	            session.setAttribute("viewedPosts", viewedPosts);
	        }
	    }

	    Board b = boardService.selectBoard(bno);
	    if (b != null) {
	        mv.addObject("b", b)
	          .addObject("loginUser", loginUser)
	          .setViewName("board/free-boardDetail");
	    } else {
	        mv.addObject("errorMsg", "게시글 상세조회 실패")
	          .setViewName("common/errorPage");
	    }

	    return mv;
	}

		
		@RequestMapping("delete.bo")
		public String deleteBoard(int bno,
								  Model model,
								  String filePath,
								  HttpSession session) {
			
			
			int result = boardService.deleteBoard(bno);
			
			if(result > 0) { // 삭제 처리 성공
				
				// delete.bo 요청 시 첨부파일이 있었을 경우
				// 서버에 보관중인 첨부 파일 실물 (수정파일명) 을 삭제 처리까지 같이 하고 싶음!!
				if(!filePath.equals("")) {
					// 넘어온 수정파일명이 있다면 == 애초에 해당 게시글에 첨부파일이 있었다면
					String realPath = session.getServletContext().getRealPath(filePath);
					new File(realPath).delete();
				}
				

				session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
				
				return "redirect:/list.bo";
				
			} else { // 삭제 처리 실패 => 에러페이지 포워딩
				
				model.addAttribute("errorMsg", "게시글 삭제 실패");
				
				return "common/errorPage";
			}
		}
		
		@ResponseBody
		@RequestMapping(value = "rlist.bo", produces = "application/json; charset=UTF-8")
		public String ajaxSelectReplyList(int bno) {
			
			ArrayList<Reply> rlist = boardService.selectReplyList(bno);

			return new Gson().toJson(rlist);
		}
		
		@ResponseBody
		@RequestMapping(value = "rinsert.bo", produces = "text/html; charset=UTF-8")
		public String ajaxInsertReply(Reply r) {
			
			
			int result = boardService.insertReply(r);
			
			return (result > 0) ? "success" : "fail";
		}
		
		@ResponseBody
		@RequestMapping(value = "rdelete.bo", produces = "text/html; charset=UTF-8", method = RequestMethod.POST)
		public String ajaxDeleteReply(@RequestParam("bre") int bre) {
			
		    int result = boardService.deleteReply(bre);
		    
		    
		    return (result > 0) ? "success" : "fail";
		}
		
		@ResponseBody
		@RequestMapping(value = "rupdate.bo", produces = "text/html; charset=UTF-8", method = RequestMethod.POST)
		public String ajaxUpdateReply(@RequestParam("bre") int bre,
		                              @RequestParam("content") String content) {

		    int result = boardService.updateReply(bre, content);
		    

		    return (result > 0) ? "success" : "fail";
		}
		
		
		
		
		@RequestMapping(value="/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
		@ResponseBody
		public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request) {
		    JsonObject jsonObject = new JsonObject();

		    // 내부경로로 저장
		    String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		    String fileRoot = contextRoot + "resources/img/board/fileupload/";

		    String originalFileName = multipartFile.getOriginalFilename();    // 오리지날 파일명
		    String extension = originalFileName.substring(originalFileName.lastIndexOf("."));    // 파일 확장자
		    String savedFileName = UUID.randomUUID() + extension;    // 저장될 파일 명
		    
		    File targetFile = new File(fileRoot + savedFileName);
		    try {
		        InputStream fileStream = multipartFile.getInputStream();
		        FileUtils.copyInputStreamToFile(fileStream, targetFile);    // 파일 저장
		        jsonObject.addProperty("url", "resources/img/board/fileupload/" + savedFileName); // contextroot + resources + 저장할 내부 폴더명
		        jsonObject.addProperty("responseCode", "success");
		        
		    } catch (IOException e) {
		        FileUtils.deleteQuietly(targetFile);    // 저장된 파일 삭제
		        jsonObject.addProperty("responseCode", "error");
		        e.printStackTrace();
		    }
		    String a = jsonObject.toString();
		    return a;
		}
		
		@RequestMapping("insert.bo")
		public String insertBoard(Board b,
								 Battachment ba,
								MultipartFile upfile,
								HttpSession session,
								Model model) {
			
			/*
			 * if(!upfile.getOriginalFilename().equals("")) { // 넘어온 첨부파일이 있을 경우
			 * 
			 * String changeName = saveFile(upfile, session);
			 * 
			 * 
			 * ba.setOriginName(upfile.getOriginalFilename());
			 * ba.setChangeName("resources/img/board/fileupload/" + changeName); }
			 */
			

			int result = boardService.insertBoard(b);
			
      //int result2 = boardService.insertBattachment(ba);
			
			if(result > 0 /*|| result2 > 0*/) { // 성공 => 일회성 알람문구 띄운 뒤 게시글 리스트페이지로 url 재요청

				
				session.setAttribute("alertMsg", "성공적으로 게시글이 등록되었습니다.");
				
				return "redirect:/list.bo"; // 내부적으로 1번 페이지로 향함
				
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
									 .format(new Date(0)); // "20230511104920"
			
			// 3. 뒤에 붙을 5자리 랜덤값 뽑기 (10000 ~ 99999 범위)
			int ranNum = (int)(Math.random() * 90000 + 10000); // 13152
			
			// 4. 원본파일명으로부터 확장자명 뽑기
			String ext = originName.substring(originName.lastIndexOf(".")); // ".jpg"
			
			// 5. 2, 3, 4 단계에서 구한 값을 모두 이어 붙이기
			String changeName = currentTime + ranNum + ext;
			
			// 6. 업로드 하고자 하는 서버의 물리적인 경로 알아내기
			String savePath = session.getServletContext().getRealPath("resources/img/board/fileupload/");
			
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
		
		@RequestMapping("updateForm.bo")
		public ModelAndView updateBoard(int bno,
									ModelAndView mv) {
			

			Board b = boardService.updateBoardList(bno);

			
	
			mv.addObject("b", b)
			  .setViewName("board/free-boardUpdate");
			
			return mv;
		}

		@RequestMapping("update.bo")
		public String updateBoard(Board b,
						HttpSession session,
						Model model) {
	
		int result = boardService.updateBoard(b);
		
		
		
		if(result > 0 ) { // 성공 => 일회성 알람문구 띄운 뒤 게시글 리스트페이지로 url 재요청
		
		
		session.setAttribute("alertMsg", "성공적으로 게시글이 수정되었습니다.");
		
		return "redirect:/list.bo"; // 내부적으로 1번 페이지로 향함
		
		} else { // 실패 => 에러 문구를 담아서 에러페이지로 포워딩
		
		model.addAttribute("errorMsg", "게시글 등록 실패");
		
		return "common/errorPage";
		}
		
		}
		
		

		//---------------------------사람구해요--------------------------------
		

		@RequestMapping("list.fi")
		public ModelAndView selectfList(@RequestParam(defaultValue="all") String gender, 
										@RequestParam(defaultValue="all")String category,
										@RequestParam(defaultValue="")String search,
										@RequestParam(value="cPage", defaultValue="1") int currentPage,
										HttpServletRequest request,
				ModelAndView mv) throws UnsupportedEncodingException {

			
			int listCount = 0;
			PageInfo pi = null;
			int pageLimit = 10;
			int boardLimit = 10;
			ArrayList<Find> flist = new ArrayList<Find>();
			String uriWithQueryString = request.getRequestURI() + "?" + request.getQueryString();
			
			
			
			HashMap<String, String> fin = new HashMap<>();
			fin.put("gender", gender);
			fin.put("category", category);
			fin.put("search", search);

			if(gender.equals("all") && category.equals("all") && search.equals("")) { // 전체조회로직
				
				// fin 이 필요 없는 로직
				listCount = boardService.selectfListCount(); // 수정
				
				pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
				flist = boardService.selectfList(pi);
				

			} 
			else {
				listCount = boardService.selectfcListCount(fin);
				

				pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
				flist = boardService.selectfList(pi, fin);
				
				
			}
			
			mv.addObject("pi", pi) 

			  .addObject("flist", flist)
			  .addObject("url", uriWithQueryString)
			  .setViewName("board/find-board");
			
			
			
			return mv;  

		}
		@RequestMapping("detail.fi")
		public ModelAndView selectFind(ModelAndView mv, HttpServletRequest request, int fno, HttpSession session) {

		    // 이미 조회한 게시글인지 확인하기 위해 세션 사용
		    Set<Integer> viewedPosts = (Set<Integer>) session.getAttribute("viewedPosts");
		    if (viewedPosts == null) {
		        viewedPosts = new HashSet<>();
		    }

		    // 게시글을 이전에 조회한 경우 조회수를 증가하지 않음
		    if (!viewedPosts.contains(fno)) {
		        int result = boardService.increasefCount(fno);
		        if (result > 0) { // 성공
		            viewedPosts.add(fno);
		            session.setAttribute("viewedPosts", viewedPosts);
		        }
		    }

		    Find fb = boardService.selectFind(fno);
		    if (fb != null) {
		        mv.addObject("fb", fb)
		          .addObject("url", request.getRequestURI())
		          .setViewName("board/find-boardDetail");
		    } else {
		        mv.addObject("errorMsg", "게시글 상세조회 실패")
		          .setViewName("common/errorPage");
		    }

		    return mv;
		}

			
		@RequestMapping("delete.fi")
		public String deleteFind(int fno,
								  Model model,
								  String filePath,
								  HttpSession session) {
			
			
			int result = boardService.deleteFind(fno);
			
			
			
			if(result > 0) { // 삭제 처리 성공
				
				// delete.bo 요청 시 첨부파일이 있었을 경우
				// 서버에 보관중인 첨부 파일 실물 (수정파일명) 을 삭제 처리까지 같이 하고 싶음!!
				if(!filePath.equals("")) {
					// 넘어온 수정파일명이 있다면 == 애초에 해당 게시글에 첨부파일이 있었다면
					String realPath = session.getServletContext().getRealPath(filePath);
					new File(realPath).delete();
				}
				

				session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
				
				return "redirect:/list.fi";
				
			} else { // 삭제 처리 실패 => 에러페이지 포워딩
				
				model.addAttribute("errorMsg", "게시글 삭제 실패");
				
				return "common/errorPage";
			}
		}
		
		@ResponseBody
		@RequestMapping(value = "rlist.fi", produces = "application/json; charset=UTF-8")
		public String ajaxSelectfReplyList(int fno) {
			
			
			ArrayList<findReply> flist = boardService.selectfReplyList(fno);
			
			
			
			return new Gson().toJson(flist);
		}
		
		@ResponseBody
		@RequestMapping(value = "rinsert.fi", produces = "text/html; charset=UTF-8")
		public String ajaxInsertfReply(findReply fr) {
			

			
			int result = boardService.insertfReply(fr);
			
			return (result > 0) ? "success" : "fail";
		}
		
		@ResponseBody
		@RequestMapping(value = "rdelete.fi", produces = "text/html; charset=UTF-8", method = RequestMethod.POST)
		public String ajaxDeletefReply(@RequestParam("fre") int fre) {
			
		    int result = boardService.deletefReply(fre);
		    
		    
		    return (result > 0) ? "success" : "fail";
		}
		
		@ResponseBody
		@RequestMapping(value = "rupdate.fi", produces = "text/html; charset=UTF-8", method = RequestMethod.POST)
		public String ajaxUpdatefReply(@RequestParam("fre") int fre,
		                              @RequestParam("content") String content) {

		    int result = boardService.updatefReply(fre, content);
		    

		    return (result > 0) ? "success" : "fail";
		}
		
		@RequestMapping("enrollForm.fi")
		public String findEnrollForm() {
			
			return "board/find-boardEnrollForm";
		}

		@RequestMapping("insert.fi")
		public String insertFind(Find f,
								HttpSession session,
								Model model) {
			
			/*
			 * if(!upfile.getOriginalFilename().equals("")) { // 넘어온 첨부파일이 있을 경우
			 * 
			 * String changeName = saveFile(upfile, session);
			 * 
			 * 
			 * ba.setOriginName(upfile.getOriginalFilename());
			 * ba.setChangeName("resources/img/board/fileupload/" + changeName); }
			 */
			

			int result = boardService.insertFind(f);
			
      //int result2 = boardService.insertBattachment(ba);
			
			if(result > 0 /*|| result2 > 0*/) { // 성공 => 일회성 알람문구 띄운 뒤 게시글 리스트페이지로 url 재요청

				
				session.setAttribute("alertMsg", "성공적으로 게시글이 등록되었습니다.");
				
				return "redirect:/list.fi"; // 내부적으로 1번 페이지로 향함
				
			} else { // 실패 => 에러 문구를 담아서 에러페이지로 포워딩
				
				model.addAttribute("errorMsg", "게시글 등록 실패");
				
				return "common/errorPage";
			}
		}
		
		@RequestMapping("updateForm.fi")
		public ModelAndView updateFind(int fno,
									ModelAndView mv) {
			

			Find fb = boardService.updateFindList(fno);
			


			
			
			mv.addObject("fb", fb)
			  .setViewName("board/find-boardUpdate");
			
			return mv;
		}


		@RequestMapping("update.fi")
		public String updateBoard(Find fb,
							String category,
						HttpSession session,
						Model model) {
			
			
			fb.setCategory(category);
		int result = boardService.updateFind(fb);
		
		
		if(result > 0 ) { // 성공 => 일회성 알람문구 띄운 뒤 게시글 리스트페이지로 url 재요청
		
		
		session.setAttribute("alertMsg", "성공적으로 게시글이 수정되었습니다.");
		
		return "redirect:/list.fi"; // 내부적으로 1번 페이지로 향함
		
		} else { // 실패 => 에러 문구를 담아서 에러페이지로 포워딩
		
		model.addAttribute("errorMsg", "게시글 등록 실패");
		
		return "common/errorPage";
		}
		
		}

	//-----------------------이용후기--------------------------------
		@RequestMapping("list.in")
		public ModelAndView selectiList(
										@RequestParam(value="cPage", defaultValue="1") int currentPage,
										HttpServletRequest request,
				ModelAndView mv) {

			
			int listCount = boardService.selectiListCount();
			
			int pageLimit = 10;
			int boardLimit = 9;
			
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			ArrayList<InReview> ilist = boardService.selectiList(pi);


			mv.addObject("pi", pi) 
			  .addObject("ilist", ilist)
			  .setViewName("board/inReview-board");
			
			
			return mv;  


		}
		
		@RequestMapping("detail.in")
		public ModelAndView selectInReview(ModelAndView mv, int ino, HttpSession session) {
			
		    // 이미 조회한 게시글인지 확인하기 위해 세션 사용
		    Set<Integer> viewedPosts = (Set<Integer>) session.getAttribute("viewedPosts");
		    if (viewedPosts == null) {
		        viewedPosts = new HashSet<>();
		    }

		    // 게시글을 이전에 조회한 경우 조회수를 증가하지 않음
		    if (!viewedPosts.contains(ino)) {
		        int result = boardService.increaseInCount(ino);
		        if (result > 0) { // 성공
		            viewedPosts.add(ino);
		            session.setAttribute("viewedPosts", viewedPosts);
		        }
		    }

		    InReview i = boardService.selectInReview(ino);
		    if (i != null) {
		        mv.addObject("i", i)
		          .setViewName("board/inReview-boardDetail");
		    } else {
		        mv.addObject("errorMsg", "게시글 상세조회 실패")
		          .setViewName("common/errorPage");
		    }

		    return mv;
		}

		
		@RequestMapping("delete.in")
		public String deleteInReview(int ino,
								  Model model,
								  String filePath,
								  HttpSession session) {
			
			
			int result = boardService.deleteInReview(ino);
			
			if(result > 0) { // 삭제 처리 성공
				
				// delete.bo 요청 시 첨부파일이 있었을 경우
				// 서버에 보관중인 첨부 파일 실물 (수정파일명) 을 삭제 처리까지 같이 하고 싶음!!
				if(!filePath.equals("")) {
					// 넘어온 수정파일명이 있다면 == 애초에 해당 게시글에 첨부파일이 있었다면
					String realPath = session.getServletContext().getRealPath(filePath);
					new File(realPath).delete();
				}
				

				session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
				
				return "redirect:/list.in";
				
			} else { // 삭제 처리 실패 => 에러페이지 포워딩
				
				model.addAttribute("errorMsg", "게시글 삭제 실패");
				
				return "common/errorPage";
			}
		}
		
		@RequestMapping("enrollForm.in")
		public String enrollFormInReview() {
			
			return "board/inReview-boardEnrollForm";
		}
		
		@RequestMapping("insert.in")
		public String insertInReview(InReview i,
								 Battachment ba,
								MultipartFile upfile,
								HttpSession session,
								Model model) {
			
			/*
			 * if(!upfile.getOriginalFilename().equals("")) { // 넘어온 첨부파일이 있을 경우
			 * 
			 * String changeName = saveFile(upfile, session);
			 * 
			 * 
			 * ba.setOriginName(upfile.getOriginalFilename());
			 * ba.setChangeName("resources/img/board/fileupload/" + changeName); }
			 */
			

			int result = boardService.insertInReview(i);
			
      //int result2 = boardService.insertBattachment(ba);
			
			if(result > 0 /*|| result2 > 0*/) { // 성공 => 일회성 알람문구 띄운 뒤 게시글 리스트페이지로 url 재요청

				
				session.setAttribute("alertMsg", "성공적으로 게시글이 등록되었습니다.");
				
				return "redirect:/list.in"; // 내부적으로 1번 페이지로 향함
				
			} else { // 실패 => 에러 문구를 담아서 에러페이지로 포워딩
				
				model.addAttribute("errorMsg", "게시글 등록 실패");
				
				return "common/errorPage";
			}
		}
		
		
		@RequestMapping("updateForm.in")
		public ModelAndView updateInReview(int ino,
									ModelAndView mv) {
			
			
			InReview i = boardService.updateInReivewList(ino);
			
				
	
			mv.addObject("i", i)
			  .setViewName("board/inReview-boardUpdate");
			
			return mv;
		}


		@RequestMapping("update.in")
		public String updateInReview(InReview i,
						HttpSession session,
						Model model) {
			
				
	
		int result = boardService.updateInReivew(i);
		
		
		
		if(result > 0 ) { // 성공 => 일회성 알람문구 띄운 뒤 게시글 리스트페이지로 url 재요청
		
		
		session.setAttribute("alertMsg", "성공적으로 게시글이 수정되었습니다.");
		
		return "redirect:/list.in"; // 내부적으로 1번 페이지로 향함
		
		} else { // 실패 => 에러 문구를 담아서 에러페이지로 포워딩
		
		model.addAttribute("errorMsg", "게시글 등록 실패");
		
		return "common/errorPage";
		}
		
		}
		
		@ResponseBody
		@RequestMapping(value = "rlist.in", produces = "application/json; charset=UTF-8")
		public String ajaxSelectInReviewReplyList(int ino) {
			
			
			ArrayList<InReviewReply> list = boardService.selectInReviewReplyList(ino);
			
			
			
			return new Gson().toJson(list);
		}
		
		@ResponseBody
		@RequestMapping(value = "rinsert.in", produces = "text/html; charset=UTF-8")
		public String ajaxInsertInReviewReply(InReviewReply ir) {
			

			
			int result = boardService.insertInReviewReply(ir);
			
			return (result > 0) ? "success" : "fail";
		}
		
		@ResponseBody
		@RequestMapping(value = "rdelete.in", produces = "text/html; charset=UTF-8", method = RequestMethod.POST)
		public String ajaxDeleteiReply(@RequestParam("ire") int ireNo) {
			
		    int result = boardService.deleteiReply(ireNo);
		    
		    
		    return (result > 0) ? "success" : "fail";
		}
		
		@ResponseBody
		@RequestMapping(value = "rupdate.in", produces = "text/html; charset=UTF-8", method = RequestMethod.POST)
		public String ajaxUpdateiReply(@RequestParam("ire") int ireNo,
		                              @RequestParam("content") String content) {

		    int result = boardService.updateiReply(ireNo, content);
		    

		    return (result > 0) ? "success" : "fail";
		}
		
		
		@RequestMapping("report.fi")
		public ModelAndView reportFind(@RequestParam("value") int findNo, @RequestParam("value2") String findTitle, 
				@RequestParam("value3") String memberId, ModelAndView mv) {
		  
		  Report r = new Report();
		  r.setTypeNo(findNo);
		  r.setReportId(memberId);
		  r.setReportType("findBoard");
		  
		  mv.addObject("r", r);
		  mv.setViewName("report/reportUpdateForm");
		    
		  return mv;
		}
		
		@RequestMapping("report.bo")
		public ModelAndView reportBoard(@RequestParam("value") int boardNo, @RequestParam("value2") String boardTitle, 
				@RequestParam("value3") String memberId, ModelAndView mv) {
		  
		  Report r = new Report();
		  r.setTypeNo(boardNo);
		  r.setReportId(memberId);
		  r.setReportType("freeBoard");
		  
		  mv.addObject("r", r);
		  mv.setViewName("report/reportUpdateForm");
		    
		  return mv;
		}
		
		@RequestMapping("report.in")
		public ModelAndView reportInReview(@RequestParam("value") int inrNo, @RequestParam("value2") String inrTitle, 
				@RequestParam("value3") String memberId, ModelAndView mv) {
		  
		  Report r = new Report();
		  r.setTypeNo(inrNo);
		  r.setReportId(memberId);
		  r.setReportType("inReviewBoard");
		  
		  mv.addObject("r", r);
		  mv.setViewName("report/reportUpdateForm");
		    
		  return mv;
		}
	
		   
}
