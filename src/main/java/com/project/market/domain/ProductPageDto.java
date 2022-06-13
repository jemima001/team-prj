package com.project.market.domain;

import java.time.LocalDateTime;
import java.util.List;

import lombok.Data;

@Data
public class ProductPageDto {

	private int id;
	private String boardTitle;
	private String boardBody;
	private int productId;
	private String Bestproduct;
	private LocalDateTime inserttime;
	private int price;
	private int Purchase;
	private List<String> fileList; 
}
