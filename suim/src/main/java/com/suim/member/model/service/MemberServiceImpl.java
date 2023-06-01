package com.suim.member.model.service;

import java.util.ArrayList;
import java.util.Map;

import javax.validation.Valid;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.member.model.dao.MemberDao;
import com.suim.member.model.vo.Member;

import com.suim.member.model.vo.SignUp;

@Service
public class MemberServiceImpl implements MemberService {

	// 필드부
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Autowired
	private MemberDao memberDao;

	@Override
	public Member loginMember(Member m) {

		return memberDao.loginMember(sqlSession, m);
	}

	@Override
	public int updateMember(Member m) {
		return memberDao.updateMember(sqlSession, m);
	}

	@Override
	public int deleteMember(String userId) {
		return memberDao.deleteMember(sqlSession, userId);
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

}
