package com.suim.member.model.service;

import java.util.ArrayList;
import java.util.Map;

import javax.validation.Valid;

import com.suim.board.model.vo.Board;
import com.suim.common.model.vo.PageInfo;
import com.suim.member.model.vo.Email;
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
	int deleteMember(String memberId);

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

	// 구글 회원 체크 서비스
	int googleConnectionCheck(String email);

	int setGoogleConnection(Member m);

	Member userGoogleoginPro(Member m);

	// 회원가입 시 memberAuth를 insert(외래키로 연결)
	int insertEmail(Email email);

	// 회원가입이 완료되거나 재발급 받을때 인증코드를 보낼때 사용
	int setEmailCode(Email email);

	// 이메일 업데이트
	int updateEmail(Email email);

	// 이메일권한체크
	int emailAuthCheck(Email email);

	// 로그인할때 이메일 체크
	int checkEmailLogin(String email);

	// 아이디 전송
	String findMemberId(Member m);

	// Member 정보와 일치하는지 체크
	int findMemberPw(Member m);

	int updateLoginDate(String memberId);

	// MemberId에 따른 멤버 한명 조회
	Member selectMember(String memberId);

}
