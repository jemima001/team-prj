package com.project.market.domain;

import java.util.List;

import lombok.Data;

@Data
public class CartDto {
	private int cartId; //카트 속 상품 하나하나의 id
	private String productName;
	private String memberId;
	private int totalPrice;
	private int bookCount; //구매 수량
	private List<Integer> CartIds; //체크된 상품(삭제)
	
	
}
