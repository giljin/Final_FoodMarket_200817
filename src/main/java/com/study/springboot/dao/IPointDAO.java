package com.study.springboot.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.PointDTO;

@Mapper
public interface IPointDAO {
	public void save_Point(String u_email ,int get_point,int remain_point);
	public void use_Point(String u_email ,int use_point,int remain_point);
	public int get_My_Remain_Point(String u_email);
	public List<PointDTO> pointList(Criteria cri);
	public int listCount(String p_email);
	public void delete(String u_email);
}
