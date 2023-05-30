package com.suim.member.model.service;

import java.util.ArrayList;
import java.util.Set;


import javax.validation.Valid;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suim.member.model.dao.MemberDao;
import com.suim.member.model.vo.Member;

import com.suim.member.model.vo.SignUp;


@Service
public class MemberServiceImpl implements MemberService {

	// 필드부
		@Autowired
		private SqlSessionTemplate sqlSession;
		
		@Autowired
		private MemberDao memberDao;
		
		@Override
		public Member loginMember(Member m) {

			// 기존 Service 단 (순수 MyBatis)
			// 1. SqlSession 객체 생성
			// 2. 만들어진 SqlSession 객체와 전달값을 Dao 로 넘기면서 요청 후 결과 받기
			// 3. 트랜잭션 처리
			// 4. SqlSession 객체 반납
			// 5. 결과 반환
			
			// Spring 에서 MyBatis 이용하기 
			// 1. SqlSessionTemplate 객체 생성 (이미 빈으로 등록했었음)
			// => 전역변수로 셋팅해두기 (@Autowired 를 이용)
			
			// 2. 만들어진 SqlSessionTemplate 객체와 전달값을 Dao 로 넘기면서 요청 후 결과 받기
			Member loginUser = memberDao.loginMember(sqlSession, m);

			// 3. 트랜잭션 처리 => 자동커밋을 이용할 예정
			// 어차피 지금은 select 문이기 때문에 패스하는게 맞음
			
			// 4. SqlSessionTemplate 객체 반납
			// => @Autowired 어노테이션에 의해 스프링 컨테이너가 객체 생성 후
			//    우리가 객체를 다 이용했다면 알아서 자동으로 객체 반납까지 해줄것임!!
			//    개발자인 내가 직접 close 메소드를 이용해서 자원 반납할 필요도 없음
			
			// 5. 결과 반환
			return loginUser;
		}

		@Override
		public int updateMember(Member m) {
			return memberDao.updateMember(sqlSession, m);
		}

		@Override
		public int deleteMember(String userId) {
			return memberDao.deleteMember(sqlSession, userId);
		}

		@Override
		public int idCheck(String checkId) {
			return memberDao.idCheck(sqlSession, checkId);
		}

		@Override
		public ArrayList<Member> selectMemberList() {
			return memberDao.selectMemberList(sqlSession);
		}

		@Override
		public int nickCheck(String nickName) {
			return memberDao.nickCheck(sqlSession, nickName);
		}

		@Override
		public int emailCheck(String email) {
			return memberDao.emailCheck(sqlSession, email);
		}



		@Override
		public int insertMember(@Valid SignUp member) {
			return memberDao.insertMember(sqlSession, member);
		}
}
