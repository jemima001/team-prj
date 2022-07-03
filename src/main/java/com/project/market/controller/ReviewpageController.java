package com.project.market.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.market.domain.ReviewpageDto;
import com.project.market.service.ProductPageService;
import com.project.market.service.ReviewpageService;

@Controller
@RequestMapping("review")
public class ReviewpageController {
	
	@Autowired
	ProductPageService ProductPageService;
	
	@Autowired
	ReviewpageService  service;
	
	@GetMapping("add")
	public void addpage(int prodctPageid, Model model, Principal principal) {
		System.out.println( prodctPageid);
		model.addAttribute("prodctpageid", prodctPageid);
	}
	
	@PostMapping("add")
	public String addreviewpage(ReviewpageDto dto,
								MultipartFile[] file,
								RedirectAttributes rttr,
								Principal principal
								) { 
	//System.out.println("리뷰 컨트롤러 dto :"+dto);
	//System.out.println("리뷰 컨트롤러 file :"+file);
	if (file != null) {
		List<String> fileList = new ArrayList<String>();
		for (MultipartFile f : file) {
			fileList.add(f.getOriginalFilename());
		}
		dto.setFileList(fileList);
	}
	
	dto.setMemberId(principal.getName());
	boolean ok = service.addReviewPage(dto, file);
	
	
	System.out.println("리뷰페이지 추가  :"+ dto);
	
	return "redirect:/product/get?id="+dto.getProductPage();
}

	
	@GetMapping("modif")
	public void reviewmodif(int id , int boardId, Model model) {
		List<String> fileList = service.getreviewFile(id);
		ReviewpageDto dto = service.getReview(id);
		//dto.setProductPage(boardId);
		if(fileList.isEmpty() == false) {
			System.out.println("test");
		dto.setFileList(fileList);
		}
		System.out.println("dto:"+dto);
		System.out.println("fileList:"+fileList);
		model.addAttribute("review", dto);
		
		
	}
	
	@PostMapping("modif")
	public String reviewupdata(ReviewpageDto dto,
							@RequestParam(name = "deleteimg", required = false) ArrayList<String>  deleteimg, 
			 				 MultipartFile[] file) {
		System.out.println("리뷰에서 삭제할 이미지 :"+deleteimg);
		System.out.println("수정 컨트롤 dto :"+dto);
		if(deleteimg != null) {
			
		  service.deleteImg(dto.getId(),deleteimg);
		}
		if(file!=null) {
			
		  service.upImg(dto, file);
		}
		  service.updatareview(dto);
		  
		  return "redirect:/product/get?id="+dto.getProductPage();
		  
	}
}
