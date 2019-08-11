<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="setting.jsp" %>

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


.logonMain li{
	width:500px;
	list-style: none; 
	margin: 0 auto;
	margin-top:10px;
}

.logonMain li input[type=text], input[type=password] {
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

#id_submit {display: block;}

#id_submit input[type=submit]{
    width: 500px; height:56px;		/* 수기 가라로 맞춤 ㅋㅋ */
    border-radius: 5px;
    background-color: black;
    font-size:15px;
    color:white;
    font-weight: bold;
}



a.no_member {
    display: block;
    width: 100%;
    height: 56px;
    line-height: 56px;
    font-size: 17px;
    color: #656565;
    background-color: #ffffff;
    text-align: center;
    border: 1px solid #656565;
    border-radius: 5px;
    margin: 0; text-decoration: none;
}
     
a {text-decoration:none;}
 
</style>

 
</head>
<body>

<!-- login페이지에서 action으로 가는게 시큐리티  --> 
 
<!------목록보여주기 header------>
<%@ include file="header.jsp" %>

<form name="singIn" action="j_spring_security_check" method="post">
<!-- 본문 시작 --> 
<!-- !!!전체 중앙 정렬 !!! -->
 	        home(연결계정 : <sec:authentication property="name"/>) 메인화면<br><br>
 
   <div style="margin: 0 auto; width: 1200px;">
     
    <section style="padding: 70px; height:700px;">
       <ul class="logonMain" style="width:500px; height: 600px; margin: 0 auto; margin-bottom: 100px;" >
          
           <li style="text-align:center;"><big style="font-weight:bold; font-size: 30px;">로그인</big></li>
           <li style="text-align:center;"><small>아트박스 통합 멤버십 회원은 한 아이디로 모든 쇼핑몰 로그인이 가능합니다.</small></li> 
           
           <li>
              <input type ="text" id="label_id" name="memId" placeholder=" 아이디를 입력해주세요." autofocus required>
           </li>
           
           <li>
               <input type="password" id="label_pwd" name="pwd" placeholder=" 비밀번호를 입력해주세요." required>         
           </li>
           
           
           <c:if test="${param.error == true}">
	           <div align="center" style="color:red; padding-top:20px; padding-bottom:30px;">
	           
					아이디나 비밀번호가 일치하지 않거나 <br>
					이메일 인증이 되지 않은 사용자입니다. 확인해주세요.
	           </div>
           </c:if>
           
           	<div align="center">
            	<br>
            	<div> 
            	<a href="id_pwdChk" style="text-decoration:none;">아이디/비밀번호 찾기  |  </a>  
            	<a href="join_member" style="text-decoration:none;">회원가입</a>
            	</div>
                <br>
                <div id="id_submit">
                    <input type ="submit" value="로그인">
                </div>
            	<br>
            	<!-- <br><br>
            	<a class="no_member" href="#">비회원 주문/배송 조회하기(이건 실행안되용)</a>
            	 -->
            	<br><br>
            	<div>
            		<img src="${root}benefit.png" style="width:500px;">
            	</div>
            	
           	</div>
           	
     	  </ul>
  		
      </section> 
   </div>


<!-----화면 맨 하단 footer---->
<%@ include file="footer.jsp" %>
 
</form> 
</body>
</html>
