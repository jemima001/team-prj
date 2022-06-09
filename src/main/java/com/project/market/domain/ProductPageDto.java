package com.project.market.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ProductPageDto {

	private String BoardId;
	private String Writer;
	private String ProductCode;
	private String BoardTitle;
	private int Price;
	private String img;
	private String BoardBody;
	private LocalDateTime Date;
}
