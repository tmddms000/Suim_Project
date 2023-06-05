package com.suim.board.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@NoArgsConstructor
@Setter
@Getter
@ToString
public class Board {
	
//	  BOARD_NO     NUMBER PRIMARY KEY,
//	  BOARD_TITLE  VARCHAR2(300) NOT NULL,
//	  BOARD_COTENT VARCHAR2(3000) NOT NULL,
//	  BOARD_VIEW   NUMBER        DEFAULT 0 NOT NULL,
//	  BOARD_DATE   DATE          DEFAULT SYSDATE NOT NULL,
//	  STATUS       CHAR(1)       DEFAULT 'Y' NOT NULL,
//	  MEMBER_ID    VARCHAR2(15)  NOT NULL
	
    
    private int boardNo;
    private String boardTitle;
    private String boardContent;
    private int boardView;
    private Date boardDate;
    private String status;
    private String memberId;
    private String nickName;
    private int replyCount;
    
    // 첨부파일 필드
	private String originName;
	private String changeName;
	private String thumbnail;
	

}
