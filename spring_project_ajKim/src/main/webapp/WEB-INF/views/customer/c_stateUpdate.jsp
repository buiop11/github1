<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/setting.jsp" %>    
    
<html>
<body>
 
    <c:if test="${updateCnt == 0}">
        <script type="text/javascript">
            alert("결제건 상태변경 실패했습니다. ㅠㅠ ");   
            window.location=window.history.go(-1);
        </script>
    </c:if>
    
    <c:if test="${updateCnt != 0}">
        
        <script type="text/javascript">
            alert("결제건 상태변경 완료했습니다!! ^^");
            window.location="myPage.box";
        </script>        
    
    </c:if>
 
 
</body>
</html>