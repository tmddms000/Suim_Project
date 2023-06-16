package com.suim.admin.model.vo;

import java.util.ArrayList;

import com.suim.house.model.vo.Region;
import com.suim.member.model.vo.Member;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Dashboard {

	private int selectMemberAll;
	private Dashboard selectEnrollMember;
	private Dashboard selectMemberGender;
	private Dashboard selectMemberHouseTopN; 
	private Dashboard selectMemberInreviewTopN;
	private int selectHouseCount;
	private int selectReservationCount;
	private Dashboard selectReservationRate;
	private Dashboard selectEmptyRate;
	private Dashboard selectHouseMonth;
	private Dashboard selectHouseDate;
	private Dashboard selectRegionTopN; 
	private Dashboard selectEnrollMemberRate;
	private Dashboard selectEnrollMemberMonthRate; 
	private Dashboard selectEnrollMemberDate;
	private Dashboard selectLeaveMemberRate;
}
