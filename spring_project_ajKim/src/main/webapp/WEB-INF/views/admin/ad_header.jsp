<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ad_setting.jsp" %>

<style>
.header_li{text-decoration: none; color: white; font-weight: bold;}
</style>

<html>
<body>
<form name="ad_header" action="admin_logoutPro" method="post">

<section style="width:1200px; height:50px; margin:0 auto;">
	<div style=" width: 260px; height: auto; float:left;">
		<img src="${root}logo.png">
	</div>
	<div style="float:right;">
		<p style=" margin-bottom: 0px; margin-top: 40px;">
		관리자 : <sec:authentication property="name"/>님, 오늘도 힘내세요! 
		<!-- ${memId}는 세션값이라 언제든 불러 쓸수있다. -->
		
		<sec:authorize access="isAuthenticated()"> <!-- 인증된게 있으면  -->
			<a href="<c:url value='/j_spring_security_logout'/>">
			<input type="button" value="로그아웃" onclick="goodbyeAlert();"></a>
			
			<!-- ★★★★★★★★   onclick="goodbyeAlert(); 이거 안먹음 ㅠㅠㅠㅠㅠㅠ -->
		</sec:authorize>
	</div>
</section>

<!-- 스타일주기  -->

<section style="width:1200px; margin:0 auto;">

	<div>
		<nav class="menu"> 
		<!-- 컨트롤러를 탄다. .ad로 이동  -->
		<!-- 페이지간 이동은  보통 nav영역에 한다. -->
			<ul style="height:30px; background-color: black">
				<li class="header_li" onclick="window.location='home'" id="home">*홈</li>
				<li class="header_li" onclick="window.location='product'" id="product">*상품관리</li>
				<li class="header_li" onclick="window.location='order'" id="order">*주문/환불 승인 관리</li>
				<li class="header_li" onclick="window.location='member'" id="member">*회원관리</li>
				<li class="header_li" onclick="window.location='board'" id="board">*게시판관리</li>
				<li class="header_li" onclick="window.location='totalCalc'" id="totalCalc">*결산</li>
			</ul>
			 
		</nav>	
	
	</div>
</section>

</form>
</body>
</html>