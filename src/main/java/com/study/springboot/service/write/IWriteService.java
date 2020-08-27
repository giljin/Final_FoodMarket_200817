package com.study.springboot.service.write;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.WriteDTO;

public interface IWriteService {
	public void write_upload(String w_title , String email , int w_grade , String w_content , String w_filename, int o_idx);
	public List<WriteDTO> get_My_ReivewList(Criteria cri);
	public WriteDTO get_My_Rivew(int idx);
	public void update_my_review(int idx,int w_grade,String w_content,String w_filename);
	public void delete_my_review(int idx);
	public int listCount(String email) throws Exception;
	public List<WriteDTO> viewWrite(String w_title);
	public List<WriteDTO> bestWrite();
}
