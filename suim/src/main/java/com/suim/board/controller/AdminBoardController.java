package com.suim.board.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.suim.board.model.service.AdminBoardService;
import com.suim.board.model.service.BoardService;
import com.suim.board.model.vo.Board;
import com.suim.board.model.vo.Find;
import com.suim.board.model.vo.InReview;
import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;

@Controller
public class AdminBoardController {
	
	@Autowired
	private AdminBoardService adminBoardService;
	
	@Autowired
	private BoardService boardService;
	
	// 자유게시판 관리자페이지 controller
	
	// 자유게시판 모든 글 조회
	@RequestMapping("adminBoardList.bo")
	public ModelAndView adminBoardList(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
									   @RequestParam(value="category", defaultValue="A") String category,
										ModelAndView mv) {
		
		if(category == null || category.equals("A")) {
			
			int listCount = adminBoardService.adminBoardCountA();

			int pageLimit = 10;
			int boardLimit = 10;
		        
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

			ArrayList<Board> list =  adminBoardService.adminBoardListA(pi);
			
			mv.addObject("pi", pi)
	          .addObject("list", list)
	          .addObject("category", category)
			  .setViewName("admin/board/freeBoard"); 
			
		} else {
			
			int listCount = adminBoardService.adminBoardCount(category);

			int pageLimit = 10;
			int boardLimit = 10;
		        
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

			ArrayList<Board> list =  adminBoardService.adminBoardList(pi, category);
			
			mv.addObject("pi", pi)
	          .addObject("list", list)
	          .addObject("category", category)
			  .setViewName("admin/board/freeBoard"); 
			
		}

		return mv;
	}
	
	// 관리자페이지에서 상세페이지 조회
	@RequestMapping("adminDetail.bo")
	public ModelAndView adminDetailBoard(ModelAndView mv,
									int bno) {

			Board b = adminBoardService.adminDetailBoard(bno);
			
			mv.addObject("b", b).setViewName("admin/board/freeDetailBoard");
			
		
		return mv;
	}
	
	// 관리자페이지에서 글 수정 페이지
	@RequestMapping("adminUpdateForm.bo")
	public ModelAndView updateBoard(int bno,
			ModelAndView mv) {


	Board b = boardService.updateBoardList(bno);
	
	mv.addObject("b", b)
	.setViewName("admin/board/freeUpdateBoard");
	return mv;
	}
	
	// 관리자페이지에서 글 수정하기
	@RequestMapping("adminUpdate.bo")
	public String updateBoard(Board b,
			HttpSession session,
			Model model) {

		int result = boardService.updateBoard(b);
		
		if(result > 0 ) { // 성공 => 일회성 알람문구 띄운 뒤 게시글 리스트페이지로 url 재요청
		
		
		session.setAttribute("alertMsg", "성공적으로 게시글이 수정되었습니다.");
		
		return "redirect:/adminBoardList.bo"; 
		
		} else { // 실패 => 에러 문구를 담아서 에러페이지로 포워딩
		
		model.addAttribute("errorMsg", "게시글 등록 실패");
		
		return "common/errorPage";
		}
		
	}
	
	// 관리자 페이지에서 글 삭제 및 되살리기
	@RequestMapping("adminDelete.bo")
	public String adminDeleteCon(@RequestParam(value="checkboxName", required = false) int[] boardNo,
								 @RequestParam(value="deleteControl") String delCon,
								 Model model, HttpSession session, HttpServletRequest request) {
			
		if(boardNo != null && boardNo.length > 0) {
			
			if("삭제".equals(delCon)){
				
				for(int bno : boardNo) {
					
					int result1 = adminBoardService.deleteBoard(bno);
					
					if(result1 > 0) {
						
						session.setAttribute("alertMsg", "자유게시판 삭제에 성공했습니다.");
						
					} else {
						
						session.setAttribute("alertMsg", "자유게시판 삭제에 실패했습니다.");
						
					}
					
				}
				
			} else if("복구".equals(delCon)) {
				
					for(int bno : boardNo) {
					
						int result2 = adminBoardService.deleteCanBoard(bno);
						
						if(result2 > 0) {
							
							session.setAttribute("alertMsg", "자유게시판 복구에 했습니다.");
							
						} else {
							
							session.setAttribute("alertMsg", "자유게시판 복구에 실패했습니다.");
							
						}
					}
			}
			
		} else {
			
			session.setAttribute("alertMsg", "체크된 자유게시판이 없습니다.");
			
		}
		
		return "redirect:/adminBoardList.bo";
		
	}
	
	// 키워드 검색
	@RequestMapping("adminBoardSearch.bo")
	public ModelAndView adminBoardSearch(@RequestParam(value="condition") String condition,
			 							 @RequestParam(value="keyword") String keyword,
										 @RequestParam(value="category", defaultValue="A") String category,
										 @RequestParam(value="currentPage", defaultValue="1") int currentPage,
										 ModelAndView mv) {
	
		HashMap<String, String> map = new HashMap<>();
		
		map.put("condition", condition);
		map.put("keyword", keyword);

		
		int listCount = adminBoardService.adminBoardSearchCount(map);
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Board> list = adminBoardService.adminBoardSearch(map, pi);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("keyword", keyword)
		  .addObject("category", category)
		  .addObject("condition", condition)
		  .setViewName("admin/board/freeBoard");
		return mv;
	}
	
	// 사람구해요 관리자페이지 controller

		// 사람구해요 게시판 모든 글 조회
		@RequestMapping("/adminFindList.bo")
		public ModelAndView adminFindList(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
											ModelAndView mv) {
			
		
				int listCount = adminBoardService.adminFindCount();

				int pageLimit = 10;
				int boardLimit = 10;
			        
				PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

				ArrayList<Find> list =  adminBoardService.adminFindList(pi);
				
				mv.addObject("pi", pi)
		          .addObject("list", list)
				  .setViewName("admin/board/findBoard"); 

			return mv;
		}
		
		// 사람구해요 게시판 관리자페이지에서 상세페이지 조회
		@RequestMapping("adminFindDetail.bo")
		public ModelAndView selectBoard(ModelAndView mv, HttpServletRequest request,
										int fno) {

			Find fb = adminBoardService.adminFindDetail(fno);
			
			mv.addObject("fb", fb)
			  .addObject("url", request.getRequestURI())
			  .setViewName("admin/board/findDetailBoard");
							
			return mv;
		}
		
		// 사람구해요 게시판 관리자페이지에서 업데이트페이지 이동
		@RequestMapping("adminFindUpdateForm.bo")
		public ModelAndView updateFind(int fno,
									ModelAndView mv) {
			

			Find fb = boardService.updateFindList(fno);
			
			mv.addObject("fb", fb)
			  .setViewName("admin/board/findUpdateBoard");
			
			return mv;
		}
		
		// 사람구해요 게시판 관리자페이지 수정 기능 구현
		@RequestMapping("adminFindUpdate.bo")
		public String updateBoard(Find fb,
							String category,
						HttpSession session,
						Model model) {
			
			
				fb.setCategory(category);
			int result = boardService.updateFind(fb);
			
			
			if(result > 0 ) { // 성공 => 일회성 알람문구 띄운 뒤 게시글 리스트페이지로 url 재요청
			
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 수정되었습니다.");
			
			return "redirect:/adminFindList.bo"; // 내부적으로 1번 페이지로 향함
			
			} else { // 실패 => 에러 문구를 담아서 에러페이지로 포워딩
			
			model.addAttribute("errorMsg", "게시글 등록 실패");
			
			return "common/errorPage";
			}
		
		}
		
		// 사람구해요 게시판 관리자페이지에서 상세페이지 조회
		@RequestMapping("adminFindDeSearch.bo")
		public ModelAndView adminFindDeSearchList(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
												  @RequestParam(value="gender") String gender,
												  @RequestParam(value="category") String category,
												  @RequestParam(value="del") String del,
												  ModelAndView mv) {

		HashMap<String, String> map = new HashMap<>();
	
		map.put("gender", gender);
		map.put("category", category);
		map.put("del", del);
		
		int listCount = adminBoardService.adminFreeDeSearchCount(map);
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<Find> list =  adminBoardService.adminFreeDeSearch(map, pi);
		
		mv.addObject("pi", pi)
		.addObject("list", list)
		.addObject("gender", gender)
		.addObject("category", category)
		.addObject("del", del)		
		.setViewName("admin/board/findBoard"); 
		
		return mv;
		}
		
		// 키워드 검색
		@RequestMapping("adminFindKeySearch.bo")
		public ModelAndView adminFindKeySearchList(@RequestParam(value="condition") String condition,
				 							 @RequestParam(value="keyword") String keyword,
											 @RequestParam(value="currentPage", defaultValue="1") int currentPage,
											 ModelAndView mv) {
		
			HashMap<String, String> map = new HashMap<>();
			
			map.put("condition", condition);
			map.put("keyword", keyword);

			
			int listCount = adminBoardService.adminFreeKeySearchCount(map);
			
			int pageLimit = 10;
			int boardLimit = 10;
			
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			
			ArrayList<Find> list = adminBoardService.adminFreeKeySearch(map, pi);
			
			mv.addObject("pi", pi)
			  .addObject("list", list)
			  .addObject("keyword", keyword)
			  .addObject("condition", condition)
			  .setViewName("admin/board/findBoard");
			
			return mv;
		}
		
		// 관리자 페이지에서 글 삭제 및 되살리기
		@RequestMapping("adminFindDelete.bo")
		public String adminFindDelete(@RequestParam(value="checkboxName", required = false) int[] findNo,
									 	 @RequestParam(value="deleteControl") String delCon,
									     Model model, HttpSession session, HttpServletRequest request) {
				
			if(findNo != null && findNo.length > 0) {
				
				if("삭제".equals(delCon)){
					
					for(int fno : findNo) {
						
						int result1 = adminBoardService.deleteFreeBoard(fno);
						
						if(result1 > 0) {
							
							session.setAttribute("alertMsg", "사람구해요 게시판 삭제에 성공했습니다.");
							
						} else {
							
							session.setAttribute("alertMsg", "사람구해요 게시판 삭제에 실패했습니다.");
							
						}
						
					}
					
				} else if("복구".equals(delCon)) {
					
						for(int fno : findNo) {
						
							int result2 = adminBoardService.deleteFreeCanBoard(fno);
							
							if(result2 > 0) {
								
								session.setAttribute("alertMsg", "사람구해요 게시판 복구에 했습니다.");
								
							} else {
								
								session.setAttribute("alertMsg", "사람구해요 게시판 복구에 실패했습니다.");
								
							}
						}
				}
				
			} else {
				
				session.setAttribute("alertMsg", "체크된 사람구해요 게시판이 없습니다.");
				
			}
			
			return "redirect:/adminFindList.bo";
			
		}
		
		
		// 플랫폼 이용후기 관리자페이지 controller
		@RequestMapping("adminInReviewList.bo")
		public ModelAndView adminInReviewList(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
										   @RequestParam(value="category", defaultValue="A") String category,
											ModelAndView mv) {
			
			if(category == null || category.equals("A")) {
				
				int listCount = adminBoardService.adminInReviewCountA();

				int pageLimit = 10;
				int boardLimit = 10;
			        
				PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

				ArrayList<InReview> list =  adminBoardService.adminInReviewListA(pi);
				
				mv.addObject("pi", pi)
		          .addObject("list", list)
		          .addObject("category", category)
				  .setViewName("admin/board/inReviewBoard"); 
				
			} else {
				
				int listCount = adminBoardService.adminInReviewCount(category);

				int pageLimit = 10;
				int boardLimit = 10;
			        
				PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

				ArrayList<InReview> list =  adminBoardService.adminInReviewList(pi, category);
				
				mv.addObject("pi", pi)
		          .addObject("list", list)
		          .addObject("category", category)
				  .setViewName("admin/board/inReviewBoard"); 
				
			}

			return mv;
		}
		
		// 관리자페이지에서 상세페이지 조회
		@RequestMapping("adminInrDetail.bo")
		public ModelAndView detailInReview(ModelAndView mv,
				int ino) {

			InReview i = adminBoardService.detailInReview(ino);
			
			mv.addObject("i", i).setViewName("admin/board/inReviewDetailBoard");

			
			return mv;
		}
		
		// 이용후기 수정 페이지 불러오기 
		@RequestMapping("adminInrUpdateForm.bo")
		public ModelAndView updateInReview(int ino,
									ModelAndView mv) {
			
			
			InReview i = boardService.updateInReivewList(ino);
			
				
	
			mv.addObject("i", i)
			  .setViewName("admin/board/inReviewUpdateBoard");
			
			return mv;
		}
		
		// 이용후기 수정 기능
		@RequestMapping("adminInrUpdate.bo")
		public String updateInReview(InReview i,
						HttpSession session,
						Model model) {

			int result = boardService.updateInReivew(i);
	
			if(result > 0 ) { // 성공 => 일회성 알람문구 띄운 뒤 게시글 리스트페이지로 url 재요청
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 수정되었습니다.");
			
			return "redirect:/adminInReviewList.bo"; 
			
			} else { // 실패 => 에러 문구를 담아서 에러페이지로 포워딩
			
			model.addAttribute("errorMsg", "게시글 등록 실패");
			
			return "common/errorPage";
			}
		
		}
		
		
		// 관리자 페이지에서 글 삭제 및 되살리기
				@RequestMapping("adminInrDelete.bo")
				public String adminInrDelete(@RequestParam(value="checkboxName", required = false) int[] inrNo,
											 	 @RequestParam(value="deleteControl") String delCon,
											     Model model, HttpSession session, HttpServletRequest request) {
						
					if(inrNo != null && inrNo.length > 0) {
						
						if("삭제".equals(delCon)){
							
							for(int ino : inrNo) {
								
								int result1 = adminBoardService.deleteInrBoard(ino);
								
								if(result1 > 0) {
									
									session.setAttribute("alertMsg", "이용후기 게시판 삭제에 성공했습니다.");
									
								} else {
									
									session.setAttribute("alertMsg", "이용후기 게시판 삭제에 실패했습니다.");
									
								}
								
							}
							
						} else if("복구".equals(delCon)) {
							
								for(int ino : inrNo) {
								
									int result2 = adminBoardService.deleteInrCanBoard(ino);
									
									if(result2 > 0) {
										
										session.setAttribute("alertMsg", "이용후기 게시판 복구에 했습니다.");
										
									} else {
										
										session.setAttribute("alertMsg", "이용후기 게시판 복구에 실패했습니다.");
										
									}
								}
						}
						
					} else {
						
						session.setAttribute("alertMsg", "체크된 이용후기 게시판이 없습니다.");
						
					}
					
					return "redirect:/adminInReviewList.bo";
					
				}

		// 키워드 검색
		@RequestMapping("adminInrSearch.bo")
		public ModelAndView adminInrSearch(@RequestParam(value="condition") String condition,
						 					 @RequestParam(value="keyword") String keyword,
											 @RequestParam(value="category", defaultValue="A") String category,
											 @RequestParam(value="currentPage", defaultValue="1") int currentPage,
											 ModelAndView mv) {
				
					HashMap<String, String> map = new HashMap<>();
					
					map.put("condition", condition);
					map.put("keyword", keyword);

					
					int listCount = adminBoardService.adminInrSearchCount(map);
					
					int pageLimit = 10;
					int boardLimit = 10;
					
					PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
					
					ArrayList<InReview> list = adminBoardService.adminInrSearch(map, pi);
					
					mv.addObject("pi", pi)
					  .addObject("list", list)
					  .addObject("keyword", keyword)
					  .addObject("category", category)
					  .addObject("condition", condition)
					  .setViewName("admin/board/inReviewBoard");
					return mv;
				}
			
}
