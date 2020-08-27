<%@page import="com.study.springboot.dao.IOrderDAO"%>
<%@page import="org.apache.catalina.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>적립금</title>
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
	border-top: 1px solid black;
}

.star_rating {
	font-size: 0;
	letter-spacing: -4px;
}

.star_rating a {
	font-size: 22px;
	letter-spacing: 0;
	display: inline-block;
	margin-left: 5px;
	color: #ccc;
	text-decoration: none;
}

.star_rating a:first-child {
	margin-left: 0;
}

.star_rating a.on {
	color: #777;
}

table {
	margin-bottom: 20px;
}

td {
	height: 100px;
	font-size: medium;
	text-align: center;
}

tr {
	border-bottom: 1px solid #d9d9d9;
}

th {
	text-align: center;
	height: 50px;
}

td>img {
	width: 76%;
	margin: 9px;
	height: 100%;
}

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

#filename {
	position: relative;
	left: 30%;
	bottom: 4%;
}

button {
	margin-left: 4px;
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
				<tr style="border-bottom: 0px">
					<th colspan="7" style="background-color: white; font-size: x-large;">나의포인트</th>
				</tr>
				<tr style="border-bottom: 0px">
					<td style="font-size: large; color: darkorange; height: 50px;">${u_point}P</td>
				</tr>
			</table>
			<form action="write_upload" method="post" enctype="multipart/form-data">
				<table width="960px">
					<tr id="first">
						<th width="25%">사용일자</th>
						<th width="25%">사용금액</th>
						<th width="25%">적립금액</th>
						<th width="25%">남은금액</th>
					</tr>
					<c:forEach var="point" items="${list}">
						<tr>
							<td>${ point.p_date }</td>
							<td style="color: red">${point.use_point }P</td>
							<td style="color: blue">${point.get_point }P</td>
							<td style="color: darkorange">${point.remain_point }P</td>
						</tr>
					</c:forEach>
				</table>
			</form>
			<div id="cri">
				<ul>
					<c:if test="${pageMaker.prev}">
						<li><a href="my_point${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
					</c:if>

					<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
						<c:choose>
							<c:when test="${idx == param.page}">
								<li><a class="pageNumber" href="my_point${pageMaker.makeQuery(idx)}" style="color: red">${idx}</a></li>
							</c:when>
							<c:when test="${idx != param.page}">
								<li><a class="pageNumber" href="my_point${pageMaker.makeQuery(idx)}">${idx}</a></li>
							</c:when>
						</c:choose>
					</c:forEach>

					<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
						<li><a href="my_review${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
					</c:if>
				</ul>
			</div>
		</section>
	</div>
	1
	<script>
		$('.my_page').hover(function() {
			$(this).children('a').css("color", "red");
		}, function() {
			$(this).children('a').css("color", "black");
		});
	</script>
</body>
</html>