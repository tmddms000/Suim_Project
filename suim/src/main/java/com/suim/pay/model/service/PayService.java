package com.suim.pay.model.service;


import java.util.ArrayList;


import com.suim.pay.model.vo.Pay;

public interface PayService {
	
	int insertPay(Pay p);
	
	ArrayList<Pay> selectPay(Pay p);
	
	int updatePay(int hno);
	
	int cancelPay(String tid);
	
	
}
