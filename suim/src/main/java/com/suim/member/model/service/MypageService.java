package com.suim.member.model.service;

import java.util.ArrayList;

import com.suim.board.model.vo.Board;
import com.suim.common.model.vo.PageInfo;

public interface MypageService {

	//자유게시판 게시글의 갯수를 조회합니다.

	int selectBoardListCount(String memberId);


	//자유게시판의 게시글 리스트를 조회합니다.
	ArrayList<Board> selectBoardList(PageInfo pi, String memberId);

	//사람 구해요 게시글 갯수를 조회합니다.

	int selectFindListCount(String memberId);
	
	//사람구해요 게시판의 게시글 리스트를 조회합니다.
	ArrayList<Board> selectFindList(PageInfo pi, String memberId);

	

	
	
}
