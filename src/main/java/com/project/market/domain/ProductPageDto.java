package com.project.market.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ProductPageDto {

	private String id;
	private String boardTitle;
	private String boardBody;
	private String productId;
	private String Bestproduct;
	private LocalDateTime inserttime;
	private int price;
}
