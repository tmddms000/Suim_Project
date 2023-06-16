package com.suim.admin.model.vo;

import java.util.ArrayList;

import com.suim.house.model.vo.Region;
import com.suim.member.model.vo.Member;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Dashboard {

	private ArrayList<Member> selectMemberAll;
	private ArrayList<Member> selectEnrollMember;
	private ArrayList<Member> selectMemberGender;
	private ArrayList<Member> selectMemberHouseTopN; 
	private ArrayList<Member> selectMemberInreviewTopN;
	private int selectHouseCount;
	private int selectReservationCount;
	private ArrayList<Member> selectReservationRate;
	private ArrayList<Member> selectEmptyRate;
	private ArrayList<Member> selectHouseMonth;
	private ArrayList<Member> selectHouseDate;
	private ArrayList<Region> selectRegionTopN; 
	private ArrayList<Member> selectEnrollMemberRate;
	private ArrayList<Member> selectEnrollMemberMonthRate; 
	private ArrayList<Member> selectEnrollMemberDate;
	private ArrayList<Member> selectLeaveMemberRate;
}
