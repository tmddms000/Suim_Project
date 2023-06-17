package com.suim.house.model.service;

import java.util.ArrayList;
import java.util.List;

import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Photo;
import com.suim.house.model.vo.Wish;

public interface HouseService {

	// 게시글 상세 조회
		House selectHouse(int hno);
		
		House selectEnroll(int hno);
		
	// 찜 조회
		ArrayList<Wish> checkHeart(int hno);
	
	// 좋아요 추가
		void heartLike(String id, int hno);

	// 좋아요 취소
	    void heartUnlike(String id, int hno);	
	    
	    ArrayList<Photo> selectPhoto(int hno);
	    
	    int enrollPhoto(Photo p);
	    
	    int enrollHouse(House h);
	    
	    int selectHno(String Id);
	    
	    int updateHouse(House h);
	    
	    int updatePhoto(Photo p);
	    
	    void deleteHouse(int hno);
		
}
