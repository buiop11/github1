<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>게시판 글보기 </title>

<link href ="./main.css" rel="stylesheet" type="text/css"> 
<style>

/* --------게시판 시작 !! css ---------- */

h1 {
      display: block;
      width: 1200px;
      height: 25px;
      line-height: 25px;
      font-size: 25px;
      text-align: center;
      margin: 0 auto;
      padding: 50px 0 30px 0;
 }


 
</style>


</head>
<body onload="document.singIn.userID.focus();">
<form name="singIn" action="16_next.jsp" method="post" onsubmit="return inputCheck();">
 
<!----목록보여주기 header----->
<%@ include file="header.jsp" %>
 
 
<!--------------게시판  시작~~~~~~ ----------------------------->
<!-- !!!!!!!!!!!!!전체 중앙 정렬 !!!!!!!!!!!!!!!!!  -->
        
<style> /*  css !!Q1!!!  나중에 위로 올릴거! */
.board {
	border:1px solid black; 
	width:100%;
	border-radius: 5px;
}
    
table{width:600px; height:auto;}
    
input[type=text], input[type=email], 
.writer_info tr td select {
  width: 100%;
  margin: 0;
  line-height: 56px;
  height: 56px;
  color: #777777;
  font-size: 15px;
  border: 0;
  background-color: #f3f3f3;
  border-radius: 5px;
} 


textarea {
    border: 0;
    border-radius: 5px;
    background-color: #f3f3f3;
    width: 500px;
    height: 118px;
    font-size: 14px;
    line-height: 18px;
    padding: 10px 12px;
}

input[type=submit], input[type=reset] {
width: 300px;
height: 56px;
font-size: 15px;
border: 0;
background-color: black;
color:white;
font-weight:bold;
border-radius: 5px;
float:right;
} 

.inputButton {
	width: 150px;
	height:30px;
	background-color: black;
	color:white;
	font-weight:bold;
	border-radius: 5px;
	float:center;
	align:center;
}
a {text-decoration: none; font-weight: bold;}
table th{
	 border-radius: 5px;
	 background-color: #f3f3f3;
     font-size: 14px;
     line-height: 18px;
     height:40px;
}

.board_content{
	width:900px; margin: 0 auto; border-radius:5px; margin-top:70px; margin-bottom:20px;
	box-shadow: 15px 15px rgba(0,0,0,.2);
	border:1px solid black;
}


</style>
        
 
    <div style="margin: 0 auto; width: 1200px;">
	      
	    <h1>고객 감동 센터 </h1>
	    <hr>
	    <div class = "board_section" style= "width:1200px; height: auto; margin-top:50px; margin-bottom: 150px;">
	    
	    
	    	 <div style="margin-bottom: 50px;"><img src="${root}cscenter_top.jpg"></div>
	    	 <hr>
	    
	    <table class="board_content">
			
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
            <td colspan="3"> ${vo.subject} </td>
        </tr>
        
        <tr>
            <th> 글내용 </th>
            <td colspan="3" style="width:200px" word-break:break-all> ${vo.content} </td>
                <!-- word-break:break-all 글자단위 자동 줄바꿈 -권장 : keep-all 단어기준 자동 줄바꿈 -->
        </tr>
 
        <tr>
            <th colspan="4">
                <input class="inputButton" type="button" value="글수정" 
                    onclick="window.location='modifyForm?num=${vo.num}&pageNum=${pageNum}'">
                <input class="inputButton" type="button" value="글삭제"
                    onclick="window.location='deleteForm?num=${vo.num}&pageNum=${pageNum}'">
                <input class="inputButton" type="button" value="답글쓰기"
                    onclick="window.location='writeForm?num=${vo.num}&ref=${vo.ref}&ref_step=${vo.ref_step}&ref_level=${vo.ref_level}&pageNum=${pageNum}'">                
                <input class="inputButton" type="button" value="목록보기" 
                    onclick="window.location='board?pageNum=${pageNum}'">
            </th>
        </tr>
		      	
		</table>
		
		</div>
      
    </div>


<!---화면 맨 하단 footer-->
<%@ include file="footer.jsp" %>
 
</form> 
</body>
</html>
