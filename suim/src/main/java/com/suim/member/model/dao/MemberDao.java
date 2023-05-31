package com.suim.member.model.dao;

import java.util.ArrayList;
import java.util.Set;


import javax.validation.Valid;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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
	
	public int deleteMember(SqlSessionTemplate sqlSession, String userId) {
		return sqlSession.update("memberMapper.deleteMember", userId);
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

}
