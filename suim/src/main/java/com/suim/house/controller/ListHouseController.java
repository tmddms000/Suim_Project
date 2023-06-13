package com.suim.house.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.suim.house.model.service.HouseService;
import com.suim.house.model.service.ListHouseService;
import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Region;
import com.suim.house.model.vo.Reservation;
import com.suim.house.model.vo.Wish;
import com.suim.member.model.vo.Member;

@Controller
public class ListHouseController {
	
	@Autowired
	private ListHouseService listHouseService;
	@Autowired
	private HouseService HouseService;
	
	// 지도와 셰어하우스 리스트 상세 검색
	@RequestMapping("list.ho")
	public ModelAndView selectList(ModelAndView mv,
				String searchKeyword,
				String minValue,
			    String maxValue,
				String[] genderDivisions,
				String[] maxResident,
				String[] houseType,
				String[] floor,
			    @DateTimeFormat(pattern = "yyyy-MM-dd")Date openDate) {
					
			if (searchKeyword == null) {
		        searchKeyword = ""; 
			}
			
			ArrayList<Region> region = listHouseService.regionSelectList(searchKeyword);
		    ArrayList<House> list = listHouseService.selectList(minValue,maxValue,genderDivisions,houseType,maxResident,floor,openDate);
		    
		    mv.addObject("list", list);
		     
		    if (region.isEmpty()) {
		        mv.addObject("regionEmpty", true);
		    } else {
		        mv.addObject("region", region);
		    }
		    
		    if(minValue != null ) {
		       mv.addObject("minValueResult", minValue);
		    } else {
		       mv.addObject("minValueResult", 0);
		    }
		    
		    if(maxValue != null) {
		       mv.addObject("maxValueResult", maxValue);
		    } else {
			   mv.addObject("maxValueResult", 300);
		    }
		    	
		    mv.setViewName("house/houseMapView"); 
		    
		    return mv;
	}
	
	// 예약신청 팝업창 컨트롤러
	@RequestMapping("houseRez.ho")
	public String reservationPage(@RequestParam("value") int houseNo, @RequestParam("value2") String houseName,
									HttpSession session, HttpServletRequest request, RedirectAttributes redirectAttributes, Model model) {

	    Member loginUser = (Member) session.getAttribute("loginUser");

	    model.addAttribute("houseNo", houseNo);
	    model.addAttribute("loginUser", loginUser);
	    model.addAttribute("houseName", houseName);

	    return "house/houseReservation";

	}
	
	// 예약 신청(등록) 컨트롤러
	@RequestMapping("enrollReservation.rez")
	public String reservationInsert(Model model, HttpServletRequest request, HttpSession session,
									Date rezDate, String rezHour, int houseNo, String memberId) {
		
		 Map<String, Object> reservation = new HashMap<>();
				 reservation.put("rezDate", rezDate);
				 reservation.put("rezHour", rezHour);
				 reservation.put("houseNo", houseNo);
				 reservation.put("memberId", memberId);
				
		int result = listHouseService.rezInsert(reservation); 
		
		 if (result > 0) { // 성공
		        session.setAttribute("alMsg", "성공적으로 예약 신청이 되었습니다.");
		    } else { // 실패
		        session.setAttribute("alMsg", "예약 신청에 실패했습니다.");
		    }
		
		String rezPopup = request.getHeader("Referer");
		return "redirect:" + rezPopup;
	}
	
	// 셰어하우스 별 예약 신청 리스트
	@RequestMapping("myhouseRez.ho")
	public ModelAndView myHouseRezSelect(ModelAndView mv, int houseNo) {
		
		House h = HouseService.selectHouse(houseNo);
		
		if (h.getEnrollStatus().equals("심사완료")) {
			mv.addObject("h", h);
			mv.setViewName("/house/kakao"); 
			return mv;
		} else {
		
		ArrayList<Reservation> list = listHouseService.myHouseRezSelect(houseNo);
		
	    mv.addObject("list", list);
	    
	    mv.setViewName("member/mypage/myHouseReservation"); 
		
	    return mv;
		}
	}
	
	// 셰어하우스 예약 확인
	@RequestMapping("confirmRez.rez")
	public ModelAndView confirmRez(ModelAndView mv, HttpServletRequest request, HttpSession session, int rno, int houseNo) {
	
		int result = listHouseService.confirmRez(rno);
		
		if (result > 0) { // 성공
	        session.setAttribute("conMsg", "성공적으로 예약 확정 되었습니다.");
	    } else { // 실패
	        session.setAttribute("conMsg", "예약 확정에 실패했습니다.");
	    }
	
		String confirm = request.getHeader("Referer");
		
	    mv.addObject("houseNo", houseNo);

	    mv.setViewName("redirect:" + confirm); 

	    return mv;
	
	}	
	
		// 예약취소 팝업창 컨트롤러
		@RequestMapping("rezCancel.rez")
		public String rezCancelPop(@RequestParam("value") int rezNo, @RequestParam("value2") String houseName,
										HttpSession session, HttpServletRequest request, RedirectAttributes redirectAttributes, Model model) {

		    model.addAttribute("rezNo", rezNo);
		    model.addAttribute("houseName", houseName);
		
		    return "member/mypage/reservationCancel";
		    
		}
		
		// 셰어하우스 예약 취소
	
}
