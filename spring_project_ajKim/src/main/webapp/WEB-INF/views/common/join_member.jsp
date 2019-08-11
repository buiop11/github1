<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="setting.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>ARTBOX</title>
 
<style>

 /* ----------------회원가입 css------------------ */
a{text-decoration: none;}
.join_membership {
	width:500px;
	list-style: none; 
	margin: 0 auto;
	margin-top:30px;
}
.join_membership tr{width:100%; height: 60px;}
.join_membership td input[type=text], input[type=password], 
input[type=email], input[type=button], input[type=submit] {
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
.phone{
  width: 96%;
  margin: 0;
  line-height: 56px;
  height: 56px;
  color: #777777;
  font-size: 15px;
  border: 0;
  background-color: #f3f3f3;
  border-radius: 5px;
}
#email_select{
	width: 27%;
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

<!----목록보여주기 header---->
<%@ include file="header.jsp" %>
 
</head>
<body>
<form name ="inputform" action="join_memberPro" method="post">

<!--  중복확인 hidden 값 -->
<input type ="hidden" name="hiddenId" value="0">
   
<!-- !!!!!!!!!!!!!전체 중앙 정렬 !!!!!!!!!!!!!!!!!  -->
 
 <!-- insert시, 인증번호만 발송되고, 로그인시 인증여부로 로그인 가능/불가능 -->
 	
<div style="margin: 0 auto; width: 1200px;">
  <section style="padding: 50px;">
   
    <table class="join_membership" style="width:700px; height: 600px; margin: 0 auto; margin-bottom: 100px;" >
       
       <tr>
    		<td colspan="5" style="text-align:center;"><big style="font-weight:bold; font-size: 25px;">회원가입</big></td>
       </tr>
       
       <tr>
       		<td style="text-align:left;"> 아이디 </td>
       		<td colspan="2"> 
       			<input type ="text" id="label_id" name="id"  maxlength="10"
       				placeholder="  4~10자 영문 숫자 조합" autofocus required>
       		</td>
       		<td colspan="2">
       			<input type="button" name="dupChk" onclick="confirmId();" 
       			value="아이디 중복 확인" style="background-color:black; color:white;">
       		</td>
       </tr>
       
       <tr>
       		<td style="text-align:left;"> 비밀번호 </td>
       		<td colspan="4"><input type="password" id="pwd" maxlength="10"
       			name="pwd" placeholder="  4~16자 영문 숫자 조합" required></td>
       </tr>
       
       <tr>
       		<td style="text-align:left;"> 재확인   </td>
       		<td colspan="4"><input type="password" id="repwd" maxlength="10"
       			name="repwd" placeholder="  4~16자 영문 숫자 조합, 비밀번호를 다시 입력하세요." required></td>
       </tr>
       
       <tr>
       		<td style="text-align:left;"> 이름 </td>
       		<td colspan="4"><input type="text" id="label_Repwd" maxlength="20"
       			name="name" required></td>
       </tr>
       
       <tr> 
       		<td style="text-align:left;"> 전화번호 </td>
       		<td><input type="tel" class="phone" name="hp1" maxlength="3" required>-</td>
       		<td><input type="tel" class="phone" name="hp2" maxlength="4" required>-</td>
       		<td><input type="tel" class="phone" name="hp3" maxlength="4" required></td>
       		<td></td>
       </tr>
       
       <tr>
       		<td style="text-align:left;"> 이메일 </td>
       		<td colspan="4">
       			<input type="text" id="label_email" maxlength="20"
       			name="email1" required style="width:200px;">
       			@
       			<input type="text" maxlength="30" name="email2" style="width:200px;" required>
	       			<select name="email3" onchange="selectEmailChk();" id="email_select" required>
	       				 <option value="0">직접입력</option>
	                     <option value="naver.com">네이버 </option>
	                     <option value="gmail.com">구글</option>
	                     <option value="nate.com">네이트</option>
	                     <option value="daum.net">다음</option>
	       			</select>
       		</td>
       </tr>
       
      <!--  <tr>
       		<td style="text-align:center;"> 이메일 인증 </td>
       		<td><input type="button" value="인증번호 발송" style="background-color:black; color:white"></td>
       		<td colspan="2"><input type="text" maxlength="6" placeholder=" 이메일에 발송된 인증번호 6자리 입력"></td>
       		<td><input type="button" name="confirm_number" value="확인" style="background-color:black; color:white"></td>
       </tr> -->
       
       <tr>
       		<td></td>
       		<td colspan="3"><small>   * 아트박스에서 제공하는 쇼핑이벤트와 혜택에 대한 다양한 소식을 받겠습니다.
       		</small></td>
       		<td><input type="checkbox"> 동의 </td>
       </tr>
       
       <tr>
       </tr>
       
       <tr>
       		<td></td>
       		<td colspan="4">
       			<input type="submit" id="label_submit" name="submit"  onclick="return hiddenChk();"
       		 	value="가입하기" style="background-color:black; color:white; font-weight:bold;">
       		</td>	
       </tr>
       
  	 </table>
	
   </section> 

</div>

 
<!----------화면 맨 하단 footer-------->
<%@ include file="footer.jsp" %>
 
</form> 
</body>
</html>
