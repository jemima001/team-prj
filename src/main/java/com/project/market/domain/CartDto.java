package com.project.market.domain;

import java.util.List;

import lombok.Data;

@Data
public class CartDto {
	private int cartId;
	private String productName;
	private String memberId;
	private int totalPrice;
	private int bookCount; //구매 수량
	private List<Integer> CartIds;
	
}
