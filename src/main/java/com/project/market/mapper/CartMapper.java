package com.project.market.mapper;

import java.util.List;

import com.project.market.domain.CartDto;


public interface CartMapper {


	List<CartDto> selectAllCart(String id); //카트 목록

	int deleteCheckedCart(int cartId); // 체크된 상품 삭제

	void getCart(String memberId);

	 //product에서 상품 가져오기
	

}

