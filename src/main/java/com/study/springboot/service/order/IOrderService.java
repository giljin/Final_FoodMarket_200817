package com.study.springboot.service.order;

import java.util.List;
import java.util.Map;

import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.OrderDTO;

public interface IOrderService {
	public List<OrderDTO> my_order_list(String o_number);
	public List<String> my_order_number(Criteria cri);
	public void cancle_My_Order(int idx);
	public void update_My_Order(String state , int idx);
	public void update_Total_Price(int p_total,String o_number);
	public int insert_My_Order(Map<String, String> map);
	public int myPage_listCount(String email) throws Exception;

	/* public int order_Count(String ) */
	public void reWrite_My_Order(int idx);
	
	public List<OrderDTO> allSearch(Criteria cri);
	public List<OrderDTO> search_My_Order(Map<String, String>map, Criteria cri);
	public int listCount(Map<String, String>map);
}
