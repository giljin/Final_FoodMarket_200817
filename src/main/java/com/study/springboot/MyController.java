package com.study.springboot;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.study.springboot.domain.Criteria;
import com.study.springboot.domain.PageMaker;
import com.study.springboot.dto.CartDTO;
import com.study.springboot.dto.MemberDTO;
import com.study.springboot.dto.OrderDTO;
import com.study.springboot.dto.Order_Qna_DTO;
import com.study.springboot.dto.PointDTO;
import com.study.springboot.dto.ProductDTO;
import com.study.springboot.dto.Product_Qna_DTO;
import com.study.springboot.dto.WriteDTO;
import com.study.springboot.service.cart.ICartService;
import com.study.springboot.service.member.IMemberService;
import com.study.springboot.service.order.IOrderService;
import com.study.springboot.service.point.IPointService;
import com.study.springboot.service.product.IProductService;
import com.study.springboot.service.qna.IQnaService;
import com.study.springboot.service.write.IWriteService;

@Controller
public class MyController {

	@Autowired
	IMemberService mService;
	@Autowired
	IOrderService oService;
	@Autowired
	ICartService cService;
	@Autowired
	IProductService pService;
	@Autowired
	IWriteService wService;
	@Autowired
	IPointService ptService;
	@Autowired
	IQnaService qService;
	@Autowired
	HttpSession session;

	// 최초 접근 시 맵핑명 main으로 이동
	@RequestMapping("/")
	public String root() throws Exception {
		return "redirect:main";
	}

	// 길진
	@RequestMapping("/main")
	public String goMain(HttpServletRequest request, Model model) {

		// PRODUCT DB 에서 칼럼명 category가 한식인 상품중에서 가장 최근 등록한상품 4가지 상품을 가져옴
		List<ProductDTO> krProducts = pService.categoryProduct("한식");

		// PRODUCT DB 에서 칼럼명 category가 중식인 상품중에서 가장 최근 등록한상품 4가지 상품을 가져옴
		List<ProductDTO> chProducts = pService.categoryProduct("중식");

		// PRODUCT DB 에서 칼럼명 category가 일식인 상품중에서 가장 최근 등록한상품 4가지 상품을 가져옴
		List<ProductDTO> jpProducts = pService.categoryProduct("일식");
		
		// PRODUCT DB 에서 칼럼명 category가 일식인 상품중에서 가장 최근 등록한상품 4가지 상품을 가져옴
		List<ProductDTO> enProducts = pService.categoryProduct("양식");

		// PRODUCT DB 에서 칼럼명 special의 값이 O인 제품을 가져옴 (1개)
		ProductDTO specialDTO = pService.sepcialProduct();

		// Write DB에서 가장 최근에 작성한 상품평을 가져옴 (4개)
		// main.jsp에서 베스트 상품평에 2개씩 보여질 수 있도록 설정
		List<WriteDTO> bestWrites = wService.bestWrite();
	    List<WriteDTO> bestWrites2 = new ArrayList<>();

	      if ( bestWrites.size() > 2 ) {
	         int bestWritesSize = bestWrites.size();
	         for(int i=0; i<bestWritesSize-2; i++) {
	            bestWrites.remove(2);
	         }
	         bestWrites2 = wService.bestWrite();
	         for(int i=0; i<2; i++) {
	            bestWrites2.remove(0);
	         }
	         System.out.println( bestWrites2 );
	      }


		// DB에서 가져온 데이터들을 main.jsp에 전달
		request.setAttribute("krlist", krProducts);
		request.setAttribute("chlist", chProducts);
		request.setAttribute("jplist", jpProducts);
		request.setAttribute("enlist", enProducts);
		request.setAttribute("special", specialDTO);
		request.setAttribute("bestWrites", bestWrites);
		request.setAttribute("bestWrites2", bestWrites2);

		return "main";
	}

	// login.jsp로 이동
	@RequestMapping("/login")
	public String login(HttpServletRequest request, Model model) {
		
		Cookie[] myCookies = request.getCookies();
		//저장된아이디가 있는지 확인 후 login 페이지에 값 넘겨주기
		if (myCookies != null) {
			request.setAttribute(myCookies[0].getName(), myCookies[0].getValue());
		}
		return "login";
	}

	//길진
	@RequestMapping("/login_ok")
	public String loginOk(HttpServletRequest request, Model model, HttpServletResponse response) {
		String sId = request.getParameter("user_id");
		String sPw = request.getParameter("user_pw");
		//아이티저장 체크 여부
		String sMemoryId = request.getParameter("memoryId");
		Cookie[] cookies = request.getCookies(); // 요청정보로부터 쿠키를 가져온다.

		MemberDTO dto = mService.login(sId, sPw);

		String message = "";
		if (dto == null) {
			//로그인 실패시
			message = "아이디/비밀번호를 확인해 주세요.";
			request.setAttribute("message", message);
			return "login";
		} else {
			// 로그인 성공시
			// 기존의 저장한 "userid" 쿠키정보삭제
			Cookie deleteCookie = deleteCookie(cookies, "userid");
			if( deleteCookie != null ) {
				response.addCookie( deleteCookie );
			}
			
			// 아이디저장 체크시 쿠키에 아이디 저장
			if (sMemoryId != null) {
				// Id값 쿠키에 저장
				Cookie myCookie = new Cookie("userid", sId);
				myCookie.setMaxAge(60 * 60 * 24 * 30); // 한달
				myCookie.setPath("/"); // 모든 경로에서 접근 가능 하도록 설정
				response.addCookie(myCookie);
			}
			// 세션에 로그인한 유저의 MemberDTO 저장
			session.setAttribute("dto", dto);
			System.out.println("로그인 성공");
			return "redirect:main";
		}
	}

	@RequestMapping("/join")
	public String join(HttpServletRequest request, Model model) {
		return "join";
	}
	
	
	@RequestMapping("/idCheck")
	public String idCheck(HttpServletRequest request, Model model) {
		String uId = request.getParameter("userid");
		String message = "";
		int checked = 0;
		// id 중복체크
		if (mService.idCheck(uId) == null && !uId.equals("admin")) {
			message = "사용가능한 아이디입니다.";
			checked = 2;
		} else {
			message = "사용불가능한 아이디입니다.";
			checked = 1;
		}

		model.addAttribute("checked", checked);
		model.addAttribute("message", message);
		Map<String, String> map = new HashMap<>();
		map.put("u_email", uId);
		model.addAttribute("map", map);
		return "join";
	}
	// 길진
	@RequestMapping("/join_ok")
	public String joinOk(HttpServletRequest request, Model model, RedirectAttributes rttr) {

		String message = "";
		// form에 입력한 데이터 가져옴
		String uId = request.getParameter("user_id");
		String uPw = request.getParameter("user_pw");
		String uName = request.getParameter("name");
		String uPhone = request.getParameter("phone");
		String uAddress = request.getParameter("address");
		String idc = request.getParameter("idcheck");
		// map에 저장
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("u_email", uId);
		map.put("u_pw", uPw);
		map.put("u_name", uName);
		map.put("u_phone", uPhone);
		map.put("u_address", uAddress);
		map.put("u_point", "0");

		if(idc.equals("") || idc.equals("0")) {
			message = "아이디 중복확인을 해주세요.";
			model.addAttribute("checked", 0);
			model.addAttribute("message", message);
			return "join";
		}else if( idc.equals("1") ) {
			message = "사용불가능한 아이디 입니다.";
			model.addAttribute("checked", 1);
			model.addAttribute("message", message);
			return "join";
		}
		model.addAttribute("checked", 2);
		
		
		// 회원가입 되면 null 회원가입 안되면 입력안된 정보 이름 출력
		String sResult = mService.join(map);
		if (sResult != null) {
			// 회원가입 실패시
				message = sResult + "를 입력해주세요.";
				model.addAttribute("message", message);
				model.addAttribute("map", map);
				return "join";
		} else {
			// 회원가입 성공시
			String u_email = map.get("u_email");
			String u_name = map.get("u_name");

			// 현재 회원의 포인트를 5000원으로 만들어줌
			ptService.save_Point(u_email, 5000);

			String path = request.getSession().getServletContext().getRealPath("/image/welcome.png");
			// 회원가입 완료시 메일 보내줌
			mService.sendMail("jisung0509@naver.com", u_name, path);
			return "login";
		}

	}

	// 로그아웃
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, Model model, RedirectAttributes rttr) {
		
		session.invalidate();
		rttr.addFlashAttribute("message", "로그아웃되었습니다.");
		return "redirect:main";
	}

	// 20200804
	@RequestMapping("/my_order")
	public String my_order(Criteria cri, Model model, HttpServletRequest request) throws Exception {
		// 로그인한 회원 이메일 가져와옴
		String id = ((MemberDTO) session.getAttribute("dto")).getU_email();

		cri.setPerPageNum(2);
		cri.setU_email(id);
		List<String> list = oService.my_order_number(cri);
		// 20072101 , 20072102
		List<Object> object = new ArrayList<Object>();

		// select * from orderlist where o_number = 20072101
		// select * from orderlist where o_number = 20072102
		for (int i = 0; i < list.size(); i++) {
			object.add(oService.my_order_list(list.get(i)));
		}
		
		PageMaker pageMaker = createPageMaker(cri, oService.myPage_listCount(id));

		model.addAttribute("list", object);
		model.addAttribute("pageMaker", pageMaker);
		return "user/my_order";
	}

	// 주문목록 삭제
	@RequestMapping("/order_cancle")
	public String order_cancle(@RequestParam("idx") int idx, @RequestParam("o_price") int o_price,
			@RequestParam("p_total") int p_total, @RequestParam("o_number") String o_number,
			@RequestParam("o_point") int o_point) throws Exception {
		// 현재 아이디 가져오기
		String u_email = ((MemberDTO) session.getAttribute("dto")).getU_email();

		int total = p_total - o_price;
		// 제품
		oService.cancle_My_Order(idx);

		if (total > 0) {
			// p_total업데이트
			oService.update_Total_Price(total, o_number);
		} else {
			// 음수일때는 0
			total = 0;
			// p_total업데이트
			oService.update_Total_Price(total, o_number);
		}
		if (o_point > 0) {
			if (oService.my_order_list(o_number).size() == 0 || oService.my_order_list(o_number) == null) {
				ptService.save_Point(u_email, o_point);
			}
		}
		return "redirect:my_order";
	}

	@RequestMapping("/review_write")
	// 20200731
	public String review_write(@RequestParam("idx") int idx, @RequestParam("o_title") String o_title, Model model)
			throws Exception {
		//// 주문목록 db에서 해당하는 주문의 인덱스(o_idx)의 레코드에서 배송상태를 상품평 완료로 바꿔줌
		oService.update_My_Order("상품평 완료", idx);

		// 해당 상품의 주문목록 인덱스
		model.addAttribute("o_idx", idx);

		// 상품평을 쓸 상품명을 model 객체에 저장
		model.addAttribute("w_title", o_title);

		// 로그인한 유저이름을 model 객체에 저장
		String name = ((MemberDTO) session.getAttribute("dto")).getU_name();
		model.addAttribute("w_name", name);

		// 페이지에 로그인한 유저이름과 상품평을 쓸 상품명, 해당상품의 주문인덱스를 전달
		return "user/my_review_writer";
	}

	// 파일 업로드
	@RequestMapping("/write_upload")
	public String write_upload(HttpServletRequest request) {

		MultipartHttpServletRequest multi_Request = (MultipartHttpServletRequest) request;
		// 로그인한 계정(이메일) 가져와서
		String email = ((MemberDTO) session.getAttribute("dto")).getU_email();

		// my_review_writer에서 전송한 데이터와 유저 아이디(이메일)을 전송
		// 유저아이디는 폴더 생성에 필요

		try {
			// image폴더 밑에 내 이름으로된 폴더를 만듬
			String path = request.getSession().getServletContext().getRealPath("/image/member/") + email + "/";
			createFolder(path);

			// image폴더 밑에 내 아이디로된 폴더에 파일을 올림
			MultipartFile file = multi_Request.getFile("filename");
			System.out.println("파일이름 :" + file.getOriginalFilename()); // ***.jpg 이런 방식

			// 파일 이름을 가져와서 기종의 파일 이름이랑 비교
			File[] files = new File(path).listFiles(); // 기존 파일
			System.out.println("파일 목록 : " + files);

			String convertFileName = file.getOriginalFilename();
			if (files != null) {
				for (File oldFile : files) {

					// 해당 path에 있는 파일들을 하나씩 비교해서 내가 보낼 파일이랑 이름이 같으면
					if (oldFile.getName().equals(convertFileName)) {

						int dotIdx = oldFile.getName().indexOf(".");
						String format = oldFile.getName().substring(dotIdx);
						String fileName = oldFile.getName().substring(0, dotIdx);

						convertFileName = fileName + "1" + format;
					}
				}
				System.out.println(convertFileName);
			}
			file.transferTo(new File(path + convertFileName)); // 파일 저장

			// my_review_writer에서 전송된 정보를 저장
			// 상품명 , 유저이름 , 별점 , 내용 , 파일명
			String w_title = multi_Request.getParameter("w_title");
			int w_grade = Integer.parseInt(multi_Request.getParameter("w_grade"));
			String w_content = multi_Request.getParameter("w_content");
			String w_filename;
			if (multi_Request.getFile("filename") != null) {
				w_filename = multi_Request.getFile("filename").getOriginalFilename();
			} else {
				w_filename = "";
			}
			int o_idx = Integer.parseInt(multi_Request.getParameter("o_idx"));

			wService.write_upload(w_title, email, w_grade, w_content, w_filename, o_idx);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 최초 상품평 작성 시 500포인트 적립
		ptService.save_Point(email, 500);

		return "redirect:main";
	}

	//길진
	@RequestMapping("/product/product_detail")
	public String product_detail(HttpServletRequest request, Model model) {
		String message = request.getParameter("message");
		// 내가 클릭한 상품의 정보를 가져옴 (ProductDTO)
		ProductDTO productDto = pService.viewProduct(request.getParameter("idx"));
		// WRITE DB에 해당 상품의 상품평을 전부 가져옴
		List<WriteDTO> writelist = wService.viewWrite(productDto.getP_name());

		// 20200731수정
		// PQNA(상품문의) DB에서 해당 상품의 문의내역을 전부 가져옴
		String p_name = productDto.getP_name();
		List<Product_Qna_DTO> P_Qna_List = qService.product_Qna_List(p_name);

		// 상품의 내용
		String content = productDto.getP_content();
		// 내용이 사진파일이기 때문에 , 으로 split해서 가져옴
		// ex)감자1.png,감자2.png,딸기.jpg
		String[] files = content.split(",");

		// 가져온 것을 상세페이지로 넘겨줌
		model.addAttribute("p_dto", productDto);
		model.addAttribute("files", files);
		model.addAttribute("writelist", writelist);
		model.addAttribute("writeCount", writelist.size());
		// 20200731 수정
		model.addAttribute("P_Qna_List", P_Qna_List);
		model.addAttribute("message", message);

		return "/product/product_detail";

	}

	//길진
	@RequestMapping("/product/search")
	public String search(HttpServletRequest request) {
		// 검색한 키워드 가져옴
		String search = request.getParameter("search");

		// product db에서 해당 키워드를 포함한 상품을 전부 가져옴
		List<ProductDTO> p_searchlist = pService.searchProductDao(search);

		// 키워드, 상품목록 , 가져온 상품의 갯수를 전달
		request.setAttribute("search", search);
		request.setAttribute("searchlist", p_searchlist);
		request.setAttribute("listcount", p_searchlist.size());

		return "/product/search";
	}

	@RequestMapping("/my_info")
	public String my_info(HttpServletRequest request) {
		return "user/my_info";
	}

	@RequestMapping("/modify")
	public String modify(HttpServletRequest request, Model model) {
		// 넘어온 정보를 MemberDTO를 하나 만들어서 저장
		// OR 그냥 변수에 저장
		String u_email = request.getParameter("user_id");
		String u_pw = request.getParameter("user_pw");
		String u_name = request.getParameter("name");
		String u_phone = request.getParameter("phone");
		String u_address = request.getParameter("address");

		System.out.println(u_email);
		// db에다가 다시 넣어줌
		mService.modify(u_email, u_pw, u_name, u_phone, u_address);
		MemberDTO dto = mService.idCheck(u_email);
		session.setAttribute("dto", dto);
		return "redirect:main";
	}

	// 아이디,비밀번호 찾기 폼
	@RequestMapping("/find_id")
	public String find_id(HttpServletRequest request, Model model) {
		return "/user/find_id";
	}

	@RequestMapping("/find_id_ok")
	public String find_idOk(HttpServletRequest request, Model model) {
		// form에서 넘어온 phone번호

		String u_phone = request.getParameter("phone");
		System.out.println(u_phone);
		// db에서 u_phone으로 이메일을 찾아옴
		String u_email = mService.find_id(u_phone);
		System.out.println(u_email);
		// 해당 이메일을 맵핑
		model.addAttribute("u_email", u_email);
		return "/user/find_id_ok";

	}

	@RequestMapping("/find_pw")
	public String find_pw(HttpServletRequest request, Model model) {
		return "/user/find_pw";
	}

	@RequestMapping("/find_pw_ok")
	public String find_pwOk(HttpServletRequest request, Model model) {
		// form에서 넘어온 이메일
		String u_email = request.getParameter("email");
		// db에서 u_email으로 암호를 찾아옴
		String u_pw = mService.find_pw(u_email);
		// 해당 암호를 맵핑
		model.addAttribute("u_pw", u_pw);
		return "/user/find_pw_ok";
	}

	// 내 리뷰 목록
	@RequestMapping("/my_review")
	public String my_review_get(Criteria cri, Model model, HttpServletRequest request) throws Exception {
		// 로그인한 사용자 아이디 가져옴
		String email = ((MemberDTO) session.getAttribute("dto")).getU_email();

		cri.setU_email(email);
		List<WriteDTO> my_Review = wService.get_My_ReivewList(cri);
		request.setAttribute("my_Review", my_Review);

		PageMaker pageMaker = createPageMaker(cri, wService.listCount(email));

		request.setAttribute("pageMaker", pageMaker);
		return "user/my_review";
	}

	// 수정할 리뷰 가져와서 페이지 이동
	@RequestMapping("/my_review_update")
	public String my_review_update(@RequestParam("idx") int idx, Model model) {

		System.out.println("idx : " + idx);
		// write데이터베이스에서 해당 인덱스에 해당하는 상품평 정보를 가져옴
		WriteDTO review = wService.get_My_Rivew(idx);

		// 해당 상품평의 파일이름을 가져와서 my_review_update_ok에 전달하기 위해..
		// multipart/form-data request는 my_review_update_ok매핑에서 request.getparameter로
		// 가져올 수가 없다.
		// 따라서 세션에 저장해놓고 my_review_update_ok에서 가져다 쓰기위해
		session.setAttribute("w_filename", review.getW_filename());

		// 해당 상품평 정보를 전달
		model.addAttribute("review", review);

		// 리뷰 수정하는 페이지로 이동
		return "user/my_review_update";
	}

	// 리뷰 수정내용 업데이트
	@RequestMapping("/my_review_update_ok")
	public String my_review_update_ok(HttpServletRequest request) {
		// 일단 파일 업로드
		MultipartHttpServletRequest multi_Request = (MultipartHttpServletRequest) request;
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		String email = dto.getU_email();

		// 이전 파일이름
		String oldfilename = (String) session.getAttribute("w_filename");
		System.out.println("oldfilename : " + oldfilename);

		try {
			String path = request.getSession().getServletContext().getRealPath("/image/member/") + email + "/"
					+ oldfilename;
			File Folder = new File(path);
			if (Folder.exists()) {
				if (Folder.delete()) {
					System.out.println("파일삭제 성공");
				} else {
					System.out.println("파일삭제 실패");
				}
			} else {
				System.out.println("파일이 존재하지 않습니다.");
			}
			System.out.println(path);

			path = request.getSession().getServletContext().getRealPath("/image/member/") + email + "/";

			// image폴더 밑에 내 아이디로된 폴더에 파일을 올림
			MultipartFile file = multi_Request.getFile("filename");
			System.out.println("파일이름 :" + file.getOriginalFilename()); // ***.jpg 이런 방식

			File[] files = new File(path).listFiles(); // 기존 파일
			System.out.println("파일 목록 : " + files);

			String convertFileName = file.getOriginalFilename();
			if (files != null) {
				for (File oldFile : files) {

					// 해당 path에 있는 파일들을 하나씩 비교해서 내가 보낼 파일이랑 이름이 같으면
					System.out.println(oldFile.getName());
					System.out.println(convertFileName);
					if (oldFile.getName().equals(convertFileName)) {

						int dotIdx = oldFile.getName().indexOf(".");
						String format = oldFile.getName().substring(dotIdx);
						String fileName = oldFile.getName().substring(0, dotIdx);

						convertFileName = fileName + "1" + format;
					}
				}
				System.out.println(convertFileName);
			}

			file.transferTo(new File(path + convertFileName)); // 파일 저장

			int idx = Integer.parseInt(multi_Request.getParameter("idx"));
			int w_grade = Integer.parseInt(multi_Request.getParameter("w_grade"));
			String w_content = multi_Request.getParameter("w_content");
			String w_filename;
			if (multi_Request.getFile("filename") != null) {
				w_filename = multi_Request.getFile("filename").getOriginalFilename();
			} else {
				w_filename = "";
			}
			wService.update_my_review(idx, w_grade, w_content, w_filename);
			System.out.println("DB에 상품평 업로드 완료");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:my_review";
	}

	@RequestMapping("/my_review_delete")
	public String my_review_delete(HttpServletRequest request, @RequestParam("idx") int idx) {
		// 아이디 가져오기
		MemberDTO dto = (MemberDTO) session.getAttribute("dto");
		String u_email = dto.getU_email();

		// 해당 상품평의 인덱스 값을 가지고 상품평 정보를 가져옴
		WriteDTO review = wService.get_My_Rivew(idx);
		// 해당 상품평의 이미지 첨부파일 이름
		String w_filename = review.getW_filename();

		String path = request.getSession().getServletContext().getRealPath("/image/member/") + u_email + "/"
				+ w_filename;
		File Folder = new File(path);
		if (Folder.exists()) {
			if (Folder.delete()) {
				System.out.println("파일삭제 성공");
			} else {
				System.out.println("파일삭제 실패");
			}
		} else {
			System.out.println("파일이 존재하지 않습니다.");
		}
		System.out.println(path);

		// 파일 삭제후 DB작업
		wService.delete_my_review(idx);

		// 주문목록의 인덱스 why? 주문목록 페이지에서 해당하는 인덱스를 가져와서 상품평완료->배송완료로 설정
		int o_idx = review.getO_idx();
		System.out.println("o_idx : " + o_idx);

		// 상품평 다시 작성 할 수 있게
		// 상품평 쓰면 상품평완료->배송완료
		oService.reWrite_My_Order(o_idx);

		// 적립금 삭제
		// 상품평 삭제 시 500포인트 차감
		ptService.use_Point(u_email, 500);
		return "redirect:my_review";
	}

	@RequestMapping("/my_point")
	public String my_point(Model model, Criteria cri) {
		String p_email = ((MemberDTO) session.getAttribute("dto")).getU_email();
		// MEMBER DB에서 U_POINT 가져옴 현재 회원의 포인트
		int u_point = ptService.get_My_Remain_Point(p_email);
		// 내 아이디로된 포인트 적립,사용 목록
		cri.setPerPageNum(5);
		cri.setU_email(p_email);
		List<PointDTO> point = ptService.pointList(cri);

		
		PageMaker pageMaker = createPageMaker(cri, ptService.listCount(p_email));

		model.addAttribute("list", point);
		model.addAttribute("u_point", u_point);
		model.addAttribute("pageMaker", pageMaker);

		return "user/my_point";
	}

	// 길진
	@RequestMapping("/categories")
	public String categoies(HttpServletRequest request) {
		String category = request.getParameter("category");
		List<ProductDTO> productlist = pService.categoryProduct(category);

		request.setAttribute("category", category);
		request.setAttribute("categorylist", productlist);
		request.setAttribute("listcount", productlist.size());

		return "/product/categories";
	}

	// 길진
	@RequestMapping("/product/cart_delete")
	public String cart_delete(HttpServletRequest request) {

		MemberDTO user = (MemberDTO) session.getAttribute("dto");
		if (user == null) {
			return "../main";
		}

		String p_idx = request.getParameter("idx");

		int result_num = cService.deleteCart(Integer.parseInt(p_idx));

		if (result_num > 0) {
			System.out.println("삭제완료");
		} else {
			System.out.println("삭제실패");
		}
		return "redirect:cart";

	}

	// 길진
	@RequestMapping("/product/cart")
	public String cart(HttpServletRequest request) {

		MemberDTO user = (MemberDTO) session.getAttribute("dto");

		user = mService.idCheck(user.getU_email());

		if (user == null) {
			return "redirect:main";
		}

		List<CartDTO> cartlist = cService.listCart(user.getIdx());

		List<ProductDTO> p_dtolist = new ArrayList<ProductDTO>();

		for (CartDTO cart : cartlist) {
			p_dtolist.add(pService.viewProduct(Integer.toString(cart.getProduct_idx())));
		}

		HashSet<String> categories = new HashSet<String>();
		for (ProductDTO dto : p_dtolist) {
			categories.add(dto.getCategory());
		}

		request.setAttribute("cartlist", cartlist);
		request.setAttribute("p_dtolist", p_dtolist);
		request.setAttribute("categories", categories);

		return "/product/cart";
	}

	// 길진
	@RequestMapping("/product/payment")
	public String payment(HttpServletRequest request) {

		// 로그인한 상태에서 구매가능
		MemberDTO user = (MemberDTO) session.getAttribute("dto");
		if (user == null) {
			return "redirect:../login";
		}

		String price = request.getParameter("price").substring(0, request.getParameter("price").length() - 1);
		String delivery = request.getParameter("delivery").substring(0, request.getParameter("delivery").length() - 1);
		String pidxs = request.getParameter("pidxs");

		int total = Integer.parseInt(price) + Integer.parseInt(delivery);

		String referer = request.getHeader("Referer");
		System.out.println(referer.indexOf("product") + 8);
		System.out.println(referer.substring(referer.indexOf("product") + 8, referer.length()));
		String prePage = referer.substring(referer.indexOf("product") + 8, referer.length());
		if (!prePage.equals("cart")) {
			request.setAttribute("pidx", pidxs);
		} else {
			request.setAttribute("pidxs", pidxs);
		}

		// 유저의 남은 포인트 가져옴
		int remain_Point = ptService.get_My_Remain_Point(user.getU_email());

		request.setAttribute("remain_Point", remain_Point);
		request.setAttribute("price", price);
		request.setAttribute("delivery", delivery);
		request.setAttribute("total", total);

		return "/product/payment";
	}

	// 길진
	@RequestMapping("/payment_ok")
	public String paymentOk(HttpServletRequest request) {

		String orderName = request.getParameter("order-name");
		if (orderName == null || orderName.isEmpty()) {
			return "redirect:/product/payment";
		}

		String recipientName = request.getParameter("recipient-name");
		String recipientPhone = request.getParameter("recipient-phone");
		String recipientPostcode = request.getParameter("recipient_postcode");
		String recipientRoadAddress = request.getParameter("recipient_roadAddress");
		String recipientDetailAddress = request.getParameter("recipient_detailAddress");
		String recipientExtraAddress = request.getParameter("recipient_extraAddress");

		// 주소 : (우편번호) 주소 상세주소 참고사항
		String totalAddrres = "(" + recipientPostcode + ") " + recipientRoadAddress + " " + recipientDetailAddress
				+ recipientExtraAddress;

		// 주문번호 : 현재시간 년월일시분초 형식
		SimpleDateFormat format1 = new SimpleDateFormat("MMddHHmmss");
		String oNumber = format1.format(new Date());

		// 주문자의 CARTLIST 들고오기
		MemberDTO user = (MemberDTO) session.getAttribute("dto");
		List<CartDTO> listCart = cService.listCart(user.getIdx());

		// 카테고리
		List<String> categories = new ArrayList<>();

		// 장바구니에서 선택한 상품들 idx
		String pidxStr = request.getParameter("pidxs");
		// 총 상품 결제금액 (배송비 뺀)
		String p_total = request.getParameter("p_total");
		// 포인트
		String o_point = request.getParameter("u_point");
		System.out.println("가져온 포인트 : " + o_point);
		
		// 장바구니가 아닌경우
		if (pidxStr == null || pidxStr.isEmpty()) {

			System.out.println("상세페이지에서옴");
			pidxStr = request.getParameter("pidx");
			
			ProductDTO product = pService.viewProduct(pidxStr);
			Map<String, String> orderParam = new HashMap<>();
			int getPrice = Integer.parseInt(request.getParameter("price"));
			System.out.println("getPrice : " + getPrice);
			int count = getPrice / product.getP_discount_price();

			orderParam.put("O_NUMBER", oNumber);
			orderParam.put("O_ORDER", user.getU_email());
			orderParam.put("O_ORDERNAME", orderName);
			orderParam.put("O_RECIVER", recipientName);
			orderParam.put("O_TITLE", product.getP_name());
			orderParam.put("O_STATE", "배송준비");
			orderParam.put("O_COUNT", Integer.toString(count));
			orderParam.put("O_PRICE", Integer.toString(getPrice));
			orderParam.put("O_DLV_CHARGE", "3000");
			orderParam.put("O_ADDR", totalAddrres);
			orderParam.put("O_PHONE", recipientPhone);
			orderParam.put("O_POINT", o_point);
			orderParam.put("P_TOTAL", p_total);
			orderParam.put("P_FILENAME", product.getP_filename());

			for (String key : orderParam.keySet()) {
				System.out.println(key + ":" + orderParam.get(key));
				if( orderParam.get(key) == null || orderParam.get(key).isEmpty() ) {
					
				}
			}

			int ResultNum = oService.insert_My_Order(orderParam);
			if (ResultNum > 0) {
				System.out.println("넣기 성공");
			} else {
				System.out.println("넣기 실패");
			}

		} else {
			System.out.println("장바구니에서옴");

			String[] pidxs = pidxStr.split(",");
			List<String> pidxlist = new ArrayList<>(Arrays.asList(pidxs));
			// 카테고리 종류 갯수 구하기 위함.
	         for(CartDTO cart : listCart) {
	            // 카테고리 숫자 * 3000원이 배송비
	            ProductDTO product = pService.viewProduct(Integer.toString(cart.getProduct_idx()));
	            if (!categories.contains(product.getCategory())) {
	               categories.add(product.getCategory());
	            }
	         }
			
			
			for (CartDTO cart : listCart) {
				if (pidxlist.contains(Integer.toString(cart.getProduct_idx()))) {
					ProductDTO product = pService.viewProduct(Integer.toString(cart.getProduct_idx()));

					Map<String, String> orderParam = new HashMap<>();
					orderParam.put("O_NUMBER", oNumber);
					orderParam.put("O_ORDER", user.getU_email());
					orderParam.put("O_ORDERNAME", orderName);
					orderParam.put("O_RECIVER", recipientName);
					orderParam.put("O_TITLE", product.getP_name());
					orderParam.put("O_STATE", "배송준비");
					orderParam.put("O_COUNT", Integer.toString(cart.getProduct_count()));
					orderParam.put("O_PRICE",
							Integer.toString(product.getP_discount_price() * cart.getProduct_count()));
					orderParam.put("O_DLV_CHARGE", Integer.toString(categories.size() * 3000));
					orderParam.put("O_ADDR", totalAddrres);
					orderParam.put("O_PHONE", recipientPhone);
					// 사용포인트
					orderParam.put("O_POINT", o_point);
					// 상품의 결제금액 (배송비 노포함)
					orderParam.put("P_TOTAL", p_total);
					orderParam.put("P_FILENAME", product.getP_filename());

					for (String key : orderParam.keySet()) {
						System.out.println(key + ":" + orderParam.get(key));
					}

					// ORDERLIST에 값 넣기
					int ResultNum = oService.insert_My_Order(orderParam);
					// ORDERLIST에 값 넣은 후 CART 에서 삭제
					if (ResultNum > 0) {
						cService.deleteCart(product.getIdx());
					}
				}
			}
		}
		// 20200805
		String u_email = user.getU_email();
		int use_point = Integer.parseInt(o_point);
		System.out.println("사용한 아이디 : " + u_email);
		System.out.println("사용한 포인트 " + use_point);
		if (use_point > 0) {
			ptService.use_Point(u_email, use_point);
		}
		return "redirect:/product/payment_success";
	}

	@RequestMapping("/product/payment_success")
	public String paymentSuccess(HttpServletRequest request) {
		return "/product/payment_success";
	}

	@RequestMapping("/product/cart_ok")
	public String cartOk(HttpServletRequest request, RedirectAttributes rttr) {

		MemberDTO user = (MemberDTO) session.getAttribute("dto");

		if (user == null) {
			return "redirect:/login";
		}
		String p_idx = request.getParameter("idx");
		String p_count = request.getParameter("count");
		String message = "";

		List<CartDTO> cDtoList = cService.listCart(user.getIdx());
		for (CartDTO cDto : cDtoList) {
			// 장바구니에 담겨 있는 아이템은 수량만 늘리기
			if (Integer.parseInt(p_idx) == cDto.getProduct_idx()) {
				Map<String, Integer> map = new HashMap<>();
				map.put("count", Integer.parseInt(p_count) + cDto.getProduct_count());
				map.put("product_idx", Integer.parseInt(p_idx));
				int nResult = cService.updateCart(map);
				if (nResult > 0) {
					message = "해당 상품이 장바구니에 담겼습니다.";
				} else {
					message = "장바구니에 담기 실패";
				}
				rttr.addFlashAttribute("message", message);
				return "redirect:product_detail?idx=" + p_idx;
			}
		}

		Map<String, Integer> map = new HashMap<>();
		map.put("user_idx", user.getIdx());
		map.put("product_idx", Integer.parseInt(p_idx));
		map.put("product_count", Integer.parseInt(p_count));

		int nResult = cService.insertCart(map);
		if (nResult > 0) {
			message = "해당 상품이 장바구니에 담겼습니다.";
		} else {
			message = "장바구니에 담기 실패";
		}
		rttr.addFlashAttribute("message", message);
		return "redirect:product_detail?idx=" + p_idx;
	}

	// 20200803
	@RequestMapping("/my_pqna")
	public String my_pqna(Model model, Criteria cri) throws Exception {
		String q_email = ((MemberDTO) session.getAttribute("dto")).getU_email();

		cri.setU_email(q_email);
		List<Product_Qna_DTO> list = qService.product_My_Qna_List(cri);
		model.addAttribute("list", list);

		PageMaker pageMaker = createPageMaker(cri, qService.p_listCount(q_email));
		model.addAttribute("pageMaker", pageMaker);
		return "/user/my_pqna";
	}

	// 20200803
	@RequestMapping("/my_oqna")
	public String my_oqna(Model model, Criteria cri) throws Exception {

		// 로그인한 사용자 아이디 가져옴
		String oq_email = ((MemberDTO) session.getAttribute("dto")).getU_email();

		cri.setU_email(oq_email);
		System.out.println(cri);
		
		List<Order_Qna_DTO> list =  qService.order_My_Qna_List(cri);
		System.out.println( list );
		model.addAttribute("list", list);

		PageMaker pageMaker = createPageMaker(cri, qService.o_listCount(oq_email));

		model.addAttribute("pageMaker", pageMaker);
		return "/user/my_oqna";
	}

	// 상품문의 등록 페이지로 이동
	@RequestMapping("/Product_qna")
	public String qna(Model model, @RequestParam String p_name) {
		model.addAttribute("p_name", p_name);
		return "/qna/product_qna";
	}

	// 상품문의 등록 작업 수행
	@RequestMapping("/product_qna_ok")
	public String product_qna_ok(HttpServletRequest request) {
		String q_name = request.getParameter("q_name");
		String p_name = request.getParameter("p_name");
		String q_category = request.getParameter("q_category");
		String q_email = request.getParameter("q_email");
		String q_title = request.getParameter("q_title");
		String q_content = request.getParameter("q_content");

		qService.product_Qna_Insert(p_name, q_category, q_email, q_name, q_title, q_content);

		// 완료후 alert페이지로 이동
		return "/qna/qna_ok";
	}

	// 20200731
	@RequestMapping("/product_qna_detail")
	public String product_qna_detail(@RequestParam int idx, Model model) {
		Product_Qna_DTO qna_detatil = qService.product_Qna_Detail(idx);
		model.addAttribute("qna_detail", qna_detatil);
		return "/qna/product_qna_detail";
	}

	// 20200803
	// 업데이트
	@RequestMapping("/product_qna_update")
	public String product_qna_update(HttpServletRequest request) {
		System.out.println(request.getParameter("idx"));
		int idx = Integer.parseInt(request.getParameter("idx"));
		String q_title = request.getParameter("q_title");
		String q_content = request.getParameter("q_content");
		qService.update_Product_Qna(idx, q_title, q_content);
		return "/qna/qna_ok";
	}

	// 20200803
	// 삭제
	@RequestMapping("/product_qna_delete")
	public String product_qna_delete(HttpServletRequest request) {
		int idx = Integer.parseInt(request.getParameter("idx"));
		System.out.println(idx);
		qService.product_Qna_Delete(idx);
		return "/qna/qna_ok";
	}

	// 20200731
	@RequestMapping("/order_qna")
	public String order_qna(HttpServletRequest request, Model model) {
		System.out.println("들어옴");

		String o_number = request.getParameter("o_number");
		String oq_email = request.getParameter("oq_email");
		String oq_name = request.getParameter("oq_name");

		System.out.println(o_number);

		model.addAttribute("o_number", o_number);
		model.addAttribute("oq_email", oq_email);
		model.addAttribute("oq_name", oq_name);
		return "/qna/order_qna";
	}

	// 20200803
	@RequestMapping("/order_qna_ok")
	public String order_qna_ok(HttpServletRequest request) {
		String o_number = request.getParameter("o_number");
		String oq_category = request.getParameter("oq_category");
		String oq_name = request.getParameter("oq_name");
		String oq_email = request.getParameter("oq_email");
		String oq_title = request.getParameter("oq_title");
		String oq_content = request.getParameter("oq_content");

		qService.order_Qna_Insert(o_number, oq_category, oq_name, oq_email, oq_title, oq_content);

		// 완료후 alert페이지로 이동
		return "/qna/qna_ok";
	}

	// 20200803
	@RequestMapping("/order_qna_detail")
	public String order_qna_detail(@RequestParam int idx, Model model) {
		Order_Qna_DTO qna_detatil = qService.order_Qna_Detail(idx);
		System.out.println(qna_detatil);
		model.addAttribute("qna_detail", qna_detatil);
		return "/qna/order_qna_detail";
	}

	// 20200803
	// 업데이트
	@RequestMapping("/order_qna_update")
	public String order_qna_update(HttpServletRequest request) {
		int idx = Integer.parseInt(request.getParameter("idx"));
		String oq_title = request.getParameter("oq_title");
		String oq_content = request.getParameter("oq_content");
		qService.update_Order_Qna(idx, oq_title, oq_content);
		return "/qna/qna_ok";
	}

	// 20200803
	// 삭제
	@RequestMapping("/order_qna_delete")
	public String order_qna_delete(HttpServletRequest request) {
		int originno = Integer.parseInt(request.getParameter("originno"));
		System.out.println(originno);
		qService.order_qna_delete(originno);
		return "/qna/qna_ok";
	}
	
	//////////////////////////////// 관리자

	@RequestMapping("/admin/admin_info")
	public String adminInfo(HttpServletRequest request, Criteria cri) {

		List<OrderDTO> orderlist = oService.allSearch(cri);
		request.setAttribute("searchlist", orderlist);

		int listCount = oService.listCount(new HashMap<String, String>());
		PageMaker pageMaker = createPageMaker(cri, listCount);
		request.setAttribute("pageMaker", pageMaker);
		request.setAttribute("listCount", listCount);

		return "/admin/admin_info";
	}

	@RequestMapping("/admin/orderSearch")
	public String orderSearch(Criteria cri, HttpServletRequest request) {

		String attribute = request.getParameter("keywordCategory");
		String param = request.getParameter("keyword");

		String ready = request.getParameter("state0");
		String ing = request.getParameter("state1");
		String finish = request.getParameter("state2");

		Map<String, String> map = new HashMap<>();
		map.put("attribute", attribute);
		map.put("param", param);
		map.put("ready", ready);
		map.put("ing", ing);
		map.put("finish", finish);
		// 20200731
		List<OrderDTO> olist = oService.search_My_Order(map, cri);
		request.setAttribute("searchlist", olist);
		
		PageMaker pageMaker = createPageMaker(cri, oService.listCount(map));
		request.setAttribute("pageMaker", pageMaker);
		
		if (olist == null) {
			request.setAttribute("listCount", 0);
		} else {
			request.setAttribute("listCount", pageMaker.getTotalCount());
		}

		request.setAttribute("keyword", param);
		request.setAttribute("keywordCategory", attribute);
		return "/admin/admin_info";
	}

	@RequestMapping("/admin/stateChange")
	public String stateChange(HttpServletRequest request) {
		String state = request.getParameter("stateCategory");
		String checklist = request.getParameter("items");
		String[] idxs = checklist.split(",");
		for (int i = 0; i < idxs.length; i++) {
			oService.update_My_Order(state, Integer.parseInt(idxs[i]));
		}
		String message = "선택된 상품의 배송상태가 " + state + "(으)로 변경되었습니다.";
		request.setAttribute("message", message);
		return "/admin/admin_info";
	}

	@RequestMapping("/admin/product_write")
	public String adminProductWrite(HttpServletRequest request) {

		return "/admin/product_write";
	}

	@RequestMapping("/admin/product_write_upload")
	public String productWriteUpload(HttpServletRequest request) {
		String message = "";
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

			// 상품DB에 들어갈 정보들
			String productName = multipartRequest.getParameter("p_name");
			String price = multipartRequest.getParameter("p_price");
			String discount_ratio = multipartRequest.getParameter("p_discount_ratio");
			String discount_price = multipartRequest.getParameter("p_discount_price");
			String category = multipartRequest.getParameter("category");
			String weight = multipartRequest.getParameter("weight");
			String count = multipartRequest.getParameter("p_count");
			List<MultipartFile> mf = multipartRequest.getFiles("p_filename");
			MultipartFile mainFile = multipartRequest.getFile("p_file_main");

			LinkedHashMap<String, String> map = new LinkedHashMap<>();
			map.put("p_name", productName);
			map.put("p_price", price);
			map.put("p_discount_ratio", discount_ratio);
			map.put("p_discount_price", discount_price);
			map.put("category", category);
			map.put("weight", weight);
			map.put("p_count", count);
			map.put("special", "X");
			
			if ( mainFile.isEmpty() ) {
				map.put("p_filename", "");
			} else {
				int dotidx = mainFile.getOriginalFilename().indexOf(".");
				String format = mainFile.getOriginalFilename().substring(dotidx);
				String fileName = productName + format;
				map.put("p_filename", fileName);
			}
			map.put("p_content", ( mf.size() > 0 && !mf.get(0).getOriginalFilename().equals("") ) ? mf.toString() : "");

			// 값이 다 입력되어 있는지 체크
			for (String key : map.keySet()) {
				String value = (String) map.get(key);
				if (value == null || value.equals("")) {

					message = convertKey(key) + "을 입력해 주세요.";
					request.setAttribute("message", message);
					return "/admin/product_write";
				}
			}

			System.out.println("상품이름:" + productName);
			List<ProductDTO> p = pService.searchProductDao(productName);
			if (!productName.equals("") && p.size() > 0) {
				message = "이미 존재하는 상품명입니다";
				System.out.println(message);
				request.setAttribute("message", message);
				return "/admin/product_write";
			}

			// 상품 내용사진들이 저장될 위치
			String path = request.getSession().getServletContext()
					.getRealPath("/image/product/" + request.getParameter("p_name") + "/");
			
			// 상품 내용사진들이 저장될 폴더 생성
			createFolder(path);
			
			String contentFiles = "";
			for (int i = 0; i < mf.size(); i++) {
				// 본래 파일명
				String originalfileName = mf.get(i).getOriginalFilename();
				contentFiles = contentFiles + originalfileName + ",";
				String savePath = path + originalfileName; // 저장 될 파일 경로
				mf.get(i).transferTo(new File(savePath)); // 파일 저장
			}
			map.put("p_content", contentFiles);

			// 상품의 썸네일이미지가 저장될 위치
			path = path + "/Thumbnail/";

			// 상품의 썸네일이미지
			createFolder(path);

			String mainFileName = map.get("p_filename");
			// 상품의 썸네일이미지 저장
			mainFile.transferTo(new File(path + mainFileName));

			pService.writeProduct(map);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/";
	}

	@RequestMapping("/admin/product_management")
	public String adminProductManagement(HttpServletRequest request, Criteria cri) {
		List<ProductDTO> productlist = pService.listProduct(cri);
		request.setAttribute("productlist", productlist);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(pService.ProductCount());
		request.setAttribute("pageMaker", pageMaker);
		request.setAttribute("listCount", pService.ProductCount());

		return "/admin/product_management";
	}

	@RequestMapping("/admin/productSearch")
	public String productSearch(Criteria cri, HttpServletRequest request) {

		String keyword = request.getParameter("keyword");
		String keywordCategory = request.getParameter("keywordCategory");
		String category = request.getParameter("category");
		int totalCount = 0;
		if ((keyword == null || keyword == "") && (category == null || category == "")) {
			System.out.println("아무것도 검색안함");
			List<ProductDTO> productlist = pService.listProduct(cri);
			request.setAttribute("productlist", productlist);
			totalCount = pService.ProductCount();
		} else {
			System.out.println("뭐라도 검색함");
			Map<String, String> map = new HashMap<>();
			map.put("attribute", keywordCategory);
			map.put("param", keyword);
			map.put("category", category);
			List<ProductDTO> productlist = pService.searchProductManagement(map, cri);
			request.setAttribute("productlist", productlist);
			totalCount = productlist.size();
		}

		PageMaker pageMaker = createPageMaker(cri, totalCount);
		request.setAttribute("listCount", totalCount);
		request.setAttribute("pageMaker", pageMaker);
		return "/admin/product_management";
	}

	@RequestMapping("/admin/productDelete")
	public String productDelete(Criteria cri, HttpServletRequest request) {

		String productIdxs = request.getParameter("idx");
		String[] idxArr = productIdxs.split(",");
		for (String productIdx : idxArr) {

			// 파일들 삭제
			ProductDTO product = pService.viewProduct(productIdx);
			String path = request.getSession().getServletContext()
					.getRealPath("/image/product/" + product.getP_name() + "/Thumbnail/");
			File[] files = new File(path).listFiles();
			files[0].delete(); // 대표 이미지 삭제

			path = request.getSession().getServletContext().getRealPath("/image/product/" + product.getP_name() + "/");
			files = new File(path).listFiles();
			for (File file : files) { // 상품명 안에있던 파일들 전체 삭제
				file.delete();
			}
			File file = new File(path);
			file.delete(); // 상품명 폴더 삭제

			// DB 에서 삭제
			pService.deleteProductDao(productIdx);
		}

		// 기존에 검색했던리스트 다시 출력하기 위함.
		String keyword = request.getParameter("keyword");
		String keywordCategory = request.getParameter("keywordCategory");
		String category = request.getParameter("category");
		List<ProductDTO> productlist;
		int totalCount = 0;
		if ((keyword == null || keyword == "") && (category == null || category == "")) {
			productlist = pService.listProduct(cri);
			totalCount = pService.ProductCount();
		} else {
			Map<String, String> map = new HashMap<>();
			map.put("attribute", keywordCategory);
			map.put("param", keyword);
			map.put("category", category);
			productlist = pService.searchProductManagement(map, cri);
			totalCount = productlist.size();
		}

		PageMaker pageMaker = createPageMaker(cri, totalCount);
		request.setAttribute("productlist", productlist);
		request.setAttribute("listCount", totalCount);
		request.setAttribute("pageMaker", pageMaker);

		return "/admin/product_management";
	}

	@RequestMapping("/admin/product_Edit")
	public String productEdit(HttpServletRequest request) {
		String productIdx = request.getParameter("idx");
		ProductDTO product = pService.viewProduct(productIdx);

		Map<String, String> map = new HashMap<>();
		map.put("idx", productIdx);
		map.put("p_name", product.getP_name());
		map.put("p_price", Integer.toString(product.getP_price()));
		map.put("p_discount_ratio", Integer.toString(product.getP_discount_ratio()));
		map.put("p_discount_price", Integer.toString(product.getP_discount_price()));
		map.put("category", product.getCategory());
		map.put("weight", Integer.toString(product.getWeight()));
		map.put("p_count", Integer.toString(product.getP_count()));
		map.put("p_filename", product.getP_filename());
		map.put("special", product.getSpecial());

		request.setAttribute("product", map);
		return "/admin/product_Edit";
	}

	@RequestMapping("/admin/product_Edit_upload")
	public String productEditUpload(HttpServletRequest request, RedirectAttributes rttr) {
		String message = "";
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			String contentFiles = "";
			// 상품DB에 들어갈 정보들
			String idx = multipartRequest.getParameter("idx");
			String productName = multipartRequest.getParameter("p_name");
			String price = multipartRequest.getParameter("p_price");
			String discount_ratio = multipartRequest.getParameter("p_discount_ratio");
			String discount_price = multipartRequest.getParameter("p_discount_price");
			String category = multipartRequest.getParameter("category");
			String weight = multipartRequest.getParameter("weight");
			String count = multipartRequest.getParameter("p_count");
			String special = multipartRequest.getParameter("special");
			if (special == null || special.equals("")) {
				special = "X";
			}
			List<MultipartFile> mf = multipartRequest.getFiles("p_filename");
			MultipartFile mainFile = multipartRequest.getFile("p_file_main");
			ProductDTO product = pService.viewProduct(idx);
			LinkedHashMap<String, String> map = new LinkedHashMap<>();
			map.put("idx", idx);
			map.put("p_name", productName);
			map.put("p_price", price);
			map.put("p_discount_ratio", discount_ratio);
			map.put("p_discount_price", discount_price);
			map.put("category", category);
			map.put("weight", weight);
			map.put("p_count", count);
			map.put("special", special);
			map.put("p_filename", mainFile.isEmpty() ? "" : mainFile.getOriginalFilename());
			map.put("p_content", mf.size() > 0 && !mf.get(0).getOriginalFilename().equals("") ? mf.toString() : "");
			System.out.println(map.get("p_content"));
			System.out.println(mf.get(0).getOriginalFilename());

			// 값이 다 입력되어 있는지 체크
			for (String key : map.keySet()) {
				String value = (String) map.get(key);
				if (value == null || value.equals("")) {

					if (key.equals("p_filename")) {
						map.put("p_filename", product.getP_filename());
					} else if (key.equals("p_content")) {
						map.put("p_content", product.getP_content());
					} else {
						message = convertKey(key) + "을 입력해 주세요.";
						System.out.println("key:" + key);
						System.out.println(message);
						rttr.addFlashAttribute("message", message);
						return "redirect:/admin/product_Edit?idx=" + idx;
					}
				}
				System.out.println("key:" + key + ", value:" + value);
			}

			// 특가는 한개만 존재하게 함. 기존에 있는 특가상품을 특가상품해제 시킴
			if (map.get("special").equals("O")) {
				ProductDTO oldSpecial = pService.sepcialProduct();
				if (oldSpecial != null) {
					pService.specialUpdate("X", Integer.toString(oldSpecial.getIdx()));
				}
			}

			System.out.println("filename:" + map.get("p_filename") + "p_content:" + map.get("p_content"));
			// 상품명 중복체크
			System.out.println("상품이름:" + productName);
			List<ProductDTO> p = pService.searchProductDao(productName);
			if (!productName.equals("") && p.size() > 0 && !productName.equals(product.getP_name())) {
				message = "이미 존재하는 상품명입니다";
				System.out.println(message);
				rttr.addFlashAttribute("message", message);
				return "redirect:/admin/product_Edit?idx=" + idx;
			}

			// 상품 내용사진들이 저장될 위치
			String path = request.getSession().getServletContext()
					.getRealPath("/image/product/" + map.get("p_name") + "/");

			// 상품이름이 변경될 때
			if ( !product.getP_name().equals(map.get("p_name")) ) {
				//바뀐 상품이름으로 새폴더 생성
				createFolder(path);
				
				// 새로운 대표이미지를 넣었는가?
				if ( map.get("p_filename").equals(product.getP_filename()) ) {
					
					System.out.println("새로운 대표이미지 안넣음");

					// 1. 기존의 상품 폴더 경로에 있는 대표이미지를 새 상품 폴더에 이동
					// 2. 기존의 상품 폴더 삭제
					
					// 1. 기존의 상품 폴더 경로에 있는 대표이미지를 새 상품 폴더에 이동
					// 기존 폴더 경로
					String oldPath = request.getSession().getServletContext()
							.getRealPath("/image/product/" + product.getP_name() + "/Thumbnail/");
					// 기존 대표이미지
					File[] oldFiles = new File(oldPath).listFiles();
					
					for (File info : oldFiles) {
						// 새로운 폴더이름 경로에 썸네일폴더 생성
						path = request.getSession().getServletContext()
								.getRealPath("/image/product/" + map.get("p_name") + "/Thumbnail/");
						createFolder(path);
						
						// 기존 대표이미지 새로운 경로에 이동
						if (info.renameTo(new File(path + info.getName()))) {
							System.out.println("이동성공");
						} else {
							System.out.println("이동실패");
						}
					}
					//2. 기존의 상품 폴더 삭제
					File oldThunFolder = new File(oldPath);
					if (oldThunFolder.delete()) {
						System.out.println("예전 썸네일폴더 삭제");
					} else {
						System.out.println("예전 썸네일폴더 삭제실패");
					}
				}else {
					// 대표 이미지에 새로운 파일을 넣음
					
					// 1. 새로운 상품 폴더 생성 후 새로운 대표이미지 저장
					// 2. 기존의 대표이미지 삭제 후 기존의 상품 폴더 삭제

					
					// 1. 새로운 상품 폴더 생성 후 새로운 대표이미지 저장
					// 상품의 썸네일이미지가 저장될 위치
					path = path + "Thumbnail/";
					// 상품의 썸네일이미지 폴더 생성
					createFolder(path);

					String mainFileName = map.get("p_filename");
					// 상품의 썸네일이미지 저장
					mainFile.transferTo(new File(path + mainFileName));

					
					// 2. 기존의 대표이미지 삭제 후 기존의 상품 폴더 삭제
					// 기존의 상품 썸네일 이미지 삭제
					String oldPath = request.getSession().getServletContext()
							.getRealPath("/image/product/" + product.getP_name() + "/Thumbnail/");
					String oldFilePath = oldPath + product.getP_filename();
					File oldThumFile = new File(oldFilePath);
					if (oldThumFile.delete()) {
						System.out.println("예전 썸네일 파일 삭제성공");
					} else {
						System.out.println("예전 썸네일 파일 삭제실패");
					}
					// 기존의 상품 폴더 삭제
					File oldThunFolder = new File(oldPath);
					if (oldThunFolder.delete()) {
						System.out.println("예전 썸네일폴더 삭제");
					} else {
						System.out.println("예전 썸네일폴더 삭제실패");
					}
				}
				
				// 새로운 내용 이미지를 안넣었는가?
				if (map.get("p_content").equals(product.getP_content())) {
					
					// 1. 기존의 상품 내용 이미지 목록을 새로운 폴더 경로로 이동
					System.out.println("새로운 내용 안넣음");
					String oldPath = request.getSession().getServletContext()
							.getRealPath("/image/product/" + product.getP_name() + "/");
					// /product/image/기존상품이름/ 경로에있는 파일 리스트(썸네일폴더, 내용사진들)
					File[] oldFiles = new File(oldPath).listFiles();
					for (File info : oldFiles) {
						// 썸네일폴더 제외
						if (!info.getName().equals("Thumbnail")) {
							path = request.getSession().getServletContext()
									.getRealPath("/image/product/" + map.get("p_name") + "/");
							if (info.renameTo(new File(path + info.getName()))) {
								System.out.println("이동성공");
							} else {
								System.out.println("이동실패");
							}
						}
					}
				} else {
					
					// 새로운 내용을 넣음
					path = request.getSession().getServletContext()
							.getRealPath("/image/product/" + map.get("p_name") + "/");
					createFolder(path);
					contentFiles = "";
					for (int i = 0; i < mf.size(); i++) {
						// 본래 파일명
						String originalfileName = mf.get(i).getOriginalFilename();
						contentFiles = contentFiles + originalfileName + ",";
						System.out.println(originalfileName);
						String savePath = path + originalfileName; // 저장 될 파일 경로
						mf.get(i).transferTo(new File(savePath)); // 파일 저장
					}
					map.put("p_content", contentFiles);

					// 기존 내용파일 삭제
					String oldPath = request.getSession().getServletContext()
							.getRealPath("/image/product/" + product.getP_name() + "/");
					// /product/image/기존상품이름/ 경로에있는 파일 리스트(썸네일폴더, 내용사진들)
					File[] oldFiles = new File(oldPath).listFiles();
					for (File info : oldFiles) {
						if (!info.getName().equals("Thumbnail")) {
							if (info.delete()) {
								System.out.println("내용 파일 삭제 성공");
							} else {
								System.out.println("내용 파일 삭제 실패");
							}
						}
					}
				}
				
				// 기존에 있던 상품폴더 삭제
				String oldPath = request.getSession().getServletContext()
						.getRealPath("/image/product/" + product.getP_name());
				File oldFolder = new File(oldPath);
				if (oldFolder.delete()) {
					System.out.println("삭제성공");
				} else {
					System.out.println("삭제 실패");
				}
			} else {

				System.out.println("상품이름안바꿈");
				// 상품이름이 안바뀌었을때 부분
				// 1. 메인이미지 수정 x -> 할필요 없음
				// 2. 메인이미지 수정 o -> 기존이미지 삭제 후, 새로운 이미지 등록
				if (!map.get("p_filename").equals(product.getP_filename())) {
					path = request.getSession().getServletContext()
							.getRealPath("/image/product/" + product.getP_name() + "/Thumbnail/");
					File[] oldFiles = new File(path).listFiles();
					// 기존 이미지 삭제
					oldFiles[0].delete();
					// 새로운 이미지 넣기
					mainFile.transferTo(new File(path + map.get("p_filename")));
				}
				// 3. 내용이미지 수정 x -> 할필요 없음
				// 4. 내용이미지 수정 o -> 기존이미지 삭제 후, 새로운 이미지 등록
				if (!map.get("p_content").equals(product.getP_content())) {
					String oldPath = request.getSession().getServletContext()
							.getRealPath("/image/product/" + product.getP_name() + "/");
					File[] oldFiles = new File(oldPath).listFiles();
					for (File file : oldFiles) {
						file.delete();
					}

					// 새로 등록한 이미지들 등록
					for (int i = 0; i < mf.size(); i++) {
						// 본래 파일명
						String originalfileName = mf.get(i).getOriginalFilename();
						contentFiles = contentFiles + originalfileName + ",";
						System.out.println(originalfileName);
						String savePath = oldPath + originalfileName; // 저장 될 파일 경로
						mf.get(i).transferTo(new File(savePath)); // 파일 저장
					}
					map.put("p_content", contentFiles);
				}
			}
			pService.updateProduct(map);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/admin/product_management";
	}

	@RequestMapping("/admin/member_management")
	public String adminMemberManagement(HttpServletRequest request, Criteria cri) {

		Map<String, String> map = new HashMap<>();
		List<MemberDTO> memberlist = mService.list(cri, map);
		request.setAttribute("memberlist", memberlist);

		PageMaker pageMaker = createPageMaker(cri, mService.count());
		request.setAttribute("pageMaker", pageMaker);
		request.setAttribute("listCount", mService.count());

		return "/admin/member_management";
	}

	@RequestMapping("/admin/memberSearch")
	public String adminMemberSearch(HttpServletRequest request, Criteria cri) {

		String keyword = request.getParameter("keyword");
		String keywordCategory = request.getParameter("keywordCategory");
		Map<String, String> map = new HashMap<>();
		map.put("attribute", keywordCategory);
		map.put("param", keyword);

		int totalCount = 0;
		if (keyword == null || keyword == "") {
			System.out.println("아무것도 검색안함");
			List<MemberDTO> memberlist = mService.list(cri, map);
			request.setAttribute("memberlist", memberlist);
			totalCount = mService.count();
		} else {
			System.out.println("뭐라도 검색함");
			List<MemberDTO> memberlist = mService.list(cri, map);
			request.setAttribute("memberlist", memberlist);
			totalCount = memberlist.size();
		}

		PageMaker pageMaker = createPageMaker(cri, totalCount - 1);
		request.setAttribute("listCount", totalCount - 1);
		request.setAttribute("pageMaker", pageMaker);

		return "/admin/member_management";
	}

	@RequestMapping("/admin/memberDelete")
	public String memberDelete(Criteria cri, HttpServletRequest request) {

		String memberIdxs = request.getParameter("idx");
		String[] idxArr = memberIdxs.split(",");
		for (String memberIdx : idxArr) {
			// DB 에서 삭제
			MemberDTO member = mService.myInfo(memberIdx);
			String u_email = member.getU_email();
			ptService.delete(u_email);
			mService.delete(memberIdx);
		}

		// 기존에 검색했던리스트 다시 출력하기 위함.
		String keyword = request.getParameter("keyword");
		String keywordCategory = request.getParameter("keywordCategory");
		List<MemberDTO> memberlist;
		int totalCount = 0;
		if (keyword == null || keyword == "") {
			memberlist = mService.list(cri, new HashMap<String, String>());
			totalCount = mService.count();
		} else {
			Map<String, String> map = new HashMap<>();
			map.put("attribute", keywordCategory);
			map.put("param", keyword);
			memberlist = mService.list(cri, map);
			totalCount = memberlist.size();
		}

		PageMaker pageMaker = createPageMaker(cri, totalCount);
		request.setAttribute("memberlist", memberlist);
		request.setAttribute("listCount", totalCount - 1);
		request.setAttribute("pageMaker", pageMaker);

		return "/admin/member_management";
	}
	public Cookie deleteCookie(Cookie[] cookies, String cookieName) {
		
		for (int i = 0; i < cookies.length; i++) { // 쿠키 배열을 반복문으로 돌린다.
			if (cookies[i].getName().equals( cookieName )) {
				cookies[i].setMaxAge(0);
				return cookies[i];
			}
		}
		return null;
	}
	
	public PageMaker createPageMaker(Criteria cri, int totalSize) {
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalSize);
		return pageMaker;
	}

	public int createFolder(String path) {
		File Folder = new File(path);
		if (!Folder.exists()) {
			try {
				// 폴더가 존재하지 않으면 폴더생성
				Folder.mkdir();
				System.out.println("폴더가 생성되었습니다.");
				return 1;
			} catch (Exception e) {
				e.getStackTrace();
				return 0;
			}
		} else {
			// 폴더가 이미 존재하는 경우
			System.out.println("이미 폴더가 생성되어 있습니다.");
			return 0;
		}

	}

	public String convertKey(String key) {
		if (key.trim().equals("p_name")) {
			return "상품이름";
		} else if (key.equals("p_price")) {
			return "판매가";
		} else if (key.equals("p_discount_ratio")) {
			return "할인율";
		} else if (key.equals("category")) {
			return "카테고리";
		} else if (key.equals("weight")) {
			return "중량";
		} else if (key.equals("p_count")) {
			return "수량";
		} else if (key.equals("p_filename")) {
			return "대표이미지";
		} else if (key.equals("p_content")) {
			return "내용";
		} else {
			return "그 외의 것";
		}

	}
	
	@RequestMapping("/admin/product_qna")
	   public String adminProductQna(HttpServletRequest request, Criteria cri) {

	      int totalCount = 0;
	      List<Product_Qna_DTO> qnalist = qService.find_Qna_List(cri, new HashMap<String, String>());
	      request.setAttribute("qnalist", qnalist);
	      System.out.println( cri.getQuery() );
	      totalCount = qService.pna_listCount( "" );
	       
	      PageMaker pageMaker = createPageMaker(cri, totalCount);
	      request.setAttribute("listCount", totalCount);
	      request.setAttribute("pageMaker", pageMaker);
	      return "/admin/product_qna";
	   }
	   
	   @RequestMapping("/admin/productQnaSearch")
	   public String productQnaSearch(HttpServletRequest request, Criteria cri) {
	      String keyword = request.getParameter("keyword");
	      String keywordCategory = request.getParameter("keywordCategory");
	      String category = request.getParameter("category");
	      Map<String, String> map = new HashMap<>();
	      map.put("attribute", keywordCategory);
	      map.put("param", keyword);
	      map.put("category", category); 

	      int totalCount = 0;
	      List<Product_Qna_DTO> qnalist = qService.find_Qna_List(cri, map);
	      request.setAttribute("qnalist", qnalist);
	      System.out.println( cri.getQuery() );
	      totalCount = qService.pna_listCount( cri.getQuery() );
	      System.out.println("2:" + cri);
	      PageMaker pageMaker = createPageMaker(cri, totalCount);
	      request.setAttribute("listCount", totalCount);
	      request.setAttribute("pageMaker", pageMaker);
	      return "/admin/product_qna";
	   }
	   
	   @RequestMapping("/admin/product_qna_delete")
	   public String productQnaDelete(HttpServletRequest request, Criteria cri) {
	      String idx = request.getParameter("idx");
	      qService.product_admin_Qna_Delete(Integer.parseInt(idx));
	      return "redirect:/admin/product_qna";
	   }
	   
	   @RequestMapping("/admin/product_qna_re")
	   public String productQnaRe(HttpServletRequest request, Criteria cri) {
	      String idx = request.getParameter("idx");
	      Product_Qna_DTO qna_dto = qService.product_Qna_Detail( Integer.parseInt(idx) );
	      request.setAttribute("qnaitem", qna_dto);
	      return "/admin/product_qna_re";
	   }
	   @RequestMapping("/admin/product_qna_re_ok")
	   public String productQnaReOk(HttpServletRequest request, Criteria cri) {
		  
	      String idx = request.getParameter("idx");
	      String content = request.getParameter("re");
	      Product_Qna_DTO qna_dto = qService.product_Qna_Detail( Integer.parseInt(idx) );
	      
	      Map<String, String>map = new HashMap<>();
	      map.put("ORIGINNO", Integer.toString(qna_dto.getOriginNo()));
	      map.put("GROUPLAYER", "1");
	      map.put("GROUPORD", Integer.toString(qService.originNoCount( qna_dto.getOriginNo() )));
	      map.put("Q_CATEGORY", qna_dto.getQ_category());
	      map.put("Q_EMAIL", "admin");
	      map.put("Q_NAME", "관리자");
	      map.put("Q_TITLE", qna_dto.getQ_title());
	      map.put("Q_CONTENT", content);
	      map.put("P_NAME", qna_dto.getP_name());
	      
	      System.out.println( map );
	      int rNum = qService.product_qna_reply(map);
	      
	      request.setAttribute("result", rNum);
	      return "/admin/product_qna_re_ok";
	   }
	
	   ////////////오더 QnA
	   @RequestMapping("/admin/order_qna")
	   public String adminOrderQna(HttpServletRequest request, Criteria cri) {

	      int totalCount = 0;
	      List<Order_Qna_DTO> qnalist = qService.find_Qna_oList(cri, new HashMap<String, String>());
	      System.out.println(qnalist);
	      request.setAttribute("qnalist", qnalist);
	      System.out.println( cri.getQuery() );
	      totalCount = qService.pna_olistCount( "" );

	      PageMaker pageMaker = createPageMaker(cri, totalCount);
	      request.setAttribute("listCount", totalCount);
	      request.setAttribute("pageMaker", pageMaker);
	      return "/admin/order_qna";
	   }
	   
	   @RequestMapping("/admin/orderQnaSearch")
	   public String orderQnaSearch(HttpServletRequest request, Criteria cri) {

	      String keyword = request.getParameter("keyword");
	      String keywordCategory = request.getParameter("keywordCategory");
	      String category = request.getParameter("category");
	      Map<String, String> map = new HashMap<>();
	      map.put("attribute", keywordCategory);
	      map.put("param", keyword);
	      map.put("category", category); 

	      int totalCount = 0;
	      List<Order_Qna_DTO> qnalist = qService.find_Qna_oList(cri, map);
	      request.setAttribute("qnalist", qnalist);
	      System.out.println( cri.getQuery() );
	      totalCount = qService.pna_olistCount(cri.getQuery());

	      PageMaker pageMaker = createPageMaker(cri, totalCount);
	      request.setAttribute("listCount", totalCount);
	      request.setAttribute("pageMaker", pageMaker);
	      return "/admin/order_qna";
	   }
	   @RequestMapping("/admin/order_qna_delete")
	   public String orderQnaDelete(HttpServletRequest request, Criteria cri) {
		  System.out.println("order_qna_delete");
	      String idx = request.getParameter("idx");
	      qService.order_admin_Qna_Delete(Integer.parseInt(idx));
	      return "redirect:/admin/order_qna";
	   }
	   
	   @RequestMapping("/admin/order_qna_re")
	   public String orderQnaRe(HttpServletRequest request, Criteria cri) {
	      String idx = request.getParameter("idx");
	      Order_Qna_DTO qna_dto = qService.order_Qna_Detail(Integer.parseInt(idx));
	      request.setAttribute("qnaitem", qna_dto);
	      return "/admin/order_qna_re";
	   }
	   @RequestMapping("/admin/order_qna_re_ok")
	   public String orderQnaReOk(HttpServletRequest request, Criteria cri) {
	      String idx = request.getParameter("idx");
	      String content = request.getParameter("re");
	      Order_Qna_DTO qna_dto = qService.order_Qna_Detail(Integer.parseInt(idx));
	      
	      
	      Map<String, String>map = new HashMap<>();
	      map.put("ORIGINNO", Integer.toString(qna_dto.getOriginno()));
	      map.put("GROUPLAYER", "1");
	      map.put("GROUPORD", Integer.toString(qService.originNoCount( qna_dto.getOriginno())));
	      map.put("OQ_CATEGORY", qna_dto.getOq_category());
	      map.put("OQ_EMAIL", "admin");
	      map.put("OQ_NAME", "관리자");
	      map.put("OQ_TITLE", qna_dto.getOq_title());
	      map.put("OQ_CONTENT", content);
	      map.put("O_NUMBER", qna_dto.getO_number());
	      
	      	
	      System.out.println( map );
	      int rNum = qService.order_qna_reply(map);
	      
	      request.setAttribute("result", rNum);
	      return "/admin/order_qna_re_ok";
	   }
}
