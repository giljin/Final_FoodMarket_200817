package com.study.springboot.service.qna;

import java.util.List;
import java.util.Map;

import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.MemberDTO;
import com.study.springboot.dto.Order_Qna_DTO;
import com.study.springboot.dto.Product_Qna_DTO;

public interface IQnaService {
	public void product_Qna_Insert(String p_name,String q_category,String q_email,String q_name,String q_title,String q_content);
	//20200731수정
	//해당 제품에 대한 리스트를 가져옴
	public List<Product_Qna_DTO> product_Qna_List(String p_name);
	//20200803
	public List<Product_Qna_DTO> product_My_Qna_List(Criteria cri);
	//20200731 수정
	//해당 인덱스에 대한 문의건을 가져옴
	public Product_Qna_DTO product_Qna_Detail(int idx);
	public void update_Product_Qna(int idx,String q_title,String q_content);
	public void product_Qna_Delete(int originno);
	public void product_admin_Qna_Delete(int idx);
	
	
	public List<Product_Qna_DTO> find_Qna_List(Criteria cri, Map<String, String> map);
	public int pna_listCount(String query);
	public int product_qna_reply(Map<String, String> map);
	public int originNoCount(int originNo);
	
	
	
	//20200803
	public void order_Qna_Insert(String o_number,String oq_category,String oq_name,String oq_email,String oq_title,String oq_content);
	
	
	
	
	//20200803
	public List<Order_Qna_DTO> order_My_Qna_List(Criteria cri);
	//20200803
	//해당 인덱스에 대한 문의건을 가져옴
	public Order_Qna_DTO order_Qna_Detail(int idx);
	//20200803
	public void update_Order_Qna(int idx,String oq_title,String oq_content);
	public void order_qna_delete(int originno);
	public void order_admin_Qna_Delete(int idx);
	public int o_listCount(String oq_email) throws Exception;
	public int p_listCount(String q_email) throws Exception;
	public int ocount();
	
	public List<Order_Qna_DTO> find_Qna_oList(Criteria cri, Map<String, String> map);
	public int pna_olistCount(String query);
	public int order_qna_reply(Map<String, String> map);
	public int o_originNoCount(int originNo);
}
