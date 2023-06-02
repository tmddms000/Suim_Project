package com.suim.house.controller;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
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
		        searchKeyword = ""; // null인 경우 빈 문자열로 초기화
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
		    	
		    mv.setViewName("house/houseMapView"); // 적절한 뷰 이름으로 업데이트하세요.
		    
		    return mv;
	}
}
