<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>비밀번호 찾기</title>
</head>
<body>

</body>
<script>
if('${u_pw}' == null || '${u_pw}' == "") {
	alert("가입된 아이디가 없습니다.");
}else{
	alert("회원님의 암호는" + '${u_pw}' + "입니다.");
}

location.href="login"
</script>
</html>