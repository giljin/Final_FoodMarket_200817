<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인</title>
<link rel="stylesheet" href="css/jquery.bxslider.css">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

html {
	height: 100%;
}

body {
	font-family: 'Segoe UI', sans-serif;;
	font-size: 1rem;
	line-height: 1.6;
	height: 100%;
}

.wrap {
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	background: #fafafa;
}

.login-form {
	width: 350px;
	margin: 0 auto;
	border: 1px solid #ddd;
	padding: 2rem;
	background: #ffffff;
}

.form-input {
	background: #fafafa;
	border: 1px solid #eeeeee;
	padding: 12px;
	width: 100%;
}

.form-group {
	margin-bottom: 1rem;
}

.form-group label {
	font-size: 12px;
}

.form-button {
	background: #69d2e7;
	border: 1px solid #ddd;
	color: #ffffff;
	padding: 10px;
	width: 100%;
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
.form-footer1{
    text-align: right;
}
</style>
</head>
<body>
	<div class="wrap">
		<input type="hidden" id="message" value="${ message }">
		<form class="login-form" action="login_ok" method="post">
			<div class="form-header">
				<h3>로그인</h3>
			</div>
			<!--Email Input-->
			<div class="form-group">
				<input type="text" class="form-input" name="user_id" placeholder="email@example.com" value="${ userid }">
			</div>
			<!--Password Input-->
			<div class="form-group">
				<input type="password" class="form-input" name="user_pw" placeholder="password">
			</div>
			<div class="form-group">
				<input type="checkbox" name="memoryId"> <label>아이디저장</label>
			</div>
			<!--Login Button-->
			<div class="form-group">
				<button class="form-button" type="submit">로그인</button>
			</div>
			<div class="form-footer">
				아이디가 없으십니까? <a href="join">회원가입</a>
			</div>
			<div class="form-footer1">
				<div>
					아이디를 잊어버리셨나요? <a href="find_id">아이디 찾기</a>
				</div>
			</div>

			<div class="form-footer1">
				<div>
					암호를 잊어버리셨나요? <a href="find_pw">비밀번호 찾기</a>
				</div>
			</div>
		</form>
	</div>
	<!--/.wrap-->
</body>
<script src="/webjars/jquery/3.4.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
            var message = $("#message").val();
            if( message != "" ){
                alert(message);
             }
      </script>
<script>
            var idcheck = $("input[name=user_id]").val();
            if( idcheck != "" ){
               $("input[name=memoryId]").prop("checked", true);
            }
      </script>
</html>