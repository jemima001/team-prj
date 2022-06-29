package com.project.market.mapper;

import java.security.Principal;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.method.P;

import com.project.market.domain.BuycheckDto;
import com.project.market.domain.PaginationDto;
import com.project.market.domain.ProductDto;
import com.project.market.domain.ProductPageDto;
import com.project.market.domain.ReviewpageDto;

public interface ProductPageMapper {

	/*int AddPage(@Param("boardTitle") String boardTitle, 
				@Param("boardBody") String boardBody, 
				@Param("productId") int productId);*/
	
	int AddPage(ProductPageDto dto);
	int Addproduct(ProductDto dto);

	List<ProductDto> getcategory();

	List<ProductDto> getcategory_low(ProductDto dto);

	void Addcategory(@Param("newProductCode0")int newProductCode0, 
					 @Param("newProductCode1")int newProductCode1 , 
					 @Param("productId") int productId);

	int getproductId(ProductDto dto);

	ProductPageDto getproductBoard(int boardid);

	ProductDto getproduct(int productId);

	List<ProductPageDto> getBoardlist(@Param("cat") String cat,@Param("search") String search,@Param("pageToStart") int pageToStart,@Param("onePageAllBoardNum") int onePageAllBoardNum);

	int deleteBoard(ProductPageDto dto);

	void insertFile(@Param("boardId")int string, @Param("fileName")String fileName,@Param("mod") String mod);
	
	List<String> getfileList(int id);
	
	int updateProduct(ProductDto dto);
	int updataPage(ProductPageDto pageDto);

	void deleteImg(@Param("id")int id,@Param("fileName") String fileName);
	
	List<ProductDto> getprodutlist();
	int deleteCategory(ProductDto dto);
	int DeleteProduct(ProductDto dto);
	int modifyProduct(ProductDto dto);
	List<String> getFileForList();
	void addCart(ProductDto dto, Principal principal);
	void addCart(@Param("memberId")String memberId,@Param("bookCount") int bookCount,@Param("productId") int productId);
	PaginationDto getAllBoardNum(String cat);
	void insertReviewFile(int string, String originalFilename);
	int getcat0(ProductDto dto);
	String getCategoryName(int category);
	int deleteCart(ProductDto dto);
	int deleteBoardfordeleteProduct(ProductDto dto);
	int searchProductName(String name);
	int AddreviewPage(ReviewpageDto dto);
	List<ReviewpageDto> getReviewList(int id);
	List<String> getBoardFile(ProductPageDto dto);
	List<String> replyViewFileList(int id);
	
	int deleteReview(int id);
//	List<ReviewpageDto> getreviewfile(int id);
	BuycheckDto whoBuyThis(@Param("id")int id,@Param("name") String name);

	

}
