package com.suim.house.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.suim.house.model.service.ListHouseService;
import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Region;

@Controller
public class ListHouseController {
	
	@Autowired
	private ListHouseService listHouseService;
	
	@RequestMapping("list.ho")
	public ModelAndView selectList(ModelAndView mv, String searchKeyword) {
		
		
		 ArrayList<Region> region = listHouseService.regionSelectList(searchKeyword);
		    ArrayList<House> list = listHouseService.selectList();
		    
		    mv.addObject("list", list);
		    
		    if (region.isEmpty()) {
		        mv.addObject("regionEmpty", true);
		    } else {
		        mv.addObject("region", region);
		    }
		    
		    mv.setViewName("house/houseMapView"); // 적절한 뷰 이름으로 업데이트하세요.
		    
		    return mv;

	}

}
