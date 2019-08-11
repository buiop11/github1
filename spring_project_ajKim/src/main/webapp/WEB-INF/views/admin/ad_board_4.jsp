<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ad_setting.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>관리자 - 게시판 관리 </title>
<style>
.menu ul li {
	float:left;
	list-style: none;
	margin-right: 20px;
}

a {font-weight: bold; text-decoration:none;}
.content table tr td {border-bottom: 1px solid black; padding-top:10px; padding-bottom:10px;}
.tabel_th{height:40px;background-color:lightgrey;}
.product_list tr td img {width:80px; height:80px;}


#board{border-bottom:2px dotted white;} /* 밑줄 표시하기 header file에 있는 id값 css적용 */
</style>
</head>
<body>

<!-- 관리자 메인 로고  -->
<%@ include file="ad_header.jsp" %>

<!-- 본문시작 -->

<form action ="" method="get">

<section style="width:1200px; height: 900px; margin:0 auto; margin-bottom:50px;">
	<br>
	<div class="content" style="width:1200px;">
		<fieldset>
			<legend>게시글 등록</legend>
			<input type="button" value="게시글 등록하기" onclick="window.location='board_write?pageNum=${pageNum}'">
		</fieldset>
		<br>
	
		<!-- 검색 기능/ common 게시판에 있는것과 동일   -->
		<fieldset>
			<legend>검색</legend>
				<ul>
					<lo>
						작성자<input type="radio" name="searchCategory" value="writer"
		      			${(param.searchCategory == '' || param.searchCategory == 'writer' || param.searchCategory == null)? 'checked' :''}
						>
						제목<input type="radio" name="searchCategory" value="subject"
						${(param.searchCategory == 'subject')? 'checked' : ''}
						>
						<input type="text" name="searchInput" >
					</lo>
				</ul>
				
				<div style="float:right;">
					<input type="submit" value="검색" >
				</div>	

		
		</fieldset>
		
		
		<br> 
		<hr>
		<br> 
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
                        <a href="board_detail?num=${dto.num}&pageNum=${pageNum}&number=${number+1}">${dto.getSubject()}</a>        
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
	
	
	</div>
	
</section>
</form>

 <!-----화면 맨 하단 footer---->
 <%@ include file="ad_footer.jsp" %>

</body>
</html>