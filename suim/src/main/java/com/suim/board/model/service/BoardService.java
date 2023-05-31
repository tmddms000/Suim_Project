package com.suim.board.model.service;

import java.util.ArrayList;

import com.suim.board.model.vo.Battachment;
import com.suim.board.model.vo.Board;
import com.suim.board.model.vo.Reply;
import com.suim.common.model.vo.PageInfo;

public interface BoardService {
	
	// 게시판 리스트 조회 서비스 (+ 페이징처리)
	// 게시글의 총 갯수 조회
	int selectListCount();
	
	// 게시글 리스트 조회
	ArrayList<Board> selectList(PageInfo pi);
	
	// 배스트 리스트 조회
	ArrayList<Board> selectbList();
	
	// 게시글 등록
	int insertBoard(Board b, Battachment ba);
	
	// 게시글 등록
	int insertBattachment(Battachment ba);
	
	// 게시글 상세조회 서비스
	
	// 게시글 조회수 증가
	int increaseCount(int boardNo);
	// 게시글 상세 조회
	Board selectBoard(int boardNo);
	// 게시글 삭제 서비스
	int deleteBoard(int boardNo);
	
	// 댓글 리스트 조회 서비스 (Ajax)
	ArrayList<Reply> selectReplyList(int boardNo);
	
	// 댓글 작성 서비스 (Ajax)
	int insertReply(Reply r);
	
	// 댓글 수량 
	int ReplyCount(int boardNo);
	

	

}
