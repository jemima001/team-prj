package com.project.market.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.market.domain.ProductPageDto;
import com.project.market.mapper.ProductPageMapper;

@Service
public class ProductPageService {
	
	@Autowired
	ProductPageMapper mapper;

	public void AddProductPage(ProductPageDto dto) {
		int ok = mapper.AddPage(dto);
		
	}

	

}
