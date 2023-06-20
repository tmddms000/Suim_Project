package com.suim.pay.controller;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.suim.common.mail.MailHandler;
import com.suim.house.model.service.HouseService;
import com.suim.house.model.vo.House;
import com.suim.member.model.vo.Member;
import com.suim.pay.model.service.PayService;
import com.suim.pay.model.vo.Pay;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
public class payController {
	
	@Autowired
	private HouseService houseService;
	
	@Autowired
	private PayService payService;
	
	@Autowired
	public payController(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
	
	private final JavaMailSender mailSender;
	private String tid;
	
	@RequestMapping(value = "/kakaopay.cls", method = RequestMethod.POST)
	@ResponseBody
	public String kakaopay(int hno,
	        HttpSession session,
	        Model model) {
	    House h = houseService.selectHouse(hno);
	    try {
	        URL url = new URL("https://kapi.kakao.com/v1/payment/ready");
	        HttpURLConnection huc = (HttpURLConnection) url.openConnection();
	        huc.setRequestMethod("POST");
	        huc.setRequestProperty("Authorization", "KakaoAK 13fc955495d1fe2148e4af8b813e14c4");
	        huc.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
	        huc.setDoOutput(true);
	        String itemName = URLEncoder.encode(h.getHouseName(), "UTF-8");
	        int deposit;
	        String price = "";
	        if (h.getDeposit() == 0) {
	            
	        	price = "0";
	            
	        } else {
	            deposit = (int) (h.getDeposit() * 0.1);
	            price = String.valueOf(deposit);
	        }

	        String memberId = h.getMemberId();
	       
	        String parameter = "cid=TC0ONETIME" +
	                "&partner_order_id=partner_order_id" +
	                "&partner_user_id=partner_user_id" +
	                "&item_name=" + itemName +
	                "&quantity=1" +
	                "&total_amount=" + price +
	                "&vat_amount=0" +
	                "&tax_free_amount=0" +
	                "&approval_url=http://localhost:8006/update?hno=" + hno +
			        "&fail_url=http://localhost:8006/mypage/house" +
		            "&cancel_url=http://localhost:8006/cancel?hno=" + hno;
	               
	        OutputStream ops = huc.getOutputStream();
	        DataOutputStream dos = new DataOutputStream(ops);
	        dos.writeBytes(parameter);
	        dos.close();
	        int result = huc.getResponseCode();
	        InputStream is;
	        // 승인이 성공적으로 이루어졌을 때의 처리
	        if (result == 200) {
	            is = huc.getInputStream();
	            InputStreamReader isr = new InputStreamReader(is);
	            BufferedReader br = new BufferedReader(isr);
	            String response = br.readLine();
	            Map<String, String> responseMap = parseResponse(response);
	            if (responseMap.containsKey("tid")) {
	                tid = responseMap.get("tid");
	                // Pay 객체 생성 및 추가
	                Pay p = new Pay();
	                p.setHouseNo(hno);
	                p.setHouseName(itemName);
	                p.setPrice(price);
	                p.setTid(tid);
	                p.setMemberId(memberId);
	               
	                // Pay 객체를 데이터베이스에 추가하는 코드 (예시)
	                int resultPay = payService.insertPay(p);
	                	
	               
	                if (resultPay > 0 /*|| result2 > 0*/) { // 성공 => 일회성 알림문구를 표시한 뒤 게시글 목록 페이지로 URL을 재요청합니다.
	                    ArrayList<Pay> pi = payService.selectPay(p);
	                    Pay latestPay = pi.get(pi.size() - 1); // 가장 최근에 추가된 Pay 객체를 가져옵니다.
	                    int pno = latestPay.getPaymentNo(); // pno 값을 가져옵니다.

	                   
	                } else { // 실패 => 에러 메시지를 모델에 추가하고 에러 페이지로 이동합니다.
	                    model.addAttribute("errorMsg", "결제 실패");
	                    return "common/errorPage";
	                }
	            }
	            return response;
	        } else {
	            is = huc.getErrorStream();
	        }
	    } catch (MalformedURLException e) {
	        e.printStackTrace();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    return "{\"result\":\"NO\"}";
	}
	
	
	private Map<String, String> parseResponse(String response) {
	    Map<String, String> responseMap = new HashMap<>();
	    JSONParser parser = new JSONParser();
	    try {
	        Object obj = parser.parse(response);
	        if (obj instanceof Map) {
	            Map<String, Object> jsonMap = (Map<String, Object>) obj;
	            String tid = (String) jsonMap.get("tid");
	            responseMap.put("tid", tid);
	        }
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
	    return responseMap;
	}
	@RequestMapping(value = "update")
	@ResponseBody
	public ModelAndView updatePay(@RequestParam("hno") int hno,
						  @RequestParam("pg_token") String pgToken,
	                        HttpSession session,
	                        ModelAndView mv) throws UnsupportedEncodingException {
		int result = payService.updatePay(hno);
		
		if (result > 0 /*|| result2 > 0*/) {
		   
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
				            + ".message { margin-top: 20px; padding: 10px; background-color: #F9F9F9; border: 1px solid #ddd; }"
				            + "</style>"
				            + "</head>"
				            + "<body>"
				            + "<h3>결제가 완료되었습니다.</h3>"
				            + "<div class='message'>"
				            + "<p>안녕하세요, 쉼입니다.</p>"
				            + "<p>" + h.getHouseName() + "의 결제가 완료되었습니다.</p>"
				            + "<p>더욱 편안한 셰어하우스가 될 수 있도록 최선을 다하겠습니다.</p>"
				            + "<p>감사합니다.</p>"
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
		      
			  mv.setViewName("common/paySuccess");

		   
		} else { // 실패 => 에러 문구를 담아서 에러페이지로 포워딩
			
			session.setAttribute("alertMsg", "결제가 실패되었습니다.");
			
			mv.setViewName("redirect:mypage/house");
		}
		return mv;
	}
	@RequestMapping(value = "cancel")
	public String cancelPay(int hno, HttpSession session,
				            Model model) {
		
		
		int result = payService.cancelPay(tid);
		if (result > 0 ) {
		    session.setAttribute("alertMsg", "결제가 취소되었습니다.");
		   
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
				            + ".message { margin-top: 20px; padding: 10px; background-color: #F9F9F9; border: 1px solid #ddd; }"
				            + "</style>"
				            + "</head>"
				            + "<body>"
				            + "<h3>결제가 취소되었습니다.</h3>"
				            + "<div class='message'>"
				            + "<p>안녕하세요, 쉼입니다.</p>"
				            + "<p>" + h.getHouseName() + "의 결제가 취소되었습니다.</p>"
				            + "<p>더욱 편안한 셰어하우스가 될 수 있도록 최선을 다하겠습니다.</p>"
				            + "<p>감사합니다.</p>"
				            + "</div>"
				            + "</body>"
				            + "</html>";
				   
				    sendMail.setText(htmlContent);
				    sendMail.setFrom("suimm012@gmail.com", "쉼");
				    sendMail.setSubject(h.getHouseName() + "의 결제가 취소되었습니다.");
				    sendMail.setTo(email);
				    sendMail.send();
				               
				} catch (MessagingException e) {
				    log.error("메일 전송 중 에러 발생: {}", e.getMessage());
				} catch (Exception e) {
				    log.error("기타 에러 발생: {}", e.getMessage());
				}
		 
		    return "redirect:/mypage/house";
		   
		} else { // 실패 => 에러 문구를 담아서 에러페이지로 포워딩
			
			model.addAttribute("errorMsg", "결제가 실패 했습니다.");
			
			return "common/errorPage";
		}
	}
}