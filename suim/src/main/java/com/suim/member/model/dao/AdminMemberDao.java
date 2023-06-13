package com.suim.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.common.model.vo.PageInfo;
import com.suim.member.model.vo.Member;
import com.suim.report.model.vo.Report;

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
	
	// 승인/반려 처리용
	public int updateMemberStatus(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("adminMemberMapper.updateMemberStatus", m);
	}
	// 전체선택용 승인/반려용
	public int updateStatusAll(SqlSessionTemplate sqlSession, int[] intArray, String memberStatus) {
		Map<String, Object> map = new HashMap<>();
		map.put("reportStatus", memberStatus);
		map.put("intArray", intArray);
		return sqlSession.update("adminMemberMapper.updateStatusAll", map);
	}
	
	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("adminMemberMapper.updateMember", m);
	}
	
	public ArrayList<Member> selectTopMemberList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMemberMapper.selectTopMemberList");
	}
}
