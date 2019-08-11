<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="setting.jsp" %>

<html>
<body>
 
 <!-- ★★ ★★  회원가입 빼껴옴   - el 태그로 다시 정리하기 ★★ ★★  -->
 
 <c:if test="${insertCnt == 0}">
 
 	<script type="text/javascript">
		alert("주문 처리에 실패했습니다. 다시 시도해주세요.");
		window.history.go(-2);
	</script>
 
 
 </c:if>
 

<c:if test="${insertCnt != 0}">

	<script type="text/javascript">
		alert("주문이 완료되었습니다! 주문상태를 마이페이지에서 확인하세요!");
		window.location="myPage";
	</script>

</c:if>
 		
    
 
</body>
</html>