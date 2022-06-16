package com.project.market.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.market.domain.PageInfoDto;
import com.project.market.domain.QueryDto;
import com.project.market.service.QueryService;


@Controller
@RequestMapping("qna")
public class QueryController {
	
	@Autowired
	private QueryService service;
	
	@GetMapping("query")
	public void insert() {
		
	}
	
	@PostMapping("query")
	public String insert(QueryDto query,
			MultipartFile[] file,
			Principal principal,
			RedirectAttributes rttr) {
		
//		System.out.println(file);
//		System.out.println(file.getOriginalFilename());
//		System.out.println(file.getSize());
		
//		if (file.getSize() > 0) {
//			board.setFileName(file.getOriginalFilename());
//		}
		
		if (file != null) {
			List<String> fileList = new ArrayList<String>();
			for (MultipartFile f : file) {
				fileList.add(f.getOriginalFilename());
			}
			query.setFileName(fileList);
		}
		
		query.setMemberId(principal.getName());
		boolean success = service.insertQuery(query, file);
		
		if (success) {
			rttr.addFlashAttribute("message", "새 글이 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새 글이 등록되지 않았습니다.");
		}
		
		return "redirect:/qna/list";
	}
	
	@RequestMapping("list")
	public void QueryList(@RequestParam(name="page", defaultValue = "1")int page, 
			  Model model) {
		int rowPerPage = 10;
		List<QueryDto> list = service.getQueryList(page, rowPerPage);
		int totalRecords = service.countCustomers();
		
		int end = (totalRecords -1) / rowPerPage + 1;
		
		PageInfoDto pageInfo = new PageInfoDto();
		pageInfo.setCurrent(page);
		pageInfo.setEnd(end);
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("queryList", list);
	}
	
	@GetMapping("get")
	public void get(int id, Model model) {
		QueryDto dto = service.getQueryById(id);
		model.addAttribute("query", dto);
	}
	
	@PostMapping("modify")
	public String modify(QueryDto dto,
			@RequestParam(name = "removeFileList", required = false) ArrayList<String> removeFileList,
			MultipartFile[] addFileList,
			Principal principal, 
			RedirectAttributes rttr) {
		QueryDto oldBoard = service.getQueryById(dto.getId());
		
		if (oldBoard.getMemberId().equals(principal.getName())) {
			boolean success = service.updateQuery(dto, removeFileList, addFileList);
			
			if (success) {
				rttr.addFlashAttribute("message", "글이 수정되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "글이 수정되지 않았습니다.");
			}
			
		} else {
			rttr.addFlashAttribute("message", "권한이 없습니다.");
		}
		
		rttr.addAttribute("id", dto.getId());
		return "redirect:/qna/get";
	}
	
	@PostMapping("remove")
	public String remove(QueryDto dto, 
						 Principal principal, 
						 RedirectAttributes rttr) {
		
		// 게시물 정보 얻고
		QueryDto oldBoard = service.getQueryById(dto.getId());
		// 게시물 작성자(memberId)와 principal의 name과 비교해서 같을 때만 진행.
		if (oldBoard.getMemberId().equals(principal.getName())) {
			boolean success = service.deleteQuery(dto.getId());
			
			if (success) {
				rttr.addFlashAttribute("message", "글이 삭제 되었습니다.");
				
			} else {
				rttr.addFlashAttribute("message", "글이 삭제 되지않았습니다.");
			}
			
		} else {
			rttr.addFlashAttribute("message", "권한이 없습니다.");
			rttr.addAttribute("id", dto.getId());
			return "redirect:/qna/get";
		}
		
		return "redirect:/qna/list";
	}
}
