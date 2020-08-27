package com.study.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.dto.CartDTO;

@Mapper
public interface ICartDAO {
	public List<CartDTO> listCartDao(int user_idx);
	public CartDTO CartDao(int cart_num);
	public int insertCartDao(Map<String, Integer> map);
	public int deleteCartDao(int product_idx);
	public int updateCartDao(Map<String, Integer> map);
}
