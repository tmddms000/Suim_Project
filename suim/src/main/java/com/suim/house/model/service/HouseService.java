package com.suim.house.model.service;

import java.util.ArrayList;

import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Wish;

public interface HouseService {

	// 게시글 상세 조회
		House selectHouse(int hno);
		
	// 찜 조회
		ArrayList<Wish> checkHeart(int hno);
	
	// 좋아요 추가
		void heartLike(String id, int hno);

	// 좋아요 취소
	    void heartUnlike(String id, int hno);	
		
}
