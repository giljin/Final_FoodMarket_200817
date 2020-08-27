package com.study.springboot.service.point;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IMemberDao;
import com.study.springboot.dao.IPointDAO;
import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.PointDTO;

@Service
public class PointService implements IPointService{
	@Autowired 
	IPointDAO Point_dao;
	@Autowired
	IMemberDao dao;
	
	@Override
	public void save_Point(String u_email, int get_point) {
		//현재 사용자가 가진 point를 가져옴
		int u_point = dao.get_My_Point(u_email);
		//유저 테이블의 포인트 정보와 내가 적립받을 포인트를 더 해줌
		int remain_point = u_point + get_point;
		//데이터베이스에 remain_point 5000원 설정
		Point_dao.save_Point(u_email,get_point,remain_point);
		//현재 회원의 가장 최신의 남은 금액을 가져옴
		remain_point = Point_dao.get_My_Remain_Point(u_email);
		//현재 회원의 남은 금액을 Member u_point에 넣어줌 
		dao.update_My_Point(u_email,remain_point);
	}

	@Override
	public void use_Point(String u_email, int use_point) {
		//현재 사용자가 가진 point를 가져옴
		int u_point = dao.get_My_Point(u_email);
		//유저 테이블의 포인트 정보와 내가 사용 할 포인트를 뺌
		int remain_point = u_point - use_point;
		// Point DB에 인서트
		Point_dao.use_Point(u_email, use_point, remain_point);
		//현재 회원의 가장 최신의 남은 금액을 가져옴
		remain_point = Point_dao.get_My_Remain_Point(u_email);
		//현재 회원의 남은 금액을 Member u_point에 넣어줌 
		dao.update_My_Point(u_email,remain_point);
		
	}

	@Override
	public List<PointDTO> pointList(Criteria cri) {
		List<PointDTO> list = Point_dao.pointList(cri);
		return list;
	}

	@Override
	public int get_My_Remain_Point(String p_email) {
		return Point_dao.get_My_Remain_Point(p_email);
	}

	@Override
	public int listCount(String p_email) {
		return Point_dao.listCount(p_email);
	}

	@Override
	public void delete(String u_email) {
		Point_dao.delete(u_email);
	}

}
