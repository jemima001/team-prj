package com.project.market.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.market.domain.AnswerDto;
import com.project.market.service.AnswerService;


@Controller
@RequestMapping("qna")
public class AnswerController {

	@Autowired
	private AnswerService service;
	
	@PostMapping("answer")
	public String insert(AnswerDto answer,
			MultipartFile[] file,
			Principal principal,
			RedirectAttributes rttr) {
		if (file != null) {
			List<String> fileList = new ArrayList<String>();
			for (MultipartFile f : file) {
				fileList.add(f.getOriginalFilename());
			}
			answer.setFileName(fileList);
		}
		
		answer.setMemberId(principal.getName());
		boolean success = service.insertQuery(answer, file);
		
		if (success) {
			rttr.addFlashAttribute("message2", "새 답변이 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message2", "새 답변이 등록되지 않았습니다.");
		}
		
		rttr.addAttribute("id", answer.getQueryId());
		return "redirect:/qna/get";
	}
	
	@PostMapping("admodify")
	public String modify(AnswerDto dto,
						 @RequestParam(name = "removeFileList2", required = false) ArrayList<String> removeFileList,
						 MultipartFile[] addFileList,
						 Principal principal,
						 RedirectAttributes rttr) {
		AnswerDto oldAnswer = service.getAnswerById(dto.getId());
		if (oldAnswer.getMemberId().equals(principal.getName())) {
			boolean success = service.updateAnswer(dto, removeFileList, addFileList);
			
			if (success) {
				rttr.addFlashAttribute("message2", "답변이 수정되었습니다.");
			} else {
				rttr.addFlashAttribute("message2", "답변이 수정되지 않았습니다.");
			}
			
		} else {
			rttr.addFlashAttribute("message2", "권한이 없습니다.");
		}
		
		rttr.addAttribute("id", dto.getQueryId());
		return "redirect:/qna/get";
	}
	
	@PostMapping("adremove")
	public String remove(AnswerDto dto,
						 Principal principal,
						 RedirectAttributes rttr) {
		AnswerDto oldAnswer = service.getAnswerById(dto.getId());
		if (oldAnswer.getMemberId().equals(principal.getName())) {
			boolean success = service.deleteAnswer(dto.getQueryId());
			
			if (success) {
				rttr.addFlashAttribute("message2", "답변이 삭제 되었습니다.");
			} else {
				rttr.addFlashAttribute("message2", "답변이 삭제 되지않았습니다.");
			}
		} else {
			rttr.addFlashAttribute("message2", "권한이 없습니다.");
			rttr.addAttribute("id", oldAnswer.getQueryId());
			return "redirect:/qna/get";
		}
		
		rttr.addAttribute("id", dto.getQueryId());
		return "redirect:/qna/get";
	}
}
