<!-- 20200803 -->
<%@page import="com.study.springboot.dao.IOrderDAO"%>
<%@page import="org.apache.catalina.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>주문문의</title>
</head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="foodmarketForm.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
#cri {
	text-align: center;
}

#cri>ul {
	position: relative;
	left: 40px;
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
					<a href="../main"><img src="image/FoodMarket.jpg" alt=""></a>
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
					<th colspan="7" style="background-color: white; font-size: x-large; text-align: center">주문문의</th>
				</tr>
			</table>
			<div id="product-Qna-list">
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th class="text-center">문의내역</th>
							<th class="text-center">주문번호</th>
							<th class="text-center">작성자</th>
							<th class="text-center">제목</th>
							<th class="text-center">날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="O_Qna_List" items="${list}">
							<tr>
								<td>${O_Qna_List.oq_category }</td>
								<td>${O_Qna_List.o_number }</td>
								<td>${O_Qna_List.oq_name }(${O_Qna_List.oq_email })</td>
								<td><c:if test="${ O_Qna_List.groupLayer == 1 }">
										<img src="/image/re.jpg">
									</c:if> <a href="#" onclick="window.open('/order_qna_detail?idx=${O_Qna_List.idx }','_blank','width=700 ,height=800,location=no,status=no,scrollbars=yes');" style="text-decoration: none; color: #333333; font-weight: bold;">${O_Qna_List.oq_title }</a></td>
								<td>${O_Qna_List.oq_date }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div id="cri">
				<ul>
					<c:if test="${pageMaker.prev}">
						<li><a href="my_oqna${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
					</c:if>

					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						<c:choose>
							<c:when test="${idx == param.page}">
								<li><a class="pageNumber" href="my_oqna${pageMaker.makeQuery(idx)}" style="color: red">${idx}</a></li>
							</c:when>
							<c:when test="${idx != param.page}">
								<li><a class="pageNumber" href="my_oqna${pageMaker.makeQuery(idx)}">${idx}</a></li>
							</c:when>
						</c:choose>
					</c:forEach>

					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<li><a href="my_oqna${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
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