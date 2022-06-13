package com.project.market.mapper;

import java.util.List;

import com.project.market.domain.OrderDto;

public interface OrderMapper {

	int insertOrder(OrderDto order);

	List<OrderDto> selectAllOrder();

	OrderDto selectOrderById(String id);

	String deleteOrderById(String id);

}
