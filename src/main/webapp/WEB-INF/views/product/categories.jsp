<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${ category }</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/foodmarketForm.css">
<link rel="stylesheet" href="/search.css">
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
					<a href="../main"><img src="image/FoodMarket.jpg" alt=""></a>
				</div>
				<div id="search">
					<div id="search_bar">
						<form action="/product/search">
							<input type="text" name="search" />
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
			<div id="search-header">
				<h2>${ category }</h2>
			</div>
			<div id="search-item-count">총 ${ listcount } 개</div>
			<div id="search-list">
				<c:forEach items="${ categorylist }" var="product">
					<div class="searchCard">
						<a href="/product/product_detail?idx=${ product.idx }"><img alt="상품이미지" src="../image/product/${ product.p_name }/Thumbnail/${ product.p_filename }"></a>
						<div class="search-name">${ product.p_name }</div>
						<div class="price">
							<label class="price_nodiscount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${ product.p_discount_price }" />원</label> <label class="price_discount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${ product.p_price }" />원</label> <label class="price_ratio">${ product.p_discount_ratio }%</label>
						</div>
					</div>
				</c:forEach>
			</div>
		</section>
		<hr>
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
					<li>GitHub : cs@wingeat.com</li>
					<li>© Agreable, Inc., All rights reserved.</li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>