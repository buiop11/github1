<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>ARTBOX0 - 인형/토이 상품 리스트 </title>

<style>
#content .mainImg {width: 100%;} /* --> 양면도 다 늘리려면?? */

.ProductTitle {
    float: left;
    width: 1200px;
    height: 50px;
    font-weight: bold;
    /* 
    line-height: 30px;
    text-align: left;
    margin-bottom: 20px;
    margin-top: 20px;
     */
    font-size: 25px;
    margin-top : 40px;
}

/* -------------- 상품 목록  ---------------- */
.mainName span{font-size: 40px; font-weight:bold;}
.selectBox{float:right;}
li{float:left;  list-style: none;}
.itemList {width:1200px; height:auto;}

</style>
 
 
</head>
<body>
 
<!-------목록보여주기 header------>
<%@ include file="header.jsp" %> 
 
 
    <!------------------------------------중간본문 section---------------------------------------------->
        <!-- !!!!!!!!!!!!!전체 중앙 정렬 !!!!!!!!!!!!!!!!!  -->
 
    <div style="margin: 0 auto; width: 1200px;  height:auto; margin-bottom:200px;" >
        
        <div class="content" >
			
		<section>	<!-- 토이/ 인형  category가 T 일때 -->
		<c:if test="${category == 'T'}">
		
			<div class="mainImg">
	            <a href="" alt="">
		            <img src="${root}toy_pro/CategoryTopImage255.jpg" style="float:left"> <!-- 젤큰 메인페이지 -->
		            <p class="mainName" style="width:250px; position:absolute; margin-top:280px; padding-left:20px; margin-left:30px">
		            	<span>인형/토이</span></p></a>
	        </div>
	    </c:if>
	    
	    <!-- 문구  category가  M일때 -->
	    <c:if test="${category == 'M'}"> 
		
			<div class="mainImg">
	            <a href="" alt="">
		            <img src="${root}fancy_pro/CategoryTopImage256.jpg" style="float:left"> <!-- 젤큰 메인페이지 -->
		            <p class="mainName" style="width:250px; position:absolute; margin-top:280px; padding-left:20px; margin-left:30px">
		            	<span>문구</span></p></a>
	        </div>
	    </c:if>
	   
	    <!-- 리빙/데코  category가  L일때 -->
	   <c:if test="${category == 'L'}">
		
			<div class="mainImg">
	            <a href="" alt="">
		            <img src="${root}living_pro/CategoryTopImage259.jpg" style="float:left"> <!-- 젤큰 메인페이지 -->
		            <p class="mainName" style="width:250px; position:absolute; margin-top:280px; padding-left:20px; margin-left:30px">
		            	<span>리빙/데코</span></p></a>
	        </div>
	    </c:if>
	    
	    <!-- 디지털/가전  category가  D일때 -->
	    <c:if test="${category == 'D'}">
		
		<div class="mainImg">
	            <a href="" alt="">
		            <img src="${root}digital_pro/CategoryTopImage260.jpg" style="float:left"> <!-- 젤큰 메인페이지 -->
		            <p class="mainName" style="width:250px; position:absolute; margin-top:280px; padding-left:20px; margin-left:30px">
		            	<span>디지털/가전</span></p></a>
	        </div>
	    </c:if>
	    
	    
   	    <!-- 검색값 input 이 있을때 -->
	    <c:if test="${input == '' || input != null}">
		
		<div class="mainImg">
	            <a href="" alt="">
		            <img src="${root}toy_pro/CategoryTopImage255.jpg" style="float:left"> <!-- 젤큰 메인페이지 -->
		            <p class="mainName" style="width:250px; position:absolute; margin-top:280px; padding-left:20px; margin-left:30px">
		            	<span>검색값 확인 </span></p></a>
	        </div>
	    </c:if>
	    
	    
	        
	        <div><p>전체</p></div>	
		
			<div class="info">
				<span class="result">총 <strong>${cnt}</strong>개의 상품이 조회되었습니다.</span>
				<span class="selectBox">
					<select name="ord">			<!-- 자바스크립트 처리해야함.. -->
						<option value="01" selected="selected">신상품순</option>
						<option value="05" >인기상품순</option>
						<option value="02" >낮은가격순</option>
						<option value="03" >높은가격순</option>
						<option value="04" >높은할인율순</option>
						<option value="06" >상품평순</option>
						
					</select>
				
				</span>
			</div>
			
<!------ 여기서 부터는 상품 리스트~ ------>
		
    
      <!-- 상품이 있으면    -->    
      <c:if test="${cnt > 0}">
      <c:forEach var="dto" items="${productList}"> 
      
         <ul class= "itemList">
                
           <li>        
               <span class="itemImg">
                   <a href="product_content?p_code=${dto.p_code}" alt="" title="${dto.p_name}">
                   
                   <c:if test="${dto.p_image == null}"> <!-- 이미지가 없을때 보여줄 것 -->
                   		<img src="${root}noimage.png">
                   </c:if>
				   <c:if test="${dto.p_image != null}">
				   		<img src="${root}p_detail/${dto.p_image}">
				   </c:if>
                   
                   <br>
                   ${dto.p_name}(${dto.p_code})<br>
                   <strong><fmt:formatNumber value="${dto.p_price}" pattern="#,###" />원</strong><img src="${root}new.png"></a>
                   <br><br>
               </span>
           </li>  
       
        </ul>      
      </c:forEach>
      </c:if>
  
  
      <!-- 게시글이 없으면  -->    
      <c:if test="${cnt < 0}">
       <table>
          <tr>
              <td>
                  		등록된 상품이 없습니다.!! 
              </td>
          </tr>
       </table> 
      </c:if>
  
		
	    <!-- 페이지 컨트롤  -->
    <table style="width:1000px; padding-top:100px;" align="center">
        <tr>
            <th align="center">
            
                <!-- 게시글 있으면  -->
                <c:if test="${cnt > 0}">
                    <!-- 특수문자 : ㅁ + 한자키 -->
                    <!-- 처음[◀◀] / 이전블록 [◀] -->
                    <c:if test="${startPage > pageBlock}">
                        <a href="product_list?category=${category}">[◀◀]</a>
                        <a href="product_list?pageNum=${startPage - pageBlock}">[◀]</a>
                    </c:if>
                    
                    
                    <!-- 블록내의 페이지 번호  forEach문 돌리기-->
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <c:if test="${i == currentPage}">
                            <span><b>[${i}]</b></span>
                        </c:if>
                        
                        <c:if test="${i != currentPage}">
                            <span><b><a href="product_list?pageNum=${i}">[${i}]</a></b></span>
                        </c:if>
                    </c:forEach>
                    
                
                    <!-- 다음블록 [▶] / 끝 [▶▶] -->
                    <c:if test="${pageCount > endPage}">
                        <a href="product_list?pageNum=${startPage + pageBlock}">[▶]</a>
                        <a href="product_list?pageNum=${pageCount}">[▶▶]</a>
                        <!-- 전체페이지를 세서  -->
                    </c:if>
                </c:if>
            </th>
        </tr>
        
    
    </table>
		</section>
	        
		</div>
    </div>


 
 <!-------화면 맨 하단 footer--------->
 <%@ include file="footer.jsp" %>
 
 
</body>
</html>
