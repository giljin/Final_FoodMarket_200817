package com.study.springboot.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.multipart.MultipartFile;

import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.WriteDTO;

@Mapper
public interface IWriteDAO {
	
	public void write_Upload(String w_title,String w_name,int w_grade,String w_content,String w_filename,int o_idx);
	public List<WriteDTO> listWriteDao();
	public List<WriteDTO> get_My_ReviewList(Criteria cri);
	//20200731수정
	public WriteDTO get_My_Review(int idx);
	public List<WriteDTO> viewWriteDao(String title);
	public void update_my_review(int idx,int w_grade,String w_content,String w_filename);
	public void delete_my_review(int idx);
	
	public List<WriteDTO> bestWriteDao();
	
	public int listCount(String email) throws Exception;
}
