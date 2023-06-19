package com.suim.member.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.common.model.vo.PageInfo;
import com.suim.member.model.dao.AdminMemberDao;
import com.suim.member.model.vo.Member;

@Service
public class AdminMemberServiceImpl implements AdminMemberService {

	@Autowired
	private AdminMemberDao adminMemberDao;

	@Autowired
	private SqlSessionTemplate sqlSession;

	// 관리자 로그인체크
	public int checkAdminLogin(String email) {
		return adminMemberDao.checkAdminLogin(sqlSession, email);
	}

	// 전체 목록 조회용
	@Override
	public int selectListCount() {
		return adminMemberDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<Member> selectList(PageInfo pi) {
		return adminMemberDao.selectList(sqlSession, pi);
	}

	// 카테고리용 전체 조회
	@Override
	public int selectCategoryListCount(String category) {
		return adminMemberDao.selectCategoryListCount(sqlSession, category);
	}

	@Override
	public ArrayList<Member> selectCategoryList(PageInfo pi, String category) {
		return adminMemberDao.selectCategoryList(sqlSession, pi, category);
	}

	@Override
	public int insertMember(Member m) {
		return adminMemberDao.insertMember(sqlSession, m);
	}

	// 회원 상세 조회용
	@Override
	public Member selectMember(String memberId) {
		return adminMemberDao.selectMember(sqlSession, memberId);
	}

	// 회원 카테고리별 상세 조회
	@Override
	public int selectMemberCategoryListCount(String memberId, String category) {
		return adminMemberDao.selectMemberCategoryListCount(sqlSession, memberId, category);
	}

	@Override
	public List<Map<String, Object>> selectCategoryMember(PageInfo pi, String memberId, String category) {
		return adminMemberDao.selectCategoryMember(sqlSession, pi, memberId, category);
	}

	// 승인/반려 처리용
	@Override
	public int updateMemberStatus(Member m) {
		return adminMemberDao.updateMemberStatus(sqlSession, m);
	}

	// 전체선택 승인/반려용
	@Override
	public int updateStatusAll(String[] idArray, String memberStatus) {
		return adminMemberDao.updateStatusAll(sqlSession, idArray, memberStatus);
	}

	@Override
	public int deleteMember(String memberId) {
		return adminMemberDao.deleteMember(sqlSession, memberId);
	}

	@Override
	public int updateMember(Member m) {
		return adminMemberDao.updateMember(sqlSession, m);
	}

}
