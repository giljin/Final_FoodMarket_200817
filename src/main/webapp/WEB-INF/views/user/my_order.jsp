<%@page import="com.study.springboot.dao.IOrderDAO"%>
<%@page import="org.apache.catalina.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>주문목록</title>
</head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="foodmarketForm.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
#first {
	border-bottom: 1px solid black;
}

table {
	border-width: 1px 0px;
	border-style: solid;
	border-color: #444444;
	margin-bottom: 20px;
}

th {
	width: 160px;
	text-align: center;
	background-color: gainsboro;
}

td {
	width: 160px;
	height: 100px;
	font-size: medium;
	text-align: center;
}

td>img {
	width: 100%;
	height: 100%;
	padding: 5px;
}

#cri {
	text-align: center;
}

#cri>ul {
	position: relative;
	left: 50px;
}

#cri>ul>li {
	margin-left: 10px;
	display: inline-block;
}
</style>
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
					<a href="main"><img src="image/FoodMarket.jpg" alt=""></a>
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
				<div>마이 페이지</div>
				<div class="my_page">
					<a href="my_order">주문내역</a>
				</div>
				<div class="my_page">
					<a href="my_review">상품평</a>
				</div>
				<div class="my_page">
					<a href="my_point">적립금</a>
				</div>
				<div class="my_page">
					<a href="my_info">내 정보 관리</a>
				</div>
				<div class="my_page">
					<a href="my_oqna">주문문의내역</a>
				</div>
				<div class="my_page">
					<a href="my_pqna">상품문의내역</a>
				</div>
			</div>
		</nav>
		<section>
			<table width="960px" style="border: 0;">
				<tr>
					<th colspan="7" style="background-color: white; font-size: x-large;">주문목록</th>
				</tr>
			</table>
			<c:forEach var="object" items="${list }">
				<table width="960px">
					<!-- 20200731 -->
					<!-- 20200803 -->
					<!-- 여기부터 수정시작해야함 -->
					<tr>
						<th colspan="1">주문일자 : ${object.get(0).o_date}</th>
						<th colspan="4">주문번호 : ${object.get(0).o_number}</th>
						<th colspan="1">
							<button type="button" class="btn btn-light" style="color: black;" onclick="window.open('/order_qna?o_number=${object.get(0).o_number}&oq_name=${object.get(0).o_ordername}&oq_email=${object.get(0).o_order}','window_name','width=700 ,height=800,location=no,status=no,scrollbars=yes');">주문문의</button>
						</th>
					</tr>
					<tr>
						<th colspan="1"></th>
						<th colspan="4">배송지 : ${object.get(0).o_addr}</th>
						<th colspan="1" style="text-align: right"><div>상품결제금액 : ${object.get(0).p_total}원</div>
							<div>배송비 : ${object.get(0).o_dlv_charge}원</div></th>
					</tr>
					<tr id="first">
						<th>&nbsp;</th>
						<th>상품명</th>
						<th>수량</th>
						<th>가격</th>
						<th colspan="2">상태</th>
					</tr>
					<c:forEach var="orderitem" items="${object}">
						<tr>
							<c:set var="o_state" value="${fn:trim(orderitem.o_state) }" />
							<td>
								<img src="../image/product/${orderitem.o_title }/Thumbnail/${orderitem.o_title }.jpg"" onerror="this.style.display='none'">
								<img src="../image/product/${orderitem.o_title }/Thumbnail/${orderitem.o_title }.png"" onerror="this.style.display='none'">
								<img src="../image/product/${orderitem.o_title }/Thumbnail/${orderitem.o_title }.jpeg"" onerror="this.style.display='none'">
							</td>
							<td>${orderitem.o_title }</td>
							<td>${orderitem.o_count}개</td>
							<td>${orderitem.o_price}원</td>
							<td>${o_state}</td>
							<c:choose>
								<c:when test="${o_state =='배송준비'}">
									<!--  20200731 -->
									<td>
										<button type="button" class="btn btn-light">
											<a href="/order_cancle?idx=${orderitem.idx }&o_price=${orderitem.o_price}&p_total=${orderitem.p_total}&o_number=${orderitem.o_number}&o_point=${orderitem.o_point}" style="color: black">주문취소</a>
										</button>
									</td>
								</c:when>
								<c:when test="${o_state == '배송완료' }">
									<td>
										<button type="button" class="btn btn-light">
											<a href="/review_write?idx=${orderitem.idx}&o_title=${orderitem.o_title}" style="color: black">상품평쓰기</a>
										</button>
									</td>
								</c:when>
								<c:otherwise>
									<td>&nbsp;</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</table>
			</c:forEach>
			<div id="cri">
				<ul>
					<c:if test="${pageMaker.prev}">
						<li><a href="my_order${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
					</c:if>

					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						<c:choose>
							<c:when test="${idx == param.page}">
								<li><a class="pageNumber" href="my_order${pageMaker.makeQuery(idx)}" style="color: red">${idx}</a></li>
							</c:when>
							<c:when test="${idx != param.page}">
								<li><a class="pageNumber" href="my_order${pageMaker.makeQuery(idx)}">${idx}</a></li>
							</c:when>
						</c:choose>
					</c:forEach>

					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<li><a href="my_order${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
					</c:if>
				</ul>
			</div>
		</section>
	</div>
	<script>
		$('.my_page').hover(function() {
			$(this).children('a').css("color", "red");
		}, function() {
			$(this).children('a').css("color", "black");
		});
	</script>
</body>
</html>