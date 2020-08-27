<!--20200731-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<!-- 20200731 -->
<title>주문문의 내용</title>
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
			<h2>상세보기</h2>
			<form>
				<input type="hidden" name="idx" value="${qna_detail.idx }" /> 
				<input type="hidden" name="originno" value="${qna_detail.originno }" /> 
				<label>주문번호</label>
				<h5>${qna_detail.o_number}</h5>
				<!-- 20200731 -->
				<label>작성자</label>
				<h5>${qna_detail.oq_name }(${ qna_detail.oq_email})</h5>
				<label>문의사항</label> <select class="form-control" disabled="disabled">
					<option>${qna_detail.oq_category}</option>
				</select>
				<div class="mb-3">
					<label for="title">제목</label> <input type="text" class="form-control" name="oq_title" id="title" placeholder="${qna_detail.oq_title }" value="${qna_detail.oq_title }" readonly="readonly">
				</div>
				<div class="mb-3">
					<label for="content">내용</label>
					<textarea class="form-control" rows="5" name="oq_content" id="content" placeholder="${qna_detail.oq_content }" readonly="readonly">${qna_detail.oq_content }</textarea>
				</div>
				<c:if test="${dto.u_email == qna_detail.oq_email }">
					<div class="col text-center">
						<button type="submit" id="update" class="btn btn-primary" style="display: none">수정완료</button>
						<button type="button" id="rewrite" class="btn btn-primary">수정</button>
						<button type="submit" id="delete" class="btn btn-warning">삭제</button>
					</div>
				</c:if>
			</form>
		</div>
	</article>
	<script type="text/javascript">
		$('#rewrite').on('click', function() {
			$('#title').removeAttr("readonly");
			$('#content').removeAttr("readonly");
			$('#rewrite').hide();
			$('#update').show();
		});
		$('#update').on('click', function() {
			if(${dto.u_email == 'admin'}){
				$("form").attr("action", "/order_qna_reply");	
			}else{
				$("form").attr("action", "/order_qna_update");	
			}
		});
		$('#delete').on('click', function() {
			$("form").attr("action", "/order_qna_delete");
		});
	</script>
</body>
</html>
