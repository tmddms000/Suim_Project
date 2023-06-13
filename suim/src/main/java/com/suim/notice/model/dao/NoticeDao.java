package com.suim.notice.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.suim.common.model.vo.PageInfo;
import com.suim.notice.model.vo.Nattachment;
import com.suim.notice.model.vo.Notice;

@Repository
public class NoticeDao {

	public int selectListCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("noticeMapper.selectListCount");
				// 완성된 쿼리문이므로 두번째 변수 필요없음
	}
												// 마이바티스의 SqlSession 과 같은 역할을 하는 스프링 전용 sqlSession이다.
	
	/* notice 게시글 목록 조회 이지환 */
	public ArrayList<Notice> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); 
		// offset 구하는 법 : currentPage에서 1 을 빼고, boardLimit 값을 곱해줌
		// offet : 건너 뛸 숫자
		int limit = pi.getBoardLimit(); // limit ; 조회할 갯수
		
		RowBounds rowBounds = new RowBounds(offset, limit); // 빈에 등록이 되어있지 않기 때문에 직접 생성해야 함
		
		return (ArrayList)sqlSession.selectList("noticeMapper.selectList", null, rowBounds);
		// (ArrayList) 로 다운캐스팅 후 리턴함
									// selectList("namespace", 해당 쿼리문의 id", xx, rouwBounds);
	}
	
	/* 게시판 상세조회 이지환 */
	public Notice selectBoard(SqlSessionTemplate sqlSession, int noticeNo) {
		return sqlSession.selectOne("noticeMapper.selectBoard", noticeNo);
	}

	/* 공지사항 게시글 상세조회 시 해당 공지사항 게시글 증가 */
	public int increseCount(SqlSessionTemplate sqlSession, int nno) {
		return sqlSession.update("noticeMapper.increaseCount", nno);
	}

	
	public ArrayList<Nattachment> selectNoticeFile(SqlSessionTemplate sqlSession, int nno) {
		return (ArrayList)sqlSession.selectList("noticeMapper.selectNoticeFile", nno);
	}
	
	
	
	
	
}
