package com.project.market.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.market.service.ProductPageService;

@Controller
@RequestMapping("product")
public class ProductPageController {
	
	@Autowired
	ProductPageService service;
	
	
	@GetMapping("add")
	public void addproduct() {
		
		
	}

}
