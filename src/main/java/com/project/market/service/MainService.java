package com.project.market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.market.domain.ProductPageDto;
import com.project.market.mapper.MainMapper;

@Service
public class MainService {

	@Autowired
	MainMapper mapper;
	
	public List<ProductPageDto> getboardlist1() {
		return mapper.getBoardlist1();
	}
	
	public List<ProductPageDto> getboardlist2() {
		return mapper.getBoardlist2();
	}

}
