package com.project.market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.market.domain.CartDto;
import com.project.market.mapper.CartMapper;


@Service
public class CartService {
	
	@Autowired
	private CartMapper mapper;
	
	/*
	 * public boolean addCart(CartDto cart) { int cnt = mapper.insertCart(cart);
	 * 
	 * return cnt == 1; }
	 * 
	 * public boolean deleteCart(int id) { return mapper.deleteCart(id) == 1; }
	 * 
	 * public boolean modifyCart(CartDto cart) { int cnt = mapper.updateCart(cart);
	 * 
	 * return cnt == 1; }
	 */

	public List<CartDto> cartList(String id) {
		
		return mapper.selectAllCart(id);
	}

	public boolean cartDelete(List<Integer> cartIds) {
		
		for(Integer getCartId : cartIds) {
			
			mapper.deleteCheckedCart(getCartId); 
		}
		return true;
	}

	public void getCart(String memberId) {
		mapper.getCart(memberId);
	}
	
	
	}
	
	


