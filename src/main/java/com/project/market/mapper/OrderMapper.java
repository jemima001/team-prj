package com.project.market.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.market.domain.CartDto;
import com.project.market.domain.MemberDto;
import com.project.market.domain.OrderDto;


public interface OrderMapper {

	int insertOrder(OrderDto order);

	OrderDto selectOrderById(String id);

	String deleteOrderById(String id);

	List<CartDto> selectAllOrders(String id);
	
	MemberDto selectMemberById(String id);

	void addOrderList(@Param("cart")CartDto cart, @Param("memberId")String memberId, @Param("recipient")String recipient, @Param("address")String address);

	void deleteCartList(String memberId);

	OrderDto getProduct(int productId);

	void addDirectOrder(@Param("dto")OrderDto dto, @Param("memberId")String memberId, @Param("recipient")String recipient, @Param("address")String address);
	
	
	
}
