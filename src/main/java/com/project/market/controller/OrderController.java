package com.project.market.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.market.domain.CartDto;
import com.project.market.domain.MemberDto;
import com.project.market.domain.OrderDto;
import com.project.market.domain.ProductDto;
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
		System.out.println(list);
		model.addAttribute("cartList", list);
		
		int allTotal = 0;
		for (CartDto cart : list) {
			allTotal += cart.getTotalPrice();
		}
		model.addAttribute("allTotalPrice", allTotal);
		
		MemberDto member = orderService.getMemberById(principal.getName());
		model.addAttribute("member", member);
	}
	
		

	
//	@PostMapping("info")
//	public String orderProcess(OrderDto order, RedirectAttributes rttr) {
//		boolean success = orderService.addOrder(order);
//		
//		if (success) {
//			rttr.addFlashAttribute("message","주문이 완료되었습니다.");
//			return "redirect:/market/project/home";
//			
//		} else {
//			rttr.addFlashAttribute("message","주문 정보를 다시 입력해주세요.");
//			rttr.addFlashAttribute("order", order);
//			return "redirect:/market/project/order";
//		}
//	}
	
	
	@GetMapping("complete")
	public void orderComplete(Model model, Principal principal) {
		
		List<CartDto> list = orderService.cartList(principal.getName());
		System.out.println(list);
		model.addAttribute("cartList", list);
		
		int allTotal = 0;
		for (CartDto cart : list) {
			allTotal += cart.getTotalPrice();
		}
		model.addAttribute("allTotalPrice", allTotal);
		
		MemberDto member = orderService.getMemberById(principal.getName());
		model.addAttribute("member", member);
	}
	
	@PostMapping ("orderData")
	   @ResponseBody
	   public void addcart(OrderDto dto, Principal principal) {
		    orderService.addOrder(dto,principal);
		   
	   }
	
}
