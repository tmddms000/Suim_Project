package com.suim.house.model.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Repository;

import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Region;

@Repository
public class ListHouseDao {

	public ArrayList<House> selectList(SqlSessionTemplate sqlSession, String minValue,
		      String maxValue,
		      String[] genderDivisions,
		      String[] houseType,
		      String[] maxResident,
		      String[] floor,
		      @DateTimeFormat(pattern = "yyyy-MM-dd")Date openDate) {
		
		Map<String, Object> con = new HashMap<>();
		con.put("minValue", minValue);
		con.put("maxValue", maxValue);
		con.put("genderDivisions", genderDivisions);
		con.put("houseType", houseType);
		con.put("maxResident", maxResident);
		con.put("floor", floor);
		con.put("openDate", openDate);
				
		return (ArrayList)sqlSession.selectList("listHouseMapper.selectList", con);
		
			}
		
		public ArrayList<Region> regionSelectList(SqlSessionTemplate sqlSession, String searchKeyword){
			
			
			return (ArrayList)sqlSession.selectList("listHouseMapper.regionSelectList", searchKeyword);

}
	
	
}
