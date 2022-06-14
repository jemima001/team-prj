package com.project.market.domain;

import lombok.Data;

@Data
public class CartDto {
	private int cartId;
	private String productName;
	private String memberId;
	private int price;
	private int bookCount; //구매 수량
	
}
