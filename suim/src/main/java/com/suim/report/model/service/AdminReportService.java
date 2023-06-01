package com.suim.report.model.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.suim.common.model.vo.PageInfo;
import com.suim.report.model.vo.Report;

public interface AdminReportService {


	// 신고 리스트 조회 서비스 (+ 페이징처리)
	// 신고 총 갯수 조회
	int selectListCount();
	// 신고 리스트 조회
	ArrayList<Report> selectList(PageInfo pi);
	
	// 카테고리용 전체 조회
	ArrayList<Report> selectList(PageInfo pi, String category);
	
	// 신고 작성하기 서비스
	int insertReport(Report r);
	
	// 신고 상세조회 서비스
	// 신고 조회수 증가
	// 필요 없어서 삭제
	
	// 신고 상세 조회
	Report selectReport(int reportNo);
	
	// 신고 삭제 서비스
	int deleteReport(int reportNo);
	
	// 신고 수정 서비스
	int updateReport(Report r);

}
