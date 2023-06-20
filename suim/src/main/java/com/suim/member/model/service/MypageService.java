package com.suim.member.model.service;

import java.util.ArrayList;

import com.suim.board.model.vo.Board;
import com.suim.common.model.vo.PageInfo;
import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Reservation;
import com.suim.member.model.vo.MyWish;
import com.suim.pay.model.vo.Pay;

public interface MypageService {

	// 자유게시판 게시글의 갯수를 조회합니다.

	int selectBoardListCount(String memberId);

	// 자유게시판의 게시글 리스트를 조회합니다.
	ArrayList<Board> selectBoardList(PageInfo pi, String memberId);

	// 사람 구해요 게시글 갯수를 조회합니다.

	int selectFindListCount(String memberId);

	// 사람구해요 게시판의 게시글 리스트를 조회합니다.
	ArrayList<Board> selectFindList(PageInfo pi, String memberId);

	// 이용 후기 게시글 갯수를 조회합니다.
	int selectInreviewCount(String memberId);

	// 이용 후기 게시글 리스트를 조회합니다.
	ArrayList<Board> selectInreviewList(PageInfo pi, String memberId);

	// 게시판의 게시글을 삭제합니다.
	int deleteBoard(int[] intArray, String memberId);

	// 찜목록 아이디로 전체 갯수 조회
	int selectWishListCount(String memberId);

	// 찜목록 리스트 조회
	ArrayList<MyWish> selectWishList(PageInfo pi, String memberId);

	// 내가올린셰어하우스리스트갯수 조회
	int selectHouseListCount(String memberId);

	// 내가올린셰어하우스리스트 조회
	ArrayList<House> selectHouseList(PageInfo pi, String memberId);

	// 내가 예약한 셰어하우스 리스트갯수 조회
	int selectRezListCount(String memberId);

	// 내가 예약한 셰어하우스 리스트 조회
	ArrayList<Reservation> selectRezList(PageInfo pi, String memberId);

	// 결제내역 리스트갯수 조회
	int selectPayListCount(String memberId);

	// 결제내역 리스트 조회
	ArrayList<Pay> selectPayList(PageInfo pi, String memberId);

	int selectAlarmCheck(String email);
	
	int updateAlarmCheck(String email);

}
