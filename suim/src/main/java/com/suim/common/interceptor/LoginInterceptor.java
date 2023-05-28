package com.suim.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/*
 * * Interceptor (인터셉터)
 * 컨트롤러 클래스로 들어오는 요청과 나가는 응답을 가로채는 역할
 * 
 * * Spring 요청 flow
 * 뷰 -> Filter(서블릿에서 파생된 개념) -> DispatcherServlet -> Interceptor(스프링에서 제공하는 개념) -> Controller클래스의 메소드
 * 
 * * Interceptor 간섭 시접
 * 1. 요청 전 : Controller 에 요청이 도달하기 전 선처리할 내용물을 정의 => preHandle
 * 			 (주로 로그인 유무 판단, 로그인한 회원의 권한 또는 직급 체크 시 사용)
 * 2. 요청 후 : Controller 에서 처리 후 응답페이지로 도달하기 전에 후처리할 내용물을 정의 => postHandle
 * 			 (요청이 잘 처리 되었는지 기록 등에 사용)
 * 
 * * Interceptor 구현 방식 2가지
 * 1. HandlerInterceptor 라는 인터페이스를 상속받아서 구현하는 방법
 * : 해당 인터페이스에서 제공하는 모든 추상메소드를 전부 다 오버라이딩 해야 하기 때문에 내가 필요하지 않은 메소드도 무조건 만들어야 한다라는 단점
 * 2. HandlerInterceptorAdapter 라는 클래스를 상속받는 방법
 * : 내가 원하는 메소드만 오버라이딩 가능
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {

//	// 1. preHandle 메소드 (선처리)
//	@Override
//	public boolean preHandle(HttpServletRequest request, 
//							 HttpServletResponse response, 
//							 Object handler) throws Exception {
//		
//		// 매개변수
//		// - request : 사용자의 요청, 사용자가 보낸 전달값이 들어있음 (parameter 영역)
//		// - response : 요청에 대한 응답, 요청 처리 후 사용자에게 돌려줄 응답 데이터
//		// - handler : 이 요청은 누가 처리하기로 했는지?
//		// System.out.println("preHandle 이 잘 작동 하나..?");
//		// System.out.println(handler.toString());
//		
//		// 리턴값
//		// - true : 요청에 최종적으로 도달하겠다.
//		// - false : 요청에 들어가지 않고 끊어버리겠다.
//		
//		// 로그인이 된 상태인지 검사하는 코드 추가
//		// => session 에서 loginUser 가 있는 지 검사
//		HttpSession session = request.getSession();
//		
//		if(session.getAttribute("loginUser") != null) { // 로그인 된 상태
//			
//			return true;
//			
//		} else { // 로그인 안된 상태
//			
//			session.setAttribute("alertMsg", "로그인 후 이용 가능한 서비스입니다.");
//			response.sendRedirect(request.getContextPath()); // 메인페이지로 url 재요청
//			
//			return false;
//		}
	}
	
	// 2. postHandle 메소드 (후처리)
	/*
	@Override
	public void postHandle(HttpServletRequest request, 
						   HttpServletResponse response,
						   Object handler,
						   ModelAndView modelAndView) throws Exception {
		
		// 매개변수
		// - request : 사용자의 요청, 사용자가 보낸 요청 시 전달값
		// - response : 이 요청에 대한 응답, 사용자에게 보낼 응답데이터
		// - handler : 이 요청은 누가 처리하기로 했는가?
		// - modelAndView : model (전달데이터) + view (응답페이지) 정보
		System.out.println("postHandle 이 잘 작동 되나..?");
		System.out.println(modelAndView.toString());
		
		// postHandle 은 반환형이 없음 (void)
		// => 이미 Controller 에서 요청 처리가 다 끝내고 돌아오는 길이라 못되돌리기 때문
	}
	*/












