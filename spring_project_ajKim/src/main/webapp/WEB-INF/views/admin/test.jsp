<%@page import="java.util.Random"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<%

	int[] numbers = new int[6];
	Random gen = new Random();
	
	for(int i =0 ; i<6 ; i++  ){
	 numbers[i] = gen.nextInt(100)+1; //난수생성
	
		for(int j = 0; j < i; j++){              
		 if(numbers[i] == numbers[j]){  
		  i = i-1;                                 
		  break;                             
		 }
		}
	}
	   
	int code2 = 0;
	for(int a =0 ; a <1; a++){
	 	code2 = numbers[a];
	}

	out.print(code2);

 


 

%>


</body>
</html>