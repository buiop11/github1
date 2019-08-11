<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>관리자 - 주문/승인 관리 </title>
<style>
.menu ul li {
    float:left;
    list-style: none;
    margin-right: 20px;
}
a {text-decoration: none; font-weight: bold;}
.content table tr td {border: 1px solid black;}
.tabel_th{border: 1px solid black; background-color:lightgrey; align:center;}
.product_list tr td img {width:80px; height:80px;}

#order{border-bottom:2px dotted white;} /* 밑줄 표시하기 header file에 있는 id값 css적용 */

.Pstyle { /* 상세보기 팝업 창 크기  */
   opacity : 0;
   display : none;
   position : relative;
   width : 600px;  height: 650px;
   border : 5px solid #fff;
   padding : 20px;
   background-color : #fff;
   margin-top:50px;
}
.b-close {
   position : absolute;
   right : 5px; top : 5px;
   padding : 0px; /* padding : 5px; */
   display : inline-block;
   cursor : pointer;
}
#state{font-weight:bold; font-size:20px; color:#F15F5F; text-align:center; margin-bottom:5px;}
.text_box{
      width: 100%; margin: 0;
      line-height: 56px; height: 56px;
      color: #777777; font-size: 15px;
      border: 0; background-color: #f3f3f3;
      border-radius: 5px;
} 

</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="http://dinbror.dk/bpopup/assets/jquery.bpopup-0.11.0.min.js"></script>
<!-- <script src="http://dinbror.dk/bpopup/assets/jquery.easing.1.3.js"></script> -->
<script type="text/javascript">
 
    function o_detail(id){
    	$("#"+id).bPopup(); 
    	
    }
 
</script>
</head>
<body>

<!-- 관리자 메인  -->
<%@ include file="ad_header.jsp" %>

<section style="width:1200px; height: 1000px; margin:0 auto; margin-bottom:50px;">

	<br>
	<div class="content" style="width:1200px; height: 1100px;">
		<br>
	
		<!-- 검색 기능  -->
		<form action="" method="get">
		
		<fieldset>
			<legend>검색</legend>
				<ul>
					<!-- <li>기간<input type="date">~<input type="date"></li> -->
					<!-- <li>상품코드명<input type="search"></li> -->
					<li>상품명<input type="search" name="productName"></li>
					<li>회원아이디 <input type="search" name="memberId"></li>
					<li>상태값 확인  <br>
						<input type="radio" name="state" value="결제요청">결제요청
						<input type="radio" name="state" value="환불요청">환불요청
						<input type="radio" name="state" value="환불완료">환불완료
						<input type="radio" name="state" value="주문확정">주문확정
					</li> 
				</ul>
				
				<div style="float:right;">
					<input type="submit" value="검색">
				</div>	
		
		</fieldset>
		</form>
		
		<br> 
		<hr>
		<br> 
	
	    <table class="product_list" style="width:1200px; margin-bottom: 10px; border-radius:5px;">
            
                <tr>
                	<th class="tabel_th">번호</th>
                	<th class="tabel_th">고객ID</th>
                	<th class="tabel_th">주문일자</th>
                    <th class="tabel_th">환불일자</th>
                    <th class="tabel_th" style="width:80px;">이미지</th>
                    <th class="tabel_th">주문정보</th>
                    <th colspan="2" class="tabel_th" style="width:200px;">상태처리</th>
                </tr>
                
        <c:if test="${cnt > 0}"> <!-- 환불 주문이 있으면! /취소완료는 결제완료 전 취소처리하는거 -->
               <c:forEach var="dto" items="${orderList}" varStatus="aa">
             <form action="stateUpdate" name="" method="get"> <!-- foreach문 안에 있어야! 한개씩 전송!! -->
                <tr>
                	<td> ${dto.o_num}</td>
                	<td> ${dto.id}</td>
                    <td>
                        <fmt:formatDate type="both" pattern="yyyy-MM-dd" value="${dto.o_date}" />
                    	
                    </td>
                    <td>
                        <fmt:formatDate type="both" pattern="yyyy-MM-dd" value="${dto.r_date}" />
                    </td>   
                    <td><img src="${root}p_detail/${dto.p_image}"></td>
                    <td>
                        <p class="p_info">${dto.p_name}</p>
                        <p class="p_option" style="margin-top:0px;">
                        	 수량: <span>${dto.o_count}</span>개 / 결제금액: <span><fmt:formatNumber value="${dto.o_price}" pattern="#,###" /></span>원 </p>
                    </td>
                    
                    <td><div id="state">${dto.state}</div>
                    
                    <div align="center">
						<c:if test="${dto.state == '결제요청'}">
							<input type="submit" value="결제완료처리"> 
						</c:if>		
						<c:if test="${dto.state == '환불요청'}">
							<input type="submit" value="환불완료처리"> 
						</c:if>				
					</div>
                    
                    </td>
                    
                    <td>
                    <div align="center">
                    	<input type="button" value="주문 상세보기" class="order_detail" onclick="o_detail('o_detail${aa.count}');"
                    	style="width:120px; height:35px; line-height: 40px; margin-top:3px;">
                    </div>	
              
      <!-- 주문 상세정보 팝업 띄우기 -->              	
     <div class="Pstyle" id="o_detail${aa.count}">
     <span class="b-close"><img src="${root}m_top_close.png" style="width:30px; height:30px"></span>
      <div class="popup_user" style="height:auto; width:600px; padding-top:50px;"> 
	       <div style="font-weight:bold; font-size:20px; padding-bottom:20px;">[주문 상세 보기]</div>
	       <div>상품명 :  <input type="text" class="text_box" value="${dto.p_code}(${dto.p_name})" disabled></div>
	       <div>받는분 : <input type="text" class="text_box" value="${dto.o_name}" disabled></div>
	       <div>연락처: <input type="text"  class="text_box" value="${dto.o_phone}" disabled></div>
	       <div>배송지 : <input type="text" class="text_box" value="${dto.address}" disabled></div>
	       <div>결제금액 : <input type="text" class="text_box" value="<fmt:formatNumber value="${dto.o_price}" pattern="#,###" />원" disabled></div>
      	   <div>현재상태 : <input type="text"  class="text_box" value="${dto.state}" disabled></div>
      	   <div>★처리자 : <input type="text" class="text_box" value="${dto.admin_id}" disabled></div>
      		
      		<!-- 없는거 여기서 보내기  -->
      		<input type="hidden" name="o_num" value="${dto.o_num}">
      		<input type="hidden" name="id" value="${dto.id}">
      		<input type="hidden" name="p_code" value="${dto.p_code}">
      		<input type="hidden" name="p_name" value="${dto.p_name}">
      		<input type="hidden" name="p_image" value="${dto.p_image}">
      		<input type="hidden" name="o_name" value="${dto.o_name}">
      		<input type="hidden" name="o_phone" value="${dto.o_phone}">
      		<input type="hidden" name="address" value="${dto.address}">
      		<input type="hidden" name="o_count" value="${dto.o_count}">
      		<input type="hidden" name="o_price" value="${dto.o_price}">
      		<input type="hidden" name="state" value="${dto.state}">
	      		
      </div>
 	  </div> 
                    </td>
                </tr>    
                
                </form>
                </c:forEach>
      </c:if> 
     
       <!-- 주문건이 하나도 없으면 , 결제랑은 전혀 관련 없음 ㅠㅠ  -->
       <c:if test="${cnt < 0 || cnt == 0}">
      		<tr>
                <th colspan="6" align="center" style="padding-top:40px; padding-bottom:30px;">
                   		내역이 없습니다. 
                </th>
            </tr>
       </c:if>
       
  
    </table>

   <!-- 페이지 컨트롤  -->
    <table style="width:1000px;" align="center">
        <tr>
            <th align="center">
            
                <!-- 게시글 있으면  -->
                <c:if test="${cnt > 0}">
                    <!-- 특수문자 : ㅁ + 한자키 -->
                    <!-- 처음[◀◀] / 이전블록 [◀] -->
                    <c:if test="${startPage > pageBlock}">
                        <a href="order">[◀◀]</a>
                        <a href="order?pageNum=${startPage - pageBlock}">[◀]</a>
                    </c:if>
                    
                    <!-- 블록내의 페이지 번호  forEach문 돌리기-->
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <c:if test="${i == currentPage}">
                            <span><b>[${i}]</b></span>
                        </c:if>
                        
                        <c:if test="${i != currentPage}">
                            <span><b><a href="order?pageNum=${i}">[${i}]</a></b></span>
                        </c:if>
                    </c:forEach>
                    
                
                    <!-- 다음블록 [▶] / 끝 [▶▶] -->
                    <c:if test="${pageCount > endPage}">
                        <a href="order?pageNum=${startPage + pageBlock}">[▶]</a>
                        <a href="order?pageNum=${pageCount}">[▶▶]</a>
                        <!-- 전체페이지를 세서  -->
                    </c:if>
                </c:if>
            </th>
        </tr>
        
    </table>            
	
	</div>

</section>

 <!-----화면 맨 하단 footer-------->
 <%@ include file="ad_footer.jsp" %>


</body>
</html>