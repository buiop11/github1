<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.menu ul li {
	float:left;
	list-style: none;
	margin-right: 20px;
}

a {text-decoration: none; color: white; font-weight: bold;}
table tr td {background-color:#EAEAEA;}
input[type=text]{background-color:#EAEAEA;}
.product_list tr td img {width:80px; height:80px;}
table th{background-color:#D5D5D5;}

</style>
</head>
<body>
<!-- 관리자 메인 로고  -->
<%@ include file="ad_header.jsp" %>

<form action="p_updatePro" method="post" name="modifyform" enctype="multipart/form-data">
 
     <!-- hidden 태그는 항상 form 태그 안에 있어야 작동한다.  다음페이지에 또 넘기려고~~ -->        
     <input type="hidden" name="p_code" value="${p_code}"> 
     <input type="hidden" name="pageNum" value="${pageNum}">
     <input type="hidden" name="old_image" value="${vo.p_image}">
     <input type="hidden" name="old_info" value="${vo.p_info}">
   
   <section style="width:1000px; margin:0 auto; margin-bottom:150px;">
  
 	<table class="product_content" style="width:900px; margin: 0 auto; border-radius:20px; margin-top:70px;">
			<div align="center" style="font-weight:bold; 
			background-color:#EAEAEA; width:900px; 
			margin: 0 auto; font-size: 20px; margin-top:50px;">
			상품 정보 수정 </div>	
			
		<tr style="height:40px;">
            <th> 상품코드 </th>
            <td> ${vo.p_code} </td>
        </tr>
        
        <tr style="height:40px;">    
            <th> 상품명 </th>
            <td><input type="text" name="name"  value="${vo.p_name}" required></td>
        </tr>
        
        <tr style="height:40px;">
            <th> 상품이미지 </th>
            <td>
            	<!-- ★★  ★★  ★★ 서비스에서 파일이있을때만 업데이트 분기처리해야 에러가안남 ㅠㅠ  ★★  ★★  ★★   -->
            	<input type="file" name="img" value="${root}p_detail/${vo.p_image}">
            	<img src="${root}p_detail/${vo.p_image}">
            </td>
         </tr>
         
        <tr style="height:40px;">
            <th > 상품가격  </th>
            <td><input type="text" name="price" value="${vo.p_price}" required></td>
        </tr>
        
         <tr style="height:40px;">
            <th> 상품수량  </th>
            <td><input type="text" name="count" value="${vo.p_count}" required ></td>
        </tr>
        
        <tr style="height:40px;">
            <th> 상품 설명 이미지  </th>
            <td>
            	<input type="file" name="info" value="${root}p_detail/${vo.p_info}">
            	<img src="${root}p_detail/${vo.p_info}">
            </td>
        </tr>
        
         <tr style="height:40px;">   
            <th> 수정일  </th>
            <td> 
                <fmt:formatDate type="both" pattern="yyyy-MM-dd HH:mm" value="${vo.p_date}" />
            </td>
        </tr>
 
         <tr>
             <th colspan="2" style="padding-top:15px;">
                 <input class="inputButton" type="submit" value="상품수정">
                 <input class="inputButton" type="reset"  value="수정취소" onclick="window.history.go(-2);">
                 <input class="inputButton" type="button" value="목록보기" onclick="window.location='product?pageNum=${pageNum}'"> 
             </th>
         </tr>    
     
     </table>         
  </section>  
 </form>

<!------화면 맨 하단 footer-------->
 <%@ include file="ad_footer.jsp" %>

</body>
</html>