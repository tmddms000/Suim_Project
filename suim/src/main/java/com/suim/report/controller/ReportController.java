package com.suim.report.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.suim.report.model.service.ReportService;
import com.suim.report.model.vo.Rattachment;
import com.suim.report.model.vo.Report;

@Controller
public class ReportController {
                  
	@Autowired
	private ReportService reportService;
	
	@RequestMapping("insert.re")
	public String insertReport(Report r,
							 Rattachment ra,
							MultipartFile upfile,
							HttpSession session,
							Model model
							,HttpServletResponse response) {
		
		// 중복신고 처리
		Integer isDuplicate = reportService.hasDuplicateReport(r);

		System.out.println(isDuplicate);
		
		if(isDuplicate == null) {
			int result = reportService.insertReport(r);

			if(result > 0) {
				response.setContentType("text/html; charset=UTF-8");
		        try {
		            PrintWriter out = response.getWriter();
		            out.println("<script>");
		            out.println("alert('신고가 접수되었습니다.');");
		            out.println("window.close();");
		            out.println("</script>");
		            out.flush();
		        } catch (IOException e) {
		            e.printStackTrace();
		        }
			}
			
	        return null;
		} else {
			model.addAttribute("errorMsg", "이미 신고가 접수되었습니다.");
			return "common/errorPage";
		}
	}
	
	public String saveFile(MultipartFile upfile, HttpSession session) {
		
		String originName = upfile.getOriginalFilename(); // "bono.jpg"
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss")
								 .format(new Date(0)); // "20230511104920"
		
		int ranNum = (int)(Math.random() * 90000 + 10000); // 13152
		
		String ext = originName.substring(originName.lastIndexOf(".")); // ".jpg"
		
		String changeName = currentTime + ranNum + ext;
		
		String savePath = session.getServletContext().getRealPath("resources/img/report/uploadFiles/");
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "/resources/img/report/uploadFiles/" + changeName;
	}
	
	@RequestMapping(value="/uploadSummerNoteImageFile", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummerNoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request) {
	    JsonObject jsonObject = new JsonObject();
	    // 내부경로로 저장
	    String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
	    String fileRoot = contextRoot + "resources/img/report/uploadFiles/";
	    String originalFileName = multipartFile.getOriginalFilename();    // 오리지날 파일명
	    String extension = originalFileName.substring(originalFileName.lastIndexOf("."));    // 파일 확장자
	    String savedFileName = UUID.randomUUID() + extension;    // 저장될 파일 명
	    
	    File targetFile = new File(fileRoot + savedFileName);
	    try {
	        InputStream fileStream = multipartFile.getInputStream();
	        FileUtils.copyInputStreamToFile(fileStream, targetFile);    // 파일 저장
	        jsonObject.addProperty("url", "resources/img/report/uploadFiles/" + savedFileName); // contextroot + resources + 저장할 내부 폴더명
	        jsonObject.addProperty("responseCode", "success");
	        
	    } catch (IOException e) {
	        FileUtils.deleteQuietly(targetFile);    // 저장된 파일 삭제
	        jsonObject.addProperty("responseCode", "error");
	        e.printStackTrace();
	    }
	    String a = jsonObject.toString();
	    return a;
	}
}
