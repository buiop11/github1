<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ad_setting.jsp" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>관리자 로그인</title>

<style>
/*----로그인!! css ---*/

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

a {text-decoration:none;}
</style>
</head>
<body> 

<%
	String memId;  // 세션 받을 값 선언 
%>

<%
	//int cnt = (Integer)request.getAttribute("cnt");
    int cnt = request.getAttribute("cnt") == null ? 2 : (Integer)request.getAttribute("cnt");
	// 맨처음에 controller에서 cnt 값이 설정이 안되어있었음! 
	// 값이 없으면 nullpointException 난다! 여기서라도 처리해야함
	String adminId = (String)request.getSession().getAttribute("adminId");
%>

<!-- 페이지 submit 시 로그인 처리 페이지로 이동  -->
<form name="singIn" action="admin_loginPro" method="post">
 
 
 	<!-- 관리자 메인 로고  -->
	<section style="width:1200px; height:50px; margin:0 auto;">
		<div style=" width: 260px; height: auto; margin: 0 auto; margin-top:50px; margin-bottom:30px;">
			<img src="${root}logo.png">
		</div>
		<hr>
	</section>
 
    <!---로그인 시작 --->
    <!--전체 중앙 정렬 -->
      
<%
	if(adminId == null) {		// 로그인 하기 전 
		
%>     

	<%
		if(cnt == 0){
	%>
		<script type="text/javascript">
			alert("정보가 다릅니다.");
		</script>
	<%		
		}else if(cnt == -1){
	%>
		<script type="text/javascript">
			alert("비밀번호를 다시 확인하세요!");
		</script>
	<%		
		}
	%>

    <div style="margin: 0 auto; width: 1200px;">
      
     <section style="padding: 70px;">
        <ul class="logonMain" style="width:500px; height: 300px; margin: 0 auto; margin-bottom: 100px;" >
           
            <li style="text-align:center;">
            <big style="font-weight:bold; font-size: 30px;">관리자로그인</big></li>
            
            <li>
               <input type ="text" id="label_id" name="id" placeholder=" 아이디를 입력해주세요." autofocus required>
            </li>
            
            <li>
                <input type="password" id="label_pwd" name="pwd" placeholder=" 비밀번호를 입력해주세요." autofocus required>         
            </li>
            	<div align="center">
	            	<br>
	                <br>
	                <div id="id_submit">
	                    <input type ="submit" value="로그인">
	                </div>
	            	<br>
	            	<br>
	            	
            	</div>
            	
      	  </ul>
   		
       </section> 
    </div>

<%
	}else {		// 로그인 완료시 
%>

	<script type="text/javascript">
		alert("${adminId}님 오늘도 화이팅.^^");
		window.location = "admin_loginOK"; 	//컨트롤러를 꼭 거쳐야 함다.
	</script>

<%
	}
%>
 
   <!---------화면 맨 하단 footer----------->
   <%@ include file="ad_footer.jsp" %>
 
</form> 
</body>
</html>
