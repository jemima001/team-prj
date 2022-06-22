package com.project.market.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.market.domain.CartDto;
import com.project.market.domain.MemberDto;
import com.project.market.domain.OrderDto;
import com.project.market.domain.ProductPageDto;
import com.project.market.service.OrderService;

@Controller
@RequestMapping("order")
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	
	@GetMapping("info")
	public void orderForm(Model model, Principal principal) {
		//System.out.println(principal.getName());
		List<CartDto> list = orderService.cartList(principal.getName());
		
		model.addAttribute("cartList", list);
		
		int allTotal = 0;
		for (CartDto cart : list) {
			allTotal += cart.getTotalPrice();
		}
		model.addAttribute("allTotalPrice", allTotal);
		
		MemberDto member = orderService.getMemberById(principal.getName());
		
		model.addAttribute("member", member);
	}
	
	
	@GetMapping("complete")
	public void orderComplete(Model model, Principal principal) {
		
		List<CartDto> list = orderService.cartList(principal.getName());
		
		model.addAttribute("cartList", list);
		
		int allTotal = 0;
		for (CartDto cart : list) {
			allTotal += cart.getTotalPrice();
		}
		model.addAttribute("allTotalPrice", allTotal);
		
		MemberDto member = orderService.getMemberById(principal.getName());
		model.addAttribute("member", member);
	}
	
	@PostMapping ("complete")
	   public void addcart(Model model, OrderDto dto, Principal principal) {
		List<CartDto> list = orderService.cartList(principal.getName());
		
		int allTotal = 0;
		for (CartDto cart : list) {
			allTotal += cart.getTotalPrice();
			orderService.addOrder(cart, principal.getName(), dto.getRecipient(), dto.getAddress());
			
		}
		
		orderService.deleteCartList(principal.getName()); //카트 정보가 추가된 뒤 삭제
	
		model.addAttribute("allTotalPrice", allTotal);
		
		MemberDto member = orderService.getMemberById(principal.getName());
		model.addAttribute("member", member);
		
		
		
	
	}
	
	
	@PostMapping("direct")
	public void direct(Model model, ProductPageDto dto, Principal principal, int Purchase) {
		
		System.out.println(Purchase);
	}
		   
	
}
