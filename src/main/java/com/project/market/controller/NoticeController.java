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

import com.project.market.domain.NoticeDto;
import com.project.market.domain.PageInfoDto;
import com.project.market.service.NoticeService;


@Controller
@RequestMapping("notice")
public class NoticeController {

	@Autowired
	private NoticeService service;
	
	@RequestMapping("list")
	public void NoticeList(@RequestParam(name="page", defaultValue = "1")int page, 
			  Model model) {
		int rowPerPage = 10;
		List<NoticeDto> list = service.getNoticeList(page, rowPerPage);
		int totalRecords = service.countCustomers();
		
		int end = (totalRecords -1) / rowPerPage + 1;
		
		PageInfoDto pageInfo = new PageInfoDto();
		pageInfo.setCurrent(page);
		pageInfo.setEnd(end);
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("noticeList", list);
	}
	
	@GetMapping("write")
	public void writeBoard() {
		
	}
	
	@PostMapping("write")
	public String wirteBoardProcess(NoticeDto notice,
									Principal principal,
									RedirectAttributes rttr) {
		
		notice.setMemberId(principal.getName());
		boolean success = service.addNotice(notice);
		
		if (success) {
			rttr.addFlashAttribute("message", "게시물이 추가 되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "게시물 추가 중 문제가 발생하였습니다.");
		}
		
		return "redirect:/notice/list";
	}

}
