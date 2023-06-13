package com.suim.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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
	
	// 카테고리용 총 갯수 조회
	public int selectCategoryListCount(SqlSessionTemplate sqlSession, String category) {
		return sqlSession.selectOne("adminMemberMapper.selectCategoryListCount", category);
	}
	
	// 카테고리용 selectList
	public ArrayList<Member> selectCategoryList(SqlSessionTemplate sqlSession, PageInfo pi, String category) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminMemberMapper.selectCategoryList", category, rowBounds);
	}
	
	// 신고 누적 횟수 구하기
	public int selectBlackList(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.selectOne("adminMemberMapper.selectBlackList", memberId);
	}
	// 누적되면 상태값을 블랙으로 바꾸기용
	public int updateBlackList(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.update("adminMemberMapper.updateBlackList", memberId);
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
	public int updateStatusAll(SqlSessionTemplate sqlSession, String[] idArray, String memberStatus) {
		Map<String, Object> map = new HashMap<>();
		map.put("memberStatus", memberStatus);
		map.put("idArray", idArray);
		return sqlSession.update("adminMemberMapper.updateStatusAll", map);
	}
	
	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.update("adminMemberMapper.updateMember", m);
	}
	
	public ArrayList<Member> selectTopMemberList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("adminMemberMapper.selectTopMemberList");
	}
}
