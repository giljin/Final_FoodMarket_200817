package com.study.springboot.service.member;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.MemberDTO;

public interface IMemberService {
	
	public List<MemberDTO> list(Criteria cri, Map<String, String>map);
	public MemberDTO idCheck(String id);
	public MemberDTO myInfo(String idx);
	public MemberDTO login(String id, String pw);
	public String join(Map<String, String> map);
	public int delete(@Param("id") String id);
	public int update(Map<String, String> map);
	public int count();
	//회원정보수정
	public void modify(String u_email, String u_pw, String u_name, String u_phone, String u_address);
	//아이디, 비번찾기
	public String find_id(String u_phone);
	public String find_pw(String u_email);
	//메일발송
	public void sendMail(String email,String u_name,String path);
}
