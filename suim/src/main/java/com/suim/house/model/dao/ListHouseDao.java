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
import com.suim.house.model.vo.Reservation;

@Repository
public class ListHouseDao {

	// 지도와 셰어하우스 리스트 상세 검색 
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
		
		// 지역 정보 조회 서비스
		public ArrayList<Region> regionSelectList(SqlSessionTemplate sqlSession, String searchKeyword){
			
			
			return (ArrayList)sqlSession.selectList("listHouseMapper.regionSelectList", searchKeyword);

			}
		
		// 예약 정보 입력 서비스
		public int rezInsert(SqlSessionTemplate sqlSession, Map<String, Object> reservation) {
			
			return sqlSession.insert("listHouseMapper.reservationInsert", reservation );
		}
		
		// 셰어하우스 별 예약 신청 리스트
		public ArrayList<Reservation> myHouseRezSelect(SqlSessionTemplate sqlSession, int houseNo) {
			
			return (ArrayList)sqlSession.selectList("listHouseMapper.myHouseRezSelect", houseNo);			
		}
		
		// 셰어하우스 예약 확인
		public int confirmRez(SqlSessionTemplate sqlSession, int rno) {
			return sqlSession.update("listHouseMapper.confirmRez", rno);
		}
	
	
}
