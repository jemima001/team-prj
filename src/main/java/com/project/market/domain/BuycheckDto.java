package com.project.market.domain;

import lombok.Data;

@Data
public class BuycheckDto {
  
	private int orderId;
	private String memberId;
	private int ProductId;
	private int orderState;
	private int ProductPageid;
	private int  reviewPageId;
}
