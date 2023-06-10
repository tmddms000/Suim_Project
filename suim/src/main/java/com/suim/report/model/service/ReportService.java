package com.suim.report.model.service;

import com.suim.report.model.vo.Rattachment;
import com.suim.report.model.vo.Report;

public interface ReportService {

	int insertReport(Report r);
	
	int insertRattachment(Rattachment ra);
}
