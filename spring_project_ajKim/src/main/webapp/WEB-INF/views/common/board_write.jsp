<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>고객감동센터</title>

<link href ="./main.css" rel="stylesheet" type="text/css"> 
<style>

/* -------게시판 시작 !! css -------- */

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

.board {
   	border:1px solid black; 
   	width:100%;
	border-radius: 5px;
}
      
 /*  td{border:1px dotted blue;} */
  table{width:600px; height:auto;}
  
  input[type=text], input[type=email], input[type=password],
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

.writer_info{
	width:1000px;
	height:auto;}

.b_name{
	width:50%; 
	margin-bottom:20px;
	border-radius: 5px;
	background-color: #f3f3f3;
	color: black;
	line-height: 40px;
	font-weight:bold;
	text-align:center;
}

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

input[type=submit], input[type=reset],input[type=button] {
width: 100px;
height: 56px;
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
<form action ="writePro" method="post" name="writeform">  
 <!-- 각 input 마다 required가 있어서  onsubmit="return writeCheck();" 없어도됨  -->
 
<!-----목록보여주기 header----->
<%@ include file="header.jsp" %>
 
    <!------------------------------------게시판  시작~~~~~~ --------------------------------------------->
        <!-- !!!!!!!!!!!!!전체 중앙 정렬 !!!!!!!!!!!!!!!!!  -->
        

    <div style="margin: 0 auto; width: 1200px;">
	      
	    <h1>고객 감동 센터 </h1>
	    <hr>
	    <div class = "board_section" style= "width:1200px; height: 900px; margin-top:50px;">
	    
	    	<div style="margin-bottom: 50px;"><img src="${root}cscenter_top.jpg"></div>
	    
	    <div class= "b_name"> 문의/상담 하기 </div> 
   		<hr>
		
		<div class = "writer_section" style="height:200px; margin-top:50px;">
	
	
	<!-- 안보이게 가져올때~~  -->        
    <input type="hidden" name="num" value="${num}">
    <input type="hidden" name="ref" value="${ref}">
    <input type="hidden" name="ref_step" value="${ref_step}">
    <input type="hidden" name="ref_level" value="${ref_level}">
    <input type="hidden" name="pageNum" value="${pageNum}">
	
	      <table class="writer_info" style="float:left; margin-bottom:50px;">
	      	
	      	<c:if test="${sessionScope.memId == null}">
	           <tr>
	                <th> 작성자 </th>
	                <td> <input class="input" type="text" name="writer" maxlength="20" placeholder="작성자를 입력하세요!!" autofocus required></td>
	            </tr>
            </c:if>
            
            <c:if test="${sessionScope.memId != null}">
            	<tr>
	                <th> 작성자 </th>
	                <td>${sessionScope.memId}</td>
	                <input type="hidden" name="writer" value="${sessionScope.memId}">
	                <!-- 숨김 값으로 DB에 작성자를 넘겨줘야 한다. -->
	            </tr>
            
            </c:if>
            
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
	      <hr>
	      
	      <div class=btnarea style="padding-top:50px; height:100px;">
	      	<span><input type="reset" value="취소" onclick="window.history.back();"></span>
	      	<span><input type="submit" value="작성"></span>
            <span><input type="button" value="목록" onclick="window.location='board?pageNum=${pageNum}'"></span>
	      </div>
	      
	   </div> 

	 </div>

      
    </div>

 
 <!----화면 맨 하단 footer---->
<%@ include file="footer.jsp" %>
 
</form> 
</body>
</html>
