<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>비밀번호 찾기</title>
</head>
<body>
<style>
	*{
    margin:0;
    padding: 0;
    box-sizing: border-box;
}
html{
    height: 100%;
}
body{
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
.find_form{
    width: 350px;
    margin: 0 auto;
    border: 1px solid #ddd;
    padding: 2rem;
    background: #ffffff;
}

</style>
 <div class="wrap">
       <div class="wrap">     
       <form class="find_form" action="find_pw_ok" method="post">
               <h3>암호 찾기 </h3>
           <div>
                   <input class="idbtn" type="text" name="email" placeholder="이메일을 입력해주세요" >
                   <button type="submit" >find</button>
                   <button type="button" onclick="history.back();">Cancel</button>              
           </div>
       </form>
</div>     
    </div>
</body>
</html>