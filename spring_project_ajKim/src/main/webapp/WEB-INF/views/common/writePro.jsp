<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="setting.jsp" %>    
    
<html>
<body>
 
    <h2> <center> 글쓰기 - 처리페이지 </center> </h2>
 
    <!-- 글쓰기 실패  -->
    <c:if test ="${insertCnt == 0}">
    
        <script type="text/javascript">
			alert("글 작성에 실패했습니다. \n 다시시도해주세요!")
        	window.history.back();
        </script>
    
    </c:if>
 
    <!--  글쓰기 성공  -->
    <c:if test="${insertCnt != 0}">
        
        <script type="text/javascript">
            alert("글쓰기 완료되었습니다. ^^!! ");
            window.location ="board?pageNum=" + ${pageNum};
        </script>
 
        <%-- <c:redirect url="board?pageNum=${pageNum}" /> --%>
        
    </c:if>
    
 
</body>
</html>
 