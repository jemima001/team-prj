package com.project.market.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.market.domain.ProductDto;
import com.project.market.domain.ProductPageDto;

public interface ProductPageMapper {

	int AddPage(@Param("boardTitle") String boardTitle, 
				@Param("boardBody") String boardBody, 
				@Param("productId") int productId);

	int Addproduct(ProductDto dto);

	List<ProductDto> getcategory();

	List<ProductDto> getcategory_low(ProductDto dto);

	void Addcategory(@Param("newProductCode0")int newProductCode0, 
					 @Param("newProductCode1")int newProductCode1 , 
					 @Param("productId") int productId);

	int getproductId(ProductDto dto);

	ProductPageDto getproductBoard(int boardid);

	ProductDto getproduct(String productId);

	List<ProductPageDto> getBoardlist();

	int deleteBoard(ProductPageDto dto);

;

	

}