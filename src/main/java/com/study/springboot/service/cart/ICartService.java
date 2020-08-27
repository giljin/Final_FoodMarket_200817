package com.study.springboot.service.cart;

import java.util.List;
import java.util.Map;

import com.study.springboot.dto.CartDTO;

public interface ICartService {
	
	public List<CartDTO> listCart(int user_idx);   
	public CartDTO cart(int cart_num);   
	public int insertCart(Map<String, Integer> map);
	public int deleteCart(int product_idx);
	public int updateCart(Map<String, Integer> map);
}
