package com.project.market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.market.domain.MemberDto;
import com.project.market.mapper.MemberMapper;

@Service
public class MemberService {
	
	@Autowired
	private MemberMapper mapper;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	public boolean addMember(MemberDto member) {

		// 평문암호를 암호화(encoding)
		String encodedPassword = passwordEncoder.encode(member.getPassword());
		
		// 암호화된 암호를 다시 세팅
		member.setPassword(encodedPassword);
		
		// insert member  
		int cnt1 = mapper.insertMember(member);
		
		return cnt1 == 1;
	}
	
}






