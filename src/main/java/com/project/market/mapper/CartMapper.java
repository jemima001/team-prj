package com.project.market.mapper;

import java.util.List;

import com.project.market.domain.CartDto;


public interface CartMapper {

	

	List<CartDto> selectAllCart(String id);

}

