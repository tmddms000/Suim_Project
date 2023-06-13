package com.suim.common.model.vo;

import java.sql.Timestamp;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Notification {
	
	public int id;
	public String content;
	public String receiverId;
	public String senderId;
	public int postNo;
	public String postType;
	public String postContent;
	public Timestamp createdTime;
	

}
