package com.suim.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.suim.board.model.vo.Board;
import com.suim.board.model.vo.Find;
import com.suim.board.model.vo.InReview;
import com.suim.common.model.vo.PageInfo;

public interface AdminBoardService {
	
	// 자유게시판 관리자페이지 interface
	
	// 자유게시판 갯수 세기
	int adminBoardCountA();
		
	// 자유게시판 select
	ArrayList<Board> adminBoardListA(PageInfo pi);
	
	// 자유게시판 갯수 세기
	int adminBoardCount(String category);
	
	// 자유게시판 select
	ArrayList<Board> adminBoardList(PageInfo pi, String category);
	
	// 게시글 상세 조회
	Board adminDetailBoard(int boardNo);	
	
	// 게시글 삭제 
	int deleteBoard(int bno);
	
	// 게시글 삭제되돌리기 
	int deleteCanBoard(int bno);
	
	// 키워드 검색 갯수 세기
	
	int adminBoardSearchCount(HashMap<String, String> map);
	
	// 키워드 검색 select

	ArrayList<Board> adminBoardSearch(HashMap<String, String> map, PageInfo pi);
	
	// 사람구해요 관리자페이지 interface

	// 사람구해요 게시판 갯수 세기
	int adminFindCount();
		
	// 사람구해요 게시판 select
	ArrayList<Find> adminFindList(PageInfo pi);
	
	// 사람구해요 게시판 조건 검색 갯수 세기
	
	int adminFreeDeSearchCount(HashMap<String, String> map);
	
	// 게시글 상세 조회
	Find adminFindDetail(int findNo);	
	
	// 사람구해요 게시판 조건 검색 select

	ArrayList<Find> adminFreeDeSearch(HashMap<String, String> map, PageInfo pi);
	
	// 키워드 검색 갯수 세기
	
	int adminFreeKeySearchCount(HashMap<String, String> map);
		
	// 키워드 검색 select

	ArrayList<Find> adminFreeKeySearch(HashMap<String, String> map, PageInfo pi);
	
	// 게시글 삭제 
	int deleteFreeBoard(int fno);
		
	// 게시글 삭제되돌리기 
	int deleteFreeCanBoard(int fno);
	
	// 플랫폼이용후기 관리자페이지 interface
	
	// 플랫폼이용후기 갯수 세기
	int adminInReviewCountA();
			
	// 플랫폼이용후기 select
	ArrayList<InReview> adminInReviewListA(PageInfo pi);
		
	// 플랫폼이용후기 갯수 세기
	int adminInReviewCount(String category);
		
	// 플랫폼이용후기 select
	ArrayList<InReview> adminInReviewList(PageInfo pi, String category);
	
	// 게시글 삭제 
	int deleteInrBoard(int ino);
		
	// 게시글 삭제되돌리기 
	int deleteInrCanBoard(int ino);
	
	// 키워드 검색 갯수 세기
	
	int adminInrSearchCount(HashMap<String, String> map);
			
	// 키워드 검색 select

	ArrayList<InReview> adminInrSearch(HashMap<String, String> map, PageInfo pi);
	
	// 상세검색
	InReview detailInReview(int inrNo);	
		
	
}
