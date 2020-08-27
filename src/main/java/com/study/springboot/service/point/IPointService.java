package com.study.springboot.service.point;

import java.util.List;

import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.PointDTO;

public interface IPointService {
	public void save_Point(String u_email ,int get_point);
	public void use_Point(String u_email ,int use_point);
	public List<PointDTO> pointList(Criteria cri);
	public int get_My_Remain_Point(String u_email);
	public int listCount(String p_email);
	public void delete(String u_email);
}
