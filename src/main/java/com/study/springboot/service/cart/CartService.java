package com.study.springboot.service.cart;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.ICartDAO;
import com.study.springboot.dto.CartDTO;

@Service
public class CartService implements ICartService{

	@Autowired
	ICartDAO C_dao;
	
	@Override
	public List<CartDTO> listCart(int user_idx) {
		return C_dao.listCartDao( user_idx );
	}

	@Override
	public CartDTO cart(int cart_num) {
		return C_dao.CartDao( cart_num );
	}

	@Override
	public int insertCart(Map<String, Integer> map) {
		return C_dao.insertCartDao( map );
	}

	@Override
	public int deleteCart(int product_idx) {
		return C_dao.deleteCartDao( product_idx );
	}

	@Override
	public int updateCart(Map<String, Integer> map) {
		return C_dao.updateCartDao( map );
	}

}
