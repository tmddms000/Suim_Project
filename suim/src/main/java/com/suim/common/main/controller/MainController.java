package com.suim.common.main.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.suim.board.model.vo.Find;
import com.suim.board.model.vo.InReview;
import com.suim.common.main.model.service.MainService;
import com.suim.house.model.vo.House;
import com.suim.member.model.vo.Member;

@Controller
public class MainController {

	@Autowired
	private HttpSession session;
	@Autowired
	private MainService mainService;

	@GetMapping("/")
	public String searchArea(Model model) {

		Member m = (Member) session.getAttribute("loginUser");
		ArrayList<House> list = mainService.selectHouseList();
		ArrayList<Find> flist = mainService.selectfList();
		ArrayList<InReview> ilist = mainService.selectiList();

		List<Find> filteredList = flist.stream().filter(find -> find.getThumbnail() != null)
				.collect(Collectors.toList());

		List<Find> listFind = flist.subList(0, Math.min(flist.size(), 8));

		if (m != null && m.getArea() != null) { // 회원이 로그인해있을때 페이지

			double longitude = m.getLongitude();
			double latitude = m.getLatitude();
			list.sort(Comparator.comparingDouble(
					house -> calculateDistance(latitude, longitude, house.getLatitude(), house.getLongitude())));

			List<House> listHouse = list.subList(0, Math.min(list.size(), 4));
			List<Double> distances = new ArrayList<>();

			for (House house : listHouse) {
				double distance = calculateDistance(latitude, longitude, house.getLatitude(), house.getLongitude());
				double roundedDistance = Math.ceil(distance * 10) / 10;
				distances.add(roundedDistance);
			}
			model.addAttribute("listHouse", listHouse);
			model.addAttribute("distance", distances);

		} else if (m == null || m.getArea() == null) { // 회원이 로그인하지 않을때 페이지
			Collections.shuffle(list);
			model.addAttribute("listHouse", list.subList(0, Math.min(list.size(), 4)));

		}

		model.addAttribute("filterFind", filteredList);
		model.addAttribute("listFind", listFind);
		model.addAttribute("ilist", ilist);
		

		return "main";

	}
	
	@GetMapping("/suim")
	public String suim(Model model) {
		Map<String, Object> count = mainService.selectCountList();
		
		model.addAttribute("count", count);
		
		return "suim";
	}
	
	

	private static final double EARTH_RADIUS = 6371; // Earth's radius in kilometers

	private double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
		// Convert latitude and longitude to radians
		double lat1Rad = Math.toRadians(lat1);
		double lon1Rad = Math.toRadians(lon1);
		double lat2Rad = Math.toRadians(lat2);
		double lon2Rad = Math.toRadians(lon2);

		// Calculate the differences between the latitude and longitude values
		double latDiff = lat2Rad - lat1Rad;
		double lonDiff = lon2Rad - lon1Rad;

		// Calculate the central angle between the two points
		double centralAngle = 2 * Math.asin(Math.sqrt(Math.pow(Math.sin(latDiff / 2), 2)
				+ Math.cos(lat1Rad) * Math.cos(lat2Rad) * Math.pow(Math.sin(lonDiff / 2), 2)));

		// Calculate the distance using the Haversine formula
		double distance = EARTH_RADIUS * centralAngle;

		return distance;
	}

	// 좌표값 계산
	public static double[] getCoordinates(String area) {
		String apiKey = "98a4b62c5632d84305d651d3c80029fd";
		String apiUrl = "https://dapi.kakao.com/v2/local/search/address.json";
		double[] coordinates = null;
		if (area == null) {
			return null;
		}
		try {
			area = URLEncoder.encode(area, "UTF-8");
			String addr = apiUrl + "?query=" + area;

			URL url = new URL(addr);
			URLConnection conn = url.openConnection();
			conn.setRequestProperty("Authorization", "KakaoAK " + apiKey);

			BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			StringBuffer docJson = new StringBuffer();

			String line;

			while ((line = rd.readLine()) != null) {
				docJson.append(line);
			}

			String jsonString = docJson.toString();
			rd.close();

			Gson gson = new Gson();
			JsonObject jsonObject = gson.fromJson(jsonString, JsonObject.class);
			JsonArray documents = jsonObject.getAsJsonArray("documents");

			if (documents != null && documents.size() > 0) {
				JsonObject document = documents.get(0).getAsJsonObject();
				JsonObject address = document.getAsJsonObject("address");
				double longitude = address.get("x").getAsDouble();
				double latitude = address.get("y").getAsDouble();

				coordinates = new double[] { longitude, latitude };
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return coordinates;
	}
	
	

}
