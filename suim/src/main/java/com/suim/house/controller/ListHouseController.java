package com.suim.house.controller;

import java.util.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.suim.common.mail.MailHandler;
import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;
import com.suim.house.model.service.HouseService;
import com.suim.house.model.service.ListHouseService;
import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Region;
import com.suim.house.model.vo.Reservation;
import com.suim.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ListHouseController {
	
	private final JavaMailSender mailSender;
	
	@Autowired
	public ListHouseController(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
	
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

		    if (region.isEmpty()) {
		        mv.addObject("regionEmpty", true);
		        
		        ArrayList<House> centerAd = listHouseService.keyCenterAd(searchKeyword);
		        		        
		        if(centerAd.isEmpty()) {
			        mv.addObject("centerAdEmpty", true);
		        } else {
		        	mv.addObject("centerAd", centerAd);
		        }
		        
		    } else {
		        mv.addObject("region", region);
		    }
		    
		    if(minValue != null ) {
		    	
		    	// 문자열을 int 타입으로 변환
		    	int minIn = Integer.parseInt(minValue);
		    	int maxIn = Integer.parseInt(maxValue);

		    	// int 타입에 10000을 곱함
		    	int divMin = minIn/10000;
		    	int divMax = maxIn/10000;

		    	// 다시 String 타입으로 변환
		    	String minValueResult = String.valueOf(divMin);
		    	String maxValueResult = String.valueOf(divMax);
		    	
		       mv.addObject("minValueResult", minValueResult);
		       mv.addObject("maxValueResult", maxValueResult);
		    
		    } else {
		    	
		       mv.addObject("minValueResult", 0);
			   mv.addObject("maxValueResult", 500);
		    }
		   
		    mv.addObject("list", list);
		    mv.addObject("searchKeyword",searchKeyword);

		    mv.setViewName("house/houseMapView"); 
		    
		    return mv;
	}
	
	// 예약신청 팝업창 컨트롤러
	@RequestMapping("houseRez.ho")
	public String reservationPage(@RequestParam("value") int houseNo, @RequestParam("value2") String houseName, @RequestParam("value3") String memberId,
									HttpSession session, HttpServletRequest request, RedirectAttributes redirectAttributes, Model model) {

	    Member loginUser = (Member) session.getAttribute("loginUser");
	    
	    String Id = loginUser.getMemberId();
	    
		 Map<String, Object> rezCheck = new HashMap<>();
			 rezCheck.put("hno", houseNo);
			 rezCheck.put("Id", Id);
		
	    int rezChResult = listHouseService.rezChCount(rezCheck);
	    	    
	    if(rezChResult > 0) {
	    	
	        session.setAttribute("altMsg", "이미 신청중인 예약이 있습니다.");
	        
		    return "house/houseReservation";

	    } else {
	    
		    model.addAttribute("houseNo", houseNo);
		    model.addAttribute("loginUser", loginUser);
		    model.addAttribute("memberId", memberId);
		    model.addAttribute("houseName", houseName);
	
		    return "house/houseReservation";
	    }
	}
	
	// 예약 신청(등록) 컨트롤러
	@RequestMapping("enrollReservation.rez")
	public String reservationInsert(Model model, HttpServletRequest request, HttpSession session,
									@DateTimeFormat(pattern = "yyyy-MM-dd")Date rezDate, String rezHour, int houseNo,
									String sendMemberId, String recMemberId) {
		
		 Map<String, Object> reservation = new HashMap<>();
				 reservation.put("rezDate", rezDate);
				 reservation.put("rezHour", rezHour);
				 reservation.put("houseNo", houseNo);
				 reservation.put("sendMemberId", sendMemberId);
				 reservation.put("recMemberId", recMemberId);
				
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
		public ModelAndView myHouseRezSelect(ModelAndView mv, @RequestParam(value="cPage", defaultValue="1")
		int currentPage, @RequestParam(value="houseNo") int houseNo, HttpSession session, HttpServletRequest request) {
			
			session.setAttribute("originalUrl", request.getRequestURI());
			
			Member loginUser = (Member) session.getAttribute("loginUser");
			
	        int pageLimit = 10;
	        int boardLimit = 10;
	        int listCount = 0;
	        PageInfo pi = null;
	        listCount = listHouseService.selectHouseRezListCount(houseNo);
	        pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
				
			ArrayList<Reservation> list = listHouseService.selectHouseRezList(pi,houseNo);
			mv.addObject("pi", pi);
		    mv.addObject("list", list);
		    mv.addObject("houseNo", houseNo);
		    
		    if (loginUser == null) {
				session.setAttribute("alertMsg", "로그인 후 이용 가능합니다.");
			    mv.setViewName("redirect:/member/login");
				return mv;
				
			} else {
		    
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
		@RequestMapping("rezCancelPop.rez")
		public String rezCancelPop(@RequestParam("value") int rezNo, @RequestParam("value2") String houseName,
										HttpSession session, HttpServletRequest request, RedirectAttributes redirectAttributes, Model model) {

			ArrayList<Reservation> r = listHouseService.selectRezOne(rezNo);

		    model.addAttribute("r", r);
		    model.addAttribute("houseName", houseName);
		
		    return "member/mypage/reservationCancel";
		    
		}
		
		@RequestMapping("rezCancel.rez")
		public ModelAndView rezCancel(ModelAndView mv, HttpServletRequest request, HttpSession session,
		                              int rezNo, String cancelContent, String sendMemberId, String recMeberId, String houseName) {
		    Map<String, Object> rezCancel = new HashMap<>();
		    rezCancel.put("rezNo", rezNo);
		    rezCancel.put("cancelContent", cancelContent);

		    int result = listHouseService.rezCancel(rezCancel);

		    String se = listHouseService.memberEmail(sendMemberId);
		    String re = listHouseService.memberEmail(recMeberId);

		    // Call the mailSendAsync method for sending cancellation emails
		    mailSendAsync(houseName, se, re, cancelContent);

		    if (result > 0) { // 성공
		        session.setAttribute("canMsg", "예약이 취소되었습니다.");
		    } else { // 실패
		        session.setAttribute("canMsg", "예약 취소에 실패하였습니다.");
		    }

		    String cancel = request.getHeader("Referer");
		    mv.setViewName("redirect:" + cancel);

		    return mv;
		}

		private void mailSendAsync(String houseName, String sendEmail, String recEmail, String cancelContent) {
		    CompletableFuture.runAsync(() -> {
		        try {
		            MailHandler sendMail = new MailHandler(mailSender);
		            sendMail.setText("<h1>예약이 취소되었습니다.</h1>"
		                    + "<br><br>"
		                    + "<h3>취소사유 :</h3>"
		                    + "<br>" + cancelContent);
		            sendMail.setFrom("suimm012@gmail.com", "쉼");
		            sendMail.setSubject(houseName + "의 예약이 취소되었습니다.");
		            sendMail.setTo(sendEmail);
		            sendMail.send();
		            sendMail.setTo(recEmail);
		            sendMail.send();
		        } catch (MessagingException e) {
		            log.error("메일 전송 중 에러 발생: {}", e.getMessage());
		        } catch (Exception e) {
		            log.error("기타 에러 발생: {}", e.getMessage());
		        }
		    });
		}





}
