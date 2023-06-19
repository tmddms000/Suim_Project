package com.suim.admin.model.vo;

import java.util.ArrayList;

import com.suim.house.model.vo.Region;
import com.suim.member.model.vo.Member;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Dashboard {

	private int totalMembers;
	private int totalHouses;
	private String month;
	private String day;
	private int newMembers;
	private String gender;
	private int memberCount;
	private String memberId;
	private String memberName;
	private int reservationCount;
	private int reviewCount;
	private int totalRooms;
	private int reservedRooms;
	private int reservationRate;
	private int vacantRooms;
	private int vacancyRate;
	private int totalRevenue;
	private String houseName;
	private String houseDate;
	private String regionName;
	private int roomCount;
	private int newMemberPercentage;
	private String registrationDate;
	private int leaveMembers;
	private int leaveRate;
	

	private int selectFind1;
	private int selectFind2;
}
