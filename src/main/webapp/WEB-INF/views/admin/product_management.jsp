<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품관리 페이지</title>
</head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/foodmarketForm.css">
<link rel="stylesheet" href="/product_management.css">
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
			<h3 id="title">전체 상품관리</h3>
			<div>전체상품 검색</div>
			<form action="/admin/productSearch">
				<table id="productSearch">
					<tr>
						<th>상품검색</th>
						<td><select class="form-control" id="keywordCategory" name="keywordCategory">
								<option>상품명</option>
								<option>상품코드</option>
						</select> <input type="text" name="keyword" id="keyword" value="${ keyword }"></td>
					</tr>
					<tr>
						<th>카테고리</th>
						<td><input type="radio" name="category" value="한식">한식 <input type="radio" name="category" value="중식">중식 <input type="radio" name="category" value="일식">일식 <input type="radio" name="category" value="양식">양식</td>
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
			<form action="/admin/countChange" method="post">
				<table id="productList">
					<tr>
						<th><input type="checkbox" id="selectAll"></th>
						<th>상품사진</th>
						<th>상품명</th>
						<th>상품가격</th>
						<th>할인율</th>
						<th>할인가</th>
						<th>카테고리</th>
						<th>중량</th>
						<th>수량</th>
						<th>특가</th>
						<th>기능</th>
					</tr>
					<c:forEach items="${ productlist }" var="item">
						<tr class="items">
							<td><input class="select" type="checkbox" name="productitem"><input class="idx" type="hidden" value="${ item.idx }"></td>
							<td><img alt="상품사진" src="/image/product/${ item.p_name }/Thumbnail/${ item.p_filename }"></td>
							<td>${ item.p_name }</td>
							<td>${ item.p_price }</td>
							<td>${ item.p_discount_ratio }</td>
							<td>${ item.p_discount_price }</td>
							<td>${ item.category }</td>
							<td>${ item.weight }</td>
							<td>${ item.p_count }</td>
							<td>${ item.special }</td>
							<td><input class="btn btn-primary" style="margin-bottom: 2px" type="button" onclick="productEdit(${item.idx})" value="수정"> <input class="btn btn-danger" type="button" onclick="productDelete(${item.idx})" value="삭제"></td>
						</tr>
					</c:forEach>
				</table>

			</form>
			<div style="margin-top: 2px">
				<label>선택한 상품</label> <input class="btn btn-danger" type="button" onclick="selectListDelete()" value="선택항목 삭제">
			</div>
		</section>
		<div id="cri">
			<ul>
				<c:if test="${pageMaker.prev}">
					<li><a href="productSearch${pageMaker.makeQuery(pageMaker.startPage - 1)}&keywordCategory=${ keywordCategory }&keyword=${ keyword }">이전</a></li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					<li><a href="productSearch${pageMaker.makeQuery(idx)}&keywordCategory=${ keywordCategory }&keyword=${ keyword }">${idx}</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li><a href="productSearch${pageMaker.makeQuery(pageMaker.endPage + 1)}&keywordCategory=${ keywordCategory }&keyword=${ keyword }">다음</a></li>
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
		            $("input[name=productitem]").each(function(){
						$(this).prop('checked', true);			            
			        });
	            }
	            else{
	            	$("input[name=productitem]").each(function(){
						$(this).prop('checked', false);			            
			        });
		        }
	        });
	    });
	</script>
	<script type="text/javascript">
		function productDelete(idx){
			var url = "/admin/productDelete?idx=" + idx;
			$(location).attr('href', url);	
		}
		function productEdit(idx){
			var url = "/admin/product_Edit?idx=" + idx;
			$(location).attr('href', url);	
		}
		function selectListDelete(){
			var idxs = "";
			$("input[name=productitem]").each(function(){
				if( $(this).is(":checked") ){
					var productidx = $(this).parent().children(".idx").val()
					idxs = idxs + productidx + ","
				}
			});
			
			var url = "/admin/productDelete?idx=" + idxs;
			$(location).attr('href', url);
		}
	</script>


</body>

</html>
