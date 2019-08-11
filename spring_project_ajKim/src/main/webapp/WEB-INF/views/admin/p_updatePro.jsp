<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ad_setting.jsp" %>    
    
<html>
<body>
 
 	<c:if test="${updateCnt == null}">
 	 <script type="text/javascript">
            alert("상품 수정에 실패했습니다!");   
            window.location=window.history.go(-2);
        </script>
 	</c:if>
 
    <c:if test="${updateCnt == 0}">
        <script type="text/javascript">
            alert("상품 수정에 실패했습니다!");   
            window.location=window.history.go(-2);
        </script>
    </c:if>
    
    <c:if test="${updateCnt != 0}">
        
        <script type="text/javascript">
            alert("상품 수정이 완료되었습니다!");
            window.location="product.ad?pageNum="+${pageNum};
        </script>        
    
    </c:if>
 
 
</body>
</html>