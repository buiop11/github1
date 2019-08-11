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

<section style="width:1200px; height: 700px; margin:0 auto; margin-bottom:50px;">
	<br>
	<div class="content" style="width:1200px; height:700px;">
		
		
		 <table class="board_content" align="center">
			
			        <tr>
            <th style="width:150px"> 글번호 </th>
            <td style="width:150px" align="center"> ${number} </td>
            
            <th style="width:150px"> 조회수 </th>
            <td style="width:150px"> ${vo.readCnt}</td>
        </tr>
        
        <tr>
            <th style="width:150px"> 작성자 </th>
            <td style="width:150px"> ${vo.writer}</td>
            
            <th style="width:150px"> 작성일 </th>
            <td style="width:150px"> 
                <fmt:formatDate type="both" pattern="yyyy-MM-dd HH:mm" value="${vo.reg_date}" />
            </td>
        </tr>
 
        <tr>
            <th> 글제목 </th>
            <td colspan="3" align="center"> ${vo.subject} </td>
        </tr>
        
        <tr>
            <th> 글내용 </th>
            <td colspan="3" style="width:200px" word-break:break-all> ${vo.content} </td>
                <!-- word-break:break-all 글자단위 자동 줄바꿈 -권장 : keep-all 단어기준 자동 줄바꿈 -->
        </tr>
 
        <tr>
            <th colspan="4">
                <input class="inputButton" type="button" value="글삭제"
                    onclick="window.location='board_delete?num=${vo.num}&pageNum=${pageNum}'">
                <input class="inputButton" type="button" value="답글쓰기"
                    onclick="window.location='board_write?num=${vo.num}&ref=${vo.ref}&ref_step=${vo.ref_step}&ref_level=${vo.ref_level}&pageNum=${pageNum}'">                
                <input class="inputButton" type="button" value="목록보기" 
                    onclick="window.location='board?pageNum=${pageNum}'">
            </th>
        </tr>
		      	
		</table>
		
	
	</div>

	
</section>

 <!------화면 맨 하단 footer-------->
 <%@ include file="ad_footer.jsp" %>


</body>
</html>