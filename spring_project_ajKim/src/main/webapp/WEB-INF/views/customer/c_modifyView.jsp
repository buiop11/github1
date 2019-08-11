<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/setting.jsp" %>    <!-- 밑에 헤더에서 불러오는데 계속 에러로 떠있어서 한번더첨부함 -->
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보 보기 </title>
<style>
.tabel_th{text-align:right;}
.table_tr {border-bottom: 1px; solid black;}
input[type=submit], input[type=button],
input[type=reset], .input_text,input[type=password]{
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

.email_text{
      width: 263px;
      margin: 0;
      line-height: 56px;
      height: 56px;
      font-size: 15px;
      border: 0;
      background-color: #f4f4f4;
      border-radius: 5px;
}

</style>
</head>
<body>

<!-- ArtboxMemberVO 에서 값을 가지고 온다. -->

<!-- 헤더 -->
<%@ include file="../common/header.jsp" %>

	<!-- 아이디, 비번 같을 때 회원정보를 가지고 온다. -->
	<c:if test="${loginCnt == 1}">
	
	<section style= "margin-top:50px; margin-bottom:100px;">

  	<form action ="c_modifyPro" method="post">
            
        <table style="width:800; margin-bottom: 100px; text-align:center; margin: 0 auto;">
              <tr>
                  <th class="tabel_th"> 아이디 </th>
                  <td colspan="3" width=70%; height=56px;> ${vo.username} </td>
                  <!-- id는 수정불가라서 input 박스 없음  -->
              </tr>
              
              <tr>
                  <th class="tabel_th"> 비밀번호 </th>
                  <td colspan="3"> 
                  	<input type="password" class="input" name="pwd" maxlength="10" value="${vo.password}">
                  </td>
              </tr>
              
               <tr>
                  <th class="tabel_th"> 비밀번호 확인 </th>
                  <td colspan="3"> 
                  	  <input type="password" class="input" name="repwd" maxlength="10" value="${vo.password}">
                  </td>
              </tr>
              
              <tr>
                  <th class="tabel_th"> 이름 </th>
                  <td colspan="3"> 
                  	<input type="text" class="input_text"  name="name" maxlength="20" value="${vo.name}"> 
                  </td>
              </tr>    
              
               <tr>
                  <th class="tabel_th"> 휴대전화 </th>
                  
                  <c:set var="hpArr" value="${fn:split(vo.phone,'-')}" />
                  <td><input type="text" class="input_text" name="hp1" maxlength="3" value="${hpArr[0]}"></td>
                  <td><input type="text" class="input_text" name="hp2" maxlength="4" value="${hpArr[1]}"></td>
                  <td><input type="text" class="input_text" name="hp3" maxlength="4" value="${hpArr[2]}"></td>
              </tr>  
              
              <tr>
                  <th class="tabel_th"> 이메일 </th>
                  
                  <c:set var="emailArr" value="${fn:split(vo.email,'@')}" />
                  <td colspan="3">
                  	<input class="email_text" type="text" name="email1" maxlength="10" value="${emailArr[0]}">
					@
					<input class="email_text" type="text" name="email2" maxlength="10" value="${emailArr[1]}">
                  </td>
              </tr> 
              
              <tr>
              	<td></td>
                  <td> <input type ="button" value="회원탈퇴 " onclick="c_deleteConfirm();"
                  		style="background-color: grey; color: white;"> </td>
                  <td> <input type= "reset" value="취소" onclick="window.history.back();" 
                  		style="background-color: black; color: white;"></td>
                  <td> <input type="submit" value="정보수정" style="background-color: black; color: white;"></td>
              </tr>
          
          </table>
    </form> 
    </section>
    
	</c:if>
	
	
	<!-- 비밀번호 다를때!  -->
	<c:if test="${loginCnt != 1}">
		<script type="text/javascript">
			errorAlert(pwdError);
			window.history.back();
		</script>
	
	</c:if>

<!-- 푸터 -->
<%@ include file="../common/footer.jsp" %>


</body>
</html>