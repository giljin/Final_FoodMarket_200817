<%@page import="com.study.springboot.dao.IOrderDAO"%>
<%@page import="org.apache.catalina.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내 정보 관리</title>
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

th {
	text-align: center;
}

td {
	width: 150px;
	height: 100px;
	font-size: medium;
	text-align: center;
}

html {
	height: 100%;
}
.wrap {
	width: 100%;
	height: 80%;
	display: flex;
	justify-content: center;
	align-items: center;
	background: #fafafa;
}

.join-form {
	width: 350px;
	margin: 0 auto;
	border: 1px solid #ddd;
	padding: 2rem;
	background: #ffffff;
}

.form-input {
	background: #fafafa;
	border: 1px solid #eeeeee;
	padding: 6px;
	width: 100%;
}

.form-group {
	display: flex;
	justify-content: center;
}

.form-group label {
	font-size: 12px;
}

.form-button {
	background: #69d2e7;
	border: 1px solid #ddd;
	color: #ffffff;
	padding: 10px;
	width: 50%;
	text-transform: uppercase;
}

.form-button:hover {
	background: #69c8e7;
}

.form-header {
	text-align: center;
	margin-bottom: 2rem;
}

.form-footer {
	text-align: center;
}

.input-title {
	font-size: 14px;
}

.alert {
	margin-top: 2px;
	padding: 3px;
	border-radius: 3px;
	width: 100%
}

.success {
	background: skyblue;
	border: 1px solid skyblue;
	color: blue;
	font-size: 14px;
}

.danger {
	background: pink;
	border: 1px solid pink;
	color: red;
	font-size: 14px;
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
						<form>
							<input type="text" />
							<button id="search_image" type="submit"></button>
						</form>
					</div>
				</div>
			</div>
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
		</header>
		<nav></nav>
		<section>
	</div>

	<script>
		$('.my_page').hover(function() {
			$(this).children('a').css("color", "red");
		}, function() {
			$(this).children('a').css("color", "black");
		});
	</script>
	<div class="wrap">
		<form class="join-form" action="modify" method="post">
			<div class="form-header">
				<h3>내 정보 관리</h3>
			</div>
			<div class="input-title">이메일</div>
			<div class="form-group">
				<input type="text" class="form-input" name="user_id" placeholder="${dto.u_email }" value="${dto.u_email }" readonly="readonly">
			</div>
			<div class="input-title">변경 비밀번호</div>
			<div class="form-group">
				<input id="pwd1" type="password" class="form-input" name="user_pw">
			</div>
			<div class="input-title">변경 비밀번호 확인</div>
			<div class="form-group">
				<input id="pwd2" type="password" class="form-input" name="user_pw_check">
			</div>
			<div class="alert success" id="alert-success">비밀번호가 일치합니다.</div>
			<div class="alert danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
			<div class="input-title">이름</div>
			<div class="form-group">
				<input type="text" class="form-input" value="${dto.u_name }" name="name">
			</div>
			<div class="input-title">휴대폰 번호</div>
			<div class="form-group">
				<input type="text" class="form-input" value="${dto.u_phone }" name="phone">
			</div>
			<div class="input-title">주소</div>
			<div class="form-group">
				<input type="text" class="form-input" value="${dto.u_address }" name="address">
			</div>

			<br> <br>
			<div class="form-group">
				<button class="form-button" type="submit" id="submit">수정하기</button>
			</div>
		</form>
		</section>

		<script src="/webjars/jquery/3.4.1/jquery.min.js"></script>
		<script src="/webjars/bootstrap/4.3.1/js/bootstrap.min.js"></script>
		<script>
     $(function(){
         $("#alert-success").hide();
         $("#alert-danger").hide();
         $("input").keyup(function(){
             var pwd1=$("#pwd1").val();
             var pwd2=$("#pwd2").val();
             if(pwd1 != "" || pwd2 != ""){
                 if(pwd1 == pwd2){
                     $("#alert-success").show();
                     $("#alert-danger").hide();
                     $("#submit").removeAttr("disabled"); }
                 else{ 
                     $("#alert-success").hide(); 
                     $("#alert-danger").show(); 
                     $("#submit").attr("disabled", "disabled"); }
                 } 
             }); 
         });
    </script>
		<script>
    $(function(){
    	$("#all-check").on('click', function() {
    		$("input[name=sub-check]:checkbox").each(function() {
				$(this).attr("checked", true);
			});
    	})
    });
    </script>
	</div>
	<!--/.wrap-->
</body>
</html>