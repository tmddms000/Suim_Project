package com.suim.chat.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatLog {
    private String sendUser;
    private String receiveUser;
    private String content;
    private Date sendDate;
    private int chatNo;
    private String status;
    private String rstatus;
}
