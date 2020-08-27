package com.study.springboot.service.qna;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IOrder_Qna_DAO;
import com.study.springboot.dao.IProduct_Qna_DAO;
import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.Order_Qna_DTO;
import com.study.springboot.dto.Product_Qna_DTO;

@Service
public class QnaService implements IQnaService {
	@Autowired
	IProduct_Qna_DAO PQna_Dao;
	@Autowired
	IOrder_Qna_DAO OQna_Dao;

	@Override
	public void product_Qna_Insert(String p_name, String q_category, String q_email, String q_name, String q_title,
			String q_content) {
		PQna_Dao.product_Qna_Insert(p_name, q_category, q_email, q_name, q_title, q_content);
	}

	// 20200731 수정
	@Override
	public List<Product_Qna_DTO> product_Qna_List(String p_name) {
		return PQna_Dao.product_Qna_List(p_name);
	}

	// 20200731 수정
	@Override
	public Product_Qna_DTO product_Qna_Detail(int idx) {
		return PQna_Dao.product_Qna_Detail(idx);
	}

	// 20200803
	@Override
	public void order_Qna_Insert(String o_number, String oq_category, String oq_name, String oq_email, String oq_title,
			String oq_content) {
		OQna_Dao.order_Qna_Insert(o_number, oq_category, oq_name, oq_email, oq_title, oq_content);
	}

	// 20200803
	@Override
	public List<Product_Qna_DTO> product_My_Qna_List(Criteria cri) {
		return PQna_Dao.product_My_Qna_List(cri);
	}

	// 20200803
	@Override
	public void update_Product_Qna(int idx, String q_title, String q_content) {
		PQna_Dao.update_Product_Qna(idx, q_title, q_content);
	}

	// 20200803
	@Override
	public void product_Qna_Delete(int originno) {
		PQna_Dao.product_Qna_Delete(originno);
	}
	@Override
	public void product_admin_Qna_Delete(int idx) {
		PQna_Dao.product_admin_Qna_Delete(idx);
	}

	@Override
	public int p_listCount(String q_email) throws Exception {
		return PQna_Dao.p_listCount(q_email);
	}

	@Override
	public List<Product_Qna_DTO> find_Qna_List(Criteria cri, Map<String, String> map) {

		if (map.size() > 0) {
			String attr = map.get("attribute");
			System.out.println(attr);
			if (attr.equals("상품명")) {
				attr = "P_NAME";
			} else if (attr.equals("이름")) {
				attr = "Q_NAME";
			} else if (attr.equals("문의제목")) {
				attr = "Q_TITLE";
			}

			String param = map.get("param");
			String category = map.get("category");
			String query = "";
			if (param == null || param == "") {
				if (category != null) {
					query = "WHERE Q_CATEGORY = '" + category + "'";
				}
			} else {
				if (category != null) {
					query = "WHERE " + attr + " = '" + param + "' AND Q_CATEGORY = '" + category + "'";
				} else {
					query = "WHERE " + attr + " = '" + param + "'";
				}
			}
			System.out.println(query);
			map.put("query", query);
		}
		cri.setMap(map);

		return PQna_Dao.find_Qna_ListDao(cri);
	}

	@Override
	public int pna_listCount(String query) {
		if (!query.isEmpty()) {
			query = "AND" + query.substring(5);
			System.out.println(query);
		}
		return PQna_Dao.pna_listCountDao(query);
	}

	@Override
	public int product_qna_reply(Map<String, String> map) {
		return PQna_Dao.product_qna_reply(map);
	}

	@Override
	public int originNoCount(int originNo) {
		return PQna_Dao.originNoCount(originNo);
	}
	// 20200803
	@Override
	public List<Order_Qna_DTO> order_My_Qna_List(Criteria cri) {
		return OQna_Dao.order_My_Qna_List(cri);
	}

	// 20200803
	// 주문문의내역 상세
	@Override
	public Order_Qna_DTO order_Qna_Detail(int idx) {
		return OQna_Dao.order_Qna_Detail(idx);
	}

	// 주문문의내역 업데이트
	@Override
	public void update_Order_Qna(int idx, String oq_title, String oq_content) {
		OQna_Dao.update_Order_Qna(idx, oq_title, oq_content);
	}

	// 주문문의 내역 삭제
	@Override
	public void order_qna_delete(int originno) {
		OQna_Dao.order_qna_delete(originno);
	}
	
	@Override
	public void order_admin_Qna_Delete(int idx) {
		OQna_Dao.order_admin_Qna_Delete(idx);
		
	}
	

	@Override
	public int o_listCount(String oq_email) throws Exception {
		return OQna_Dao.o_listCount(oq_email);
	}


	@Override
	public int ocount() {
		return OQna_Dao.articleCount();
	}


	@Override
	public List<Order_Qna_DTO> find_Qna_oList(Criteria cri, Map<String, String> map) {
		if (map.size() > 0) {
			String attr = map.get("attribute");
			System.out.println(attr);
			if (attr.equals("주문번호")) {
				attr = "O_NUMBER";
			} else if (attr.equals("이름")) {
				attr = "OQ_NAME";
			} else if (attr.equals("문의제목")) {
				attr = "OQ_TITLE";
			}

			String param = map.get("param");
			String category = map.get("category");
			String query = "";
			if (param == null || param == "") {
				if (category != null) {
					query = "WHERE OQ_CATEGORY = '" + category + "'";
				}
			} else {
				if (category != null) {
					query = "WHERE " + attr + " = '" + param + "' AND OQ_CATEGORY = '" + category + "'";
				} else {
					query = "WHERE " + attr + " = '" + param + "'";
				}
			}

			System.out.println(query);
			map.put("query", query);
		}
		cri.setMap(map);

		return OQna_Dao.find_Qna_oListDao(cri);
	}

	@Override
	public int pna_olistCount(String query) {
		if (!query.isEmpty()) {
			query = "AND" + query.substring(5);
			System.out.println(query);
		}
		return OQna_Dao.pna_listCountDao(query);
	}

	@Override
	public int order_qna_reply(Map<String, String> map) {
		return OQna_Dao.order_qna_reply(map);
	}

	@Override
	public int o_originNoCount(int originNo) {
		return OQna_Dao.o_originNoCount(originNo);
	}




}
