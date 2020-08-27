<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리 페이지</title>
</head>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/foodmarketForm.css">
<link rel="stylesheet" href="/member_management.css">
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
			<h3 id="title">전체 회원관리</h3>
			<div>전체회원 검색</div>
			<form action="/admin/memberSearch">
				<table id="memberSearch">
					<tr>
						<th>상품검색</th>
						<td><select class="form-control" id="keywordCategory" name="keywordCategory">
								<option>이름</option>
								<option>아이디</option>
						</select> <input type="text" name="keyword" id="keyword" value="${ keyword }"></td>
					</tr>

				</table>
				<div class="searchBtns">
					<input type="submit" class="search" value="검색하기"> <input type="button" class="clear" value="초기화">
				</div>
			</form>
			<div class="option">
				<span id="listCount">전체 ${ listCount }건</span>
			</div>
			<form action="/admin/countChange" method="post">
				<table id="memberList">
					<tr>
						<th><input type="checkbox" id="selectAll"></th>
						<th>아이디</th>
						<th>이름</th>
						<th>휴대폰번호</th>
						<th>주소</th>
						<th>포인트</th>
						<th>기능</th>
					</tr>
					<c:forEach items="${ memberlist }" var="user">
						<c:if test="${ user.u_email != 'admin' }">
							<tr class="items">
								<td class="th1"><input class="select" type="checkbox" name="user"><input class="idx" type="hidden" value="${ user.idx }"></td>
								<td>${ user.u_email }</td>
								<td>${ user.u_name }</td>
								<td>${ user.u_phone }</td>
								<td>${ user.u_address }</td>
								<td>${ user.u_point }</td>
								<td class="th7"><input class="btn btn-danger" type="button" onclick="memberDelete(${user.idx})" value="삭제"></td>
							</tr>
						</c:if>
					</c:forEach>
				</table>

			</form>
			<div style="margin-top: 2px">
				<label>선택한 회원</label> <input class="btn btn-danger" type="button" onclick="selectListDelete()" value="선택항목 삭제">
			</div>
		</section>
		<div id="cri">
			<ul>
				<c:if test="${pageMaker.prev}">
					<li><a href="memberSearch${pageMaker.makeQuery(pageMaker.startPage - 1)}&keywordCategory=${ keywordCategory }&keyword=${ keyword }">이전</a></li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					<li><a href="memberSearch${pageMaker.makeQuery(idx)}&keywordCategory=${ keywordCategory }&keyword=${ keyword }">${idx}</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li><a href="memberSearch${pageMaker.makeQuery(pageMaker.endPage + 1)}&keywordCategory=${ keywordCategory }&keyword=${ keyword }">다음</a></li>
				</c:if>
			</ul>
		</div>
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
		$(function(){
			$(".clear").click(function(){
				$(".items").empty();
			});
		});
	</script>
	<script type="text/javascript">
		$(function(){
	        $("#selectAll").click(function(){
	            var chk = $(this).is(":checked");//.attr('checked');
	            if(chk){
		            $("input[name=user]").each(function(){
						$(this).prop('checked', true);			            
			        });
	            }
	            else{
	            	$("input[name=user]").each(function(){
						$(this).prop('checked', false);			            
			        });
		        }
	        });
	    });
	</script>
	<script type="text/javascript">
		function memberDelete(idx){
			var url = "/admin/memberDelete?idx=" + idx;
			$(location).attr('href', url);	
		}
		function selectListDelete(){
			var idxs = "";
			$("input[name=user]").each(function(){
				if( $(this).is(":checked") ){
					var productidx = $(this).parent().children(".idx").val()
					idxs = idxs + productidx + ","
				}
			});
			
			var url = "/admin/memberDelete?idx=" + idxs;
			$(location).attr('href', url);
		}
	</script>


</body>

</html>
