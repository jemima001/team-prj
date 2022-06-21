package com.project.market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.market.domain.CartDto;
import com.project.market.domain.MemberDto;
import com.project.market.domain.OrderDto;
import com.project.market.mapper.OrderMapper;

@Service
public class OrderService {

	@Autowired
	private OrderMapper mapper;

	//주문 목록 넘겨주기
//	public boolean addOrder(OrderDto order, Principal principal) {
//		
//		int cnt1 = mapper.insertOrder(order);
//
//		return cnt1 == 1;
//	}
	
	//order의 데이터 member로 넘겨주기
//	public void orderData (OrderDto dto, Principal principal) {
//		String memberId = principal.getName();
//		int orderId = dto.getOrderId();
//		int bookCount = dto.getBookCount();
//		int allTotalPrice = dto.getTotalOrderPrice();
//	
//		mapper.orderData (memberId,orderId,bookCount,allTotalPrice);
//		
//	}
	
	
	
	
	



	public OrderDto getOrderById(String id) {
		return mapper.selectOrderById(id);
	}

	public List<CartDto> cartList(String id) {
		// TODO Auto-generated method stub
		return mapper.selectAllOrders(id);
	}



	public MemberDto getMemberById(String id) {
		// TODO Auto-generated method stub
		return mapper.selectMemberById(id);
	}

	public void addOrder(CartDto cart, String memberId, String recipient, String address) {
		// TODO Auto-generated method stub
		mapper.addOrderList(cart, memberId, recipient, address);
	}


	public void deleteCartList(String memberId) {
	
			mapper.deleteCartList(memberId); 
		
		
	}
	


	
	
	

	//@Transactional 
	//? 이 부분 수정
	
//	public boolean removeOrder(OrderDto dto) {
//		OrderDto order = mapper.selectOrderById(dto.getId());
//
//		String cnt3 = mapper.deleteOrderById(dto.getId());
//		
//		return cnt3 == 1;

	}

