package com.study.springboot.service.write;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IWriteDAO;
import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.WriteDTO;

@Service
public class WriteService implements IWriteService{
	@Autowired
	IWriteDAO W_dao;
	
	@Override
	public void write_upload(String w_title, String email, int w_grade, String w_content, String w_filename,
			int o_idx) {
		W_dao.write_Upload(w_title, email, w_grade, w_content, w_filename,o_idx);
		
	}

	@Override
	public List<WriteDTO> get_My_ReivewList(Criteria cri) {
		List<WriteDTO> review = W_dao.get_My_ReviewList(cri);
		return review;
	}
	
	//20200731 수정
	@Override
	public WriteDTO get_My_Rivew(int idx) {
		WriteDTO review = W_dao.get_My_Review(idx);
		return review;
	}

	@Override
	public void update_my_review(int idx, int w_grade, String w_content, String w_filename) {
		W_dao.update_my_review(idx,w_grade,w_content,w_filename);
	}

	@Override
	public void delete_my_review(int idx) {
		W_dao.delete_my_review(idx);
	}

	@Override
	public int listCount(String email) throws Exception {
		return W_dao.listCount(email);
	}

	@Override
	public List<WriteDTO> viewWrite(String w_title) {
		return W_dao.viewWriteDao(w_title);
	}

	@Override
	public List<WriteDTO> bestWrite() {
		return W_dao.bestWriteDao();
	}






}
