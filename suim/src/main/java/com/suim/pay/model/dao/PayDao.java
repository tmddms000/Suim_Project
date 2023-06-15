package com.suim.pay.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.pay.model.vo.Pay;



@Repository
public class PayDao {
	
	public int insertPay(SqlSessionTemplate sqlSession, Pay p) {
		return sqlSession.insert("payMapper.insertPay", p);
	}
	
	public ArrayList<Pay>selectPay(SqlSessionTemplate sqlSession, Pay p) {
		return (ArrayList) sqlSession.selectList("payMapper.selectPay", p);
	}
	
	public int updatePay(SqlSessionTemplate sqlSession, int hno) {
		return sqlSession.update("payMapper.updatePay", hno);
	}
	
	public int cancelPay(SqlSessionTemplate sqlSession, String tid) {
		return sqlSession.update("payMapper.cancelPay", tid);
	}

}
