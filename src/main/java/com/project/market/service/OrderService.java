package com.project.market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.market.domain.MemberDto;
import com.project.market.domain.OrderDto;
import com.project.market.mapper.OrderMapper;

@Service
public class OrderService {

	@Autowired
	private OrderMapper mapper;

	// admin이 볼 수 있는 주문 페이지
	public boolean addOrder(OrderDto order) {

		// insert order
		int cnt1 = mapper.insertOrder(order);

		return cnt1 == 1;
	}

	public List<OrderDto> listOrder() {
		return mapper.selectAllOrder();
	}

	public OrderDto getOrderById(String id) {
		return mapper.selectOrderById(id);
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

