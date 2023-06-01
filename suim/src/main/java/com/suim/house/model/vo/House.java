package com.suim.house.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class House {
    private int houseNo;
    private String houseName;
    private String houseAddress;
    private int deposit; // 보증금
    private int rent; // 월세
    private Date enterDate; // 입주가능일
    private String minStay; // 최소거주기간
    private String maxStay; // 최대거주기간
    private int roomPeople; // 인실
    private String incFurniture; // 시설정보
    private String houseContent; // 하우스 소개
    private String resGender; // 성별
    private String resType; // 주거유형
    private String floor; // 층수
    private char houseStatus; // 삭제 유무
    private Date houseDate; // 작성일
    private String memberId; // 멤버아이디
}
