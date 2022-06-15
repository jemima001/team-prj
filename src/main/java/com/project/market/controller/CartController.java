package com.project.market.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.market.domain.CartDto;
import com.project.market.service.CartService;



@Controller
@RequestMapping("order")
public class CartController {
	@Autowired
	private CartService cartService;
	
	@GetMapping("cart")
	public void cart(String id, Model model) {
		
		List<CartDto> list = cartService.cartList(id);
		System.out.println(list);
		model.addAttribute("cartList", list);
		
	}
}


