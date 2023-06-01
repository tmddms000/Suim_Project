package com.suim.member.model.service;

import java.util.ArrayList;

import com.suim.common.model.vo.PageInfo;
import com.suim.member.model.vo.Member;

public interface AdminMemberService {

	// 회원 리스트 조회 서비스 (+ 페이징처리)
	// 회원 총 갯수 조회
	int selectListCount();
	// 회원 리스트 조회
	ArrayList<Member> selectList(PageInfo pi);
	
	// 회원 작성하기 서비스
	int insertMember(Member m);
	
	// 회원 상세조회 서비스
	// 회원 조회수 증가
	// 필요 없어서 삭제
	
	// 회원 상세 조회
	Member selectMember(String memberId);
	
	// 회원 삭제 서비스
	int deleteMember(String memberId);
	
	// 회원 수정 서비스
	int updateMember(Member m);

	// 회원 top5 리스트 조회용 서비스 (Ajax)
	ArrayList<Member> selectTopMemberList();
}
