package com.suim.house.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.suim.house.model.service.HouseService;
import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Wish;
import com.suim.member.model.vo.Member;


@Controller
public class HouseController {
	@Autowired
	private HouseService houseService;
	
	@RequestMapping("detail.ho")
	public ModelAndView selectList(ModelAndView mv, int hno, HttpSession session) {
	    House h = houseService.selectHouse(hno);
	    System.out.println("아");
	    System.out.println(hno);
	    
	    ArrayList<Wish> list = houseService.checkHeart(h.getHouseNo());
	    
	    Member loginUser = (Member) session.getAttribute("loginUser");
	    
	    int lo = 0;
	    
	    if (loginUser != null) {
	    	for(Wish w : list) {
	    		if(loginUser.getMemberId().equals(w.getId())){
	    			lo = w.getHno();
	    		}
	    	}
	    }
	    mv.addObject("lo", lo);
	    mv.addObject("h", h).setViewName("house/houseView");

	    return mv;
	}
	
	@RequestMapping("heart.ho")
	public ResponseEntity<String> heart(@RequestParam("hno") int hno, @RequestParam("type") String type, HttpSession session) {
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
}
