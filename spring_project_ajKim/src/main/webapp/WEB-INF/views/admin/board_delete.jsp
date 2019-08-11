<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ad_setting.jsp" %>    
    
<html>
<body>
 
    <h2><center> 삭제 처리 </center></h2>
 
    <c:if test="${deleteCnt == 0}">
        
        <script type="text/javascript">
            errorAlert(deleteError);
        </script>
    
    </c:if>
 
 
    <c:if test="${deleteCnt != 0}">
    
        <script type="text/javascript">
            alert("삭제가 완료되었습니다!");
            window.location ="board.ad?pageNum=" + ${pageNum};
        </script>
    
        <%--  <c:redirect src="board.ad?pageNum= ${pageNum}" /> --%>
    </c:if>
 
</body>
</html>