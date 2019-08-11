<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>관리자 - 상품 등록하기 </title>
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
<section style="width:1200px; height: 700px; margin:0 auto; margin-bottom:50px;">

<form action="p_insertPro" name="" method="post" enctype="multipart/form-data">
<!-- 
	get 으로 확인해보니  ★★  ★★  
	http://localhost/JSP_project_ajKim/p_insertPro.ad?category=M
	&1_img=hot.gif
	&name=%EC%86%90%EB%8B%98%ED%82%B4a   (받을때 UTF-8 설정!) 
	&info=re.gif		(파일명만 들어감)
	&price=50000
	&count=234234
	&admin_id=kim
	
	이렇게 넘김 
 -->


	<br>
	<div class="content" style="width:1200px; height:700px;">
		
		
		<table class="board_content" style="width:900px; margin: 0 auto; border-radius:20px; margin-top:40px; margin-bottom:20px;">
			<div align="center" style="font-weight:bold; 
			background-color:#EAEAEA; width:900px; 
			margin: 0 auto; font-size: 20px; margin-top:50px;">
			상품등록</div>
			
			<tr>
				<th>상품 카테고리 </th>
				<td>
					<select name="category" required>
						<option>카테고리 선택</option>
						<option value="T">인형/토이</option>
						<option value="M">문구</option>
						<option value="D">디지털/가전</option>
						<option value="L">리빙/데코</option>
					</select>
					
				</td>
			</tr>
			
			<tr>
				<th>상품 대표 이미지</th>
				<td><input type="file" name="img" required></td>
			</tr>
			
			<tr>
				<th>상품 이름</th>
				<td><input type="text" name="name" required></td>
			</tr>
			
			<tr>
				<th>상품 설명 이미지</th>
				<td><input type="file" name="info"></td>
			</tr>
			
			<tr>
				<th>가격</th>
				<td><input type="text" name="price" required></td>
			</tr>
			
			<tr>
				<th>수량</th>
				<td><input type="text" name="count" required></td>
			</tr>
			
			<tr>
				<th>처리자</th>
				<td><sec:authentication property="name" /></td>
				<input type="hidden" name="admin_id" value="<sec:authentication property='name' />">
			</tr>
		      	
		</table>
		
		<div style="width:900px; margin: 0 auto; border-radius:20px;">
		
			<div style="float:right;">
				<input type="submit" value="등록하기">
			</div>
			<div style="float:right;">
				<input type="button" value="목록" onclick="window.location='product'">
			</div>
			<div>
				<input type="reset" value="취소" onclick="window.history.back();">
			</div>
		</div>
	
	</div>

</form>	
</section>

 <!----화면 맨 하단 footer---->
 <%@ include file="ad_footer.jsp" %>
 
 
</body>
</html>