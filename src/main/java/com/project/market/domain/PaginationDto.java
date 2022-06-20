package com.project.market.domain;

import lombok.Data;

@Data
public class PaginationDto {

	
	private int page;  // 받은 페이지 번호
	private int allPageNum; // 전체 페이지 수
	private int startPage;  // 페이지 네이게이터 시작 번호
	private int endPage;	// 페이지 네비게이터 끝번호
	private int onePageAllBoardNum;
	private int pageToStart; // 페이지 불러오는 시작 게시글
	private int allBoard;
	private String cat;
	private String search;
	private int nowpage;
}