package com.suim.member.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.board.model.vo.Board;
import com.suim.common.model.vo.PageInfo;
import com.suim.member.model.dao.AdminMemberDao;
import com.suim.member.model.vo.Member;

@Service
public class AdminMemberServiceImpl implements AdminMemberService {

	@Autowired
	private AdminMemberDao adminMemberDao;

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int selectListCount() {
		return adminMemberDao.selectListCount(sqlSession);
	}

	@Override
	public ArrayList<Member> selectList(PageInfo pi) {
		return adminMemberDao.selectList(sqlSession, pi);
	}

	@Override
	public int insertMember(Member m) {
		return adminMemberDao.insertMember(sqlSession, m);
	}

	@Override
	public Member selectMember(String memberId) {
		return adminMemberDao.selectMember(sqlSession, memberId);
	}

	@Override
	public int deleteMember(String memberId) {
		return adminMemberDao.deleteMember(sqlSession, memberId);
	}

	@Override
	public int updateMember(Member m) {
		return adminMemberDao.updateMember(sqlSession, m);
	}

	@Override
	public ArrayList<Member> selectTopMemberList() {
		return adminMemberDao.selectTopMemberList(sqlSession);
	}

}
