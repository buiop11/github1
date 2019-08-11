<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ad_setting.jsp" %>    
    
<html>
<body>
 
    <h2><center> 삭제 처리 </center></h2>
 
    <c:if test="${deleteCnt == 0}">
        
        <script type="text/javascript">
           	alert("상품 삭제 실패! 다시 시도하세요!");
            window.location ="product.ad?pageNum=" + ${pageNum};
        </script>
    
    </c:if>
 
 
    <c:if test="${deleteCnt != 0}">
    
        <script type="text/javascript">
            alert("상품 삭제가 완료되었습니다!");
            window.location ="product.ad?pageNum=" + ${pageNum};
        </script>
    
    </c:if>
 
</body>
</html>