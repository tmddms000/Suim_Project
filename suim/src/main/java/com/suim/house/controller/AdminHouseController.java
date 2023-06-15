package com.suim.house.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
	
	// 리스트 조회 포워딩용
	@RequestMapping("list.ho")
	public String selectList(
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			@RequestParam(value="category", defaultValue="all") String category,
			Model model) {
		
		int pageLimit = 10;
		int boardLimit = 10;

		ArrayList<House> list = new ArrayList<House>();

		// listCount 는 게시판 종류에 따라 달라지게 하기(조건문에 집어넣을거임)
		int listCount = 0;
		PageInfo pi = null;

		if (category == null || category.equals("all")) {

			listCount = adminHouseService.selectListCount();
			pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			list = adminHouseService.selectList(pi);
			
		} else {

			listCount = adminHouseService.selectCategoryListCount(category);
			pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			list = adminHouseService.selectCategoryList(pi, category);

		}

		model.addAttribute("pi", pi).addAttribute("list", list).addAttribute("category", category);
		
		return "admin/house/house";
	}

	
	@RequestMapping("detail.ho")
	public ModelAndView selectHouse(ModelAndView mv,
									@RequestParam(value="hno") int houseNo) {
			House h = adminHouseService.selectHouse(houseNo);
			
			// 조회된 데이터를 mv 에 담아서 포워딩 페이지 경로를 잡아주기
			mv.addObject("h", h).setViewName("admin/house/house_detail");
		
		return mv;
	}
	
	// 승인/반려 처리용
	@RequestMapping("updateStatus.ho")
	public String updateHouseStatus(House h,
							HttpSession session,
							Model model) {

		int result = adminHouseService.updateHouseStatus(h);
		
		if(result > 0) { // 성공
			
			// 일회성 알람문구를 담아서 게시판 상세보기 페이지로 url 재요청
			session.setAttribute("alertMsg", "성공적으로 상태가 수정되었습니다.");
			
			return "redirect:/admin/detail.ho?hno=" + h.getHouseNo();
			
		} else { // 실패
			
			// 에러문구 담아서 에러페이지로 포워딩
			model.addAttribute("errorMsg", "게시글 수정 실패");
			
			return "common/errorPage";
		}
	}
	
	// 전체 선택 승인/반려용
	@ResponseBody
	@RequestMapping("updateStatusAll.ho")
	public String updateStatusAll(String houseNo, 
								String houseStatus,
								HttpServletRequest request) {

		String[] idArray = houseNo.split(",");
		int[] intArray = new int[idArray.length];
		for (int i = 0; i < idArray.length; i++) {
			intArray[i] = Integer.parseInt(idArray[i]);
		}
		int result = adminHouseService.updateStatusAll(intArray, houseStatus);
		return result > 0 ? "Y" : "N";
	}
	
	// 검색용
	@RequestMapping("search.ho")
	public ModelAndView selectSearch(String condition, String keyword, 
						@RequestParam(value="currentPage", defaultValue="1") int currentPage,
						ModelAndView mv) {
		
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
		
		House h = adminHouseService.selectHouse(houseNo);
		
		model.addAttribute("h", h);
		
		return "admin/house/house_update";
	}
}
