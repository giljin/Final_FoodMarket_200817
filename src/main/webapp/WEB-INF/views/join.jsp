<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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

.join-form {
   width: 350px;
   margin: 0 auto;
   border: 1px solid #ddd;
   padding: 2rem;
   background: #ffffff;
}

.form-input {
   background: #fafafa;
   border: 1px solid #eeeeee;
   padding: 6px;
   width: 100%;
   margin-bottom: 10px;
}

.form-group label {
   font-size: 12px;
}

.form-button {
   background: #69d2e7;
   border: 1px solid #ddd;
   color: #ffffff;
   padding: 10px;
   width: 50%;
   text-transform: uppercase;
}

#id_check {
   background: #69d2e7;
   border: 1px solid #ddd;
   color: #ffffff;
   width: 20%;
   border-radius: 3px;
}

#id_check:hover {
   background: #69c8e7;
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

.input-title {
   font-size: 14px;
}

.alert {
   margin-top: 2px;
   padding: 3px;
   border-radius: 3px;
   width: 100%
}

.success {
   background: skyblue;
   border: 1px solid skyblue;
   color: blue;
   font-size: 14px;
}

.danger {
   background: pink;
   border: 1px solid pink;
   color: red;
   font-size: 14px;
}
</style>
</head>
<body>
   <div class="wrap">
      <form class="join-form" action="join_ok?idcheck=${ checked }" method="post">
         <input type="hidden" id="message" value="${ message }">
         <div class="form-header">
            <h3>회원가입</h3>
         </div>
         <div class="input-title">
            이메일<input type="button" onclick="idCheck()" id="id_check" value="중복확인">
         </div>
         <div class="form-group">
            <input type="hidden" id="check" value="${ checked }"> <input
               type="text" class="form-input" name="user_id"
               value="${ map.u_email }">
         </div>
         <div class="input-title">비밀번호</div>
         <div class="form-group">
            <input id="pwd1" type="password" class="form-input" name="user_pw"
               value="${ map.u_pw }">
         </div>
         <div class="input-title">비밀번호 확인</div>
         <div class="form-group">
            <input id="pwd2" type="password" class="form-input"
               name="user_pw_check" value="${ map.u_pw }">
         </div>
         <div class="alert success" id="alert-success">비밀번호가 일치합니다.</div>
         <div class="alert danger" id="alert-danger">비밀번호가 일치하지 않습니다.</div>
         <div class="input-title">이름</div>
         <div class="form-group">
            <input type="text" class="form-input" name="name"
               value="${ map.u_name }">
         </div>
         <div class="input-title">휴대폰 번호</div>
         <div class="form-group">
            <input type="text" class="form-input" name="phone"
               value="${ map.u_phone }">
         </div>
         <div class="input-title">주소</div>
         <div class="form-group">
            <input type="text" class="form-input" name="address"
               value="${ map.u_address }">
         </div>
         

         <div class="form-group">
            <button class="form-button" id="submit" type="submit">회원가입</button><button class="form-button" type="button" onclick="location.href='login'">가입취소</button>
         </div>
      </form>

      <script src="/webjars/jquery/3.4.1/jquery.min.js"></script>
      <script src="/webjars/bootstrap/4.3.1/js/bootstrap.min.js"></script>
      <script>
         $(function() {
            $("#alert-success").hide();
            $("#alert-danger").hide();
            $("input").keyup(function() {
               var pwd1 = $("#pwd1").val();
               var pwd2 = $("#pwd2").val();
               if (pwd1 != "" || pwd2 != "") {
                  if (pwd1 == pwd2) {
                     $("#alert-success").show();
                     $("#alert-danger").hide();
                     $("#submit").removeAttr("disabled");
                  } else {
                     $("#alert-success").hide();
                     $("#alert-danger").show();
                     $("#submit").attr("disabled", "disabled");
                  }
               }
            });
         });
      </script>
      <script>
         $(function() {
            if ($("#check").val() == 1) {
               $("input[name=user_id]").css("border", "2px solid pink");
               $("#submit").attr("disabled", "disabled");
            } else if ($("#check").val() == 2) {
               $("input[name=user_id]").css("border", "2px solid skyblue");
               $("input[name=user_id]").attr("readonly", "true");
               $("#submit").removeAttr("disabled");
               $("#id_check").attr("disabled", "disabled");
            }
         });
      </script>
      <script>
            var message = $("#message").val();
            if( message != "" ){
                alert(message);
             }
            
      </script>
      <script>
      	function idCheck(){
          	var userid = $("input[name=user_id]").val();
          	if( userid != "" ){
              	$(location).attr('href', "idCheck?userid=" + userid)
            }else{
                alert("아이디를 입력하세요");
            }
        }
      </script>
   </div>
   <!--/.wrap-->
</body>
</html>