package com.suim.member.model.dao;

import java.util.ArrayList;
import java.util.Map;
import java.util.Set;


import javax.validation.Valid;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.board.model.vo.Board;
import com.suim.common.model.vo.PageInfo;
import com.suim.member.model.vo.Email;
import com.suim.member.model.vo.Member;

import com.suim.member.model.vo.SignUp;

@Repository
public class MemberDao {

	
	
	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.loginMember", m);
	}
	
	public int insertMember(SqlSessionTemplate sqlSession, @Valid SignUp member) {
		return sqlSession.insert("memberMapper.insertMember", member);

	}
	
	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.updateMember", m);
	}
	
	public int deleteMember(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.update("memberMapper.deleteMember", memberId);
	}
	

	public ArrayList<Member> selectMemberList(SqlSessionTemplate sqlSession) {
		return (ArrayList) sqlSession.selectList("memberMapper.selectMemberList");
	}
	
	public int idCheck(SqlSessionTemplate sqlSession, String checkId) {
		return sqlSession.selectOne("memberMapper.idCheck", checkId);
	}

	public int nickCheck(SqlSessionTemplate sqlSession, String nickName) {
		
		return sqlSession.selectOne("memberMapper.nickCheck", nickName);
	}

	public int emailCheck(SqlSessionTemplate sqlSession, String email) {
		
		return sqlSession.selectOne("memberMapper.emailCheck", email);
	}

	public int phoneCheck(SqlSessionTemplate sqlSession, String phone) {
		
		return sqlSession.selectOne("memberMapper.phoneCheck", phone);
	}

	public Map<String, Object> naverConnectionCheck(SqlSessionTemplate sqlSession, String email) {
		return (Map) sqlSession.selectOne("memberMapper.naverConnectionCheck", email);
	}

	public int setNaverConnection(SqlSessionTemplate sqlSession, Map<String, Object> apiJson) {
		return sqlSession.update("memberMapper.setNaverConnection", apiJson);
	}

	public Member userNaverLoginPro(SqlSessionTemplate sqlSession, Map<String, Object> apiJson) {
		return sqlSession.selectOne("memberMapper.userNaverLoginPro", apiJson);
	}

	public int insertApiMember(SqlSessionTemplate sqlSession, Member member) {
		return sqlSession.insert("memberMapper.insertApiMember", member);
	}
	

	public int insertEmail(SqlSessionTemplate sqlSession, Email email) {
		return sqlSession.insert("emailMapper.insertEmail", email);
	}

	public int setEmailCode(SqlSessionTemplate sqlSession, Email email) {
		return sqlSession.update("emailMapper.setEmailCode", email);
	}

	public int updateEmail(SqlSessionTemplate sqlSession, Email email) {
		return sqlSession.update("emailMapper.updateEmail", email);
	}

	public int emailAuthCheck(SqlSessionTemplate sqlSession, Email email) {
		return sqlSession.selectOne("emailMapper.emailAuthCheck", email);
	}

	public int checkEmailLogin(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.selectOne("emailMapper.checkEmailLogin", email);
	}

	public int selectBoardListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("emailMapper.selectBoardListCount");
	}

	public String findMemberId(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.findMemberId", m);
	}

	public int findMemberPw(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.findMemberPw", m);
	}

	public int googleConnectionCheck(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.selectOne("memberMapper.googleConnectionCheck", email);
	}

	public int setGoogleConnection(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("memberMapper.setGoogleConnection", m);
	}

	public Member userGoogleoginPro(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.userGoogleLoginPro", m);
	}

	public int updateLoginDate(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.update("memberMapper.updateLoginDate", memberId);
	}

	public Member selectMember(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.selectOne("memberMapper.selectMember", memberId);
	}






}
