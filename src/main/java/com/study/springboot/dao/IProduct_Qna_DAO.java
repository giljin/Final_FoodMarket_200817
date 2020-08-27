package com.study.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.Product_Qna_DTO;

@Mapper
public interface IProduct_Qna_DAO {
	public void product_Qna_Insert(String p_name,String q_category, String q_email,String q_name,String q_title, String q_content);
	//20200731수정
	public List<Product_Qna_DTO> product_Qna_List(String p_name);
	//20200803
	public List<Product_Qna_DTO> product_My_Qna_List(Criteria cri);
	//20200731수정
	public Product_Qna_DTO product_Qna_Detail(int idx);
	
	public List<Product_Qna_DTO> find_Qna_ListDao(Criteria cri);
	public int pna_listCountDao(String query);
	public int product_qna_reply(Map<String, String> map);
	public int originNoCount(int originNo);
	
	public void update_Product_Qna(int idx, String q_title, String q_content);
	public void product_Qna_Delete(int origino);
	public void product_admin_Qna_Delete(int idx);
	public int p_listCount(String q_email);
}
