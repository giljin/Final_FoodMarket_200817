<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록 페이지</title>
</head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/foodmarketForm.css">
<link rel="stylesheet" href="/product_write.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
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
					<a href="../main"><img src="/image/FoodMarket.jpg" alt=""></a>
				</div>
			</div>
		</header>
		<nav>
			<div id="category">
				<div>관리자 페이지</div>
				<div class="my_page">
					<a href="admin_info">주문관리</a>
				</div>
				<div class="my_page">
					<a href="product_write">상품등록</a>
				</div>
				<div class="my_page">
					<a href="product_management">상품관리</a>
				</div>
				<div class="my_page">
					<a href="product_qna">상품문의</a>
				</div>
				<div class="my_page">
					<a href="order_qna">주문문의</a>
				</div>
				<div class="my_page">
					<a href="member_management">회원관리</a>
				</div>
			</div>
		</nav>
		<section>
			<form action="product_write_upload" method="post" enctype="multipart/form-data">
				<h3 id="title">상품 등록</h3>
				<div id="main_image">
					<img id="im" alt="대표이미지" src="/image/500x500.png" />
				</div>
				<table id="product_data">
					<tr>
						<th>상품명</th>
						<td><input type="text" name="p_name"></td>
					</tr>
					<tr>
						<th>판매가(원)</th>
						<td><input type="text" name="p_price"></td>
					</tr>
					<tr>
						<th>할인율(%)</th>
						<td><input type="text" name="p_discount_ratio"></td>
					</tr>
					<tr>
						<th>할인가(원)</th>
						<td><input type="text" name="p_discount_price" readonly="readonly"></td>
					</tr>
					<tr>
						<th>카테고리</th>
						<td><input type="radio" name="category" value="한식">한식 <input type="radio" name="category" value="중식">중식 <input type="radio" name="category" value="일식">일식 <input type="radio" name="category" value="양식">양식</td>
					</tr>
					<tr>
						<th>중량(g)</th>
						<td><input type="text" name="weight"></td>
					</tr>
					<tr>
						<th>수량(개)</th>
						<td><input type="text" name="p_count"></td>
					</tr>
					<tr>
						<th>대표이미지</th>
						<td><input type="file" id="filename1" name="p_file_main"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td><input type="file" id="filename2" name="p_filename" multiple="multiple" /></td>
					</tr>
				</table>
				<div id="buttons">
					<input type="submit" value="등록"> <input type="button" value="취소">
				</div>
			</form>
		</section>
	</div>
	<script src="/webjars/jquery/3.4.1/jquery.min.js"></script>
	<script src="/webjars/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		var message = $("#message").val();
    	if( message != "" ){
        	alert(message);
    	}
	</script>
	<script type="text/javascript">
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#im').attr('src', e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}

		$("#filename1").change(function() {
			readURL(this);
		});
	</script>
	<script>
		$("input[name=p_discount_ratio]").change(function(){
			var price = $("input[name=p_price]").val();
			var ratio = $("input[name=p_discount_ratio]").val();
			ratio = ratio / 100;
			var discountPrice = price - (price * ratio);
			$("input[name=p_discount_price]").val( discountPrice );
		});
	</script>

</body>

</html>
