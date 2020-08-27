<%@page import="com.study.springboot.dao.IOrderDAO"%>
<%@page import="org.apache.catalina.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 페이지</title>
</head>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/foodmarketForm.css">
<link rel="stylesheet" href="/admin_info.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style>
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
			<h3 id="title">전체 주문관리</h3>
			<div>전체주문 검색</div>
			<form action="/admin/orderSearch">
				<table id="orderSearch">
					<tr>
						<th>주문검색</th>
						<td><select class="form-control" id="keywordCategory" name="keywordCategory">
								<option>주문상품</option>
								<option>주문번호</option>
								<option>주문자</option>
						</select> <input type="text" name="keyword" id="keyword" value="${ keyword }"></td>
					</tr>
					<tr>
						<th>주문상태</th>
						<td><input type="checkbox" name="state0">배송준비 <input type="checkbox" name="state1">배송중 <input type="checkbox" name="state2">배송완료</td>
					</tr>
				</table>
				<div class="searchBtns">
					<input type="submit" class="search" value="검색하기"> <input type="button" class="clear" value="초기화">
				</div>
			</form>
			<div class="option">
				<span id="listCount">전체 ${ listCount }건</span>
			</div>
			<!-- 20200731  -->
			<form action="/admin/stateChange" method="post">
				<table id="orderList">
					<tr>
						<th><input type="checkbox" id="selectAll"></th>
						<th>주문날짜</th>
						<th>주문번호</th>
						<th>주문상품</th>
						<th>주문자</th>
						<th>결제금액</th>
						<th>상태</th>
					</tr>
					<c:forEach items="${ searchlist }" var="item">
						<c:set var="total_price" value="${ item.o_price + item.o_dlv_charge }"></c:set>
						<tr class="items">
							<td><input class="select" type="checkbox" name="orderitem"><input class="idx" type="hidden" value="${ item.idx }"></td>
							<td>${ item.o_date }</td>
							<td>${ item.o_number }</td>
							<td>${ item.o_title }</td>
							<td>${ item.o_ordername }<br>( ${ item.o_order } )</td>
							<td>${ total_price }</td>
							<td>${ item.o_state }</td>
						</tr>
					</c:forEach>
				</table>
				<div style="margin-top: 2px">
					<!-- 20200731 수정 -->

					<label>선택한 상품</label> <select class="form-control" id="stateCategory" name="stateCategory">
						<option>배송준비</option>
						<option>배송중</option>
						<option>배송완료</option>
					</select>&nbsp;<input class="btn btn-info"  type="button" onclick="goState()" value="변경">
				</div>
			</form>
		</section>
		<div id="cri">
			<ul>
				<c:if test="${pageMaker.prev}">
					<li><a href="orderSearch${pageMaker.makeQuery(pageMaker.startPage - 1)}&keywordCategory=${ keywordCategory }&keyword=${ keyword }">이전</a></li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					<li><a href="orderSearch${pageMaker.makeQuery(idx)}&keywordCategory=${ keywordCategory }&keyword=${ keyword }">${idx}</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li><a href="orderSearch${pageMaker.makeQuery(pageMaker.endPage + 1)}&keywordCategory=${ keywordCategory }&keyword=${ keyword }">다음</a></li>
				</c:if>
			</ul>
		</div>
	</div>
	<script src="/webjars/jquery/3.4.1/jquery.min.js"></script>
	<script src="/webjars/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script>
		$('.my_page').hover(function() {
			$(this).children('a').css("color", "red");
		}, function() {
			$(this).children('a').css("color", "black");
		});
	</script>
	<script>
		$(function(){
			$(".clear").click(function(){
				$(".items").empty();
			});
		});

		function goState(){
			var url = "/admin/stateChange?stateCategory=" + $("#stateCategory").val() + "&items=";
			$("input[name=orderitem]:checked").each(function() {
				url = url + $(this).parent().children(".idx").val() + ",";
			});
			
			$(location).attr('href', url);		
		};
	</script>
	<script>
        var message = $("#message").val();
        if( message != "" ){
            alert(message);
        }
    </script>
	<script>
	    $(function(){
	        $("#selectAll").click(function(){
	            var chk = $(this).is(":checked");//.attr('checked');
	            if(chk){
		            $("input[name=orderitem]").each(function(){
						$(this).prop('checked', true);			            
			        });
	            }
	            else{
	            	$("input[name=orderitem]").each(function(){
						$(this).prop('checked', false);			            
			        });
		        }
	        });
	    });
    </script>
</body>
</html>