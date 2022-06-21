package com.project.market.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.market.domain.ProductPageDto;
import com.project.market.service.MainService;

@Controller
@RequestMapping("project")
public class MainController {
	
	@Autowired
	MainService service;
	
	@GetMapping("home")
	public void main(Model model) {
		 List<ProductPageDto> list1 = service.getboardlist1();
		 List<ProductPageDto> list2 = service.getboardlist2();
		 model.addAttribute("boardlist1", list1);
		 model.addAttribute("boardlist2", list2);
	}
	
}
