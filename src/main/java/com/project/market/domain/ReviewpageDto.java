package com.project.market.domain;

import java.util.List;

import lombok.Data;

@Data
public class ReviewpageDto {
	private int Id;
	private int productPage;
	private String reviewTitle;
	private String reviewBody;
	private String revireFileName;
	private List<String> fileList;
	private String memberId;
	private int reviewId;
	private String fileName;
	private List<Integer> boardList;
	
}
