<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>관리자 - 회원 관리 </title>
<style>
.menu ul li {
	float:left;
	list-style: none;
	margin-right: 20px;
}

a {text-decoration: none; color: white; font-weight: bold;}
.content table tr td {border: 1px solid black;}
.tabel_th{border: 1px solid black; background-color:lightgrey;}
.product_list tr td img {width:80px; height:80px;}


#member{border-bottom:2px dotted white;} /* 밑줄 표시하기 header file에 있는 id값 css적용 */
</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

	 function member_delete(id){
		 alert(id);
		$("#delete_id").val(id);
	}
	

</script>
</head>
<body>

<!-- 관리자 메인 로고  -->
<%@ include file ="ad_header.jsp" %>

<!-- 본문시작  // ★★리스트에서 고객 정보 전체 다 보여주고 삭제도 바로 옆에서 칸으로 처리할 수 있게 해보자! -->
<section style="width:1200px; height: 700px; margin:0 auto; margin-bottom:50px;">
<form action="" method="get"> 
	<br>
	<div class="content" style="width:1200px;">
	
		<!-- 검색 서취 기능을 넣을 것임  -->
		<fieldset>
			<legend>검색</legend>
				<ul>
					<li>이름<input type="search"></li>
					<li>아이디<input type="search"></li>
				</ul>
				
				<div style="float:right;">
					<input type="button" value="검색">
				</div>	

		</fieldset>
		
		
		<br> 
		<hr>
		<br> 
		<table class="product_list" style="width:1200px; margin-bottom: 10px; border-radius:5px;">
			<tr>
				<th class="tabel_th" style="width:100px">아이디</th>
				<th class="tabel_th" style="width:100px">비밀번호</th>
				<th class="tabel_th" style="width:200px">이름</th>
				<th class="tabel_th" style="width:150px">핸드폰</th>
				<th class="tabel_th" style="width:200px">이메일</th>
				<th class="tabel_th" style="width:200px">가입일</th>
				<th class="tabel_th" style="width:20px">X</th>
			</tr>
			
			<c:if test="${cnt > 0}">
			<c:forEach var="dto" items="${memberList}">
				<tr>
					<td align="center"> ${dto.username}</td>
					<td align="center"> ${dto.password}</td>
					<td align="center"> ${dto.name}</td>
					<td align="center"> ${dto.phone}</td>
					<td align="center"> ${dto.email}</td>
					<td align="center"> ${dto.reg_date}</td>
					<td align="center"><input type="radio" class="member" name="member" onclick="member_delete('${dto.username}');"></td>
					
				</tr> 
			</c:forEach>
					
					<!-- 값보내기 (아이디) -->
					<input type="text" id="delete_id" name="delete_id" value="">
			
			
			</c:if>
			
			<c:if test="${cnt < 0}">
            <tr>
                <td colspan="6" align="center">
                    	등록된 회원이 없습니다!
                </td>
            </tr>
        
        </c:if>
		</table>
	
		<!-- ★★  ★★  ★★  ★★    할 수 있으면 하기  ★★  ★★  ★★   check - box value값을 가지고 올 수 있어야한다. 
			근데, DB에서 읽어오는거라 valude를 어떻게 넣는건지 모르겠음.ㅠㅠㅠ ★★   안할거면 체크박스 없애기 ! -->
			
		<div class="member_delete" style="float:right;">
			<input type="submit" value="탈퇴처리">
		</div>
		
	
   <!-- 페이지 컨트롤  -->
    <table style="width:1000px;" align="center">
        <tr>
            <th align="center">
            
                <!-- 게시글 있으면  -->
                <c:if test="${cnt > 0}">
                    <!-- 특수문자 : ㅁ + 한자키 -->
                    <!-- 처음[◀◀] / 이전블록 [◀] -->
                    <c:if test="${startPage > pageBlock}">
                        <a href="member">[◀◀]</a>
                        <a href="member?pageNum=${startPage - pageBlock}">[◀]</a>
                    </c:if>
                    
                    
                    <!-- 블록내의 페이지 번호  forEach문 돌리기-->
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <c:if test="${i == currentPage}">
                            <span><b>[${i}]</b></span>
                        </c:if>
                        
                        <c:if test="${i != currentPage}">
                            <span><b><a href="member?pageNum=${i}">[${i}]</a></b></span>
                        </c:if>
                    </c:forEach>
                    
                
                    <!-- 다음블록 [▶] / 끝 [▶▶] -->
                    <c:if test="${pageCount > endPage}">
                        <a href="member?pageNum=${startPage + pageBlock}">[▶]</a>
                        <a href="member?pageNum=${pageCount}">[▶▶]</a>
                        <!-- 전체페이지를 세서  -->
                    </c:if>
                </c:if>
            </th>
        </tr>
        
    
    </table>
	
	</div>
</form>
</section>

 <!-----화면 맨 하단 footer----->
 <%@ include file ="ad_footer.jsp" %>


</body>
</html>