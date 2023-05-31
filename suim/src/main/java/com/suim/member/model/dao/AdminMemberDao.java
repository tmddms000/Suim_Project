package com.suim.member.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.common.model.vo.PageInfo;
import com.suim.member.model.vo.Member;

@Repository
public class AdminMemberDao {
	
	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("adminMemberMapper.selectListCount");
	}
	
	public ArrayList<Member> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminMemberMapper.selectList", null, rowBounds);
	}
	
	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("adminMemberMapper.insertBoard", m);
	}

	
	public Member selectMember(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.selectOne("adminMemberMapper.selectMember", memberId);
	}
	
	public int deleteMember(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.update("adminMemberMapper.deleteMember", memberId);
	}
	
	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("adminMemberMapper.updateMember", m);
	}
	
	public ArrayList<Member> selectTopMemberList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMemberMapper.selectTopMemberList");
	}
}
