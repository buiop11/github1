<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	
	<form action="addAlien"> <!-- controller의 addAlien로 이동 -->
		<input type="text" name="aid"><br>
		<input type="text" name="aname"><br>
		<input type="text" name="tech"><br>
		<input type="submit"><br>
	
	</form>

	<form action="getAlien"> <!-- aid로 alien 가져오기 -->
		<input type="text" name="aid"><br>
		<input type="submit"><br>
	
	</form>



</body>
</html>