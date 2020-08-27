package com.study.springboot.service.order;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IOrderDAO;
import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.OrderDTO;

@Service
public class OrderService implements IOrderService {

	@Autowired
	IOrderDAO O_dao;

	@Override
	public List<OrderDTO> my_order_list(String o_number) {
		return O_dao.listDao(o_number);
	}

	@Override
	public List<String> my_order_number(Criteria cri) {
		List<String> list = O_dao.my_order_number(cri);
		return list;
	}

	@Override
	public int myPage_listCount(String email) throws Exception {
		return O_dao.myPage_listCount(email);
	}

	@Override
	public void cancle_My_Order(int idx) {
		O_dao.cancle_My_Order(idx);
	}

	@Override
	public void update_Total_Price(int p_total, String o_number) {
		O_dao.update_Total_Price(p_total, o_number);
	}

	@Override
	public void update_My_Order(String state,int idx) {
		O_dao.update_My_Order(state,idx);

	}

	@Override
	public int insert_My_Order(Map<String, String> map) {
		return O_dao.insert_My_OrderDao(map);
	}

	@Override
	public void reWrite_My_Order(int idx) {
		O_dao.reWrite_My_Order(idx);

	}

	@Override
	public List<OrderDTO> search_My_Order(Map<String, String> map, Criteria cri) {
		String attribute = map.get("attribute");
		if (attribute.equals("주문번호")) {
			map.put("attribute", "O_NUMBER");
			try {
				Integer.parseInt(map.get("param"));
			} catch (NumberFormatException e) {
				map.put("param", "0");
				System.out.println("숫자아님");
				return null;
			}
		} else if (attribute.equals("주문상품")) {
			map.put("attribute", "O_TITLE");
		} else if (attribute.equals("주문자")) {
			map.put("attribute", "O_ORDERNAME");
		}
		String query = "";
		if (!map.get("param").isEmpty()) {
			query = "WHERE " + map.get("attribute") + " = " + "'" + map.get("param") + "'";
			if (map.get("ing") != null) {
				query += "AND O_STATE = '배송중'";
			}
			if (map.get("ready") != null) {
				query += "AND O_STATE = '배송준비'";
			}
			if (map.get("finish") != null) {
				query += "AND O_STATE = '배송완료'";
			}
		} else {
			if (map.get("ing") != null) {
				query = "WHERE O_STATE = '배송중'";
			}
			if (map.get("ready") != null) {
				query = "WHERE O_STATE = '배송준비'";
			}
			if (map.get("finish") != null) {
				query = "WHERE O_STATE = '배송완료'";
			}
		}

		map.put("query", query);

		System.out.println(map);
		cri.setMap(map);
		return O_dao.searchDao(cri);
	}

	@Override
	public int listCount(Map<String, String> map) {
		return O_dao.listCountDao(map);
	}

	@Override
	public List<OrderDTO> allSearch(Criteria cri) {

		return O_dao.allSearchDao(cri);
	}

}
