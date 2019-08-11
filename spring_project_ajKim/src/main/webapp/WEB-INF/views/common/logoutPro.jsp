<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="setting.jsp" %>

<html>
<body>
 
 <!-- ★★ ★★  회원가입 빼껴옴   - el 태그로 다시 정리하기 ★★ ★★  -->
 
 <c:if test="${sessionScope.memId != null}">
 
 	<script type="text/javascript">
		alert("로그아웃 실패하였습니다.");
		window.history.go(-1);
	</script>
 
 
 </c:if>
 

<c:if test="${sessionScope.memId == null}">

	<script type="text/javascript">
		alert("로그아웃 되었습니다. \n 다음에 또 이용해주세요!");
		window.location="main";
	</script>

</c:if>
 		
    
 
</body>
</html>