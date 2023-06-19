package com.suim.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.suim.board.model.vo.Battachment;
import com.suim.board.model.vo.Board;
import com.suim.board.model.vo.Find;
import com.suim.board.model.vo.InReview;
import com.suim.board.model.vo.InReviewReply;
import com.suim.board.model.vo.Reply;
import com.suim.board.model.vo.findReply;
import com.suim.common.model.vo.PageInfo;
import com.suim.board.model.vo.InReview;

public interface BoardService {
	
	
	
	//------------------자유게시판-----------------------
	
	// 게시판 리스트 조회 서비스 (+ 페이징처리)
	// 게시글의 총 갯수 조회
	int selectListCount();
	
	// 게시글 리스트 조회
	ArrayList<Board> selectList(PageInfo pi);
	
	// 배스트 리스트 조회
	ArrayList<Board> selectbList();
	
	// 게시글 등록
	int insertBoard(Board b);
	
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
	
	int deleteReply(int breNo);
	
	int updateReply(int breNo, String content);
	
	
	// 게시글 업데이트
	int updateBoard(Board b);
	
	// 상세페이지 조회
	Board updateBoardList(int boardNo);
	
	//------------------------------------------------
	
	//------------------사람구해요-----------------------
	
	// 게시판 리스트 조회 서비스 (+ 페이징처리)
	// 게시글의 총 갯수 조회
	int selectfListCount();
	
	int selectfcListCount(HashMap<String, String> fin);
	
	// 게시글 리스트 조회
	ArrayList<Find> selectfList(PageInfo pi);
	
	ArrayList<Find> selectfList(PageInfo pi, HashMap<String, String> fin);
	
	// 게시글 상세조회 서비스
	
	// 게시글 조회수 증가
	int increasefCount(int findNo);
	// 게시글 상세 조회
	Find selectFind(int findNo);
	
	// 게시글 삭제 서비스
	int deleteFind(int findNo);
	
	// 댓글 리스트 조회 서비스 (Ajax)
	ArrayList<findReply> selectfReplyList(int findNo);
	
	// 댓글 작성 서비스 (Ajax)
	int insertfReply(findReply fr);
	
	int deletefReply(int freNo);
	
	int updatefReply(int freNo, String content);
	
	// 게시글 등록
	int insertFind(Find f);
	
	// 게시글 업데이트
	int updateFind(Find f);
	
	// 상세페이지 조회
	Find updateFindList(int findNo);
	

	//------------------------------------------------
	
	//------------------이용후기-----------------------
	
	// 게시판 리스트 조회 서비스 (+ 페이징처리)
	// 게시글의 총 갯수 조회
	int selectiListCount();
	
	
	// 게시글 리스트 조회
	ArrayList<InReview> selectiList(PageInfo pi);
	
	
	// 게시글 상세조회 서비스
	// 게시글 조회수 증가
	int increaseInCount(int inrNo);
	// 게시글 상세 조회
	InReview selectInReview(int inrNo);
	
	// 게시글 삭제 서비스
	int deleteInReview(int inrNo);
	
	// 게시글 등록
	int insertInReview(InReview i);
	
	// 게시글 업데이트
	int updateInReivew(InReview i);
	
	// 상세페이지 조회
	InReview updateInReivewList(int inrNo);
	
	// 댓글 리스트 조회 서비스 (Ajax)
	ArrayList<InReviewReply> selectInReviewReplyList(int inrNo);
	
	// 댓글 작성 서비스 (Ajax)
	int insertInReviewReply(InReviewReply ir);
	
	int deleteiReply(int ireNo);
	
	int updateiReply(int ireNo, String content);



}
