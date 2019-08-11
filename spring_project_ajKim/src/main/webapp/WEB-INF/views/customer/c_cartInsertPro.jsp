<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/setting.jsp" %>

<html>
<body>
 
 <c:if test="${insertCnt == 0}">
 
 	<script type="text/javascript">
		alert("장바구니 담기에 실패했습니다. 다시 시도해주세요.");
		window.history.go(-1);
	</script>
 
 
 </c:if>
 

<c:if test="${insertCnt != 0}">

	<script type="text/javascript">
		var cart = confirm("선택하신 상품이 장바구니에 담겼습니다. \n 장바구니로 이동하겠습니까?");
		if(cart == true){
			window.location="cart";
		}else{
			window.history.go(-1);
		}
		
	</script>

</c:if>
 		
    
 
</body>
</html>