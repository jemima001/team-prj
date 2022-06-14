package com.project.market.domain;

import lombok.Data;

@Data
public class ProductDto {

	private String productName; // Productname 변경하자!!! 우선 name를 Productname로 변경함
	private int Stock;
	private int price;
	private int Product_Middle_Class;
	private String middle_Name;
	private int Product_Low_Class;
	private String low_Name;
	private int ProductId;
	
}
