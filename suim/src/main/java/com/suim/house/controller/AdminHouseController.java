package com.suim.house.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;
import com.suim.house.model.service.AdminHouseService;
import com.suim.house.model.vo.House;
import com.suim.report.model.vo.Report;

@RequestMapping("/admin")
@Controller
public class AdminHouseController {

	@Autowired
	private AdminHouseService adminHouseService;
	
	// 신고 리스트 조회 포워딩용
	@RequestMapping("list.ho")
	public ModelAndView selectList(
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			ModelAndView mv) {
		
		// 페이징처리를 위한 PageInfo 객체 얻어내기
		int listCount = adminHouseService.selectListCount();
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<House> list = adminHouseService.selectList(pi);

		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .setViewName("admin/report/report");
		
		return mv;
	}
	
	@ResponseBody
	// 카테고리용 전체 조회용
	@RequestMapping(value = "category.ho", produces = "application/json; charset=UTF-8")
	public Map<String, Object> selectList(
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			ModelAndView mv,
			String category) {
		
		// 페이징처리를 위한 PageInfo 객체 얻어내기
		int listCount = adminHouseService.selectListCount();
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		ArrayList<House> list = new ArrayList<>();
		
		if(category == null || category.equals("A")) {
			list = adminHouseService.selectList(pi);
		} else {
			list = adminHouseService.selectList(pi, category);
		}
		
		Map<String, Object> response = new HashMap<>();
		response.put("pi", pi);
		response.put("list", list);
		return response;
	}

	
	@RequestMapping("detail.ho")
	public ModelAndView selectHouse(ModelAndView mv,
									@RequestParam(value="hno") int houseNo) {
			House h = adminHouseService.selectHouse(houseNo);
			
			// 조회된 데이터를 mv 에 담아서 포워딩 페이지 경로를 잡아주기
			mv.addObject("h", h).setViewName("admin/house/house_detail");
		
		return mv;
	}
	
	@RequestMapping("delete.ho")
	public String deleteHouse(@RequestParam("hno") int houseNo,
							  Model model,
							  String filePath,
							  HttpSession session) {
		
		
		int result = adminHouseService.deleteHouse(houseNo);
		
		if(result > 0) { // 삭제 처리 성공
			
			// delete.bo 요청 시 첨부파일이 있었을 경우
			// 서버에 보관중인 첨부 파일 실물 (수정파일명) 을 삭제 처리까지 같이 하고 싶음!!
			if(!filePath.equals("")) {
				// 넘어온 수정파일명이 있다면 == 애초에 해당 게시글에 첨부파일이 있었다면
				String realPath = session.getServletContext().getRealPath(filePath);
				new File(realPath).delete();
			}
			
			// 일회성 알람 문구 담고 게시판 리스트페이지로 url 재요청
			session.setAttribute("alertMsg", "성공적으로 OO가 삭제되었습니다.");
			
			return "redirect:/admin/list.ho";
			
		} else { // 삭제 처리 실패 => 에러페이지 포워딩
			
			model.addAttribute("errorMsg", "회원 삭제 실패");
			
			return "common/errorPage";
		}
	}
	
	@RequestMapping("updateForm.ho")
	public String updateForm(@RequestParam("hno") int houseNo,
						   Model model) {
		
		// 게시글 상세보기용 selectMember 요청 재활용
		House h = adminHouseService.selectHouse(houseNo);
		
		model.addAttribute("h", h);
		
		return "admin/house/house_update";
	}
	
	// 검색용
	@RequestMapping("search.ho")
	public ModelAndView selectSearch(String condition, String keyword, 
						@RequestParam(value="currentPage", defaultValue="1") int currentPage,
						ModelAndView mv) {
		
		// 페이징처리를 위한 PageInfo 객체 얻어내기
		int listCount = adminHouseService.selectListCount();
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		HashMap<String, String> map = new HashMap<>();
		
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		
		ArrayList<House> list = adminHouseService.selectSearchList(map, pi);
		
		System.out.println(list);

		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .setViewName("admin/house/house");
		
		return mv;
	}
}
