<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ad_setting.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>관리자 - 상품관리 </title>
<style>
.menu ul li {
	float:left;
	list-style: none;
	margin-right: 20px;
}

a {text-decoration: none; font-weight: bold;}
.content table tr td {border: 1px solid black;}
.tabel_th{border: 1px solid black; background-color:lightgrey;}
.product_list tr td img {width:80px; height:80px;}


#product{border-bottom:2px dotted white;} /* 밑줄 표시하기 header file에 있는 id값 css적용 */
</style>
</head>
<body>

<!-- 관리자 메인 로고  -->
<%@ include file="ad_header.jsp" %>

<!-- 본문 시작  -->
<form action="product_search" method="get">
<section style="width:1200px; height: 700px; margin:0 auto; margin-bottom:50px;">
	<br>
	<div class="content" style="width:1200px;">
		
		<fieldset>
			<legend>상품등록</legend>
			<a href="product_regist"><input type="button" value="상품등록하기"></a>
		</fieldset>
		
		<br>
	
		<!-- ** 검색 서취 기능을 넣을 것임 ** -->
		<fieldset>
			<legend>검색</legend>
				<ul>
					<li>상품명 검색 : <input type="text" name="searchInput"></li>
				</ul>
				
				<div style="float:right;">
					<input type="submit" value="검색">
				</div>	

		
		</fieldset>
		
		<br> 
		<hr>
		<br> 
		<table class="product_list" style="width:1200px; margin-bottom: 10px; border-radius:5px;">
			<tr>
				<th class="tabel_th" style="width:50px">번호</th>
				<th class="tabel_th" style="width:80px">상품코드</th>
				<th class="tabel_th" style="width:80px">이미지</th>
				<th class="tabel_th" style="width:100px">상품명</th>
				<th class="tabel_th" style="width:100px">가격</th>
				<th class="tabel_th" style="width:80px">보유수량</th>
				<th class="tabel_th" style="width:100px">등록일</th>
			</tr>
			
		 <!-- 게시글이 있으면  게시글보이기   -->    
        <c:if test="${cnt > 0}">
            <c:forEach var="dto" items="${productList}"> 
            <!-- 객체들의 모임 arrayList라서 forEach돌려야함!! -->
                
                <tr>
                    <td align="center">
                        ${number}
                        <c:set var="number" value="${number -1}" />
                    </td>
                    
                    <td align="left"> <!--  글제목 !!!!-->
                    
                       <!-- 상세페이지  key, pageNum을  (+보여지는 숫자 number도) 가지고 가야한다. -->
                       <a href="p_contentForm?p_code=${dto.p_code}&pageNum=${pageNum}&number=${number+1}">${dto.p_code}</a>        
                       <!--  dto.subject로도 가져올 수 있다. -->
                    </td>
                    
                    <td align="center">
                        ${dto.p_image}
                    </td>
                    
                    <td align="center"> 
                       ${dto.p_name}
                    </td>
                    
                    <td align="center">
                        ${dto.p_price}
                    </td>
                    
                    <td align="center">
                        ${dto.p_count}
                    </td>
                    
                     <td align="center">
                     	<fmt:formatDate type="both" pattern="yyyy-MM-dd HH:mm" value="${dto.p_date}" />
                    </td>
                    
                </tr>
                
            </c:forEach>
        </c:if>
    
    
        <!-- 게시글이 없으면  -->    
        <c:if test="${cnt < 0}">
            <tr>
                <td colspan="6" align="center">
                   	등록된 상품이 없습니다! 상품을 등록하세요.
                </td>
            </tr>
        
        </c:if>
		
		</table>
	
	
    <!-- 페이지 컨트롤  -->
    <table style="width:1000px;" align="center">
        <tr>
            <th align="center">
            
                <!-- 게시글 있으면  -->
                <c:if test="${cnt > 0}">
                    <!-- 특수문자 : ㅁ + 한자키 -->
                    <!-- 처음[◀◀] / 이전블록 [◀] -->
                    <c:if test="${startPage > pageBlock}">
                        <a href="admin_product">[◀◀]</a>
                        <a href="admin_product?pageNum=${startPage - pageBlock}">[◀]</a>
                    </c:if>
                    
                    
                    <!-- 블록내의 페이지 번호  forEach문 돌리기-->
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <c:if test="${i == currentPage}">
                            <span><b>[${i}]</b></span>
                        </c:if>
                        
                        <c:if test="${i != currentPage}">
                            <span><b><a href="admin_product?pageNum=${i}">[${i}]</a></b></span>
                        </c:if>
                    </c:forEach>
                    
                
                    <!-- 다음블록 [▶] / 끝 [▶▶] -->
                    <c:if test="${pageCount > endPage}">
                        <a href="admin_product?pageNum=${startPage + pageBlock}">[▶]</a>
                        <a href="admin_product?pageNum=${pageCount}">[▶▶]</a>
                        <!-- 전체페이지를 세서  -->
                    </c:if>
                </c:if>
            </th>
        </tr>
        
    
    </table>
	</div>
</section>
</form>


</body>
</html>


 <!------화면 맨 하단 footer----->
 <%@ include file="ad_footer.jsp" %>