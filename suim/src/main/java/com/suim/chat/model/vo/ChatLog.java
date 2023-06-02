package com.suim.chat.model.vo;

import java.sql.Timestamp;

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
    private Timestamp sendDate;
    private int chatNo;
    private char status;
}
