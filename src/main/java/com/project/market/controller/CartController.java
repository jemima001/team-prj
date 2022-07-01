package com.project.market.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.market.domain.CartDto;
import com.project.market.service.CartService;



@Controller
@RequestMapping("order")
public class CartController {
	@Autowired
	private CartService cartService;
	
	@GetMapping("cart")
	public void cart(Principal principal, Model model) {
		
		List<CartDto> list = cartService.cartList(principal.getName());
		//System.out.println(list);
		model.addAttribute("cartList", list);
		
		int allTotal = 0;
		for (CartDto cart : list) {
			allTotal += cart.getTotalPrice();
		}
		model.addAttribute("allTotalPrice", allTotal);
	}
	
	
	@PostMapping("cart")
	public void getCart(String memberId, Principal principal) {
	
		System.out.println(memberId);
		
	}
	
	
	
	
	@PostMapping("checked")
	public String cartDelete(CartDto dto , 
			@RequestParam(name = "cartIds", required = false) List<Integer> cartIds, 
			Principal principal, RedirectAttributes rttr) {
		//System.out.println("12"+dto.getCartId());
		//System.out.println("555"+principal.getName());
		//System.out.println(cartIds);
		
		rttr.addAttribute("id", dto.getMemberId());
		
		boolean success = cartService.cartDelete(cartIds);
			
		return "redirect:/order/cart?id="+principal.getName();
	}
	
	
	
	
	
	
	
	
	
}
	

	
	





