package com.project.market.controller;

import java.security.Principal;
import java.util.List;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.market.domain.AddressDto;
import com.project.market.domain.MemberDto;
import com.project.market.domain.OrderDto;
import com.project.market.domain.PaginationDto;
import com.project.market.domain.ProductDto;
import com.project.market.service.MemberService;

@Controller
@RequestMapping("member")
public class MemberController {
	@Autowired
	private MemberService service;

	@Autowired
	private JavaMailSender mailSender;
	
	@GetMapping("login")
	public void loginPage() {

	}

	@GetMapping("signup")
	public void signupForm() {

	}

	@PostMapping("signup")
	public String signupProcess(MemberDto member, RedirectAttributes rttr) {
		boolean success = service.addMember(member);

		if (success) {
			rttr.addFlashAttribute("message", "회원가입이 완료되었습니다.");
			return "redirect:/project/home";
		} else {
			rttr.addFlashAttribute("message", "회원가입이 실패하였습니다.");
			rttr.addFlashAttribute("member", member);

			return "redirect:/member/signup";
		}
	}

	@GetMapping(path = "check", params = "id")
	@ResponseBody
	public String idCheck(String id) {

		boolean exist = service.hasMemberId(id);

		if (exist) {
			return "notOk";
		} else {
			return "ok";
		}
	}

	@GetMapping(path = "check", params = "email")
	@ResponseBody
	public String emailCheck(String email) {

		boolean exist = service.hasMemberEmail(email);

		if (exist) {
			return "notOk";
		} else {
			return "ok";
		}
	}

	@GetMapping(path = "check", params = "nickName")
	@ResponseBody
	public String nickNameCheck(String nickName) {

		boolean exist = service.hasMemberNickName(nickName);

		if (exist) {
			return "notOk";
		} else {
			return "ok";
		}
	}

	@GetMapping("mypage")
	public String getMember(String id,
			Principal principal,
			HttpServletRequest request,
			Model model) {

		if (hasAuthOrAdmin(id, principal, request)) {
			MemberDto member = service.getMemberById(id);
			model.addAttribute("member", member);

			return null;
		}

		return "redirect:/member/login";
	}

	private boolean hasAuthOrAdmin(String id, Principal principal, HttpServletRequest req) {
		return req.isUserInRole("ROLE_ADMIN") ||
				(principal != null && principal.getName().equals(id));
	}

	@GetMapping("setaddress")
	public String getMember2(String id,
			Principal principal,
			HttpServletRequest request,
			Model model) {

		if (hasAuthOrAdmin(id, principal, request)) {
			MemberDto member = service.getMemberById(id);
			model.addAttribute("member", member);

			List<AddressDto> list = service.listAddress(id);
			model.addAttribute("addressList", list);

			return null;
		}

		return "redirect:/member/setaddress?id="+principal.getName();
	}

	@PostMapping("remove")
	public String removeMember(MemberDto dto,
			Principal principal,
			HttpServletRequest req,
			RedirectAttributes rttr) {

		if (hasAuthOrAdmin(dto.getId(), principal, req)) {
			boolean success = service.removeMember(dto);

			if (success) {
				rttr.addFlashAttribute("message", "회원 탈퇴 되었습니다.");
				return "redirect:/project/home";
			} else {
				rttr.addAttribute("id", dto.getId());
				return "redirect:/member/mypage";
			}
		} else {
			return "redirect:/member/mypage";
		}
	}

	@PostMapping("modify")
	public String modifyMember(MemberDto dto,
			String oldPassword,
			Principal principal,
			HttpServletRequest req,
			RedirectAttributes rttr) {

		if (hasAuthOrAdmin(dto.getId(), principal, req)) {
			boolean success = service.modifyMember(dto, oldPassword);

			if (success) {
				rttr.addFlashAttribute("message", "회원 정보가 수정되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "회원 정보가 수정되지 않았습니다.");
			}

			rttr.addFlashAttribute("member", dto); // model object
			rttr.addAttribute("id", dto.getId()); // query string
			return "redirect:/member/mypage";
		} else {
			return "redirect:/member/login";
		}

	}

	@PostMapping("setaddress")
	public String modifyAddress(MemberDto dto,
			String address,
			Principal principal,
			HttpServletRequest req,
			RedirectAttributes rttr) {
		boolean exist = service.hasAddress(principal.getName(),address);
		if(exist) {
			rttr.addFlashAttribute("message", "이미 존재하는 배송지 입니다.");
			return "redirect:/member/setaddress?id="+principal.getName();
			
		} else {
			service.setAddress(dto);
		}

		/*if (success) {
			rttr.addFlashAttribute("message", "기본배송지 설정이 완료되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "기본배송지 설정이 완료되지 않았습니다.");
		}*/

		rttr.addFlashAttribute("member", dto); // model object
		rttr.addAttribute("id", dto.getId()); // query string
		return "redirect:/member/setaddress?id="+principal.getName();

	}

	@GetMapping("initpw")
	public void initpwPage() {

	}

	@PostMapping("initpw")
	public String initpwProcess(String id) {
		service.initPassword(id);

		return "redirect:/project/home";
	}

	@GetMapping("adminpage")
	// jsp (id, password, email, nickName, inserted) table로 보여주세요.
	// ORDER BY inserted DESC
	public void list(Model model) {
		List<MemberDto> list = service.listMember();
		model.addAttribute("memberList", list);
	}

	@GetMapping("productlist")
	public void getlist(Model model) {

		List<ProductDto> list = service.Productlist();
		model.addAttribute("productlist", list);

	}

	@PostMapping("productRemove")
	public String removeProduct(ProductDto dto) {

		return "redirect:/member/productlist";
	}

	@PostMapping("productModify")
	public String modifyProduct(ProductDto dto) {

		return "redirect:/member/productlist";
	}

	@GetMapping("adminorderlist")
	public void getOrderlist(
			Model model,
			@RequestParam(name = "page", defaultValue ="1") int page,
			RedirectAttributes rttr
			) {

		List<OrderDto> allList = service.listAllOrder();
		
		PaginationDto paginationDto = new PaginationDto();
		paginationDto.setPage(page);
		paginationDto.setAllPageNum(((allList.size()-1)/10) + 1);
		paginationDto.setEndPage((allList.size()-1)/10 + 1);
		int limitNumber = (page-1) * 10;
		paginationDto.setNowpage(page);
		
		List<OrderDto> list = service.listPageOrder(limitNumber);
		
		PaginationDto outPaginationDto = paginationDto;
		
		model.addAttribute("orderList", list);
		model.addAttribute("paginationDto", outPaginationDto);
		
	}

	@GetMapping("userorderlist")
	public void getUserOrderlist(Model model, @RequestParam(name = "page", defaultValue ="1") int page, String id, Principal principal) {
		
		List<OrderDto> allList = service.listUserOrder(id);
		
		PaginationDto paginationDto = new PaginationDto();
		paginationDto.setPage(page);
		paginationDto.setAllPageNum(((allList.size()-1)/10) + 1);
		paginationDto.setEndPage((allList.size()-1)/10 + 1);
		int limitNumber = (page-1) * 10;
		paginationDto.setNowpage(page);
		
		List<OrderDto> list = service.listUserPageOrder(id,limitNumber);
		
		PaginationDto outPaginationDto = paginationDto;
		
		model.addAttribute("orderList", list);
		model.addAttribute("paginationDto", outPaginationDto);
		model.addAttribute("id", principal.getName());

	}

	@PostMapping("addressRemove")
	public String removeAddress(String address, Principal principal) {

		service.removeAddress(address);
		
		return "redirect:/member/setaddress?id="+principal.getName();
	}
	
	@PostMapping("setOneAddress")
	public String setOneAddress(String id,
			String address,
			Principal principal,
			HttpServletRequest req,
			RedirectAttributes rttr) {

//		System.out.println(principal.getName());
//		System.out.println(address);
		service.updateOneAddress(principal.getName(), address);
		
		return "redirect:/member/setaddress?id="+principal.getName();
	}
	
	@GetMapping("findId")
	public void findId() {
		
	}
	
	@PostMapping("findId")
	public String searchId(String email,
			MemberDto dto,
			RedirectAttributes rttr, 
			Principal principal,
			HttpServletRequest req) {
		
//		System.out.println(email);
//		System.out.println(dto.getId());
		
		boolean exist = service.hasMemberEmail(email);
		
		if(exist) {
			dto = service.searchId(email);
			rttr.addFlashAttribute("message", "아이디는 " + dto.getId() + " 입니다.");
			return "redirect:/member/findId";
		} else {
			rttr.addFlashAttribute("message", "존재하지 않습니다.");
		}
		return "redirect:/member/findId";
	}
	
	@GetMapping("findPassword")
	public void findPassword() {
		
	}
	
	@PostMapping("findPassword")
	public String searchPassword(
			MemberDto dto,
			RedirectAttributes rttr, 
			Principal principal,
			HttpServletRequest req) {
		
//		System.out.println(id);
		System.out.println(dto.getEmail());
		System.out.println(dto.getId());
		String prvemail = dto.getEmail();
//		System.out.println(prvemail);
		if(service.hasMemberId(dto.getId())) {
			MemberDto member = service.getMemberById(dto.getId());
			if(service.hasMemberId(member.getId()) && service.hasMemberEmail(member.getEmail()) && prvemail.equals(member.getEmail())) {
				
				service.initPassword(dto.getId());
				rttr.addFlashAttribute("message", "비밀번호가 아이디로 초기화 되었습니다.");
			} else if(service.hasMemberId(member.getId()) && !(prvemail.equals(member.getEmail()))) {
				rttr.addFlashAttribute("message", "email이 맞지 않습니다.");
			}
		} else {
			rttr.addFlashAttribute("message", "존재하지 않는 아이디입니다.");
		}
		
		return "redirect:/member/findPassword";
	}
	
	@PostMapping("orderApprove")
	public String approveOrder(RedirectAttributes rttr, int orderId, int bookCount, String productName) {
		System.out.println(bookCount);
		System.out.println(productName);
		
		int Stock = service.getStock(productName);
		System.out.println(Stock);
		if((Stock - bookCount)<0) {
			rttr.addFlashAttribute("message", "재고가 부족합니다.");
			return "redirect:/member/adminorderlist";
		} else {
			service.approveOrder(orderId);
			service.countStock(bookCount, productName);
		}
		
		
		
		return "redirect:/member/adminorderlist";
	}
	
	@GetMapping("checkEmailById")
	@ResponseBody
	public String emailCheckById(String id, String email) {
//		System.out.println(id);
//		System.out.println(email);
		
		boolean exist = service.hasMemberEmailById(id,email);

		if (exist) {
			return "ok";
		} else {
			return "notOk";
		}
	}
	
	
	
	@GetMapping("confirmEmail")
	@ResponseBody
	public String confirmEmail(HttpSession session, Model model, String email) {
		boolean exist = false;
		
		System.out.println(email);
		
		Random random = new Random();
		int pass = random.nextInt(999999)+100000;
		System.out.println(pass);
		
		String subject = "인증번호 전송";
		String content = "인증번호 : " + pass;
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
			exist = true;
		} catch(Exception e) {
			e.printStackTrace();
		}
		session.setAttribute("pass", pass);
		if (exist) {
			return "ok";
		} else {
			return "notOk";
		}
	}
	
	@GetMapping("confirmNumber")
	@ResponseBody
	public String confirmNumber(HttpSession session, Model model, int number) {
		boolean exist = false;
		System.out.println(number);
		int pass = (Integer)session.getAttribute("pass");
		System.out.println(pass);
		
		if(number == pass) {
			exist = true;
		}
		
		if (exist) {
			return "ok";
		} else {
			return "notOk";
		}
	}
}