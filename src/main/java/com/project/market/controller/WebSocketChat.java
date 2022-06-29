package com.project.market.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.project.market.domain.MemberDto;
import com.project.market.service.ChatService;

@Controller
@ServerEndpoint(value="/comm/echo")
@RequestMapping("comm")
public class WebSocketChat {
	
	@Autowired
	private ChatService service;
	
	private static final List<Session> sessionList = new ArrayList<Session>();
	private static final Logger logger = LoggerFactory.getLogger(WebSocketChat.class);
	public WebSocketChat() {
		System.out.println("웹소켓(서버) 객체생성");
	}
	@RequestMapping("chat")
	public ModelAndView getChatViewPage (ModelAndView mav, 
										 Model model, 
										 Principal principal, 
										 MemberDto member) {
		mav.setViewName("comm/chat");
		String nickName = service.getMemberByNickName(principal.getName());
		
		model.addAttribute("nickName", nickName);
		return mav;
	}
	@OnOpen
	public void onOpen(Session session) {
		logger.info("Open session ld:" + session.getId());
		try {
			final Basic basic = session.getBasicRemote();
			basic.sendText("Connection Established");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		sessionList.add(session);
	}
	
	private void sendAllSessionToMessage(Session self, String message) {
		try {
			for(Session session : WebSocketChat.sessionList) {
				if(!self.getId().equals(session.getId())) {
					session.getBasicRemote().sendText(message.split("#####")[1]+" : "+message.split("#####")[0]);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
	}
	@OnMessage
	public void OnMessage(String message, Session session) {
		logger.info("Message From - " +message.split("#####")[1] + ": "+message.split("#####")[0]);
		try {
			final Basic basic = session.getBasicRemote();
			basic.sendText("to : "+message.split("#####")[0]);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		sendAllSessionToMessage(session, message);
	}
	@OnError
	public void onError(Throwable e, Session session) {
		
	}
	@OnClose
	public void onClose(Session session) {
		logger.info("Session " + session.getId()+ " has ended");
		sessionList.remove(session);
	}
}
