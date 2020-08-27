<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<title>문의글 답변</title>
</head>
<body>
	<div class="container" role="main">
		<h2 style="text-align:center;">상품문의</h2>
		<form name="form" id="form" role="form" method="post"
			action="product_qna_re_ok?idx=${ qnaitem.idx }">
			<h5>제품명</h5>
			<label>${ qnaitem.p_name }</label>
			<h5>작성자</h5>
			<label>${ qnaitem.q_name }</label>
			<h5>카테고리</h5>
				<select class="form-control" disabled="disabled">
					<option>${ qnaitem.q_category }</option>
				</select>
			<div class="mb-3">
				<h5>제목</h5> 
				<input type="text" class="form-control" id="title" value="${ qnaitem.q_title }" readonly="readonly">
			</div>
			<div class="mb-3">
				<h5><a>내용</a></h5>
				<textarea class="form-control" rows="10" id="content" readonly="readonly">${ qnaitem.q_content }</textarea>
			</div>
			<div class="mb-3">
				<h5>답변</h5>
				<textarea rows="10" name="re" style="width:100%;"></textarea>
			</div>
			<div style="text-align: center">
				<button type="submit" class="btn btn-sm btn-primary" id="btnSave">답변하기</button>
			</div>
		</form>
	</div>
</body>
</html>