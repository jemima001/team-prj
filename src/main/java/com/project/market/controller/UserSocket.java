package com.project.market.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.project.market.domain.MemberDto;
import com.project.market.service.ChatService;

@Controller
@ServerEndpoint(value = "/comm/user")
@RequestMapping("comm")
public class UserSocket {

	@Autowired
	private ChatService service;

	// searchUser 함수의 filter 표현식을 위한 인터페이스
	private interface SearchExpression {
		// 람다식을 위한 함수
		boolean expression(User user);
	}

	// 서버와 유저간의 접속을 key로 구분하기 위한 인라인 클래스
	private class User {
		Session session;
		String key;
		String userName;
	}

	// 유저와 서버간의 접속 리스트
	private static List<User> sessionUsers = Collections.synchronizedList(new ArrayList<>());

	// Session으로 접속 리스트에서 User 클래스를 탐색
	private static User getUser(Session session) {
		return searchUser(x -> x.session == session);
	}

	// Key로 접속 리스트에서 User 클래스를 탐색
	private static User getUser(String key) {
		return searchUser(x -> x.key.equals(key));
	}

	// 접속 리스트 탐색 함수
	private static User searchUser(SearchExpression func) {
		Optional<User> op = sessionUsers.stream().filter(x -> func.expression(x)).findFirst();
		// 결과가 있으면
		if (op.isPresent()) {
			// 결과를 리턴
			return op.get();
		}
		// 없으면 null 처리
		return null;
	}

	@RequestMapping("user")
	public ModelAndView getChatViewPage(ModelAndView mav,
			Model model,
			Principal principal,
			MemberDto member) {
		mav.setViewName("comm/user");
		String nickName = service.getMemberByNickName(principal.getName());

		model.addAttribute("nickName", nickName);
		return mav;
	}

	// browser에서 웹 소켓으로 접속하면 호출되는 함수
	@OnOpen
	public void handleOpen(Session userSession) {
		// 인라인 클래스 User를 생성
		User user = new User();
		// Unique키를 발급 ('-'는 제거한다.)
		user.key = UUID.randomUUID().toString().replace("-", "");
		user.userName = userSession.getUserPrincipal().getName();
		// WebSocket의 세션
		user.session = userSession;
		// 유저 리스트에 등록한다.
		sessionUsers.add(user);
		// 운영자 Client에 유저가 접속한 것을 알린다.
		AdminSocket.visit(user.key, user.userName);
	}

	// browser에서 웹 소켓을 통해 메시지가 오면 호출되는 함수
	@OnMessage
	public void handleMessage(String message, Session userSession) throws IOException {
		// 닉네임과 메시지 구분키를 #####를 넣었다. (json으로 해도 되는데 Gson 연결까지 하면 귀찮아져서...)
		String[] split = message.split("#####", 2);
		// 중간은 정보는 메시지
		String msg = split[0];
		// 뒤 정보는 닉네임
		String nick = split[1];
		// Session으로 접속 리스트에서 User 클래스를 탐색
		User user = getUser(userSession);
		// 접속 리스트에 User가 있으면(당연히 있다. 없으면 버그..)
		if (user != null) {
			// 운영자 Client에 유저 key와 메시지를 보낸다.
			AdminSocket.sendMessage(user.key, msg, nick);
		}
	}

	// 운영자 client가 유저에게 메시지를 보내는 함수
	public static void sendMessage(String key, String message, String nickName) {
		// key로 접속 리스트에서 User 클래스를 탐색
		User user = getUser(key);
		if (user != null) {
			try {
				// 유저 Session으로 socket을 취득한 후 메시지를 전송한다.
				user.session.getBasicRemote().sendText("(" + nickName + ")" + " => " + message);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	// WebSocket이 종료가 되면, 종료 버튼이 없기 때문에 유저 브라우저가 닫히면 발생한다.
	@OnClose
	public void handleClose(Session userSession) {
		// Session으로 접속 리스트에서 User 클래스를 탐색
		User user = getUser(userSession);
		// 접속 리스트에 User가 있으면(당연히 있다. 없으면 버그..)
		if (user != null) {
			// 운영자 Client에 유저 key로 접속 종료를 알린다.
			AdminSocket.bye(user.key);
			// 위 유저 접속 리스트에서 유저를 삭제한다.
			sessionUsers.remove(user);
		}
	}

	// 유저간의 접속 리스트의 키를 취득하려고 할때.
	public static String[] getUserKeys() {
		// 반환할 String 배열을 선언한다.
		String[] ret = new String[sessionUsers.size()];
		// 유저 리스트를 반복문에 돌린다.
		for (int i = 0; i < ret.length; i++) {
			// 유저의 키만 반환 변수에 넣는다.
			ret[i] = sessionUsers.get(i).key;
		}
		// 값 반환
		return ret;
	}
	
	public static String[] getUserName() {
		// 반환할 String 배열을 선언한다.
		String[] ret = new String[sessionUsers.size()];
		// 유저 리스트를 반복문에 돌린다.
		for (int i = 0; i < ret.length; i++) {
			// 유저의 키만 반환 변수에 넣는다.
			ret[i] = sessionUsers.get(i).userName;
		}
		// 값 반환
		return ret;
	}
}
