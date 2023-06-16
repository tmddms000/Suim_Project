package com.suim.house.model.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Repository;

import com.suim.common.model.vo.PageInfo;
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
			
			return sqlSession.insert("listHouseMapper.reservationInsert", reservation);
		}
		
		// 셰어하우스 별 예약 신청 리스트 갯수
		public int selectHouseRezListCount(SqlSessionTemplate sqlSession, int houseNo) {
			return sqlSession.selectOne("listHouseMapper.selectHouseRezListCount", houseNo);
		}
		
		// 셰어하우스 별 예약 신청 리스트
		public ArrayList<Reservation> selectHouseRezList(SqlSessionTemplate sqlSession, PageInfo pi, int houseNo) {
			
			int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
			int limit = pi.getBoardLimit(); // limit : 조회할 갯수
			
			RowBounds rowBounds = new RowBounds(offset, limit);
			
			return (ArrayList)sqlSession.selectList("listHouseMapper.myHouseRezSelect", houseNo, rowBounds);			
		}
		
		// 예약 취소를 위한 셰어하우스 정보 select
		public ArrayList<Reservation> selectRezOne(SqlSessionTemplate sqlSession, int rezNo) {
			return (ArrayList)sqlSession.selectList("listHouseMapper.selectRezOne", rezNo);
		}
		
		// 셰어하우스 예약 확인
		public int confirmRez(SqlSessionTemplate sqlSession, int rno) {
			return sqlSession.update("listHouseMapper.confirmRez", rno);
		}
	
		// 셰어하우스 예약 취소
		public int rezCancel(SqlSessionTemplate sqlSession, Map<String, Object> rezCancel) {
			return sqlSession.update("listHouseMapper.rezCancel", rezCancel);
		}
		
		// 멤버 이메일 주소 가져오기
		public String memberEmail(SqlSessionTemplate sqlSession, String memberId) {
			return sqlSession.selectOne("listHouseMapper.memberEmail", memberId);
		}
		
		// 로그인유저의 셰어하우스 예약 체크
		public int rezChCount(SqlSessionTemplate sqlSession, Map<String, Object> rezCheck) {
			return sqlSession.selectOne("listHouseMapper.rezChCount", rezCheck);
		}
		
		// 로그인유저의 셰어하우스 예약 번호 받아오기
		public int loginRno(SqlSessionTemplate sqlSession, Map<String, Object> rezCheck) {
			return sqlSession.selectOne("listHouseMapper.loginRno", rezCheck);
		}
		
		// 중심좌표 셰어하우스 이름 키워드 검색
		public ArrayList<House> keyCenterAd(SqlSessionTemplate sqlSession, String searchKeyword){
			return (ArrayList)sqlSession.selectList("listHouseMapper.keyCenterAd", searchKeyword);
		}
	
}
