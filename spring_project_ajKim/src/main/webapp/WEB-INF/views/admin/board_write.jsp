<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ad_setting.jsp" %>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>관리자 - 게시판 글쓰기 </title>
<style>
.menu ul li {
	float:left;
	list-style: none;
	margin-right: 20px;
}

a {text-decoration: none; color: white; font-weight: bold;}
.content table tr td input{background-color:#EAEAEA; width:100%;}
table th{background-color:#D5D5D5;}

textarea {
    width:100%;
    border: 0;
    border-radius: 5px;
    background-color: #f3f3f3;
    height: 118px;
    font-size: 14px;
    line-height: 18px;
    resize: none;
}

.list {
width: 80px;
height: 40px;
font-size: 15px;
border: 0;
background-color: black;
color:white;
font-weight:bold;
border-radius: 5px;
float:right;
} 

</style>
</head>
<body>


<!-- 관리자 메인 로고  -->
<%@ include file="ad_header.jsp" %>

<!-- 본문시작 -->
<section style="width:1200px; height: 500px; margin:0 auto; margin-bottom:150px;">
<form action ="board_writePro.ad" method="post">  

	<br>
	<div class="content" style="width:1200px; height:700px;">
		
		
	<!-- 안보이게 가져올때~~  -->        
    <input type="hidden" name="num" value="${num}">
    <input type="hidden" name="ref" value="${ref}">
    <input type="hidden" name="ref_step" value="${ref_step}">
    <input type="hidden" name="ref_level" value="${ref_level}">
    <input type="hidden" name="pageNum" value="${pageNum}">
		
	<div align="center" style="font-weight:bold; 
	background-color:#EAEAEA; width:900px; 
	margin: 0 auto; font-size: 20px; margin-top:50px;">
	게시글 작성</div>
		
		<table class="board_content" style="width:900px; margin: 0 auto; border-radius:20px; margin-top:40px; margin-bottom:20px;">
			
			<tr>
                <th> 작성자 </th>
                <td> <input class="input" type="text" name="writer" maxlength="20" placeholder="작성자를 입력하세요!!" autofocus required></td>
            </tr>
            
            <tr>
                <th> 비밀번호 </th> 
                <td><input class="input" type="password" name="pwd" maxlength="10" placeholder="비밀번호를 입력하세요!" required> </td>
            </tr>
 
            <tr>
                <th> 제목 </th>
                <td><input class="input" type="text" name="subject" maxlength="50" placeholder="제목을 입력하세요!" required></td>
            </tr>        
            
            <tr>
                <th> 내용 </th>
                <td>
                    <textarea class="input" name="content" 
                    placeholder="글내용을 입력하세요!" word-break:break-all></textarea>
                </td>
            </tr>
            
            
	      </table>
	      
	      <div class=btnarea style="padding-top:50px; height:100px;">
	      	<span><input type="reset" class="list" value="취소" onclick="window.history.back();"></span>
	      	<span><input type="submit" class="list" value="작성"></span>
            <span><input type="button" value="목록" class="list" onclick="window.location='board.ad?pageNum=${pageNum}'"></span>
	      </div>
	
	
	</div>
	
	
</form>
	
</section>

 <!----화면 맨 하단 footer---->
 <%@ include file="ad_footer.jsp" %>

</body>
</html>