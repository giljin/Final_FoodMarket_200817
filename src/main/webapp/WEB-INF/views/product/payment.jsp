<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문하기</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/foodmarketForm.css">
<link rel="stylesheet" href="/payment.css">
</head>
<body>
	<div id="wrap">
		<header>
			<div id="header_top">
				<ul>
					<c:if test="${ dto == null }">
						<li><a href="../login">로그인</a></li>
						<li><a href="../join">회원가입</a></li>
					</c:if>
					<c:if test="${ dto != null }">

						<c:if test="${ dto.u_email == 'admin' }">
							<li><a href="/admin/admin_info">관리자페이지</a></li>
						</c:if>

						<c:if test="${ dto.u_email != 'admin' }">
							<li><a href="/product/cart">장바구니</a></li>
							<li><a href="/my_order">마이페이지</a></li>
						</c:if>
						<li><a href="../logout">로그아웃</a></li>
					</c:if>
				</ul>
			</div>
			<div id="header_mid">
				<div id="logo">
					<a href="../main"><img src="/image/FoodMarket.jpg" alt=""></a>
				</div>
				<div id="search">
					<div id="search_bar">
						<form action="/product/search">
							<input name="search" type="text" />
							<button id="search_image" type="submit"></button>
						</form>

					</div>
				</div>
			</div>
		</header>
		<nav>
			<div id="category">
				<div>
					전체 카테고리
					<ol id="menu">
						<li class="menu_list"><a href="/categories?category=한식">한식</a></li>
						<li class="menu_list"><a href="/categories?category=일식">일식</a></li>
						<li class="menu_list"><a href="/categories?category=양식">양식</a></li>
						<li class="menu_list"><a href="/categories?category=중식">중식</a></li>
					</ol>
				</div>
				<div><a class="main_category" href="/categories?category=한식">한식</a></div>
				<div><a class="main_category" href="/categories?category=일식">일식</a></div>
				<div><a class="main_category" href="/categories?category=양식">양식</a></div>
				<div><a class="main_category" href="/categories?category=중식">중식</a></div>
			</div>
		</nav>
		<section>
			<form action="/payment_ok?pidxs=${ pidxs }&price=${price }&pidx=${ pidx }" method="post">
				<div id="step">
					<div id="step-cart">장바구니</div>
					<div class="step-right">></div>
					<div id="step-buy">주문하기</div>
					<div class="step-right">></div>
					<div id="step-finish">주문완료</div>
				</div>
				<h1 id="section-header">주문하기</h1>
				<div id="payment-items">
					<div id="order-form" class="bd-lg">
						<h3>주문자</h3>
						<div class="order-field">
							<label>이름</label>
							<div id="name" class="order-inputs">
								<input id="order-name" class="bd-lg" type="text" name="order-name" placeholder="${dto.u_name}" value="${dto.u_name}" readonly="readonly">
							</div>
						</div>
						<div class="order-field">
							<label>연락처</label>
							<div id="phone" class="order-inputs">
								<input id="order-phone" class="bd-lg" type="text" name="order-phone" placeholder="${dto.u_phone }" value="${dto.u_phone}" readonly="readonly">
							</div>
						</div>
						<div class="order-field">
							<label>이메일</label>
							<div id="email" class="order-inputs">
								<input id="order-email" class="bd-lg" type="text" name="order-email" placeholder="${dto.u_email }" value="${dto.u_email}" readonly="readonly">
							</div>
						</div>
					</div>

					<div id="recipient-form" class="bd-lg">
						<h3>받는 사람</h3>
						<input type="button" onclick="dataLoad()" value="주문자 정보와 동일">
						<div class="recipient-field">
							<label>이름</label>
							<div class="recipient-inputs">
								<input id="recipient-name" class="bd-lg" type="text" name="recipient-name" placeholder="이름">
							</div>
						</div>
						<div class="recipient-field">
							<label>연락처</label>
							<div class="recipient-inputs">
								<input id="recipient-phone" class="bd-lg" type="text" name="recipient-phone" placeholder="연락처">
							</div>
						</div>
						<div class="recipient-field">
							<label>주소</label>
						</div>
						<div class="recipient-field">
							<input type="text" id="recipient_postcode" class="recipient_input" name="recipient_postcode" placeholder="우편번호" readonly /> <input type="button" id="recipient_btn" onclick="recipient_execDaumPostcode()" value="주소 찾기"><br>
						</div>
						<div class="recipient-field">
							<input type="text" id="recipient_address" name="recipient_roadAddress" class="recipient_input" placeholder="주소" readonly />
						</div>
						<div class="recipient-field">
							<input type="text" id="recipient_detailAddress" name="recipient_detailAddress" placeholder="상세주소"> <input type="text" id="recipient_extraAddress" name="recipient_extraAddress" class="recipient_input" placeholder="참고항목" readonly />
						</div>

					</div>
				</div>
				<div id="payment-cash">
					<div id="cash-info">
						<!-- 전송할 데이터 -->
						<input id="p_total" name="p_total" type="hidden" value="${price}"> <input id="u_point" name="u_point" type="hidden" value="0">

						<div id="info-header">결제 정보</div>
						<div class="info-title">총 상품 금액</div>
						<div id="o_price" class="info-content">${ price }원</div>
						<div class="info-title">총 배송비</div>
						<div class="info-content">${ delivery }원</div>
						<div class="info-title">포인트사용(보유: ${remain_Point })</div>
						<div style="margin-bottom: 10px">
							<input type="text" id="point" class="form-control input-sm" style="width: 61%; display: inline-block;">
							<button type="button" onclick="point_use()" class="btn-info btn-sm">사용</button>
							<button type="reset" onclick="back()" class="btn-info btn-sm">다시입력</button>
						</div>
						<div id="info-total-price" class="bg-gray">
							<div id="info-total-title">결제 예정 금액</div>
							<div id="info-total-content">${ total }원</div>
						</div>
						<div id="btns">
							<input type="submit" class="btn buy" value="결제하기">
						</div>
					</div>
				</div>
			</form>
		</section>


		<div id="footer">
			<div id="footer_header">
				<div id="footer_header_title">
					<h3>고객센터 0000-0000</h3>
				</div>
				<div id="footer_header_content">평일 | 오전 9시 ~ 오후 6시, 점심시간 | 오후12시~오후1시</div>
			</div>
			<hr>
			<div class="footer_child">
				<ul>
					<li>제작자 : 조지성, 조신형, 나길진</li>
					<li>포트폴리오</li>
				</ul>
			</div>
			<div class="footer_child">
				<ul>
					<li>GitHub : xx@github.com</li>
					<li>© Agreable, Inc., All rights reserved.</li>
				</ul>
			</div>
		</div>
	</div>
	<script src="/webjars/jquery/3.4.1/jquery.min.js"></script>
	<script src="/webjars/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
    function recipient_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("recipient_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("recipient_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('recipient_postcode').value = data.zonecode;
                document.getElementById("recipient_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("recipient_detailAddress").focus();
            }
        }).open();
    }
	</script>
	<script>
	function dataLoad(){
		$("#recipient-name").val( $("#order-name").val() );
		$("#recipient-phone").val( $("#order-phone").val() );
	}
	</script>

	<script type="text/javascript">
		/* 정수만입력 */
		$("#point").keyup( function(){ $(this).val( $(this).val().replace(/[^0-9]/gi,"") ); } );
	</script>

	<script type="text/javascript">
	function point_use(){
		//사용포인트
		var point = $('#point').val();
		//가진포인트
		var remain_Point = ${ remain_Point };
		/*상품 금액과 총결재 금액을 가져옴*/
		var price = Number(${price});
		var	total = Number(${total});
		
		if(point > remain_Point || point > price){
			/* 가진 포인트보다 많은 금액을 입력한 경우 */
			alert("다시 입력하세요");
		}else{
			//버튼 클릭시 수정
	 		$('#o_price').text(price-point+"원");
			$('#info-total-content').text(total-point+"원");
			/* 전송할 데이터를 넣어줌  */
			$('#p_total').val(price-point);
			$('#u_point').val(point);
		}
	}
	
	function back(){
		var o_price = ${price};
		var o_total = ${total};
 		$('#o_price').text(o_price+"원");
		$('#info-total-content').text(o_total+"원");
	}
	</script>
</body>
</html>