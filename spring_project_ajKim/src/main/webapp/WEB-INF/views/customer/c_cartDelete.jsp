<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../common/setting.jsp" %>    
    
<html>
<body>
 
    <c:if test="${deleteCnt == 0}">
        
        <script type="text/javascript">
            alert("장바구니 상품삭제 실패! \n 다시 시도해주십시오.");
            window.history.go(-1);
        </script>
    
    </c:if>
 
 
    <c:if test="${deleteCnt != 0}">
    
        <script type="text/javascript">
            alert("장바구니 상품삭제가 완료되었습니다!");
            window.location ="cart.box";
        </script>
    
        <%--  <c:redirect src="board.box?pageNum= ${pageNum}" /> --%>
    </c:if>
 
</body>
</html>
 