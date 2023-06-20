package com.suim.house.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.concurrent.CompletableFuture;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.suim.common.mail.MailHandler;
import com.suim.common.model.vo.PageInfo;
import com.suim.common.template.Pagination;
import com.suim.house.model.service.AdminHouseService;
import com.suim.house.model.service.HouseService;
import com.suim.house.model.vo.House;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/admin")
@Controller
public class AdminHouseController {
	
	private final JavaMailSender mailSender;
	
	@Autowired
	private HouseService houseService;
	
	@Autowired
	private AdminHouseService adminHouseService;
	
	@Autowired
	public AdminHouseController(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
	
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
	
	@ResponseBody
	@RequestMapping("updateStatusAll.ho")
	public String updateStatusAll(String houseNo, String houseStatus, HttpServletRequest request) {

	    String[] idArray = houseNo.split(",");
	    int[] intArray = new int[idArray.length];
	    String[] email = new String[idArray.length];
	    House[] h = new House[idArray.length];
	    
	    for (int i = 0; i < idArray.length; i++) {
	        intArray[i] = Integer.parseInt(idArray[i]);
	        h[i] = houseService.selectHouse(intArray[i]);
	        email[i] = adminHouseService.selectEmail(h[i].getMemberId());
	    }
	    
	    int result = adminHouseService.updateStatusAll(intArray, houseStatus);
	    
	    for (int i = 0; i < idArray.length; i++) {
	        if (houseStatus.equals("심사완료")) {
	            // Call the mailSendAsync method
	            mailSendAsync(h[i].getHouseName(), email[i], true, h[i].getHouseNo());
	        } else if (houseStatus.equals("반려")) {
	            // Call the mailSendAsync method
	            mailSendAsync(h[i].getHouseName(), email[i], false, h[i].getHouseNo());
	        }
	    }
	    
	    return result > 0 ? "Y" : "N";
	}

	private void mailSendAsync(String houseName, String email, boolean isApproved, int hno) {
	    CompletableFuture.runAsync(() -> {
	        try {
	            MailHandler sendMail = new MailHandler(mailSender);
	            House h = houseService.selectHouse(hno);
				
	            String approvalMessage = "";
	            String contentMessage = "";
				if(h.getAge() > 0){
					approvalMessage = isApproved ? "재심사가 완료되었습니다." : "심사가 반려되었습니다.";
	            	contentMessage = isApproved ? "확인해주세요." : "하우스 정보를 다시 수정해 주세요.";
				} else {
		            approvalMessage = isApproved ? "심사가 완료되었습니다." : "심사가 반려되었습니다.";
		            contentMessage = isApproved ? "결제를 진행해 주세요." : "하우스 정보를 다시 수정해 주세요.";
				}
	            
	            // HTML content for the email
	            String htmlContent = "<html>"
	                    + "<head>"
	                    + "<style>"
	                    + "body { font-family: Arial, sans-serif; }"
	                    + "h3 { color: #333; }"
	                    + ".message { margin-top: 20px; padding: 10px; background-color: #f9f9f9; border: 1px solid #ddd; }"
	                    + ".payment-button { display: inline-block; margin-top: 20px; padding: 10px 20px; background-color: #007bff; color: #fff; text-decoration: none; }"
	                    + "</style>"
	                    + "</head>"
	                    + "<body>"
	                    + "<h3>" + approvalMessage + "</h3>"
	                    + "<div class='message'>"
	                    + "<p>안녕하세요, 쉼입니다.</p>"
	                    + "<p>" + houseName + "의  " + approvalMessage + "</p>"
	                    + "<p>마이페이지 셰어하우스 목록에서 " + contentMessage + "</p>"
	                    + "<p>궁금하신 사항이 있으면 채널톡의 관리자에게 문의해 주세요.</p>"
	                    + "<p>감사합니다.</p>"
	                    + "</div>"
	                    + "</body>"
	                    + "</html>";

	            sendMail.setText(htmlContent);
	            sendMail.setFrom("suimm012@gmail.com", "쉼");
	            sendMail.setSubject(houseName + "의 " + approvalMessage);
	            sendMail.setTo(email);
	            sendMail.send();
	        } catch (MessagingException e) {
	            log.error("메일 전송 중 에러 발생: {}", e.getMessage());
	        } catch (Exception e) {
	            log.error("기타 에러 발생: {}", e.getMessage());
	        }
	    });
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
