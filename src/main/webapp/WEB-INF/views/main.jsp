<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<link rel="stylesheet" href="main.css">
<link rel="stylesheet" href="css/jquery.bxslider.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<style>
.carousel-indicators  li {
	border: 1px solid #666;
}

.carousel-indicators .active {
	background: #666;
}
.main_category{
	color: black;
}
</style>
<body>
	<div id="wrap">
		<input type="hidden" id="message" value="${ message }">
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
				<div>전체 카테고리</div>
				<div><a class="main_category" href="/categories?category=한식">한식</a></div>
				<div><a class="main_category" href="/categories?category=일식">일식</a></div>
				<div><a class="main_category" href="/categories?category=양식">양식</a></div>
				<div><a class="main_category" href="/categories?category=중식">중식</a></div>
			</div>
			<ol id="menu">
				<li class="menu_list"><a href="/categories?category=한식">한식</a></li>
				<li class="menu_list"><a href="/categories?category=일식">일식</a></li>
				<li class="menu_list"><a href="/categories?category=양식">양식</a></li>
				<li class="menu_list"><a href="/categories?category=중식">중식</a></li>
			</ol>
			<div id="myCarousel" class="carousel slide" data-ride="carousel">
				<ol class="carousel-indicators">
					<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
					<li data-target="#myCarousel" data-slide-to="1"></li>
					<li data-target="#myCarousel" data-slide-to="2"></li>
				</ol>

				<!-- Carousel items -->

				<div class="carousel-inner">
					<div class="item active">
						<img src="image/Food1.jpg" alt="First slide">
					</div>
					<div class="item">
						<img src="image/Food2.jpg" alt="Second slide">
					</div>
					<div class="item">
						<img src="image/Food3.jpg" alt="Third slide">
					</div>
				</div>
			</div>
		</nav>
		<section>
			<article>
				<div id="special_title">특가 세일</div>
				<div id="special">
					<div id="special_image">
						<a href="/product/product_detail?idx=${ special.idx }"><img src="../image/product/${ special.p_name }/Thumbnail/${ special.p_filename}"></a>
					</div>
					<div id="special_content">
						<div id="special_name" style="font-weight: bolder; font-size: large;">${ special.p_name }</div>
						<div id="special_price" style="font-size: small;">
							<label class="price_nodiscount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${ special.p_discount_price }" />원</label> <label class="price_discount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${ special.p_price }" />원</label> <label class="price_ratio">${ special.p_discount_ratio }%</label>
						</div>
					</div>
				</div>
			</article>
		</section>
		<section class="content">
			<main>
				<div class="recomend_title">한식 추천 상품</div>
				<div id="korea_food">
					<ul class="product_list">
						<c:forEach items="${ krlist }" var="krProduct" begin="0" step="1" end="3">
							<li>
								<dl>
									<dt>
										<a href="/product/product_detail?idx=${ krProduct.idx }">${ krProduct.p_name }</a>
									</dt>
									<dd class="img">
										<a href="/product/product_detail?idx=${ krProduct.idx }"><img src="../image/product/${ krProduct.p_name }/Thumbnail/${ krProduct.p_filename}"></a>
									</dd>
									<dd class="price">
										<label class="price_nodiscount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${ krProduct.p_discount_price }" />원</label> <label class="price_discount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${ krProduct.p_price }" />원</label> <label class="price_ratio">${ krProduct.p_discount_ratio }%</label>
									</dd>
								</dl>
							</li>
						</c:forEach>
					</ul>
				</div>
				<div class="recomend_title">일식 추천 상품</div>
				<div id="japanese_food">
					<ul class="product_list">
						<c:forEach items="${ jplist }" var="jpProduct" begin="0" step="1" end="3">
							<li>
								<dl>
									<dt>
										<a href="/product/product_detail?idx=${ jpProduct.idx }">${ jpProduct.p_name }</a>
									</dt>
									<dd class="img">
										<a href="/product/product_detail?idx=${ jpProduct.idx }"><img src="../image/product/${ jpProduct.p_name }/Thumbnail/${ jpProduct.p_filename}"></a>
									</dd>
									<dd class="price">
										<label class="price_nodiscount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${ jpProduct.p_discount_price }" />원</label> <label class="price_discount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${ jpProduct.p_price }" />원</label> <label class="price_ratio">${ jpProduct.p_discount_ratio }%</label>
									</dd>
								</dl>
							</li>
						</c:forEach>
					</ul>
				</div>
				<div class="recomend_title">중식 추천 상품</div>
				<div id="chinese_food">
					<ul class="product_list">
						<c:forEach items="${ chlist }" var="chProduct" begin="0" step="1" end="3">
							<li>
								<dl>
									<dt>
										<a href="/product/product_detail?idx=${ chProduct.idx }">${ chProduct.p_name }</a>
									</dt>
									<dd class="img">
										<a href="/product/product_detail?idx=${ chProduct.idx }"><img src="../image/product/${ chProduct.p_name }/Thumbnail/${ chProduct.p_filename}"></a>
									</dd>
									<dd class="price">
										<label class="price_nodiscount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${ chProduct.p_discount_price }" />원</label> <label class="price_discount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${ chProduct.p_price }" />원</label> <label class="price_ratio">${ chProduct.p_discount_ratio }%</label>
									</dd>
								</dl>
							</li>
						</c:forEach>
					</ul>
				</div>
				<div class="recomend_title">양식 추천 상품</div>
				<div id="chinese_food">
					<ul class="product_list">
						<c:forEach items="${ enlist }" var="enProduct" begin="0" step="1" end="3">
							<li>
								<dl>
									<dt>
										<a href="/product/product_detail?idx=${ enProduct.idx }">${ enProduct.p_name }</a>
									</dt>
									<dd class="img">
										<a href="/product/product_detail?idx=${ enProduct.idx }"><img src="../image/product/${ enProduct.p_name }/Thumbnail/${ enProduct.p_filename}"></a>
									</dd>
									<dd class="price">
										<label class="price_nodiscount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${ enProduct.p_discount_price }" />원</label> <label class="price_discount"><fmt:formatNumber type="number" maxFractionDigits="3" value="${ enProduct.p_price }" />원</label> <label class="price_ratio">${ enProduct.p_discount_ratio }%</label>
									</dd>
								</dl>
							</li>
						</c:forEach>
					</ul>
				</div>
			</main>
			<aside></aside>
		</section>
		<div class="recomend_title">베스트 후기</div>
		<div class="bxslider">
			<div>
				<c:forEach items="${ bestWrites }" var="bestWrite">
					<div class="review">
						<c:if test="${ bestWrite.w_filename != null }">
							<img class="review_image" src="../image/member/${ bestWrite.w_email }/${ bestWrite.w_filename }" alt="리뷰사진">
						</c:if>
						<div class="review_content_box">
							<div class="review_title">
								<h3>${ bestWrite.w_title }</h3>
							</div>
							<div class="review_star_ratio">
								<c:if test="${ bestWrite.w_grade == 5 }">
                     ★★★★★
                  </c:if>
								<c:if test="${ bestWrite.w_grade == 4 }">
                     ★★★★☆
                  </c:if>
								<c:if test="${ bestWrite.w_grade == 3 }">
                     ★★★☆☆
                  </c:if>
								<c:if test="${ bestWrite.w_grade == 2 }">
                     ★★☆☆☆
                  </c:if>
								<c:if test="${ bestWrite.w_grade == 1 }">
                     ★☆☆☆☆
                  </c:if>
							</div>
							<div class="review_content">
								<label>${ bestWrite.w_content }</label>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<div>
				<c:forEach items="${ bestWrites2 }" var="bestWrite">
					<div class="review">
						<c:if test="${ bestWrite.w_filename != null }">
							<img class="review_image" src="../image/member/${ bestWrite.w_email }/${ bestWrite.w_filename }" alt="리뷰사진">
						</c:if>
						<div class="review_content_box">
							<div class="review_title">
								<h3>${ bestWrite.w_title }</h3>
							</div>
							<div class="review_star_ratio">
								<c:if test="${ bestWrite.w_grade == 5 }">
                     ★★★★★
                  </c:if>
								<c:if test="${ bestWrite.w_grade == 4 }">
                     ★★★★☆
                  </c:if>
								<c:if test="${ bestWrite.w_grade == 3 }">
                     ★★★☆☆
                  </c:if>
								<c:if test="${ bestWrite.w_grade == 2 }">
                     ★★☆☆☆
                  </c:if>
								<c:if test="${ bestWrite.w_grade == 1 }">
                     ★☆☆☆☆
                  </c:if>
							</div>
							<div class="review_content">
								<label>${ bestWrite.w_content }</label>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
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
	<script src="js/jquery-2.2.4.min.js"></script>
	<script src="js/jquery.bxslider.js"></script>
	<script>
        $(function(){
            $('.bxslider').bxSlider({
                slideWidth: 960,
                captions: false, //주석 
                auto: true, //자동재생
                autoControls: false,  //Start/Stop 버튼 사용
                stopAutoOnClick: true,
                mode: "horizontal", //vertical, fade 전환효과
                speed: 500, //슬라이딩 속도
                adaptiveHeight: false, //이미지 높이에 따라 슬라이드 높이 결정
                touchEnabled: true, //터치 스와이프 사용 결정
                controls: true, //Prev/Next 버튼 사용 여부
                prevText: "Prev", //이전버튼 문구
                nextText: "Next", //다음버튼 문구
                autoHover: false //마우스 올리면 일시 정지 
            });
        });
    </script>
	<script>
       $('.menu_list').hover(function() {
       $(this).css("background-color", "#fff");
       $(this).children('a').css("color","black");
       }, function(){
       $(this).css("background-color", "rgba(38, 38, 38, -0.3)");
       $(this).children('a').css("color","#fff");
       });
   </script>
	<script>
       var message = $("#message").val();
       if( message != "" ){
           alert(message);
       }
   </script>
</body>
</html>