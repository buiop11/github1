<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>관리자 홈</title>

<style>
.menu ul li {
	float:left;
	list-style: none;
	margin-right: 20px;
}

a {text-decoration: none; color: white; font-weight: bold;}

.content table tr td {
	width:50px; 
	border-radius: 130px;
}
.today_info {font-size:25px;}
#home {border-bottom:2px dotted white;} /* 밑줄 표시하기 header file에 있는 id값 css적용 */

</style>
</head>
<body>

<!-- 관리자 메인 로고  -->
<%@ include file ="ad_header.jsp" %>

<!-- 본문 시작  -->
<section  style="width:1200px; height: 700px; margin:0 auto; margin-bottom:50px;">
	<div class="content" style="width:1200px;">
		<table style="width:700px; height:500px; float:left;">
			<div style="font-size:30px; margin-bottom:30px;">TODAY</div>
			
				<tr>
					<td id="circle1" style="background-color:#FFD9EC; height:200px;">
					<div align="center" class="today_info">
					<b>승인대기</b><br> 1건 </div></td>
					<td id="circle2" style= "background-color:#D9E5FF;">
					<div align="center" class="today_info">
					<b>환불대기</b><br> 1건</div></td>
					<td id="circle3" style= "background-color:#FAECC5;">
					<div align="center" class="today_info">
					<b>신규문의</b><br> 1건</div></td>
				</tr>
				
				<tr>
					<td id="circle4" style= "background-color:#CEFBC9; height:200px;">
					<div align="center" class="today_info">
					<b>상품등록</b><br> 100건</div></td>
					<td id="circle5" style= "background-color:#E8D9FF;">
					<div align="center" class="today_info">
					<b>가입회원</b><br>1명</div></td>
					<td id="circle6" style= "background-color:#FAE0D4;">
					<div align="center" class="today_info">
					<b>방문자수</b><br>1명</div></td>
				</tr>
			
		</table>
	
	
		<div style="width:400px; float:left; margin-left:50px;">
			<ul style="width:400px; border: 2px dotted purple;">
				<li style="font-weight:bold; 
				font-size:20px; list-style:none; margin-bottom:10px;">공지사항</li>
				<hr>
				<li>sdfsfsf</li>
				<li>sdfsfsf</li>
			</ul>
			
			<ul style="width:400px; border: 2px dotted purple;">
				<li style="font-weight:bold; 
				font-size:20px; list-style:none; margin-bottom:10px;">사내 알림</li>
				<hr>
				<li>sdfsfsf</li>
				<li>sdfsfsf</li>
			</ul>
		
		</div>
	</div>
</section>

 <!-----화면 맨 하단 footer---->
 <%@ include file = "ad_footer.jsp" %>

</body>
</html>