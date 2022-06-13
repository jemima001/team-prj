package com.project.market.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.market.domain.ProductDto;
import com.project.market.domain.ProductPageDto;
import com.project.market.service.ProductPageService;

@Controller
@RequestMapping("product")
public class ProductPageController {
	
	@Autowired
	ProductPageService service;
	
	
	@GetMapping("add")
	public void addproduct(Model model) {
		List<ProductDto> list = service.getcategory();
		// ajx로 나중에 처리 시도 해야
		/*List<ProductDto> list_low = service.getcategory_low();*/
		model.addAttribute("m_category", list);
		System.out.println("처음 중분류 카테고리 리스트:"+list);
		
	}
	// !!!!! 상품 등록시 service.addProduct(productdto); 로 반드시 상품 부터 등록해야 함!!!!!
	@PostMapping("add")
	public String addproduct_in(ProductPageDto dto, 
								ProductDto productdto, 
								MultipartFile[] file) {
		int productId = service.addProduct(productdto);
		System.out.println("제품 판매글 로 받은 데이터");
		System.out.println("판매글 제목 :"+dto.getBoardTitle());
		System.out.println("판매글 내용 :"+dto.getBoardBody());
		System.out.println("판매글 로 제품 id 학인 :" +productId);
		System.out.println(dto);
		// 사진 추가 코드 입력
		if (file != null) {
			List<String> fileList = new ArrayList<String>();
			for (MultipartFile f : file) {
				fileList.add(f.getOriginalFilename());
			}
			dto.setFileList(fileList);
		}
		
		
		//
		service.AddProductPage(dto, productId, file);
		return "redirect:/product/list";
		
	}
	
	@PostMapping("product_add")
	public void productadd(ProductDto dto) {
		
		System.out.println("제품 등록으로 받은 데이터");
		System.out.println("productname:"+dto.getProductname());
		System.out.println("Stock:"+dto.getStock());
		System.out.println("proce:"+dto.getPrice());
		System.out.println("M-class:"+dto.getProduct_middle_class());
		System.out.println("low-class:"+dto.getProduct_low_class());
		 service.addProduct(dto);
		
	}
	@GetMapping("get_low_class")
	@ResponseBody
	public List<ProductDto> retrun_low_class(ProductDto dto){
		
		List<ProductDto> list = service.getcategory_low(dto);
		System.out.println("low_list ajax통신 소분류 카테고리 :"+list);
		return list;
	}
	
	@GetMapping("get")
	public void getProductPage(int id, Model model) {
		ProductPageDto Board = service.getProductBoard(id);
		ProductDto product = service.getproduct(Board.getProductId());
		List<String> fileList = service.getfileList(id);
		Board.setFileList(fileList);
		
		System.out.println("fileList:" +fileList);
		
		model.addAttribute("productboard", Board);
		model.addAttribute("product", product);
	}
	
	@GetMapping("list")
	public void getlist(Model model) {
		
	 List<ProductPageDto> list = service.getboardlist();
	 System.out.println(list);
	 model.addAttribute("boardlist", list);
		
	}
	
	@PostMapping("deleteBoard")
	public String deleteBoard(ProductPageDto dto) {
		//System.out.println(dto.getId());
		 boolean ok = service.deleteBoard(dto);
		System.out.println(ok);
		// if 사용해서 메시지 출력 해야함
		 return "redirect:/product/list";
		
	}

	@GetMapping("modif")
	public void modifboard(int id, Model model) {
		ProductPageDto productborad = service.getProductBoard(id);
		int productId = productborad.getProductId();
		ProductDto product = service.getproduct(productId);
		List<String> fileList = service.getfileList(id);
		productborad.setFileList(fileList);
		model.addAttribute("productpage", productborad);
		// rttr.addFlashAttribute("product", product);
	}
}
