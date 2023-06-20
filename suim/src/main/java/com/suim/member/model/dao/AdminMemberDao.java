package com.suim.member.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.common.model.vo.PageInfo;
import com.suim.member.model.vo.Member;

@Repository
public class AdminMemberDao {
	
	// 관리자 로그인 체크용
	public int checkAdminLogin(SqlSessionTemplate sqlSession, String email) {
		return sqlSession.selectOne("adminMemberMapper.checkAdminLogin", email);
	}
	
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
	
	
	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("adminMemberMapper.insertBoard", m);
	}

	// 회원 상세 조회용
	public Member selectMember(SqlSessionTemplate sqlSession, String memberId) {
		return sqlSession.selectOne("adminMemberMapper.selectMember", memberId);
	}
	
	// 회원 카테고리별 상세 조회
	public int selectMemberCategoryListCount(SqlSessionTemplate sqlSession, String memberId, String category) {
		Map<String, Object> params = new HashMap<>();
		params.put("memberId", memberId);
		params.put("category", category);
		return sqlSession.selectOne("adminMemberMapper.selectMemberCategoryListCount", params);
	}
	public List<Map<String, Object>> selectCategoryMember(SqlSessionTemplate sqlSession, PageInfo pi, String memberId, String category) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // offset : 건너뛸 숫자
		int limit = pi.getBoardLimit(); // limit : 조회할 갯수
		RowBounds rowBounds = new RowBounds(offset, limit);
		Map<String, Object> map = new HashMap<>();
		map.put("memberId", memberId);
		map.put("category", category);
		map.put("rowBounds", rowBounds);
		return sqlSession.selectList("adminMemberMapper.selectCategoryMember", map, rowBounds);
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
