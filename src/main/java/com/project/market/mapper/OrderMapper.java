package com.project.market.mapper;

import java.util.List;

import com.project.market.domain.CartDto;
import com.project.market.domain.MemberDto;
import com.project.market.domain.OrderDto;


public interface OrderMapper {

	int insertOrder(OrderDto order);

	OrderDto selectOrderById(String id);

	String deleteOrderById(String id);

	List<CartDto> selectAllOrders(String id);
	
	MemberDto selectMemberById(String id);

	void orderData (String memberId, int orderId, int bookCount, int allTotalPrice);

}
