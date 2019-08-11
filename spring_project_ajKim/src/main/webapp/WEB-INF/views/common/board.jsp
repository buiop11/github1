<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>고객감동센터</title>

<style>

/* -----게시판 시작 !! css ------ */

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
    
td{border-bottom:1px solid black; padding-top:10px; padding-bottom:10px;}
        
.write{
	width: 150px;
	margin: 0;
	height: 30px;
	font-size: 15px;
	border: 0;
	background-color: black;
	color:white;
	border-radius: 5px;
	float:right;
} 

.b_name{
	width:50%; 
	margin-bottom:20px;
	border-radius: 5px;
	background-color: #f3f3f3;
	line-height: 40px;
	font-weight:bold;
	text-align:center;
}

 
</style>

</head>
<body>
<form name="singIn" action="" method="get" onsubmit="return inputCheck();">
<!-- action을 안주면 같은 페이지 탄다.  -->
 
<!-------목록보여주기 header------->
<%@ include file="header.jsp" %>
 
 
 <!------게시판  시작~~----->
  <!-- !!!!!!!!!!!!!전체 중앙 정렬 !!!!!!!!!!!!!!!!!  -->
        

    <div style="margin: 0 auto; width: 1200px;">
	      
	    <h1>고객 감동 센터 </h1>
	    <hr>
	    <div class = "board_section" style= "width:1200px; height: 1050px; margin-top:50px;">
	    
	    <div style="margin-bottom: 50px;"><img src="${root}cscenter_top.jpg"></div>
	    
	    <div class= "b_name"> 문의/상담 게시판 </div> 
   		<hr>

	      <table class="board">
	      	
	      	<tr style="background-color: lightgrey;">
	      		<th style="width:50px;  height:60px;">글번호(num/ref/r_step/r_level) </th>
	      		<th style="width:500px;">제목</th>
	      		<th style="width:200px;">작성자</th>
	      		<th style="width:200px;">작성일</th>
	      		<th style="width:100px;">조회</th>
	      		<th style="width:100px;">IP</th>
	      	</tr>
	      		
		      
	     
        <!-- 게시글이 있으면  게시글보이기   -->    
        <c:if test="${cnt > 0}">
            <c:forEach var="dto" items="${boardList}"> 
            <!-- 객체들의 모임 arrayList라서 forEach돌려야함!! -->
                
                <tr>
                    <td align="center">
                        ${number}
                        <c:set var="number" value="${number -1}" />
                        (${dto.num} / ${dto.ref} / ${dto.ref_step} / ${dto.ref_level})        
                        <!-- 보여지는 글번호  -->
                    </td>
                    
                    <td align="left"> <!--  글제목 !!!!!!!!!!!!!!!  -->
                    
                                <!--  답글인 경우 : 들여쓰기 > 1 , 이경우는 > 0 인경우도 함께 붙는다. -->
                                <c:if test="${dto.ref_level > 1}">
                                    <c:set var="wid" value="${(dto.ref_level -1) * 10}" />
                                    <img src ="${root}level.gif" border="0" width="${wid}">  <!-- 공백의 이미지 파일  width를 조정  -->
                                </c:if>
                                
                                
                                <!-- 답글인 경우 : 들여쓰기 > 0  -->
                                <c:if test="${dto.ref_level > 0}">
                                    <img src ="${root}re.gif" border="0" width="20"> 
                                </c:if>
                                
                                
                                <!-- hot 이미지 -->
                                <c:if test="${dto.readCnt > 10}">        <!-- 조회수가 10보다 큰 경우  -->
                                    <img src ="${root}hot.gif" border="0" width="20"> 
                                </c:if>
                    
                    
                        <!-- 상세페이지  key, pageNum을  (+보여지는 숫자 number도) 가지고 가야한다. -->
                        <a href="contentForm?num=${dto.num}&pageNum=${pageNum}&number=${number+1}">${dto.getSubject()}</a>        
                        <!--  dto.subject로도 가져올 수 있다. -->
                    </td>
                    
                    <td align="center">
                        ${dto.writer}
                    </td>
                    
                    <td align="center"> 
                        <fmt:formatDate type="both" pattern="yyyy-MM-dd HH:mm" value="${dto.reg_date}" />
                    </td>
                    
                    <td align="center">
                        ${dto.readCnt}
                    </td>
                    
                    <td align="center">
                        ${dto.ip}
                    </td>
                    
                </tr>
                
            </c:forEach>
        </c:if>
    
    
        <!-- 게시글이 없으면  -->    
        <c:if test="${cnt < 0}">
            <tr>
                <td colspan="6" align="center">
                    게시글이 없습니다. 글을 작성해주세요!!
                </td>
            </tr>
        
        </c:if>
    
    </table>
    
    
    <!-- 페이지 컨트롤  -->
    <table style="width:1000px;" align="center">
        <tr>
            <th align="center">
            
            <!-- 검색시에도 페이징 처리 -->
            <c:set var="addParam" value="searchCategory=${param.searchCategory}&searchInput=${param.searchInput}" />
            
                <!-- 게시글 있으면  -->
                <c:if test="${cnt > 0}">
                    <!-- 특수문자 : ㅁ + 한자키 -->
                    <!-- 처음[◀◀] / 이전블록 [◀] -->
                    <c:if test="${startPage > pageBlock}">
                        <a href="board">[◀◀]</a>
                        <a href="board?${addParam}&pageNum=${startPage - pageBlock}">[◀]</a>
                    </c:if>
                    
                    
                    <!-- 블록내의 페이지 번호  forEach문 돌리기-->
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <c:if test="${i == currentPage}">
                            <span><b>[${i}]</b></span>
                        </c:if>
                        
                        <c:if test="${i != currentPage}">
                            <span><b><a href="board?${addParam}&pageNum=${i}">[${i}]</a></b></span>
                        </c:if>
                    </c:forEach>
                    
                
                    <!-- 다음블록 [▶] / 끝 [▶▶] -->
                    <c:if test="${pageCount > endPage}">
                        <a href="board?${addParam}&pageNum=${startPage + pageBlock}">[▶]</a>
                        <a href="board?${addParam}&pageNum=${pageCount}">[▶▶]</a>
                        <!-- 전체페이지를 세서  -->
                    </c:if>
                </c:if>
            </th>
        </tr>
        
    </table>
    

			<!-- 검색 기능 (이름, 제목으로 검색!)  -->    
	      <div style="margin-top:50px;">
		      <div class="boardSearch" style="float:left;">
		      		<input type="radio" name="searchCategory" value="writer"
		      			${(param.searchCategory == '' || param.searchCategory == 'writer' || param.searchCategory == null)? 'checked' :''}
		      		>이름	<!-- input 태그 안에 checked 처리는 text임 / 기본 값으로 null 이나 '' 일때 다 체크함 -->
		      		<input type="radio" name="searchCategory" value="subject"
		      			${(param.searchCategory == 'subject')? 'checked' : ''}
		      		>제목
		      		<input type="text" name="searchInput">	<!-- 입력값  -->
		      		<input type="submit" value="검색">
		      </div>	
		      	
		      	
	<!-- 문의 작성 누르면 !! 로그인을 하세요 팝업 띄우기????? ==> 걍 비회원도 글쓰게 하자...ㅠㅠ -->	
		      <div style="float:right;"> 
		      		<a href="writeForm?pageNum=${pageNum}"><input type="button" class="write" value="문의 작성"></a>
		      </div>
	      </div>
	      	
	    </div>
    </div>

 
<!------화면 맨 하단 footer------>
<%@ include file="footer.jsp" %>
 
</form> 
</body>
</html>
