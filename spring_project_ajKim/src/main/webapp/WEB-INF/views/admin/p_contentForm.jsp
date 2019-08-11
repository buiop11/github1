<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ad_setting.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>관리자 - 게시판 관리 </title>
<style>
.menu ul li {
	float:left;
	list-style: none;
	margin-right: 20px;
}

a {text-decoration: none; color: white; font-weight: bold;}
.content table tr td {background-color:#EAEAEA;}
.product_list tr td img {width:80px; height:80px;}
table th{background-color:#D5D5D5;}

</style>
</head>
<body>

<!-- 관리자 메인 로고  -->
<%@ include file="ad_header.jsp" %>

<!-- 본문시작 -->
<!-- 게시판 글 뿌리기 !!  -->

<section style="width:1200px; height:auto; margin-bottom:30px; margin:0 auto;">
	<br>
	<div class="content" style="width:1200px; height:auto; margin-bottom:100px;">
		
	<table class="product_content" style="width:900px; margin: 0 auto; border-radius:20px; margin-top:40px;">
			<div align="center" style="font-weight:bold; 
			background-color:#EAEAEA; width:900px; 
			margin: 0 auto; font-size: 20px; margin-top:50px;">
			상품 정보 보기 </div>	
		
		<tr style="height:40px;">
            <th> 상품코드 </th>
            <td> ${vo.p_code} </td>
        </tr>
        
        <tr style="height:40px;">    
            <th> 상품명 </th>
            <td> ${vo.p_name}</td>
        </tr>
        
        <tr style="height:40px;">
            <th> 상품이미지 </th>
            <td> <img src="${root}p_detail/${vo.p_image}" style="width:400px;"></td>
         </tr>
         
        <tr style="height:40px;">
            <th > 상품가격  </th>
            <td> ${vo.p_price} </td>
        </tr>
        
         <tr style="height:40px;">
            <th> 상품수량  </th>
            <td> ${vo.p_count} </td>
        </tr>
        
        <tr style="height:40px;">
            <th> 상품 정보  </th>
             <td> <img src="${root}p_detail/${vo.p_info}" style="width:800px;"></td>
        </tr>
        
         <tr style="height:40px;">   
            <th> 수정일  </th>
            <td> 
                <fmt:formatDate type="both" pattern="yyyy-MM-dd HH:mm" value="${vo.p_date}" />
            </td>
        </tr>
 
 
        <tr>
            <th colspan="2" style="height:40px;">
 				<input class="inputButton" type="button" value="상품 정보 수정"
                    onclick="window.location='p_updateView?p_code=${vo.p_code}&pageNum=${pageNum}'">
                <input class="inputButton" type="button" value="상품 삭제"
                    onclick="window.location='p_delete?p_code=${vo.p_code}&pageNum=${pageNum}'">
                <input class="inputButton" type="button" value="목록보기" 
                    onclick="window.location='product?pageNum=${pageNum}'">
            </th>
        </tr>
		      	
		</table>
		
	
	</div>

	
</section>

 <!------화면 맨 하단 footer-------->
 <%@ include file="ad_footer.jsp" %>


</body>
</html>