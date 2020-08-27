package com.study.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.OrderDTO;

@Mapper
public interface IOrderDAO {
	public List<OrderDTO> listDao(String o_number);
	
	public void cancle_My_Order(int idx);
	
	public void update_My_Order(String state,int idx);
	
	public void reWrite_My_Order(int idx);
	public List<String> my_order_number(Criteria cri);
	public int insert_My_OrderDao(Map<String, String> map);
	public List<OrderDTO> searchDao(Map<String, String>map);
	public int myPage_listCount(String email) throws Exception;
	public void update_Total_Price(int p_total,String o_number);
	
	public List<OrderDTO> allSearchDao(Criteria cri);
	public List<OrderDTO> searchDao(Criteria cri);
	public int listCountDao(Map<String, String> map);
}
