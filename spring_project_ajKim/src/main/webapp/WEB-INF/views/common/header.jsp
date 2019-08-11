<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="setting.jsp" %>    
    
<html>
<body>

<form action="product_search" method="get">

    <header style="margin: 0 auto; width: 1200px;">
 
        <div class="logo">
            <img src="${root}logo.png" onclick="window.location='main'">
        </div>
 
        <div class="lnb">
            <ul>
            	<!-- ★★ 데이터베이스에 있는 상품을 끌어와야하네.... ^^;  -->
                 <li class="mainCategory"><a href="product_list?category=T">인형/토이</a></li>
                <li class="mainCategory"><a href="product_list?category=M">문구</a></li>
                <li class="mainCategory"><a href="product_list?category=L">리빙/데코</a></li>
                <li class="mainCategory"><a href="product_list?category=D">디지털/가전</a></li>
                
                <!-- ★★EL 태그 사용!!!! 이부분만 로그인 전/후 바뀐다. ★★로그인전-->
               <sec:authorize access="isAnonymous()">

                <%-- <c:if test="${sessionScope.memId == null}"> --%>

	               <li class="mainCategory_cart">
	                    <a href="main_cart" alt="">
	                    <img src="${root}top_icon_cart.png"></a>		<!-- 맨위의 카트 아이콘 -->
               		</li>
	               
	                <li class="mainCategory_login">
	                  	<a id = "top_login"href="login" alt="" style="visibility: visible;"> <!-- 맨위의 로그인 아이콘 -->
	                    <img src="${root}login_balloon (1).png"></a>
	                    <a href="login" alt="" >    
	                    <img src="${root}top_icon_login.png"></a>
	                </li>
                </sec:authorize>
                
                <!--★★★★★★★★ 회원 로그인시! 허가되었으면 나오는거  -->
                <sec:authorize access="isAuthenticated()">
                <%-- <c:if test="${sessionScope.memId != null}">  --%>
                
                
                	<li class="mainCategory_cart">
	                    <a href="cart" alt="">	<!--고객용 장바구니!! -->
	                    <img src="${root}top_icon_cart.png"></a>		<!-- 맨위의 카트 아이콘 -->
               		</li>
                	
                	<li class="mainCategory_login">
	                    <a href="myPage" alt="" >    <!-- ★★마이페이지로 이동해야함  -->
	                    <img src="${root}top_icon_login_logined.png"></a>
	                </li>
                
                </sec:authorize> 
                <!-- 회원 변경되는 거 끝  ★★★-->
                
                <!-- 맨위의 서치아이콘 -->
                <li class="mainCategory_search">					
                    <div class="box-search">
                        <input type="text" id="search" name="searchInput">
                        <input type="submit" id="searchIcon" value="">
                    </div>
                </li>
            </ul>
        </div>
    </header>
 
</form>

</body>
</html>