package com.suim.common.main.model.vo;

import com.suim.house.model.vo.House;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class HouseDistance {
    private House house;
    private double distance;
}
