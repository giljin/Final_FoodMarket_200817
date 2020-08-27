package com.study.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.MemberDTO;

@Mapper
public interface IMemberDao {
	public List<MemberDTO> listDao(Criteria cri);
	
	public MemberDTO idCheckDao(String id);
	public MemberDTO loginDao(String id, String pw);
	public int joinDao(Map<String, String> map);
	public int deleteDao(@Param("id") String id);
	public int updateDao(Map<String, String> map);
	public int articleCount();
	public int get_My_Point(String id);
	public int update_My_Point(String id,int reamin_Point);
	public void modify(String u_email, String u_pw, String u_name, String u_phone, String u_address) ;	
	public String find_id(String u_phone);
	public String find_pw(String u_email);
	public MemberDTO myInfo(String idx);
}
