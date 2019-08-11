<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>로그인</title>

<link href ="./main.css" rel="stylesheet" type="text/css"> 
<style>

/* --------------------------로그인 시작 !! css ----------------------------- */


.logon_cartMain li{
	width:500px;
	list-style: none; 
	margin: 0 auto;
	margin-top:10px;
}

#id_submit {display: block;}

#id_submit input[type=submit] {
    width: 500px; height:56px;		/* 수기 가라로 맞춤 ㅋㅋ */
    border-radius: 5px;
    background-color: black;
    font-size:15px;
    color:white;
    font-weight: bold;
}

.no_member input[type=button] {
  width: 100%;
  margin: 0;
  line-height: 56px;
  height: 56px;
  color: #777777;
  font-size: 15px;
  border: 0;
  background-color: #f3f3f3;
  border-radius: 5px;
}

a {text-decoration:none;}
 
</style>



</head>
<body>
<form name="singIn" action="login" method="post">
 
<!--------목록보여주기 header------->
 <%@ include file="header.jsp" %>
 
 
 <!------------------------------------로그인 시작~~~~~~ --------------------------------------------->
        <!-- !!!!!!!!!!!!!전체 중앙 정렬 !!!!!!!!!!!!!!!!!  -->
 
    <div style="margin: 0 auto; width: 1200px;">
      
 
     <section style="padding: 70px;">
        <ul class="logon_cartMain" style="width:500px; height: 300px; margin: 0 auto; margin-bottom: 100px;" >
           
            <li style="text-align:center;"><big style="font-weight:bold; font-size: 30px;">장바구니</big></li>
            <li style="text-align:center;"><small>장바구니를 이용하시려면 로그인을 해주세요.</small></li> 
            
           	<div align="center">
            	<br>
                <div id="id_submit">
                    <input type ="submit" value="로그인">
                </div>
            	<br><br>
            	<div><small>ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ 아직 아트박스 회원이 아니신가요?ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ</small></div>
            	<br>
            	<a class="no_member" href="join_member"><input type ="button" value="회원가입하기"></a>
            	
           	</div>
            	
      	  </ul>
   		
       </section> 
    </div>



 
<!---------화면 맨 하단 footer---------->
<%@ include file="footer.jsp" %>
 
</form> 
</body>
</html>
