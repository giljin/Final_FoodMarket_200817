<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/foodmarketForm.css">
<link rel="stylesheet" href="/cart.css">
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
			<div id="step">
				<div id="step-cart">장바구니</div>
				<div class="step-right">></div>
				<div id="step-buy">주문하기</div>
				<div class="step-right">></div>
				<div id="step-finish">주문완료</div>
			</div>
			<h1 id="section-header">장바구니</h1>
			<div id="cart-items">
				<div id="all-check">
					<input type="checkbox" name="checkAll">전체 선택
				</div>

				<%-- 카테고리별 박스 --%>
				<c:forEach items="${ categories }" var="category">
					<div class="category-frame">
						<div class="card-category bg-gray">${ category }</div>

						<%-- 상품별 카드 --%>
						<c:forEach items="${ p_dtolist }" var="p_dto">
							<c:if test="${ p_dto.category == category }">
								<div class="card-content ">
									<div>
										<div class="product-name">
											<input type="checkbox" name="checkOne">${ p_dto.p_name } <input type="hidden" class="productIdx" value="${ p_dto.idx }">
										</div>
										<div class="cartlist-delete">
											<a href="cart_delete?idx=${ p_dto.idx }">x</a>
										</div>
									</div>
									<div class="card-option">
										<img class="product-image" alt="상품이미지" src="../image/product/${ p_dto.p_name }/Thumbnail/${ p_dto.p_filename}">
										<div class="product-price">${ p_dto.p_discount_price }</div>
										<c:forEach items="${ cartlist }" var="cartItem">
											<c:if test="${ p_dto.idx == cartItem.product_idx }">
												<span class="product-count">${ cartItem.product_count }</span>
												<span>개</span>
											</c:if>
										</c:forEach>
									</div>
								</div>
							</c:if>
						</c:forEach>

						<div class="card-total bg-gray">
							<div class="card-total-content">
								<div class="total-title">상품금액</div>
								<div class="total-price" id="">0원</div>
							</div>
							<div class="card-total-content">
								<div class="total-title">배송비 35,000원 이상 무료</div>
								<div class="total-price">0원</div>
							</div>
							<div class="card-total-content">
								<div class="total-title">주문금액</div>
								<div class="total-price">0원</div>
							</div>
						</div>
					</div>
					<%-- 카테고리별 박스 끝 --%>
				</c:forEach>

			</div>
			<div id="cart-cash">
				<div id="cash-info">
					<div id="info-header">결제 정보</div>
					<div class="info-title">총 상품 금액</div>
					<div class="info-content">0원</div>
					<div class="info-title">총 배송비</div>
					<div class="info-content">0원</div>
					<div id="info-total-price" class="bg-gray">
						<div id="info-total-title">결제 예정 금액</div>
						<div id="info-total-content">0원</div>
					</div>
					<div id="btns">
						<input type="button" class="btn buy" onclick="paymentGo()" value="주문하기">
					</div>
				</div>
			</div>
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
	<script>
      function allCheckFunc(obj) {
         $("[name=checkOne]").trigger("click");
      }

      /* 체크박스 체크시 전체선택 체크 여부 */
      function oneCheckFunc(obj) {
         var allObj = $("[name=checkAll]");
         var objName = $(obj).attr("name");

         if ($(obj).prop("checked")) {
            checkBoxLength = $("[name=" + objName + "]").length;
            checkedLength = $("[name=" + objName + "]:checked").length;

            if (checkBoxLength == checkedLength) {
               allObj.prop("checked", true);
            } else {
               allObj.prop("checked", false);
            }
         } else {
            allObj.prop("checked", false);
         }
      }
   
      $(function() {
         $("[name=checkAll]").click(function() {
            allCheckFunc(this);
         });
         $("[name=checkOne]").each(function() {
            $(this).click(function() {
               oneCheckFunc($(this));
            });
         });
      });
   </script>
	<script>
      function lastTextSub(str) {
         return Number( str.substring( 0, str.length-1 ) );
      }
      $(function() {
         $("[name=checkOne]").each(function() {
            $(this).click(function() {
               // 체크된 상품 가격
               var checkPrice = $(this).parent().parent().parent().children(".card-option").children(".product-price").text();
               var checkCount = $(this).parent().parent().parent().children(".card-option").children(".product-count").text();
               // 상품가격 넣어야 하는 객체 
               var productPriceObj1 = $(this).parent().parent().parent().parent().children(".card-total").children(".card-total-content").children(".total-price").eq(0);
               var productPriceObj2 = $(this).parent().parent().parent().parent().children(".card-total").children(".card-total-content").children(".total-price").eq(1);
               var productPriceObj3 = $(this).parent().parent().parent().parent().children(".card-total").children(".card-total-content").children(".total-price").eq(2);

               
               if( $(this).is(":checked") == true ){
                  var beforePrice = lastTextSub( productPriceObj1.text() );
                  var afterPrice = beforePrice + ( Number( checkPrice ) * Number( checkCount ) );
                  /* alert("체크됨." + afterPrice); */
                  productPriceObj1.text( afterPrice + "원" );
                  
                  if( afterPrice != 0 ){
                     productPriceObj2.text( "3000원" );
                  }
                  var objPrice1 = lastTextSub( productPriceObj1.text() );
                  var objPrice2 = lastTextSub( productPriceObj2.text() );
                  productPriceObj3.text( objPrice1 + objPrice2 + "원" );
                  
               }else{
                  
                  var beforePrice = lastTextSub( productPriceObj1.text() );
                  var beforeDelivery = lastTextSub( productPriceObj2.text() );
                  var afterPrice = Number( beforePrice ) - ( Number( checkPrice ) * Number( checkCount ) );
                  /* alert("체크안됨."); */
                  productPriceObj1.text( afterPrice + "원" );

                  if( afterPrice == 0 ){
                     productPriceObj2.text( "0원" );
                  }
                  var objPrice1 = lastTextSub( productPriceObj1.text() );
                  var objPrice2 = lastTextSub( productPriceObj2.text() );
                  productPriceObj3.text( objPrice1 + objPrice2 + "원" )

               }
               // 총 합계 나오는 곳
               var totalprice = 0;
               var totalDelivery = 0;
               $(".category-frame").each(function(){
                  totalprice = totalprice + lastTextSub( $(this).children(".card-total").children(".card-total-content").children(".total-price").eq(0).text() );
                  totalDelivery = totalDelivery + lastTextSub( $(this).children(".card-total").children(".card-total-content").children(".total-price").eq(1).text() );
               });
               $(".info-content").eq(0).text( totalprice + "원" );
               $(".info-content").eq(1).text( totalDelivery + "원" );

               $("#info-total-content").text( totalprice + totalDelivery + "원" );
               
            });
            
         });
      });
   </script>
	<script>
      $(function() {
         $("[name=checkAll]").trigger("click");
      });
   </script>
	<script>
      function paymentGo(){
         
         var idxlist = "";
            
         $("[name=checkOne]").each(function() {
            if( $(this).is(":checked") == true ){
               idxlist = idxlist + $(this).parent().children(".productIdx").val() + ",";
            }
         });

         idxlist = idxlist.substring( 0, idxlist.length-1 );
         var url = "/product/payment?price=" + $(".info-content").eq(0).text() + "&delivery=" + $(".info-content").eq(1).text();
         
         url = url + "&pidxs=" + idxlist;
         $(location).attr('href', url);
      }
   </script>
</body>
</html>