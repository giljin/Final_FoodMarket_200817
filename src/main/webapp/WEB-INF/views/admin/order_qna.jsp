<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문문의</title>
</head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/foodmarketForm.css">
<link rel="stylesheet" href="/product_qna.css">
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
			<h3 id="title">주문 문의 관리</h3>
			<div>주문 문의 검색</div>
			<form action="/admin/orderQnaSearch">
				<table id="productQnaSearch">
					<tr>
						<th>주문 문의<br/> 검색</th>
						<td><select class="form-control" id="keywordCategory" name="keywordCategory">
								<option>주문번호</option>
								<option>이름</option>
								<option>문의제목</option>
						</select> <input type="text" name="keyword" id="keyword" value="${ keyword }"></td>
					</tr>
					<tr>
						<th>카테고리</th>
						<td><input type="radio" name="category" value="배송">배송<input type="radio" name="category" value="교환">교환 
							<input type="radio" name="category" value="환불">환불<input type="radio" name="category" value="상품">상품
							<input type="radio" name="category" value="기타">기타
						</td>
					</tr>

				</table>
				<div class="searchBtns">
					<input type="submit" class="search" value="검색하기"> <input type="button" class="clear" value="초기화">
				</div>
			</form>
			<div class="option">
				<span id="listCount">전체 ${ listCount }건</span>
			</div>
			<table id="memberList">
				<tr>
					<th>주문번호</th>
					<th>문의제목</th>
					<th>문의자<br>(아이디)
					</th>
					<th>카테고리</th>
					<th>날짜</th>
					<th>기능</th>
				</tr>

				<c:forEach items="${ qnalist }" var="item">
					<tr class="items">
						<td><c:if test="${ item.groupLayer != 1 }">
                        ${ item.o_number }
                     </c:if> <c:if test="${ item.groupLayer == 1 }">
								<img src="/image/re.jpg">
							</c:if></td>
						<td><a onclick="detailLoad(${ item.idx})">${ item.oq_title }</a></td>
						<td>${ item.oq_name }<br>( ${ item.oq_email } )
						</td>
						<td>${ item.oq_category }</td>
						<td>${ item.oq_date }</td>
						<td><c:if test="${ item.groupLayer != 1 }">
								<input class="btn btn-info" type="button" onclick="order_qna_re(${item.idx})" value="답변">
							</c:if> <c:if test="${ item.groupLayer == 1 }">
								<input class="btn btn-danger" type="button" onclick="order_qna_delete(${item.idx})" value="삭제">
							</c:if></td>
					</tr>
				</c:forEach>
			</table>
		</section>
		<div id="cri">
			<ul>
				<c:if test="${pageMaker.prev}">
					<li><a href="orderQnaSearch${pageMaker.makeQuery(pageMaker.startPage - 1)}&keywordCategory=${ keywordCategory }&keyword=${ keyword }">이전</a></li>
				</c:if>
				<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
					<li><a href="orderQnaSearch${pageMaker.makeQuery(idx)}&keywordCategory=${ keywordCategory }&keyword=${ keyword }">${idx}</a></li>
				</c:forEach>

				<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
					<li><a href="orderQnaSearch${pageMaker.makeQuery(pageMaker.endPage + 1)}&keywordCategory=${ keywordCategory }&keyword=${ keyword }">다음</a></li>
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
      function order_qna_re( idx ){
         var url = "order_qna_re?idx=" + idx;
         window.open(url,'_blank','width=700 ,height=700,location=no,status=no,scrollbars=yes');
      }
      function order_qna_delete( idx ){
         var url = "order_qna_delete?idx=" + idx;
         $(location).attr('href', url);
      }
      function detailLoad( idx ){
         var url = "../order_qna_detail?idx=" + idx;
         window.open(url,'_blank','width=700 ,height=700,location=no,status=no,scrollbars=yes');
      }
   </script>


</body>

</html>
