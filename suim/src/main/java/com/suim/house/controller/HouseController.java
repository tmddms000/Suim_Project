package com.suim.house.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.suim.common.main.controller.MainController;
import com.suim.house.model.service.HouseService;
import com.suim.house.model.service.ListHouseService;
import com.suim.house.model.vo.House;
import com.suim.house.model.vo.Photo;
import com.suim.house.model.vo.Wish;
import com.suim.member.model.vo.Member;
import com.suim.report.model.vo.Report;

@Controller
public class HouseController {

	private final JavaMailSender mailSender;

	@Autowired
	private HouseService houseService;

	@Autowired
	private ListHouseService listHouseService;

	@Autowired
	public HouseController(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	@RequestMapping("detail.ho")
	public ModelAndView selectList(ModelAndView mv, int hno, HttpSession session, String admin) {

		House h = houseService.selectHouse(hno);

		if (!h.getEnrollStatus().equals("등록완료") && (admin == null)) {
			if (h.getEnrollStatus().equals("심사완료") && (h.getAge() > 0 || h.getDeposit() == 0)) {
				
				ArrayList<Wish> list = houseService.checkHeart(h.getHouseNo());
				ArrayList<Photo> plist = houseService.selectPhoto(hno);

				Member loginUser = (Member) session.getAttribute("loginUser");

				int lo = 0;
				String Id = "";
				int rezChResult = 0;

				if (loginUser != null) {
					Id = loginUser.getMemberId();

					Map<String, Object> rezCheck = new HashMap<>();
					rezCheck.put("hno", hno);
					rezCheck.put("Id", Id);

					rezChResult = listHouseService.rezChCount(rezCheck);

					if (rezChResult > 0) {

						int loginRno = listHouseService.loginRno(rezCheck);
						mv.addObject("loginRno", loginRno);
					}

					for (Wish w : list) {
						if (loginUser.getMemberId().equals(w.getId())) {
							lo = w.getHno();
						}
					}
				}

				mv.addObject("rezChResult", rezChResult);
				mv.addObject("plist", plist);
				mv.addObject("Id", Id);
				mv.addObject("lo", lo);
				mv.addObject("h", h).setViewName("house/houseView");

				return mv;
				
			} else {
			session.setAttribute("alertMsg", "현재 심사중입니다.");
			mv.setViewName("redirect:/mypage/house");
			return mv;
			}
		}

		ArrayList<Wish> list = houseService.checkHeart(h.getHouseNo());
		ArrayList<Photo> plist = houseService.selectPhoto(hno);

		Member loginUser = (Member) session.getAttribute("loginUser");

		int lo = 0;
		String Id = "";
		int rezChResult = 0;

		if (loginUser != null) {
			Id = loginUser.getMemberId();

			Map<String, Object> rezCheck = new HashMap<>();
			rezCheck.put("hno", hno);
			rezCheck.put("Id", Id);

			rezChResult = listHouseService.rezChCount(rezCheck);

			if (rezChResult > 0) {

				int loginRno = listHouseService.loginRno(rezCheck);
				mv.addObject("loginRno", loginRno);
			}

			for (Wish w : list) {
				if (loginUser.getMemberId().equals(w.getId())) {
					lo = w.getHno();
				}
			}
		}

		mv.addObject("rezChResult", rezChResult);
		mv.addObject("plist", plist);
		mv.addObject("Id", Id);
		mv.addObject("lo", lo);
		mv.addObject("h", h).setViewName("house/houseView");

		return mv;
	}

	@RequestMapping("heart.ho")
	public ResponseEntity<String> heart(@RequestParam("hno") int hno, @RequestParam("type") String type,
			HttpSession session) {
		Member loginUser = (Member) session.getAttribute("loginUser");
		String id = "";
		if (loginUser != null) {
			id = loginUser.getMemberId();
		} else {
			// 로그인이 필요한 기능이므로 로그인되지 않은 경우 에러 응답을 반환
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 후 이용해주세요.");
		}

		if (type.equals("like")) {
			houseService.heartLike(id, hno);
		} else {
			houseService.heartUnlike(id, hno);
		}

		// 성공적인 응답 반환
		return ResponseEntity.ok().body("success");
	}

	@RequestMapping("enrollHouse.ho")
	public String enrollHouse(House h, MultipartFile image1, MultipartFile image2, MultipartFile image3,
			MultipartFile image4, MultipartFile image5, MultipartFile image6, HttpSession session, Model model) {

		Member loginUser = (Member) session.getAttribute("loginUser");
		h.setMemberId(loginUser.getMemberId());

		MultipartFile[] images = { image1, image2, image3, image4, image5, image6 };

		if (h.getHouseAddress() != null) {
			double[] area = MainController.getCoordinates(h.getHouseAddress());
			h.setLongitude(area[0]);
			h.setLatitude(area[1]);
		}

		int result2 = houseService.enrollHouse(h);

		int hno = houseService.selectHno(h.getMemberId());

		int result = result2;

		for (int i = 0; i < images.length; i++) {
			MultipartFile image = images[i];
			String changeName = saveFile(image, session);

			Photo photo = new Photo();
			photo.setOriginName(image.getOriginalFilename());
			photo.setChangeName(changeName);
			photo.setHouseNo(hno);

			if (i == 0) {
				photo.setFileLevel("Y");
			} else {
				photo.setFileLevel("N");
			}

			int result1 = houseService.enrollPhoto(photo);
			result *= result1;
		}

		if (result > 0) { // 게시글 등록 성공 => 게시글 목록보기 요청
			session.setAttribute("alertMsg", "방이 등록되었습니다.");
			return "redirect:/mypage/house";
		} else { // 게시글 등록 실패 => 에러문구 담아서 에러페이지 포워딩
			model.addAttribute("errorMsg", "방 등록에 실패하였습니다.");
			return "common/errorPage";
		}
	}

	public String saveFile(MultipartFile upfile, HttpSession session) {

		String originName = upfile.getOriginalFilename(); // "bono.jpg"

		// 2. 현재 시간 형식을 문자열로 뽑아내기
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); // "20230511104920"

		// 3. 뒤에 붙을 5자리 랜덤값 뽑기 (10000~99999 범위)
		int ranNum = (int) (Math.random() * 90000 + 10000); // 13152

		// 4. 원본 파일명으로부터 확장자명 뽑기
		String ext = originName.substring(originName.lastIndexOf(".")); // ".jpg"

		// 5. 2, 3 , 4 단계에서 구한 값을 모두 이어 붙히기
		String changeName = currentTime + ranNum + ext;

		// 6. 업로드 하고자 하는 서버의 물리적인 경로 알아내기
		String savePath = session.getServletContext().getRealPath("/resources/img/house/uploadFiles/");

		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IOException e) {
			e.printStackTrace();
		}

		return changeName;
	}

	@RequestMapping("houseEdit.ho")
	public ModelAndView houseEdit(ModelAndView mv, int hno, HttpSession session) {

		House h = houseService.selectHouse(hno);

		if (!h.getEnrollStatus().equals("등록완료")) {
			if (h.getEnrollStatus().equals("심사완료") && (h.getAge() > 0 || h.getDeposit() == 0)) {
				ArrayList<Photo> plist = houseService.selectPhoto(hno);

				mv.addObject("plist", plist);
				mv.addObject("h", h).setViewName("house/houseEdit");

				return mv;
			} else {
			
				session.setAttribute("alertMsg", "현재 심사중입니다.");
				mv.setViewName("redirect:/mypage/house");
				return mv;
			}
		}

		ArrayList<Photo> plist = houseService.selectPhoto(hno);

		mv.addObject("plist", plist);
		mv.addObject("h", h).setViewName("house/houseEdit");

		return mv;
	}

	@RequestMapping("updateHouse.ho")
	public String updateHouse(House h, int hno, int photoNo1, int photoNo2, int photoNo3, int photoNo4, int photoNo5,
			int photoNo6, MultipartFile image1, MultipartFile image2, MultipartFile image3, MultipartFile image4,
			MultipartFile image5, MultipartFile image6, HttpSession session, Model model) {

		int[] photoNos = { photoNo1, photoNo2, photoNo3, photoNo4, photoNo5, photoNo6, };
		MultipartFile[] images = { image1, image2, image3, image4, image5, image6 };

		if (h.getHouseAddress() != null) {
			double[] area = MainController.getCoordinates(h.getHouseAddress());
			h.setLongitude(area[0]);
			h.setLatitude(area[1]);
		}

		h.setHouseNo(hno);
		Member loginUser = (Member) session.getAttribute("loginUser");
		h.setMemberId(loginUser.getMemberId());
		int age = h.getAge();
		h.setAge(++age);

		int result2 = houseService.updateHouse(h);

		int result = result2;

		for (int i = 0; i < images.length; i++) {
			MultipartFile image = images[i];

			// 이미지가 변경되었을 경우에만 처리
			if (!image.isEmpty()) {
				String changeName = saveFile(image, session);

				Photo photo = new Photo();
				photo.setPhotoNo(photoNos[i]);
				photo.setOriginName(image.getOriginalFilename());
				photo.setChangeName(changeName);
				photo.setHouseNo(hno);

				if (i == 0) {
					photo.setFileLevel("Y"); // 대표 이미지
				} else {
					photo.setFileLevel("N"); // 일반 이미지
				}

				int result1 = houseService.updatePhoto(photo);
				result *= result1;
			}
		}

		if (result > 0) {
			session.setAttribute("alertMsg", "방 정보가 수정되었습니다.");
			return "redirect:/mypage/house";
		} else {
			model.addAttribute("errorMsg", "방 정보 수정에 실패하였습니다.");
			return "common/errorPage";
		}
	}

	@RequestMapping("delete.ho")
	public ModelAndView deleteHouse(ModelAndView mv, int hno) {
		houseService.deleteHouse(hno);
		mv.setViewName("redirect:/mypage/house");
		return mv;
	}

	@RequestMapping("report.ho")
	public ModelAndView reportHouse(@RequestParam("value") int houseNo, @RequestParam("value2") String houseName,
			@RequestParam("value3") String memberId, ModelAndView mv) {

		Report r = new Report();
		r.setTypeNo(houseNo);
		r.setReportId(memberId);
		r.setReportType("house");

		mv.addObject("r", r);
		mv.setViewName("report/reportUpdateForm");

		return mv;
	}

	@RequestMapping("Write.ho")
	public ModelAndView WriteHouse(ModelAndView mv, HttpSession session) {

		Member loginUser = (Member) session.getAttribute("loginUser");
		if (loginUser != null) {
			mv.setViewName("/house/houseWrite");
			return mv;
		} else {

			session.setAttribute("alertMsg", "로그인 후 이용해주세요.");
			mv.setViewName("redirect:/member/login");
			return mv;
		}
	}
}
