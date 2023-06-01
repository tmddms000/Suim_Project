package com.suim.member.model.service;

import java.util.ArrayList;
import java.util.Map;

import javax.validation.Valid;


import com.suim.member.model.vo.Member;
import com.suim.member.model.vo.SignUp;


public interface MemberService {

	// 로그인 서비스 (select)
	Member loginMember(Member m);
	
	// 회원가입 서비스 (insert)
	int insertMember(@Valid SignUp member);
	
	// 회원정보수정 서비스 (update)
	int updateMember(Member m);
	
	// 회원탈퇴 서비스 (update)
	int deleteMember(String userId);
	
	// 아이디중복체크 서비스 (select)
	int idCheck(String checkId);
	
	// 회원 전체조회 서비스
	ArrayList<Member> selectMemberList();
	
	// 닉네임 중복체크 서비스
	int nickCheck(String nickName);

	// 메일 중복체크 서비스
	int emailCheck(String email);

	// 번호 중복체크 서비스
	int phoneCheck(String phone);
	
	// NAVER API 회원가입
	int insertApiMember(Member member);

	// 네이버로그인 계정 체크
	Map<String, Object> naverConnectionCheck(String email);
	
	// 네이버 회원 체크 서비스
	int setNaverConnection(Map<String, Object> apiJson);

	// 회원 네이버 연동 서비스
	Member userNaverLoginPro(Map<String, Object> apiJson);

	
}
