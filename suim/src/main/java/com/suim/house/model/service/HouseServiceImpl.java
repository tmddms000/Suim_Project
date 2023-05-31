package com.suim.house.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.house.model.dao.HouseDao;
import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Wish;

@Service
public class HouseServiceImpl implements HouseService {
	@Autowired
	private HouseDao houseDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public House selectHouse(int hno) {
	  return houseDao.selectHouse(sqlSession, hno);
	}
	
	@Override
	public ArrayList<Wish> checkHeart(int hno) {
	  return houseDao.checkHeart(sqlSession, hno);
	}
	
    @Override
    public void heartLike(String id, int hno) {
        // 좋아요 기능의 구현
        // id와 hno를 사용하여 해당 게시글에 좋아요를 추가하는 로직을 구현합니다.
        houseDao.addHeart(sqlSession, id, hno);
    }

    @Override
    public void heartUnlike(String id, int hno) {
        // 좋아요 취소 기능의 구현
        // id와 hno를 사용하여 해당 게시글의 좋아요를 취소하는 로직을 구현합니다.
        houseDao.removeHeart(sqlSession, id, hno);
    }
}
