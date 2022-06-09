package com.project.market.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.market.domain.ProductPageDto;
import com.project.market.service.ProductPageService;

@Controller
@RequestMapping("product")
public class ProductPageController {
	
	@Autowired
	ProductPageService service;
	
	
	@GetMapping("add")
	public void addproduct() {
		
		
	}
	
	@PostMapping("add")
	public void addproduct_in(ProductPageDto dto) {
		service.AddProductPage(dto);
		System.out.println("판매글 제목 :"+dto.getBoardTitle());
		System.out.println("판매글 내용 :"+dto.getBoardBody());
	}

}
