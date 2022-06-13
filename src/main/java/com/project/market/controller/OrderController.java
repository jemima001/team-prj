package com.project.market.controller;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.market.domain.MemberDto;
import com.project.market.domain.OrderDto;
import com.project.market.service.OrderService;

@Controller
@RequestMapping("order")
public class OrderController {
	
	private OrderService orderService;
	
	@GetMapping("info")
	public void orderForm(
			//int productId,
			//int payment,
			Model model, 
			Principal principal) {
		
		MemberDto memberdto = new MemberDto();//db에서 가져오기
		
		//MemberDto memberdto = memberSerivce.getMemberById(principal.getName());
		
		memberdto.setId("donald");
		memberdto.setNickName("도람뿌"); //아직 데이터가 없으므로 임의로 지정함
		
		//memberdto.setpayment
		
		
		//productdto 승호씨가 만드는 영역이므로 우선 비활성화
		//ProductDto productdto = new ProductDto(); // db에서 가져오기
		//productdto.setId(1); //primary key
		//productdto.setName("컴퓨터");
		
		//model.addAttribute("product", productdto);
		model.addAttribute("member", memberdto);
		
		
		

		
	}
	
	@PostMapping("info")
	public String orderProcess(OrderDto order, RedirectAttributes rttr) {
		boolean success = orderService.addOrder(order);
		
		if (success) {
			rttr.addFlashAttribute("message","주문이 완료되었습니다.");
			return "redirect:/market/project/home";
			
		} else {
			rttr.addFlashAttribute("message","주문 정보를 다시 입력해주세요.");
			rttr.addFlashAttribute("order", order);
			return "redirect:/market/project/order";
		}
	}
	
	
	@GetMapping("complete")
	public void orderComplete(OrderDto order) {
		
	}
	
	@GetMapping("cart")
	public void cart() {
		
	}
}
