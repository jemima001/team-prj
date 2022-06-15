package com.project.market.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.market.domain.MemberDto;
import com.project.market.domain.ProductDto;
import com.project.market.service.MemberService;

@Controller
@RequestMapping("member")
public class MemberController {
	@Autowired
	private MemberService service;
	
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
			
			return null;
		}
		
		return "redirect:/member/login";
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
			Principal principal,
			HttpServletRequest req,
			RedirectAttributes rttr) {
		
			boolean success = service.setAddress(dto);
			
			if (success) {
				rttr.addFlashAttribute("message", "기본배송지 설정이 완료되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "기본배송지 설정이 완료되지 않았습니다.");
			}
			
			rttr.addFlashAttribute("member", dto); // model object
			rttr.addAttribute("id", dto.getId()); // query string
			return "redirect:/member/mypage";
		
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
	
	@GetMapping("orderlist")
	public void getOrderlist(Model model) {
		
		List<MemberDto> list = service.listMember();
		model.addAttribute("memberList", list);
		
	}
	
}
