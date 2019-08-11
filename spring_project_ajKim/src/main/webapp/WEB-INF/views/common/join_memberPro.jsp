<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="setting.jsp" %>

<html>
<body>
 
 <%
 	int cnt = (Integer)request.getAttribute("insertCnt");
 
 	if(cnt == 0){ 	// 회원가입에 실패했을 경우 
%>
	
	<script type="text/javascript">
		alert("회원가입에 실패했습니다. 다시 시도해주세요.");
		window.location="join_member";
	</script>


<%		
 	}else { 		// DB에 INSERT처리 완료함.
 		
%> 		
 		
	<!-- 페이지 이동 시킨다. 로그인페이지로 간다. -->   
	<script type="text/javascript">
		alert("축하합니다. 회원가입이 완료되었습니다. 다시로그인하세요^^!");
		window.location="login";
	</script>

<%
 	}
 
 %>   
    
 
</body>
</html>