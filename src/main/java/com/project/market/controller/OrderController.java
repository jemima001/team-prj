package com.project.market.controller;

import java.security.Principal;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.market.domain.CartDto;
import com.project.market.domain.MemberDto;
import com.project.market.domain.OrderDto;
import com.project.market.domain.ProductPageDto;
import com.project.market.service.MemberService;
import com.project.market.service.OrderService;

@Controller
@RequestMapping("order")
public class OrderController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private JavaMailSender mailSender;
	
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
	public void orderComplete(Model model, 
							  Principal principal, 
							  OrderDto dto, 
							  RedirectAttributes rttr, 
							  HttpSession session) {
		
		List<CartDto> list = orderService.cartList(principal.getName());
		MemberDto member = orderService.getMemberById(principal.getName());
		
		model.addAttribute("cartList", list);
		
		int allTotal = 0;
		int bookCount = 0;
		for (CartDto cart : list) {
			allTotal += cart.getTotalPrice();
			bookCount += cart.getBookCount();
			orderService.addOrder(cart, principal.getName(), dto.getRecipient(), dto.getAddress());
		}
		orderService.deleteCartList(principal.getName());
		System.out.println(list);
	
		System.out.println(allTotal);
		System.out.println(dto.getBookCount());
		model.addAttribute("a", allTotal);
		model.addAttribute("b", bookCount);
		model.addAttribute("member", member);
		
		/*if(list.size() > 1) {
			String email = member.getEmail();
			System.out.println(member.getEmail());
			String subject = "?????? ??? ????????? ?????????????????????.";
				
			String content = "?????? ??? ????????? ?????????????????????." + "<br>" + "?????????  : " + list.get(0).getProductName() + " ???  " + (list.size()-1) + "???  <br>"
							 + "?????? : " + bookCount + "<br>??? ?????? : " + allTotal + "<br>?????? 352-1234-5678-90 ?????? ??? ?????? ?????? ??????????????????.";
			String from = "hjh564@naver.com";
			String to = email;
			
			try {
				MimeMessage mail = mailSender.createMimeMessage();
				MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");
				
				mailHelper.setFrom(from);
				mailHelper.setTo(to);
				mailHelper.setSubject(subject);
				mailHelper.setText(content, true);
				
				mailSender.send(mail);
			} catch(Exception e) {
				e.printStackTrace();
			}
			
		} else if(list.size() == 1){
			String email = member.getEmail();
			System.out.println(member.getEmail());
			String subject = "?????? ??? ????????? ?????????????????????.";
				
			String content = "?????? ??? ????????? ?????????????????????. <br>" + "?????????  : " + list.get(0).getProductName() + " ???  " + (list.size()-1) + "???  <br>"
					 + "?????? : " + bookCount + "<br>??? ?????? : " + allTotal + "<br>?????? 352-1234-5678-90 ?????? ??? ?????? ?????? ??????????????????.";
			String from = "hjh564@naver.com";
			String to = email;
			
			try {
				MimeMessage mail = mailSender.createMimeMessage();
				MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");
				
				mailHelper.setFrom(from);
				mailHelper.setTo(to);
				mailHelper.setSubject(subject);
				mailHelper.setText(content, true);
				
				mailSender.send(mail);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}*/
		
		
		
	}
	
	@PostMapping ("complete")
	   public void addcart(Model model, OrderDto dto, Principal principal,RedirectAttributes rttr) {
		
		System.out.println(dto);
		List<CartDto> list = orderService.cartList(principal.getName());
		
		int allTotal = 0;
		for (CartDto cart : list) {
			allTotal += cart.getTotalPrice();
			
			
			orderService.addOrder(cart, principal.getName(), dto.getRecipient(), dto.getAddress());
			
		}
		
		
		
		orderService.deleteCartList(principal.getName()); //?????? ????????? ????????? ??? ??????
	
		rttr.addFlashAttribute("a", allTotal);
		rttr.addFlashAttribute("b", list.size());
		
		MemberDto member = orderService.getMemberById(principal.getName());
		model.addAttribute("member", member);
		
		
		
	}
	
	
	@PostMapping("directComplete")
	public String directComplete(Model model, String recipient, int totalOrderPrice, OrderDto dto, Principal principal, String address, int bookCount, RedirectAttributes rttr) {
	System.out.println(address);
	System.out.println(recipient);
	
	model.addAttribute("a", totalOrderPrice);
	model.addAttribute("b", bookCount);
	
	dto = orderService.getProduct(dto.getProductId());
	dto.setBookCount(bookCount);
	System.out.println(dto);
	System.out.println(principal.getName());
	System.out.println(dto.getRecipient());
	System.out.println(dto.getAddress());
	orderService.addDirectOrder(dto, principal.getName(), recipient, address);
	
	MemberDto member = orderService.getMemberById(principal.getName());
	model.addAttribute("member", member);
	// ????????? ?????? ?????? ????????? ????????? ????????? ????????? ????????? ?????? ?????? ??????
	
	/*String email = member.getEmail();
	System.out.println(member.getEmail());
	String subject = "?????? ??? ????????? ?????????????????????.";
		
	String content = "?????? ??? ????????? ?????????????????????." + "<br>" + "?????????  : " + dto.getProductName()+"<br>"
					 + "?????? : " + bookCount + "<br>??? ?????? : " + totalOrderPrice + "<br>?????? 352-1234-5678-90 ?????? ??? ?????? ?????? ??????????????????.";
	String from = "hjh564@naver.com";
	String to = email;
	
	try {
		MimeMessage mail = mailSender.createMimeMessage();
		MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");
		
		mailHelper.setFrom(from);
		mailHelper.setTo(to);
		mailHelper.setSubject(subject);
		mailHelper.setText(content, true);
		
		mailSender.send(mail);
	} catch(Exception e) {
		e.printStackTrace();
	}*/
		
	return "/order/complete";
	}


	//?????? ??????
	@GetMapping("direct")
	public void directOrder(Model model, ProductPageDto dto, Principal principal,
			int productId, int Purchase, int id) {
		
		//?????? get?????? ????????? ?????? ??????
		OrderDto order = orderService.getProduct(productId);
		order.setBookCount(Purchase);
		order.setTotalOrderPrice(order.getPrice() * Purchase);
		
		model.addAttribute("price", order.getTotalOrderPrice());
		model.addAttribute("order", order);
		
		//member ?????? ????????????
		MemberDto member = orderService.getMemberById(principal.getName());
		model.addAttribute("member", member); //jsp??? ?????????
		model.addAttribute("productId", productId);
		model.addAttribute("bookCount", Purchase);
	}	
	
	@PostMapping ("remove")
	public String removeOrder(Principal principal, int orderId) {
		
		orderService.removeOrder(orderId);
		
		return "redirect:/member/userorderlist?id=" + principal.getName();
	}
	
	@PostMapping ("adminRemove")
	public String removeAdminOrder(Principal principal, int orderId) {
		
		orderService.removeOrder(orderId);
		
		return "redirect:/member/adminorderlist";
	}
		
	
}
