package com.project.market.domain;

import lombok.Data;

@Data
public class ProductDto {

	private String productname; // Productname 변경하자!!! 우선 name를 Productname로 변경함
	private int Stock;
	private int price;
	private int Product_middle_class;
	private String middle_name;
	private int Product_low_class;
	private String low_name;
	private int productId;
	
}
