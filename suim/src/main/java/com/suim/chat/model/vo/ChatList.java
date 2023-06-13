package com.suim.chat.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatList {
    private int chatNo;
    private String cuser;
    private String muser;
    private Date cDate;
    private String status;
    private int unreadCount; // 추가된 변수
}
