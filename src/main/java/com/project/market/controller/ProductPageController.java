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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.market.domain.PaginationDto;
import com.project.market.domain.ProductDto;
import com.project.market.domain.ProductPageDto;
import com.project.market.domain.ReviewpageDto;
import com.project.market.service.ProductPageService;

@Controller
@RequestMapping("product")
public class ProductPageController {
	
	@Autowired
	ProductPageService service;
	
	
	@GetMapping("add")
	public void addproduct(Model model ,ProductDto dto, 
				@RequestParam(name = "mod", defaultValue = "add" ) String addMod) {
		if(addMod.equals("addFormProductList")) {
			System.out.println("if문 안");
			System.out.println(addMod);
			int category =service.getcategoryone(dto);
			String categoryName = service.getCategoryName(category);
			System.out.println("카테고리 "+category);
			dto.setProduct_Middle_Class(category);
			dto.setMiddle_Name( categoryName);
			model.addAttribute("product", dto);
			model.addAttribute("addMod","addFormProductList" );
			
			List<ProductDto> list = service.getcategory();
			// ajx로 나중에 처리 시도 해야
			/*List<ProductDto> list_low = service.getcategory_low();*/
			model.addAttribute("m_category", list);
			
		} else {
			
			model.addAttribute("addMod","add" );
		List<ProductDto> list = service.getcategory();
		// ajx로 나중에 처리 시도 해야
		/*List<ProductDto> list_low = service.getcategory_low();*/
		model.addAttribute("m_category", list);
		System.out.println("처음 중분류 카테고리 리스트:"+list);
		}
		
	}
	// !!!!! 상품 등록시 service.addProduct(productdto); 로 반드시 상품 부터 등록해야 함!!!!!
	@PostMapping("add")
	public String addproduct_in(ProductPageDto dto, 
								ProductDto productdto, 
								MultipartFile[] file,
								RedirectAttributes rttr,
								String mod) {
		int productId;
		/*	System.out.println("중분류 확인 :"+productdto);*/
		System.out.println("add 컨트롤러");
		if(mod.equals("addnew")) {
			
			//System.out.println("add 컨트롤러  if addnew속");
		 productId = service.addProduct(productdto);
		} else {
			//System.out.println("add 컨트롤러 else 속");
		 productId = productdto.getProductId();
			//System.out.println("productId :"+productId);
			
		}
		/*System.out.println("제품 판매글 로 받은 데이터");
		System.out.println("판매글 제목 :"+dto.getBoardTitle());
		System.out.println("판매글 내용 :"+dto.getBoardBody());
		System.out.println("판매글 로 제품 id 학인 :" +productId);
		System.out.println(dto);*/
		// 사진 추가 코드 입력
		if (file != null) {
			List<String> fileList = new ArrayList<String>();
			for (MultipartFile f : file) {
				fileList.add(f.getOriginalFilename());
			}
			dto.setFileList(fileList);
		}
		
		
		//
		boolean ok = service.AddProductPage(dto, productId, file);
		
		if(ok) {
			rttr.addFlashAttribute("message", "상품이 게시되었습니다.");
		} else {
			rttr.addFlashAttribute("message_error", "상품이 게시에 실패하였습니다.");
		}
		return "redirect:/product/list";
		
	}
	
	@PostMapping("product_add")
	public void productadd(ProductDto dto) {
		
		/*System.out.println("제품 등록으로 받은 데이터");
		System.out.println("productname:"+dto.getProductName());
		System.out.println("Stock:"+dto.getStock());
		System.out.println("price:"+dto.getPrice());
		System.out.println("M-class:"+dto.getProduct_Middle_Class());
		System.out.println("low-class:"+dto.getProduct_Low_Class());*/
		 service.addProduct(dto);
		
	}
	@GetMapping("get_low_class")
	@ResponseBody
	public List<ProductDto> return_low_class(ProductDto dto){
		
		List<ProductDto> list = service.getcategory_low(dto);
		System.out.println("low_list ajax통신 소분류 카테고리 :"+list);
		return list;
	}
	
	@GetMapping("get")
	public void getProductPage(int id, Model model, Principal principal) {
		ProductPageDto Board = service.getProductBoard(id);
		ProductDto product = service.getproduct(Board.getProductId());
		List<String> fileList = service.getfileList(id);
		List<ReviewpageDto> reviewList = service.getReviewList(id);
		System.out.println("reviewList :"+reviewList);
		Board.setFileList(fileList);
		
		//System.out.println("fileList:" +fileList);
		model.addAttribute("reviewList",reviewList);
		model.addAttribute("productboard", Board);
		model.addAttribute("product", product);
	}
	
	@ResponseBody
	@PostMapping("cheekProductName")
	public boolean cheekProductName(String name) {
	 // System.out.println(name); 넘어 오는거 확인
		boolean ok = service.searchProductName(name);
		
		return !ok;
		
	}
	
	@GetMapping("list")
	public void getlist(Model model, 
						@RequestParam(name = "cat", defaultValue = "0" ) String cat, 
						@RequestParam(name ="search", defaultValue = "")String search,
						@RequestParam(name = "page", defaultValue ="1") int page
						) {
		PaginationDto paginationDto = new PaginationDto();
		int setOnePageAllBoardNum =15;
		paginationDto.setPage(page);
		paginationDto.setOnePageAllBoardNum(setOnePageAllBoardNum);
		//List<String> fileList = service.getFileForList();
		List<ProductDto> categoryList = service.getcategory();
		// ajx로 나중에 처리 시도 해야
		/*List<ProductDto> list_low = service.getcategory_low();*/
		model.addAttribute("m_category", categoryList);
		System.out.println("cat:"+cat);
		
	    List<ProductPageDto> list = service.getboardlist(cat, search, paginationDto);
	    System.out.println("상품 리스트:"+list);
	    model.addAttribute("boardlist", list);
	    
	    PaginationDto outPaginationDto = service.getCountBoard(cat,setOnePageAllBoardNum);
	    System.out.println("컨트롤러 페이지 네이게이터 Dto:"+ outPaginationDto);
	    outPaginationDto.setSearch(search);
	    outPaginationDto.setNowpage(page);
	    
		/* if(cat == null || cat.equals("0")) {
			
		}*/
	    model.addAttribute("paginationDto", outPaginationDto);
		
	}
	
	@PostMapping("deleteBoard")
	public String deleteBoard(ProductPageDto dto, 
							  RedirectAttributes rttr,
							  @RequestParam(name = "deleteImg", required = false) ArrayList<String> deleteImg) {
		//System.out.println(dto.getId());
		
		 boolean ok = service.deleteBoard(dto,deleteImg);
		System.out.println(ok);
		// if 사용해서 메시지 출력 해야함
		
			if(ok) {
				rttr.addFlashAttribute("message", "판매글이 삭제되었습니다.");
			} else {
				rttr.addFlashAttribute("message_error", "판매글 삭제에 실패하였습니다.");
			}
			 return "redirect:/product/list";
			
	}

	@GetMapping("modif")
	public void modifboard(int id, Model model) {
		ProductPageDto productborad = service.getProductBoard(id);
		productborad.setId(id);
		int productId = productborad.getProductId();
		ProductDto product = service.getproduct(productId);
		product.setProductId(productId);
		List<String> fileList = service.getfileList(id);
		List<ProductDto> list = service.getcategory();
		productborad.setFileList(fileList);
		model.addAttribute("productpage", productborad);
		model.addAttribute("m_category", list);
		model.addAttribute("product", product);
		System.out.println("수정 페이지 프로덕트 dto:"+product);
		System.out.println();
		// rttr.addFlashAttribute("product", product);
	}
	
	@PostMapping("modif")
	public String updateboard(ProductDto dto, 
							ProductPageDto pageDto, 
							MultipartFile[] file,
							@RequestParam(name = "deleteImg", required = false) ArrayList<String> deleteImg) {
		System.out.println("포스트 수정 컨트롤러 !!!!!!!!!!!!!!!!!!!!!!!!");
		System.out.println(dto);
		System.out.println(pageDto);
		System.out.println(deleteImg);
		// 사진 추가 코드 입력
				if (file != null) {
					List<String> fileList = new ArrayList<String>();
					for (MultipartFile f : file) {
						fileList.add(f.getOriginalFilename());
					}
					pageDto.setFileList(fileList);
				}
		
		boolean ok = service.upDateProduct(dto);
		boolean ok_page = service.upDatepage(pageDto , file, deleteImg);
		return "redirect:/product/get?id="+pageDto.getId();
		
	}
	
	@GetMapping("productlist")
	public void getlist(Model model) {
		
	 List<ProductDto> list = service.Productlist();
	 System.out.println("상품 리스트"+list);
	 model.addAttribute("productlist", list);
		
	}
	
	@PostMapping("productRemove")
	public String removeProduct(ProductDto dto) {
		
		System.out.println("상품 삭제 받는 dto:"+dto);
		boolean ok = service.deleteProduct(dto);
		System.out.println("ok:"+ok);
		return "redirect:/product/productlist";
	}
	
	@PostMapping("productModify")
	public String productModify(ProductDto dto) {
		boolean ok = service.modifyProduct(dto);
		System.out.println("상품 수정 받는 dto:"+dto);
		return "redirect:/product/productlist";
	}
	@PostMapping ("addcart")
   @ResponseBody
   public void addcart(ProductDto dto, Principal principal) {
	   System.out.println("장바구니 추가 ajax:"+dto.getPurchase());
	   System.out.println("장바구니 추가 ajax:"+dto.getProductId());
	   System.out.println("장바구니 추가 ajax:"+principal.getName());
	    service.addCart(dto,principal);
	   
   }
	
	@GetMapping("reviewpage")
		public void reviewpage() {
			
		}
	
	@PostMapping("reviewpage")
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
	@PostMapping("deleteReview") 
	public String deletReview(ReviewpageDto dto) {
		System.out.println("deleteReview dto :"+dto);
		boolean ok =service.deleteReview(dto);
		return "redirect:/product/get?id="+dto.getProductPage();
	}
}
