package com.suim.member.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.suim.common.model.vo.PageInfo;
import com.suim.member.model.vo.Member;

public interface AdminMemberService {

	// 관리자 로그인체크
	int checkAdminLogin(String email);

	// 회원 리스트 조회 서비스 (+ 페이징처리)
	// 회원 총 갯수 조회
	int selectListCount();

	// 회원 리스트 조회
	ArrayList<Member> selectList(PageInfo pi);

	// 카테고리마다 전체 조회
	int selectCategoryListCount(String category);

	ArrayList<Member> selectCategoryList(PageInfo pi, String category);


	// 회원 작성하기 서비스
	int insertMember(Member m);

	// 회원 상세조회 서비스
	// 회원 조회수 증가
	// 필요 없어서 삭제

	// 회원 상세 조회
	Member selectMember(String memberId);

	// 회원 카테고리별 상세 조회
	int selectMemberCategoryListCount(String memberId, String category);

	List<Map<String, Object>> selectCategoryMember(PageInfo pi, String memberId, String category);

	// 탈퇴용
	int updateMemberStatus(Member m);

	// 전체 선택 탈퇴용
	int updateStatusAll(String[] idArray, String memberStatus);

	// 회원 삭제 서비스
	int deleteMember(String memberId);

	// 회원 수정 서비스
	int updateMember(Member m);
}
