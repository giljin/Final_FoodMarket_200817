<!-- 20200731수정 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${ p_dto.p_name }</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/foodmarketForm.css">
<link rel="stylesheet" href="/product_detail.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style>
</style>
</head>
<body>
	<div id="wrap">
		<input type="hidden" id="message" value="${ message }" />
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
		<div id="itemMainTemplate">
			<div id="itemImages">
				<div id="itemMainImage">
					<img class="main-image" alt="상품 대표 이미지" src="../image/product/${ p_dto.p_name }/Thumbnail/${ p_dto.p_filename } " />
				</div>
			</div>

			<div id="itemInfo">
				<div id="itemTitle">${ p_dto.p_name }</div>
				<div id="itemCard">
					<div class="card">신상품</div>
					<div class="card">BEST</div>
					<div class="card">할인</div>
					<div class="card">품절</div>
				</div>
				<hr>
				<div class="itemValue">
					<input type="hidden" id="p_idx" value="${ p_dto.idx }">
					<ol>
						<li class="itemValueBox">
							<div class="valueTitle">판매가격</div>
							<div class="valueContent">${ p_dto.p_price }</div>
						</li>
						<li class="itemValueBox">
							<div class="valueTitle">할인율</div>
							<div class="valueContent">${ p_dto.p_discount_ratio }%</div>
						</li>
						<li class="itemValueBox">
							<div class="valueTitle">할인가</div>
							<div id="discount_price" class="valueContent">${ p_dto.p_discount_price }</div>
						</li>
						<li class="itemValueBox">
							<div class="valueTitle">수량</div>
							<div class="valueContent">${ p_dto.p_count }</div>
						</li>
						<li class="itemValueBox">
							<div class="valueTitle">중량/용량</div>
							<div class="valueContent">${ p_dto.weight }</div>
						</li>
						<li class="itemValueBox">
							<div class="valueTitle">배송비</div>
							<div class="valueContent">무료</div>
						</li>
					</ol>
				</div>
				<hr>
				<div id="itemoption">
					<div id="option-top">상품 제목</div>
					<div id="option-bottom">
						<div id="option-bottom-num">
							<div id="option-count-plus">
								<input type="button" class="counting_btn" value="+">
							</div>
							<div id="option-count">1</div>
							<div id="option-count-minus">
								<input type="button" class="counting_btn" value="-">
							</div>
						</div>
						<div id="option-bottom-price">
							총 구매 가격 : <label id="total_price">${ p_dto.p_discount_price }</label>
						</div>
					</div>
				</div>
				<div id="buybtns">
					<c:if test="${ dto == null }">
						<input type="button" class="btn qna" onclick="goLogin();" value="상품문의">
					</c:if>
					<c:if test="${ dto != null }">
						<input type="button" class="btn qna" onclick="window.open('../Product_qna?p_name=${ p_dto.p_name}','window_name','width=700 ,height=700,location=no,status=no,scrollbars=yes');" value="상품문의">
					</c:if>
					<input type="button" class="btn buy" onclick="goPayment()" value="구매하기"> <input type="button" class="btn cart" onclick="goCart()" value="장바구니">
				</div>
			</div>
		</div>
		<div id="active-tab">
			<a id="tab1" href="#">상세내용보기</a><a id="tab2" href="#" style="margin-right: 20px">상품평</a><a id="tab3" href="#">상품문의</a>
		</div>
		<hr />
		<div id="detail-content">
			<c:forEach items="${ files }" var="file">
				<img class="content-image" src="../image/product/${ p_dto.p_name }/${ file }" alt="상품내용이미지" />
			</c:forEach>
		</div>
		<div id="review-list">
			<!-- 20200810 -->
			<c:forEach items="${ writelist }" var="writedto" begin="0" step="1" end="9">

				<div class="review-card">
					<div class="review-userid">${ writedto.w_email }</div>
					<div class="review-starratio">
						<c:if test="${ writedto.w_grade == 5 }">
                     ★★★★★
                  </c:if>
						<c:if test="${ writedto.w_grade == 4 }">
                     ★★★★☆
                  </c:if>
						<c:if test="${ writedto.w_grade == 3 }">
                     ★★★☆☆
                  </c:if>
						<c:if test="${ writedto.w_grade == 2 }">
                     ★★☆☆☆
                  </c:if>
						<c:if test="${ writedto.w_grade == 1 }">
                     ★☆☆☆☆
                  </c:if>
					</div>
					<div class="review-content">
						<c:if test="${ writedto.w_filename != null }">
							<img class="review-image" alt="리뷰이미지" src="../image/member/${writedto.w_email }/${writedto.w_filename}">
						</c:if>
						<span class="review-text">${ writedto.w_content }</span>
					</div>
					<div class="review-date">${ writedto.w_date }</div>
				</div>

			</c:forEach>
		</div>
		<!-- 20200731 수정 -->
		<div id="product-Qna-list">
			<form id="boardForm" name="boardForm" method="post">
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th class="text-center">문의내역</th>
							<th class="text-center">작성자</th>
							<th class="text-center">제목</th>
							<th class="text-center">날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="P_Qna_List" items="${P_Qna_List }" begin="0" step="1" end="9">
							<tr>
								<td>${P_Qna_List.q_category }</td>
								<td>${P_Qna_List.q_name }(${P_Qna_List.q_email})</td>
								<td><c:if test="${ P_Qna_List.groupLayer == 1 }">
										<img src="/image/re.jpg">
									</c:if> <a href="#" onclick="window.open('/product_qna_detail?idx=${P_Qna_List.idx }','_blank','width=700 ,height=700,location=no,status=no,scrollbars=yes');" style="text-decoration: none; color: #333333; font-weight: bold;">${P_Qna_List.q_title }</a></td>
								<td>${P_Qna_List.q_date }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
		</div>
		<div id="footer">
			<hr>
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
	<script src="/webjars/jquery/3.4.1/jquery.min.js"></script>
	<script src="/webjars/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script>
       $(function(){
          $(".counting_btn").on('click', function() {
                if( $(this).val() == '+' ){
                      var count = $("#option-count").text();
                      $("#option-count").text(Number(count) + 1);
                 }else{
                    var count = $("#option-count").text();
                    if( count > 1 ){
                       $("#option-count").text(Number(count) - 1);   
                     }else{
                         alert("최소 구매 수량은 1개 이상입니다.");
                      }
                  }
                var price = $("#discount_price").text();
                  $("#total_price").text( Number(price) * Number($("#option-count").text()) );
             })
       });
    </script>
	<!-- 20200731 -->
	<script>
       $(function(){
          $("#review-list").hide();
          $("#product-Qna-list").hide();
          $("#tab1").on('click', function() {
              $("#detail-content").show();
              $("#review-list").hide();
              $("#product-Qna-list").hide();
             })
             $("#tab2").on('click', function() {
              $("#detail-content").hide();
              $("#review-list").show();
              $("#product-Qna-list").hide();
             })
             $("#tab3").on('click', function() {
              $("#detail-content").hide();
              $("#review-list").hide();
              $("#product-Qna-list").show();
             })             
       });
    </script>
	<script>
      function goCart(){
         var itemCount = $("#option-count").text();
         var idx = $("#p_idx").val();
         var url = "cart_ok?idx=" + idx + "&count=" + itemCount;
         $(location).attr('href', url);
      };
      
      function goPayment(){
         var idx = $("#p_idx").val();
         var price = $("#total_price").text() + "원";
         var url = "payment?pidxs=" + idx + "&price=" + price + "&delivery=3000원";
         $(location).attr('href', url);      
      }
      function goLogin(){
          var url = "../login";
          $(location).attr('href', url);      
       }
   </script>
	<script>
        var message = $("#message").val();
        if( message != "" ){
              alert( message );
        }
   </script>
</body>
</html>