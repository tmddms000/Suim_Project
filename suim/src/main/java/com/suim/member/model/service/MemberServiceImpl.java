package com.suim.member.model.service;

import java.util.ArrayList;
import java.util.Map;

import javax.validation.Valid;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.board.model.vo.Board;
import com.suim.common.model.vo.PageInfo;
import com.suim.member.model.dao.MemberDao;
import com.suim.member.model.vo.Email;
import com.suim.member.model.vo.Member;

import com.suim.member.model.vo.SignUp;

@Service
public class MemberServiceImpl implements MemberService {

	// 필드부
	private final SqlSessionTemplate sqlSession;
	private final MemberDao memberDao;

	@Autowired
	public MemberServiceImpl(SqlSessionTemplate sqlSession, MemberDao memberDao) {
		this.sqlSession = sqlSession;
		this.memberDao = memberDao;
	}

	@Override
	public Member loginMember(Member m) {

		return memberDao.loginMember(sqlSession, m);
	}

	@Override
	public int updateMember(Member m) {
		return memberDao.updateMember(sqlSession, m);
	}

	@Override
	public int deleteMember(String memberId) {
		return memberDao.deleteMember(sqlSession, memberId);
	}

	@Override
	public int idCheck(String checkId) {
		return memberDao.idCheck(sqlSession, checkId);
	}

	@Override
	public ArrayList<Member> selectMemberList() {
		return memberDao.selectMemberList(sqlSession);
	}

	@Override
	public int nickCheck(String nickName) {
		return memberDao.nickCheck(sqlSession, nickName);
	}

	@Override
	public int emailCheck(String email) {
		return memberDao.emailCheck(sqlSession, email);
	}

	@Override
	public int insertMember(@Valid SignUp member) {
		return memberDao.insertMember(sqlSession, member);
	}

	@Override
	public int phoneCheck(String phone) {
		return memberDao.phoneCheck(sqlSession, phone);
	}

	@Override
	public Map<String, Object> naverConnectionCheck(String email) {
		return memberDao.naverConnectionCheck(sqlSession, email);
	}

	@Override
	public int setNaverConnection(Map<String, Object> apiJson) {
		return memberDao.setNaverConnection(sqlSession, apiJson);

	}

	@Override
	public Member userNaverLoginPro(Map<String, Object> apiJson) {
		return memberDao.userNaverLoginPro(sqlSession, apiJson);
	}

	@Override
	public int insertApiMember(Member member) {
		// TODO Auto-generated method stub
		return memberDao.insertApiMember(sqlSession, member);
	}

	@Override
	public int insertEmail(Email email) {
		return memberDao.insertEmail(sqlSession, email);
	}

	@Override
	public int setEmailCode(Email email) {
		return memberDao.setEmailCode(sqlSession, email);
	}

	@Override
	public int updateEmail(Email email) {
		return memberDao.updateEmail(sqlSession, email);
	}

	@Override
	public int emailAuthCheck(Email email) {
		return memberDao.emailAuthCheck(sqlSession, email);
	}

	@Override
	public int checkEmailLogin(String email) {
		return memberDao.checkEmailLogin(sqlSession, email);
	}

	@Override
	public String findMemberId(Member m) {
		return memberDao.findMemberId(sqlSession, m);
	}

	@Override
	public int findMemberPw(Member m) {
		return memberDao.findMemberPw(sqlSession, m);
	}

	@Override
	public int googleConnectionCheck(String email) {
		return memberDao.googleConnectionCheck(sqlSession, email);
	}

	@Override
	public int setGoogleConnection(Member m) {
		return memberDao.setGoogleConnection(sqlSession, m);
	}

	@Override
	public Member userGoogleoginPro(Member m) {
		return memberDao.userGoogleoginPro(sqlSession, m);
	}

	@Override
	public int updateLoginDate(String memberId) {
		return memberDao.updateLoginDate(sqlSession, memberId);
	}

	@Override
	public Member selectMember(String memberId) {
		return memberDao.selectMember(sqlSession, memberId);
	}

}
