<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="setting.jsp" %>    
 
<style>

textarea {
    width:100%;
    border: 0;
    border-radius: 5px;
    background-color: #f3f3f3;
    height: 250px;
    font-size: 14px;
    line-height: 18px;
    resize: none;
}

input[type=submit], input[type=reset],
input[type=button] {
	width: 100px;
	height: 40px;
	font-size: 15px;
	border: 0;
	background-color: black;
	color:white;
	font-weight:bold;
	border-radius: 5px;
	float:right;
} 

.input_write {
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
</style>
 
 
<html>
<body onload="modifyFocus();">

<!-- 헤더 -->
<%@ include file="header.jsp" %>

 
    <c:if test="${selectCnt == 0}">    <!-- 비밀번호가 맞지 않을때  -->
        <script type="text/javascript">
            errorAlert(pwdError);    
            window.location=window.history.go(-2);
        </script>
        
    </c:if>
 
    <c:if test="${selectCtn != 0}">
        
        <form action="modifyPro.box" method="post" name="modifyform">
        
            <!-- hidden 태그는 항상 form 태그 안에 있어야 작동한다.  다음페이지에 또 넘기려고~~ -->        
            <input type="hidden" name="num" value="${num}"> 
            <input type="hidden" name="pageNum" value="${pageNum}">
            
            <table align="center" style="width:800px; margin-top:100px; margin-bottom:100px; border:1px soild black;">
                <tr>
                    <th colspan="2" style="padding-top:10px; padding-bottom:10px;"> 
                    	<h2><center> 게시글 수정 </center></h2> 
                    </th>
                </tr>
 
                <tr>
                    <th style="height:56px;"> 작성자 </th>
                    <td> ${vo.writer}</td>
                </tr>                
                
                <tr>
                    <th> 글제목 </th>
                    <td>
                        <input class="input_write" type="text" name="subject" maxlength="50" value="${vo.subject}">
                    </td>
                </tr>
            
                <tr>
                    <th> 글내용 </th>
                    <td>
                        <textarea rows="10" cols="40" name="content" word-break:break-all>
                            ${vo.content}
                        </textarea>        
                        
                        <!-- word-break:break-all 글자단위 자동 줄바꿈 -권장 
                                    : keep-all 단어기준 자동 줄바꿈 -->
                    </td>
                </tr>
            
                <tr>
                    <th colspan="2" style="padding-top:15px;">
                        <input class="inputButton" type="submit" value="글수정">
                        <input class="inputButton" type="reset"  value="수정취소">
                        <input class="inputButton" type="button" value="목록보기" onclick="window.location='board.box?pageNum=${pageNum}'"> 
                    </th>
                </tr>    
            
            </table>         
        
        </form>
    
    </c:if>
 
 <!-- 푸터 -->
 <%@ include file="footer.jsp" %>
 
</body>
</html>