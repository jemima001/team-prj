package com.project.market.domain;

import java.time.LocalDateTime;
import java.util.List;

import lombok.Data;

@Data
public class OrderDto {
	
	//private String orderId; //주문번호
	
	private String memberId; // 주문 회원 아이디
	
	private String address;	//받는 사람 주소
	
	//private String orderState; // 주문 상태
			
	//private int price; // 상품 1개 가격
	
	private int productCount; //주문 수량
	
	private List<MemberDto> orders; // 주문 수량(dto 어디서 받아올지 따라 수정할수도 있음)/ 장바구니
	
	private int totalOrderPrice; //총 가격(상품 가격 * 주문 수량)
	
	private LocalDateTime inserted;
}
