package com.suim.common.main.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.suim.board.model.vo.Find;
import com.suim.board.model.vo.InReview;
import com.suim.house.model.vo.House;

public interface MainService {
	
	//하우스 리스트 구해오기
	ArrayList<House> selectHouseList();

	//메인페이지에 필요한 카운팅 (회원 수, 게시글 수 등)
	Map<String, Object> selectCountList();

	//사람구해요 게시판 구하기
	ArrayList<Find> selectfList();
	
	//이용후기 게시판 구하기
	ArrayList<InReview> selectiList();

}
