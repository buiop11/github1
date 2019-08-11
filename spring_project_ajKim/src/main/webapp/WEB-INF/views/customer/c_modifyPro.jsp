<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/setting.jsp" %>    
<html>
<body>

	<h2> 회원 정보 수정 </h2>
	
	<c:if test="${updateCnt == 0}">  <!-- 업데이트 실패시  -->
	
		<script type="text/javascript">
			errorAlert(updateError);
			window.history.back();
		</script>
	
	</c:if>
	
	<c:if test="${updateCnt != 0}">
	
		<script type="text/javascript">
			alert("회원정보가 수정되었습니다!!"); 
			window.history.back();
		</script>
	
	</c:if>
	
	
	
	
</body>
</html>