package com.suim.pay.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.pay.model.dao.PayDao;
import com.suim.pay.model.vo.Pay;
@Service
public class PayServiceImpl  implements PayService {
	
	@Autowired
	private PayDao PayDao;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertPay(Pay p) {
		return PayDao.insertPay(sqlSession,p);
	}

	@Override
	public ArrayList<Pay> selectPay(Pay p) {
		return PayDao.selectPay(sqlSession,p);
	}

	@Override
	public int updatePay(int hno) {
		return PayDao.updatePay(sqlSession,hno);
	}
	
	@Override
	public int cancelPay(String tid) {
		return PayDao.cancelPay(sqlSession,tid);
	}
}
