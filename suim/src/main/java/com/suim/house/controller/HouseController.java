package com.suim.house.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.suim.common.mail.MailHandler;
import com.suim.house.model.service.HouseService;
import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Photo;
import com.suim.house.model.vo.Wish;
import com.suim.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HouseController {
	
	private final JavaMailSender mailSender;
	
	@Autowired
	private HouseService houseService;
	
	@Autowired
	public HouseController(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
	
	@RequestMapping("detail.ho")
	public ModelAndView selectList(ModelAndView mv, int hno, HttpSession session) {
		
	    House h = houseService.selectHouse(hno);
	    
	    if (!h.getEnrollStatus().equals("등록완료")) {
	    	session.setAttribute("alertMsg", "현재 심사중입니다.");
	    	mv.setViewName("redirect:/mypage/house");
	    	return mv;
	    }
	    
	    ArrayList<Wish> list = houseService.checkHeart(h.getHouseNo());
	    ArrayList<Photo> plist = houseService.selectPhoto(hno);
	    
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    
	    int lo = 0;
	    String Id = "";
	    
	    if (loginUser != null) {
	    	Id = loginUser.getMemberId();
	    	for(Wish w : list) {
	    		if(loginUser.getMemberId().equals(w.getId())){
	    			lo = w.getHno();
	    		}
	    	}
	    }
	    
	    mv.addObject("plist", plist);
	    mv.addObject("Id", Id);
	    mv.addObject("lo", lo);
	    mv.addObject("h", h).setViewName("house/houseView");

	    return mv;
	}
	
	
	
	
	
	
	
	@RequestMapping("heart.ho")
	public ResponseEntity<String> heart(@RequestParam("hno") int hno, @RequestParam("type") String type, HttpSession session) {
		System.out.println("왔나?");
		System.out.println(hno);
	  Member loginUser = (Member) session.getAttribute("loginUser");
	  String id = "";
	  if (loginUser != null) {
	    id = loginUser.getMemberId();
	  } else {
	    // 로그인이 필요한 기능이므로 로그인되지 않은 경우 에러 응답을 반환
	    return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 후 이용해주세요.");
	  }

	  if (type.equals("like")) {
	    houseService.heartLike(id, hno);
	  } else {
	    houseService.heartUnlike(id, hno);
	  }

	  // 성공적인 응답 반환
	  return ResponseEntity.ok().body("success");
	}

	
	@RequestMapping("enrollHouse.ho")
	public String enrollHouse(House h, 
	        MultipartFile image1, MultipartFile image2, MultipartFile image3, MultipartFile image4, MultipartFile image5, MultipartFile image6,
	        HttpSession session, Model model) {
	    
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    h.setMemberId(loginUser.getMemberId());
	    
	    MultipartFile[] images = {image1, image2, image3, image4, image5, image6};
	    
	    int result2 = houseService.enrollHouse(h);
	    
	    int hno = houseService.selectHno(h.getMemberId());
	    
	    int result = result2;
	    
	    for (int i = 0; i < images.length; i++) {
	        MultipartFile image = images[i];
	        String changeName = saveFile(image, session);
	        
	        Photo photo = new Photo();
	        photo.setOriginName(image.getOriginalFilename());
	        photo.setChangeName(changeName);
	        photo.setHouseNo(hno);
	        
	        if (i == 0) {
	            photo.setFileLevel("Y");
	        } else {
	            photo.setFileLevel("N");
	        }
	        
	        int result1 = houseService.enrollPhoto(photo);
	        result *= result1;
	    }
	    
	    if(result > 0) { // 게시글 등록 성공 => 게시글 목록보기 요청
	        session.setAttribute("alertMsg", "성공적으로 방이 등록되었습니다.");
	        return "redirect:/mypage/house";
	    } else { // 게시글 등록 실패 => 에러문구 담아서 에러페이지 포워딩
	        model.addAttribute("errorMsg", "방 등록에 실패하였습니다.");
	        return "common/errorPage";
	    }
	}
	
	
	public String saveFile(MultipartFile upfile,
			HttpSession session) {
		
		String originName = upfile.getOriginalFilename(); // "bono.jpg"
			
		// 2. 현재 시간 형식을 문자열로 뽑아내기
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss")
									.format( new Date()); // "20230511104920"
			
		// 3. 뒤에 붙을 5자리 랜덤값 뽑기 (10000~99999 범위)
		int ranNum = (int)(Math.random() * 90000 + 10000); // 13152
			
		// 4. 원본 파일명으로부터 확장자명 뽑기
		String ext = originName.substring(originName.lastIndexOf(".")); // ".jpg"
			
		// 5. 2, 3 , 4 단계에서 구한 값을 모두 이어 붙히기
		String changeName= currentTime + ranNum +  ext;
			
		// 6. 업로드 하고자 하는 서버의 물리적인 경로 알아내기
		String savePath = session.getServletContext().getRealPath("/resources/img/house/uploadFiles/");
			
		try {
		upfile.transferTo(new File(savePath + changeName));
		} catch (IOException e) {
		e.printStackTrace();
		}
		
		return changeName;
		}
	
	@RequestMapping("houseEdit.ho")
	public ModelAndView houseEdit(ModelAndView mv, int hno, HttpSession session) {
	
	    House h = houseService.selectHouse(hno);
	    
	    if (!h.getEnrollStatus().equals("등록완료")) {
	    	session.setAttribute("alertMsg", "현재 심사중입니다.");
	    	mv.setViewName("redirect:/mypage/house");
	    	return mv;
	    }
		
	    ArrayList<Photo> plist = houseService.selectPhoto(hno);
	    
	    mv.addObject("plist", plist);
	    mv.addObject("h", h).setViewName("house/houseEdit");

	    return mv;
	}
	
	@RequestMapping("updateHouse.ho")
	public String updateHouse(House h, int hno, int photoNo1, int photoNo2, int photoNo3, int photoNo4, int photoNo5, int photoNo6,
	        MultipartFile image1, MultipartFile image2, MultipartFile image3, MultipartFile image4, MultipartFile image5, MultipartFile image6,
	        HttpSession session, Model model) {
	
				
		int [] photoNos = {photoNo1, photoNo2, photoNo3, photoNo4, photoNo5, photoNo6,};
	    MultipartFile[] images = {image1, image2, image3, image4, image5, image6};    

	    h.setHouseNo(hno);
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    h.setMemberId(loginUser.getMemberId());

	    int result2 = houseService.updateHouse(h);

	    int result = result2;

	    for (int i = 0; i < images.length; i++) {
	        MultipartFile image = images[i];

	        // 이미지가 변경되었을 경우에만 처리
	        if (!image.isEmpty()) {
	            String changeName = saveFile(image, session);
	            
	            Photo photo = new Photo();
	            photo.setPhotoNo(photoNos[i]);
	            photo.setOriginName(image.getOriginalFilename());
	            photo.setChangeName(changeName);
	            photo.setHouseNo(hno);

	            if (i == 0) {
	                photo.setFileLevel("Y"); // 대표 이미지
	            } else {
	                photo.setFileLevel("N"); // 일반 이미지
	            }

	            int result1 = houseService.updatePhoto(photo);
	            result *= result1;
	        }
	    }

	    if (result > 0) {
	        session.setAttribute("alertMsg", "성공적으로 방 정보가 수정되었습니다.");
	        return "redirect:/mypage/house";
	    } else {
	        model.addAttribute("errorMsg", "방 정보 수정에 실패하였습니다.");
	        return "common/errorPage";
	    }
	}
	
    @RequestMapping("delete.ho")
	public ModelAndView deleteChat(ModelAndView mv, int hno) {
		houseService.delete(hno);
		mv.setViewName("redirect:/mypage/house");
		return mv;
	}
    
    @RequestMapping("payment")
	public ModelAndView payment(ModelAndView mv, int hno, HttpSession session) {
		houseService.payment(hno);
		House h = houseService.selectHouse(hno);
		Member loginUser = (Member) session.getAttribute("loginUser");
		  String email = loginUser.getEmail();
		
		  try {
			    MailHandler sendMail = new MailHandler(mailSender);
			    
			    // HTML 형식으로 메일 내용을 작성합니다.
			    String htmlContent = "<html>"
			            + "<head>"
			            + "<style>"
			            + "body { font-family: Arial, sans-serif; }"
			            + "h3 { color: #333; }"
			            + ".message { margin-top: 20px; padding: 10px; background-color: #f9f9f9; border: 1px solid #ddd; }"
			            + "</style>"
			            + "</head>"
			            + "<body>"
			            + "<h3>결제가 완료되었습니다.</h3>"
			            + "<div class='message'>"
			            + "<p>안녕하세요, 쉼입니다.</p>"
			            + "<p>" + h.getHouseName() + "의 결제가 완료되었습니다.</p>"
			            + "<p>더욱 편안한 휴식을 즐기실 수 있도록 최선을 다하겠습니다.</p>"
			            + "<p>감사합니다!</p>"
			            + "</div>"
			            + "</body>"
			            + "</html>";

			    sendMail.setText(htmlContent);
			    sendMail.setFrom("suimm012@gmail.com", "쉼");
			    sendMail.setSubject(h.getHouseName() + "의 결제가 완료되었습니다.");
			    sendMail.setTo(email);
			    sendMail.send();
			                
			} catch (MessagingException e) {
			    log.error("메일 전송 중 에러 발생: {}", e.getMessage());
			} catch (Exception e) {
			    log.error("기타 에러 발생: {}", e.getMessage());
			}
		
		
		mv.setViewName("redirect:/mypage/house");
		return mv;
	}
    
}
