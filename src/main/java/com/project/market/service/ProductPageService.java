package com.project.market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.market.domain.ProductDto;
import com.project.market.domain.ProductPageDto;
import com.project.market.mapper.ProductPageMapper;

@Service
public class ProductPageService {
	
	@Autowired
	ProductPageMapper mapper;

	public void AddProductPage(ProductPageDto dto , int productId) {
		String BoardTitle = dto.getBoardTitle();
		String BoardBody = dto.getBoardBody();
		
		int ok = mapper.AddPage(BoardTitle, BoardBody, productId);
	}
	@Transactional
	public int addProduct(ProductDto dto) {
		ProductDto NewProductDto = new ProductDto();
		int ok = mapper.Addproduct(dto);
		int productId =  mapper.getproductId(dto);
		NewProductDto.setProductId(productId);
		int NewProductCode0 = dto.getProduct_middle_class();
		int	NewProductCode1 = dto.getProduct_low_class();
		
		mapper.Addcategory(NewProductCode0, NewProductCode1 , productId);
		return mapper.getproductId(NewProductDto);
	}

	public List<ProductDto> getcategory() {
		// TODO Auto-generated method stub
		return mapper.getcategory();
	}

	public List<ProductDto> getcategory_low(ProductDto dto) {
		// TODO Auto-generated method stub
		return mapper.getcategory_low(dto);
	}
	public ProductPageDto getProductBoard(int boardid) {
		// TODO Auto-generated method stub
		return mapper.getproductBoard(boardid);
	}
	public ProductDto getproduct(String productId) {
		// TODO Auto-generated method stub
		return mapper.getproduct(productId);
	}
	public List<ProductPageDto> getboardlist() {
		// TODO Auto-generated method stub
		return mapper.getBoardlist();
	}
	public boolean deleteBoard(ProductPageDto dto) {
		int ok = mapper.deleteBoard(dto);
		
		return ok ==1;
	}
	

	

}
