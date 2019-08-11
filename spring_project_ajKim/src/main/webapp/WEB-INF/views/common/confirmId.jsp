<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="setting.jsp" %>


<html>

<style>
.input{
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

.inputButton{
  width: 100px;
  margin: 0;
  line-height: 40px;
  height: 40px;
  color: #777777;
  font-size: 15px;
  border: 0;
  background-color: black;
  color:white;
  border-radius: 5px;
}
</style>

<body onload="confirmIdFocus();">
 
 
<%
    int cnt = (Integer)request.getAttribute("selectCnt");
    String id = (String)request.getAttribute("id");
    // request.getAttribute() => object형으로 반환되서 꼭 ★형변환해야함!!
    // 이 페이지에서 쓰려면 또 변수에 담아야함 ^^ 
%>
 
<!-- 사용할 수 없으면 다시 또 읽어야해서 다시 또 호출함  -->
<form action="confirmId.box" method="post" name="confirmform" onsubmit="return confirmIdCheck();">
 
<%
    // cnt == 1 이면 아이디 중복 / 사용할 수 없음 
    if(cnt == 1){
%>
    
    <table style="border: 1px solid black; padding: 10px;">
        <tr>
            <th colspan="2">
                <span><%=id %></span>는 사용할 수 없습니다.(--)
            </th>
        </tr>
        
        <tr>
        	<td colspan="2">
        		--------------------------------------
        	</td>
        </tr>
        
        <tr> <!-- 사용할 수 없는 아이디면 바로 밑에서 다른 아이디를 입력받음  -->
            <th> 아이디 : </th>
            <td>
                <input class="input" type="text" name="id" maxlength="20" style="width:150px;">
            </td>
        </tr>
    
    	<tr>
        	<td colspan="2">
        		--------------------------------------
        	</td>
        </tr>
        
        <tr>
            <th colspan="2">
                <input class="inputButton" type="submit" value="확인">
                <input class="inputButton" type="reset" value="취소" onclick="self.close();">
                <!-- 자바스크립트 self.close();하면 그냥 창 닫힘 -->
            </th>
        </tr>
    
    </table>
 
<%        
    // id 중복 아닐때 
    
    }else {
        
%>
 
    <table style="border: 1px solid black; padding: 10px;">
        <tr>
            <td align="center">
                <span><%=id %></span>는 사용할 수 있습니다!
            </td>
        </tr>
        
        <tr>
        	<td colspan="2">
        		--------------------------------------
        	</td>
        </tr>
        <tr>
            <th colspan="2">
                <input class="inputButton" type="button" value="확인" onclick="setId('<%=id%>');">
            </th>
        </tr>
    </table>
 
<%
    
    }
%>
 
 
 
 
</form>
 
</body>
</html>
