<!-- 20200803 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<title>주문문의</title>
<script>
	$(document).on('click', '#btnSave', function(e){
		e.preventDefault();
		$("#form").submit();
	});
</script>
<style>
body {
	padding-top: 70px;
	padding-bottom: 30px;
}
</style>
</head>
<body>
	<article>
		<div class="container" role="main">
			<h2>주문문의</h2>
			<form name="form" id="form" role="form" method="post" action="order_qna_ok">
				<!-- 20200731 -->
				<label>주문번호</label>
				<h5>${o_number }</h5>
				<input type="hidden" name="o_number" value="${o_number }"/>
				<label>작성자</label>
				<h5>${oq_name }</h5>
				<input type="hidden" name="oq_email" value="${oq_email }"/>
				<input type="hidden" name="oq_name" value="${oq_name }"/>
				<label>문의사항</label> <select class="form-control" name="oq_category">
					<option>배송</option>
					<option>교환</option>
					<option>환불</option>
					<option>상품</option>
					<option>기타</option>
				</select>
				<div class="mb-3">
					<label for="title">제목</label> <input type="text" class="form-control" name="oq_title" id="title" placeholder="제목을 입력해 주세요">
				</div>
				<div class="mb-3">
					<label for="content">내용</label>
					<textarea class="form-control" rows="10" name="oq_content" id="content" placeholder="내용을 입력해 주세요"></textarea>
				</div>
			</form>
			<div style="text-align: center">
				<button type="button" class="btn btn-sm btn-primary" id="btnSave">문의하기</button>
			</div>
		</div>
	</article>
</body>
</html>
