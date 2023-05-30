<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>고객 마이페이지</title>
    </head>
    <body>
        고객의 아이디는 : ${member.memberId}이고,
        고객의 비밀번호는 : ${member.memberPwd}이고,
        고객의 전화번호는 : ${member.phone}이고,
        고객의 이름은 : ${member.memberName}이고,
        고객의 닉네임은 ${member.nickName}입니다.
    </body>
</html>
