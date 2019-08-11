<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="ad_setting.jsp" %>    
    
<html>
<body>
 
    <h2> <center> 상품 등록 - 처리 페이지  </center> </h2>
 
    <!-- 상품등록  실패  -->
    <c:if test ="${insertCnt == 0}">
    
        <script type="text/javascript">
            alert("상품등록에 실패 했습니다. 다시 시도하세요!");
            window.history.back();
        </script>
    
    </c:if>
 
    <!--  상품등록 성공  -->
    <c:if test="${insertCnt != 0}">
        
        <script type="text/javascript">
            alert("상품 등록이 완료되었습니다!");
            window.location ="product";
        </script>
 
        
    </c:if>
    
 
</body>
</html>
 