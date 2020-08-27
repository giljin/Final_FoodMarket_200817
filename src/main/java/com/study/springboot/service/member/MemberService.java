package com.study.springboot.service.member;

import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.study.springboot.dao.IMemberDao;
import com.study.springboot.domain.Criteria;
import com.study.springboot.dto.MemberDTO;

@Service
public class MemberService implements IMemberService {

	@Autowired
	IMemberDao M_dao;
	@Autowired
	JavaMailSender javaMailSender;

	@Override
	public List<MemberDTO> list(Criteria cri, Map<String, String> map) {

		System.out.println(map.size());
		if (map.size() > 0) {
			String attr = map.get("attribute");
			attr = attr.trim();
			System.out.println("속성:" + attr + "이름과 같냐?" + attr.equals("이름"));
			if (attr.equals("이름")) {
				attr = "U_NAME";
			} else if (attr.equals("아이디")) {
				attr = "U_EMAIL";
			}

			String param = map.get("param");
			String query = "";
			if (param == null || param == "") {

			} else {
				query = "WHERE " + attr + " = '" + param + "'";
			}

			System.out.println(query);
			map.put("query", query);
			cri.setMap(map);
		}
		return M_dao.listDao(cri);
	}

	@Override
	public MemberDTO idCheck(String id) {
		return M_dao.idCheckDao(id);
	}

	@Override
	public MemberDTO myInfo(String idx) {
		return M_dao.myInfo(idx);
	}

	@Override
	public MemberDTO login(String id, String pw) {
		return M_dao.loginDao(id, pw);
	}

	@Override
	public String join(Map<String, String> map) {

		for (String key : map.keySet()) {
			if (map.get(key) == null || map.get(key).isEmpty()) {
				return convertName(key);
			}
		}
		M_dao.joinDao(map);
		return null;
	}

	@Override
	public int delete(String id) {
		return M_dao.deleteDao(id);
	}

	@Override
	public int update(Map<String, String> map) {
		return M_dao.updateDao(map);
	}

	@Override
	public int count() {
		return M_dao.articleCount();
	}

	@Override
	public void modify(String u_email, String u_pw, String u_name, String u_phone, String u_address) {
		M_dao.modify(u_email, u_pw, u_name, u_phone, u_address);
	}

	@Override
	public String find_id(String u_phone) {
		String u_email = M_dao.find_id(u_phone);
		System.out.println(u_email);
		return u_email;
	}

	@Override
	public String find_pw(String u_email) {
		String u_pw = M_dao.find_pw(u_email);
		System.out.println(u_pw);
		return u_pw;
	}

	@Override
	public void sendMail(String email, String u_name, String path) {
		// String path =
		// request.getSession().getServletContext().getRealPath("/image/welcome.png");
		String setfrom = "FoodMarket";
		String title = "[FoodMarket]푸드마켓 회원이 되신걸 진심으로 환영합니다.!";
		String content = "<h2>" + u_name + "님 푸드마켓 회원이 되신걸 진심으로 환영합니다.</h2>";
		String contents = content + "<img src='http://jisung0509.dothome.co.kr/welcome.png'/>";
		try {
			MimeMessage message = javaMailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하거나 하면 정상작동을 안함
			messageHelper.setTo(email); // 받는사람 이메일
			messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
			messageHelper.setText(contents, true); // 메일 내용

			javaMailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	public String convertName(String key) {
		if( key.equals("u_email") ) {
			return "이메일";
		}else if( key.equals("u_pw") ) {
			return "비밀번호";
		}else if( key.equals("u_name") ) {
			return "이름";
		}else if( key.equals("u_phone") ) {
			return "휴대폰 번호";
		}else if( key.equals("u_address") ) {
			return "주소";
		}else {
			return "알 수 없는 값";
		}
	}

}
