<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/setting.jsp" %>    

<html>
<body>


    <c:if test="${deleteCnt == 0}">
        
        <script type="text/javascript">
            errorAlert(deleteError);
            window.history.back();
        </script>
    
    </c:if>
 
 
    <c:if test="${deleteCnt != 0}">
    	<!-- 삭제 성공시 세션도 삭제해야함  -->
    
        <script type="text/javascript">
            alert("탈퇴가 완료되었습니다!");
            /* window.location ="main"; */
        </script>

    	<%-- <%
    		//세션 삭제 
    		request.getSession().removeAttribute("memId");
    	%> --%>
    	<sec:authorize access="isAuthenticated()"> <!-- 인증된게 있으면  logout페이지를 타라! -->
	      <%-- --<c:url value='/j_spring_security_logout'/>--- --%>	<!-- 손을안쓰고 동작하게하려면 javascript를 써야한다~~!!!!!★ -->
	            <script type="text/javascript">
		            window.location ="<c:url value='/j_spring_security_logout'/>"; 
		        </script>
		</sec:authorize>
    	
    
    
    </c:if>
 
</body>
</html>