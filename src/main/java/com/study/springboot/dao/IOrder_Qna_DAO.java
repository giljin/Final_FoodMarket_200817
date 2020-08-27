//20200803
package com.study.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.MemberDTO;
import com.study.springboot.dto.Order_Qna_DTO;

@Mapper
public interface IOrder_Qna_DAO {
	public void order_Qna_Insert(String o_number,String oq_category,String oq_name,String oq_email,String oq_title,String oq_content);
	public List<Order_Qna_DTO> order_My_Qna_List(Criteria cri);
	public Order_Qna_DTO order_Qna_Detail(int idx);
	public void update_Order_Qna(int idx, String oq_title, String oq_content);
	public void order_qna_delete(int originno);
	public void order_admin_Qna_Delete(int idx);
	public int o_listCount(String oq_email);
	public int articleCount();
	
	public List<Order_Qna_DTO> find_Qna_oListDao(Criteria cri);
	public int pna_listCountDao(String query);
	public int order_qna_reply(Map<String, String> map);
	public int o_originNoCount(int originNo);
}
