<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="ad_setting.jsp" %>    
    
<html>
<body>
 
    <h2> <center> 글쓰기 - 처리페이지 </center> </h2>
 
    <!-- 글쓰기 실패  -->
    <c:if test ="${insertCnt == 0}">
    
        <script type="text/javascript">
            errorAlert(insertError);
        </script>
    
    </c:if>
 
    <!--  글쓰기 성공  -->
    <c:if test="${insertCnt != 0}">
        
        <script type="text/javascript">
            alert("글쓰기 완료되었습니다. ^^!! ");
            window.location ="board.ad?pageNum=" + ${pageNum};
        </script>
 
        
    </c:if>
    
 
</body>
</html>
 