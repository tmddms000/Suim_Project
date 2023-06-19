package com.suim.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.suim.board.model.vo.Find;
import com.suim.common.model.vo.PageInfo;
import com.suim.house.model.vo.Reservation;

public interface AdminReservationService {
	
	// 예약 리스트 
	int adminRezCount();
	
	ArrayList<Reservation> adminRezList(PageInfo pi);
	
	// 예약 상세페이지
	Reservation adminRezDetail(int rno);

	// 예약 수정
	int adminRezUpdate(HashMap<String, Object> map);
	
	// 사람구해요 게시판 조건 검색 갯수 세기
	
	int adminRezDeSearchCount(HashMap<String, Object> map);
	
	// 사람구해요 게시판 조건 검색 select

	ArrayList<Reservation> adminRezDeSearch(HashMap<String, Object> map, PageInfo pi);
	
	// 키워드 검색
	
	int adminRezKeySearchCount(HashMap<String, String> map);
		
	// 키워드 검색 select

	ArrayList<Reservation> adminRezKeySearch(HashMap<String, String> map, PageInfo pi);
	
	// 삭제 복구
	int deleteRezBoard(int rno);
		
	int deleteRezCanBoard(int rno);
}
