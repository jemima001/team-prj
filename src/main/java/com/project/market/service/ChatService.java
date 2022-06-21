package com.project.market.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.market.mapper.ChatMapper;

@Service
public class ChatService {

	@Autowired
	private ChatMapper mapper;

	public String getMemberByNickName(String id) {
		// TODO Auto-generated method stub
		return mapper.selectMemberByNickName(id);
	}

}
