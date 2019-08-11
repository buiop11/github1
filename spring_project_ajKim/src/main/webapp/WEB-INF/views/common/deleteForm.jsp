<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="setting.jsp" %>    
    

<style>
input[type=password] {
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

input[type=submit], input[type=reset] {
	width: 200px;
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
    
    
<html>
<body>

 <!-- 헤더 -->
<%@ include file="header.jsp" %>
 
    <form action="deletePro.box" method="post" name="pwdform">
    
        <!-- hidden : submit 일 경우 input 태그에 보이지 않는 값을 넘길 때 -->
        <input type="hidden" name="pageNum" value="${pageNum}">
        <input type="hidden" name="num" value="${num}"> 
        
        <table align="center" style="margin-bottom: 200px; margin-top:100px;">
             <tr>
                <th colspan="2">비밀번호를 입력하세요!! </th>
            </tr>
            <tr>
        		<th colspan="2">ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ</th>
        	</tr>
        
            <tr>
              <td colspan="2">
                  <input class="input" type="password" name="pwd" maxlength="10" placeholder="비밀번호 입력" autofocus required>
                  <!-- autofocus: 자동으로 focus주기 /  required: 필수체크-->
              </td>
            </tr>
        
            <tr>
                <th colspan="2">
                    <input class="inputButton" type="submit" value="확인">
                    <input class="inputButton" type="reset" value="취소" onclick="window.history.back();">
                </th>
            </tr>
        
        </table>
    
    </form>
 
 <!-- 푸터 -->
 <%@ include file="footer.jsp" %> 
 
</body>
</html>
 