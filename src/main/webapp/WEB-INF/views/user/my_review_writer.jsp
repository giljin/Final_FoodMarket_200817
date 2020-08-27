<%@page import="com.study.springboot.dao.IOrderDAO"%>
<%@page import="org.apache.catalina.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품평 쓰기</title>
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

td {
	width: 150px;
	height: 100px;
	font-size: medium;
	text-align: center;
}

th {
	text-align: center;
	height: 50px;
}

#filename {
	position: relative;
	left: 30%;
	bottom: 4%;
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
			<form action="write_upload" method="post" enctype="multipart/form-data">
				<input type="hidden" name="w_title" value="${w_title }">
				<!-- 주문목록 인덱스 -->
				<input type="hidden" name="o_idx" value="${o_idx }"> <input type="hidden" id="w_grade" name="w_grade" value="0">
				<table width="960px">
					<tr>
						<td>상품명</td>
						<td>${w_title}</td>
					</tr>
					<tr>
						<td>이름</td>
						<td>${w_name}</td>
					</tr>
					<tr>
						<td>별점</td>
						<td>
							<p class="star_rating">
								<a href="#" value="1">★</a> <a href="#" value="2">★</a> <a href="#" value="3">★</a> <a href="#" value="4">★</a> <a href="#" value="5">★</a>
							</p>
						</td>
					</tr>
					<tr>
						<td>첨부파일</td>
						<td><input type="file" id="filename" name="filename" accept="image/png, image/jpeg"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea name="w_content" rows="15" cols="50" placeholder="내용을 입력하세요"></textarea></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><input type="submit" style="width: 20%">
						<td>
					</tr>
				</table>
			</form>
		</section>
	</div>

	<script>
		$('.my_page').hover(function() {
			$(this).children('a').css("color", "red");
		}, function() {
			$(this).children('a').css("color", "black");
		});

		$(".star_rating a").click(function() {
			$(this).parent().children("a").removeClass("on");
			$(this).addClass("on").prevAll("a").addClass("on");
			var value = $(this).attr('value');
			$("#w_grade").attr('value', value);
		});
	</script>
</body>
</html>