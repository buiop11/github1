<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title> 마이페이지 </title>
 
<style>
/* -------------------------- mypage 시작 !! css ----------------------------- */
.Tbox1, .Tbox2, .Tbox3 {float:left; list-style: none; width: 200px; height:145px; 
    background-color: white;  margin-left:33px;}
.Tbox1 .GName {
    margin-top: 24px; display: block;
    font-size: 23px;font-weight: bold;
    text-align: center;
}
.Tbox1 .GImg {
    margin: 6px auto 0 auto;  display: block;
    width: auto; height: 35px;
}
.Tbox1 .GSee {
    margin-top: 3px; display: block;
    font-size: 17px;text-align: center;
}
.Tbox2 .CImg {
    margin: 30px auto 0 auto; display: block;
    width: 54px;height: 30px;
}
.Tbox2 .CCandy {
    margin-top: 10px; display: block;
    font-size: 47px; font-weight: bold;
    text-align: center; color: #94b7d1;
}
.Tbox3 span:nth-child(1) {
    display: block;font-size: 20px;
    text-align: center; color: #646464;
    margin-bottom: 10px; margin-top: 25px;
}
.Tbox3 span:nth-child(2) {
    display: block;font-size: 47px;
    text-align: center; color: #e71e22;
}
.MenuBar_Box {width: 100%;}
.MenuBar_Box li {
    cursor: pointer; text-align: center;
    font-size: 20px;color: #999999;
    background-color: #f4f4f4;
    border-bottom: 1px solid #000000;
    width: 200px; height: 65px;
    line-height: 65px;float:left;
    list-style:none; border-radius: 5px;
    margin-right: 10px; margin-bottom: 50px; margin-left: 65px;
    
}
table tr td img {width: 100px; height:100px;}
.tab_menu {width: 1200px; height: auto;}
table {margin-top:100px;}
.tabel_th {height: 40px; background :#f4f4f4; border-radius: 5px;}
.search select {
    margin: 0; line-height: 56px;
    height: 40px; font-size: 15px;
    border: 1px solid black; border-radius: 5px;    
    float:right;    
} 

.p_info{text-align:left; margin:0px; font-size:15px; font-weight:bold;}
.p_option{text-align:left; font-size:15px;margin:5px; color:grey; }

input[type=email], input[type=button],
input[type=tel], .text_box{
      width: 100%; margin: 0;
      line-height: 56px; height: 56px;
      color: #777777; font-size: 15px;
      border: 0; background-color: #f3f3f3;
      border-radius: 5px;
} 
 
input[type=password]{
      width: 50%; margin: 0;
      line-height: 56px; height: 56px;
      font-size: 15px; border: 0;
      background-color: #f4f4f4; border-radius: 5px;
}

#modi_button{
	width:150px; folat:right;
	border-radius:5px;line-height: 56px;
    height: 56px;background-color:#8C8C8C;
	color:white;margin-top:10px;
}

table td{border-bottom: #cccccc 1px dotted;}

.Pstyle { /* 상세보기 팝업 창 크기  */
   opacity : 0;
   display : none;
   position : relative;
   width : 600px;  height: 650px;
   border : 5px solid #fff;
   padding : 20px;
   background-color : #fff;  margin-top:50px;
}
.b-close {
   position : absolute;
   right : 5px; top : 5px;
   padding : 0px; /* padding : 5px; */
   display : inline-block;
   cursor : pointer;
}


</style>
 
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="http://dinbror.dk/bpopup/assets/jquery.bpopup-0.9.4.min.js"></script>
<script src="http://dinbror.dk/bpopup/assets/jquery.easing.1.3.js"></script>
<script type="text/javascript">
 
    $(function(){
        // display는 section에 적용함 !
        $("#order").click(function(){ 
            $("#menu_1").css("display","block");
            $("#menu_2").css("display","none");
            $("#menu_3").css("display","none");
            $("#menu_4").css("display","none");
            $("#order").css("background-color","#8C8C8C");
            $("#refund").css("background-color","#f3f3f3");
            $("#board").css("background-color","#f3f3f3");
            $("#customer").css("background-color","#f3f3f3");
            $("#order").css("color","white");
            $("#refund").css("color","#777777");
            $("#board").css("color","#777777");
            $("#customer").css("color","#777777");
        });
        
        $("#refund").click(function(){
             $("#menu_1").css("display","none");
             $("#menu_2").css("display","block");
             $("#menu_3").css("display","none");
             $("#menu_4").css("display","none");
             $("#order").css("background-color","#f3f3f3");
             $("#refund").css("background-color","#8C8C8C");
             $("#board").css("background-color","#f3f3f3");
             $("#customer").css("background-color","#f3f3f3");
             $("#order").css("color","#777777");
             $("#refund").css("color","white");
             $("#board").css("color","#777777");
             $("#customer").css("color","#777777");
        });
        
        $("#board").click(function(){
             $("#menu_1").css("display","none");
             $("#menu_2").css("display","none");
             $("#menu_3").css("display","block");
             $("#menu_4").css("display","none");
             $("#order").css("background-color","#f3f3f3");
             $("#refund").css("background-color","#f3f3f3");
             $("#board").css("background-color","#8C8C8C");
             $("#customer").css("background-color","#f3f3f3");
             $("#order").css("color","#777777");
             $("#refund").css("color","#777777");
             $("#board").css("color","white");
             $("#customer").css("color","#777777");
        });
        
        $("#customer").click(function(){
             $("#menu_1").css("display","none");
             $("#menu_2").css("display","none");
             $("#menu_3").css("display","none");
             $("#menu_4").css("display","block");
             $("#order").css("background-color","#f3f3f3");
             $("#refund").css("background-color","#f3f3f3");
             $("#board").css("background-color","#f3f3f3");
             $("#customer").css("background-color","#8C8C8C");
             $("#order").css("color","#777777");
             $("#refund").css("color","#777777");
             $("#board").css("color","#777777");
             $("#customer").css("color","white");
        });
	        
    });
    
    function o_detail(id){
    	$(id).bPopup();
    }
 
    
    function stateChk(state){
    	
    	console.dir(this); //꿀팁(?)
    	
    	if(state == '주문확정'){
    		$("#state").val('주문확정');
    		confirm("주문확정시 환불이 불가능합니다. \n 확정처리 하시겠습니까?");
    	}
    
    	$("#stateUpdateForm").submit();	
    	// button에 submit 기능 심기
    }
    
    
</script>
 
 
</head>
<body onload="">
 
<!-------목록보여주기 header------->
<%@ include file="../common/header.jsp" %>
 
 
 
    <!--------- 게시판  시작~~~~~~ ----------->
        <!-- !!!!!전체 중앙 정렬 !!!!!!!  -->
   
    <div style="margin: 0 auto; width: 1200px;">
 
 
         <section style="width: 1200px;">
             <div class="myPage" style="background-color: #f5f5f5; border-radius: 30px; margin-top: 40px;">
                 <br>
                 <p style="font-size: 20px; padding-left:33px;"> 안녕하세요, 
                 <big style="font-weight:bold;"><sec:authentication property="principal.username" /></big>님! 
                 <!-- password는 null 값... ㅠㅠ  -->
                 
                 	<sec:authorize access="isAuthenticated()"> <!-- 인증된게 있으면  -->
						<a href="<c:url value='/j_spring_security_logout'/>">
						<input type="button" style="width:150px; height:50px; font-size:18px;" 
                 		value="로그아웃"></a>
                 	<%-- <input type="button" style="width:150px; height:50px; font-size:18px;" 
                 		value="로그아웃" onclick="<c:url value='/j_spring_security_logout'/>"> --%>
					</sec:authorize>
                 </p>
                 <hr>
                 <br>
                 <ul style="padding:0px; height:200px;">
                     
                     <!-- 등급 혜택보기  -->
                     <li class="Tbox1">    
                        <span class="GName grade5">SILVER</span>
                        <img class="GImg" src="${root}pc_top_grade5.png">
                        <span class="GSee grade5">[등급혜택보기]</span>                    
                    </li>
                     
                     <!-- 캔디 -->
                     <li class="Tbox2">
                        <img class="CImg" src="${root}common_img_koomcandy.png">
                        <span class="CCandy">172</span>
                    </li>
                    
                    <li class="Tbox3"> 
                    <!-- ★★ ★★   오늘 날짜로 다시 검색기능만들면 그걸로 수정 ★★  ★★    -->
                    <!-- 게시판이랑 주문이랑 겹쳐서 막 나옴.  -->
                        <span>주문/배송</span><span>${cnt}</span>
                     </li>
                     
                     <li class="Tbox3">
                        <span>쿠폰</span><span>2</span>
                     </li>
                            
                     <li class="Tbox3">
                        <span>구매후기</span><span>0</span>
                    </li>
                    
                 </ul>
             
             </div>
         
         
         </section>
     
     
         <div class="MenuBar_Box">
            <ul style="padding-left:25px;">
                <li id="order" style="background-color:#8C8C8C; color:white;">주문/배송</li>
                <li id="refund">취소/환불</li>
                <li id="board">1:1 문의/상담</li>
                <li id="customer">회원정보 변경</li>
            </ul>
        
        </div>
        
    <!----------------탭 메뉴 ----------------->
        
        <!------- 1. 주문/배송  ------->
        
        
        <section class="tab_menu" id="menu_1" style="display:block; margin-bottom: 100px;" >     
            
            <table style="width:1000px; text-align:center;  margin:0 auto">
            
                <tr>
                    <td colspan="5">
                        <div style="font-size: 20px; font-weight:bold; text-align: left; padding-bottom: 10px;"> 최근 주문 내역 </div>
                    </td>
                    
                    <td>
                    <select style="float:right;">
                        <option>최근 1개월</option>
                        <option>최근 3개월</option>
                        <option>최근 6개월</option>
                    </select>
                    </td>
                </tr>
                
                <tr>
                	<th class="tabel_th" style="width:50px">번호</th>
                    <th class="tabel_th" style="width:200px">주문일자</th>
                    <th class="tabel_th" style="width:110px">이미지</th>
                    <th class="tabel_th" style="width:550px">주문정보</th>
                    <th class="tabel_th" style="width:150px">상태</th>
                    <th class="tabel_th" style="width:200px">확인/신청</th>
                </tr>
                
          
                
       <%--  <c:if test="${cnt > 0}"> <!-- 주문이 있으면! --> --%>
                <c:forEach var="dto" items="${orderList}" varStatus="aa">
         <form action="cancleUpdate" id="stateUpdateForm" name="stateUpdateForm" method="post"  >
        <c:if test="${dto.state =='결제완료' || dto.state =='결제요청' || dto.state =='주문확정'}"> 
        <!-- 여기는 탭이 주문진행 상태, 환불/취소상태 탭이 2개로 나뉘어져 있음.! -->
                <tr>
                	<td> ${number} <c:set var="number" value="${number -1}" /></td>
                    <td>
                        <fmt:formatDate type="both" pattern="yyyy-MM-dd" value="${dto.o_date}" />
                    	<div>
                    	<input type="button" value="주문 상세보기" class="order_detail" onclick="o_detail('#o_detail${aa.count}');"
                    	style="width:120px; height:40px; line-height: 40px;">
                    	</div>	
              
      <!-- 주문 상세정보 팝업 띄우기 -->              	
     <div class="Pstyle" id="o_detail${aa.count}">
     <span class="b-close"><img src="${root}m_top_close.png" style="width:30px; height:30px"></span>
      <div class="content2" style="height:auto; width:600px; padding-top:50px;"> 
	       <div style="font-weight:bold; font-size:20px; padding-bottom:20px;">[주문 상세 보기]</div>
	       <div>주문일자 : <input type="text" class="text_box" value="<fmt:formatDate type="both" pattern="yyyy년 MM월 dd일 /HH시mm분" value="${dto.o_date}" />" disabled></div>
	       <div>상품명 :  <input type="text" class="text_box" value="${dto.p_code}(${dto.p_name})" disabled></div>
	       <div>받는분 : <input type="text" class="text_box" value="${dto.o_name}" disabled></div>
	       <div>연락처: <input type="text" class="text_box" value="${dto.o_phone}" disabled></div>
	       <div>배송지 : <input type="text" class="text_box" value="${dto.address}" disabled></div>
	       <div>결제금액 : <input type="text" class="text_box" value="<fmt:formatNumber value="${dto.o_price}" pattern="#,###" />원" disabled></div>
      	   <div>처리상태 : <input type="text" class="text_box" value="${dto.state}" disabled></div>
      
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
      		<input type="hidden" name="o_date" value="${dto.o_date}">
      
      </div>
 	  </div>
                    </td>
                    <td><img src="${root}p_detail/${dto.p_image}"></td>
                    <td>
                        <p class="p_info">${dto.p_name}</p>
                        <p class="p_option"> 수량: <span>${dto.o_count}</span>개 / 결제금액: <span><fmt:formatNumber value="${dto.o_price}" pattern="#,###" /></span>원 </p>
                                         
                    </td>
                    <td><span style="font-weight:bold; font-size:20px; color:#F15F5F;">${dto.state}</span></td>
                    <td> 
                    	<!--★★ 
                    	결제요청 --: 취소처리 (결제승인전 취소처리, 바로환불) 
						결제완료 --: 환불요청 (결제완료후 취소처리, 환불승인후 환불완료로 변경) -->
						
                    	<c:if test="${dto.state == '결제요청'}">
	                    	<!-- 관리자 상태변경이랑 동일! 프로시저 취소처리하고, 로그남김 -->
	                    	<input type="submit" value="취소처리" 
	                    		style="width:100px; height:40px; line-height: 40px; margin-top:10px; 
	                    		background-color:#8C8C8C; color:white;"> 
	                    		<input type="hidden" name="state" value="취소완료">
	                    		
	                    	<p style="margin:0px;"><small> '결제완료'전 주문 취소처리 </small></p>
                    	</c:if>
                    	<c:if test="${dto.state == '결제완료'}">
                    	
	                    	<input type="button" value="환불요청"  onclick="stateChk('환불요청');"
	                    		style="width:100px; height:40px; line-height: 40px; margin-top:10px; 
	                    		background-color:#8C8C8C; color:white;"> 
	                    		
	                    	<p style="margin:0px;"><small> '결제완료'후  취소처리</small></p>
	                    	
	                    	<!-- 주문확정처리 (결산에 반영)★★★ -->
                    		<input type="button" value="주문확정"  onclick="stateChk('주문확정');"
	                    		style="width:100px; height:40px; line-height: 40px; margin-top:10px; 
	                    		background-color:#8C8C8C; color:white;"> 

							<!-- state ★환불요청시 = 결제완료 넘김// 주문확정시 = 주문확정 넘김  -->
                    		<input type="hidden" id="state" name="state" value="결제완료">
	                    		
	                    	<p style="margin:0px;"><small> '주문확정'이후 환불 불가 </small></p>
	                    	
                    	</c:if>
                    	
                    </td>
                </tr>    
     </c:if> 
         </form>      
     <%--  <c:if test="${cnt < 0 || cnt == 0}"> --%>
      <c:if test="${cnt <= 0}">    
      		    <tr>
                <th colspan="6" align="center" style="padding-top:40px; padding-bottom:30px;">
                   		 주문 내역이 없습니다. 
                </th>
            </tr>
      </c:if>    
        </c:forEach>
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
                        <a href="myPage">[◀◀]</a>
                        <a href="myPage?pageNum=${startPage - pageBlock}">[◀]</a>
                    </c:if>
                    
                    <!-- 블록내의 페이지 번호  forEach문 돌리기-->
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <c:if test="${i == currentPage}">
                            <span><b>[${i}]</b></span>
                        </c:if>
                        
                        <c:if test="${i != currentPage}">
                            <span><b><a href="myPage?pageNum=${i}">[${i}]</a></b></span>
                        </c:if>
                    </c:forEach>
                    
                
                    <!-- 다음블록 [▶] / 끝 [▶▶] -->
                    <c:if test="${pageCount > endPage}">
                        <a href="myPage?pageNum=${startPage + pageBlock}">[▶]</a>
                        <a href="myPage?pageNum=${pageCount}">[▶▶]</a>
                        <!-- 전체페이지를 세서  -->
                    </c:if>
                </c:if>
            </th>
        </tr>
        
    </table>            
            
 </section>
        
        
        <!------- 2. 취소/환불  ------->
        
        <section class="tab_menu" id="menu_2" style="display:none; margin-bottom: 100px;">     
            
             <table style="width:1000px; text-align:center;  margin:0 auto">
            
                <tr>
                    <td colspan="5">
                        <div style="font-size: 20px; font-weight:bold; text-align: left; padding-bottom: 10px;"> 최근 주문 내역 </div>
                    </td>
                    
                    <td>
                    <select style="float:right;">
                        <option>최근 1개월</option>
                        <option>최근 3개월</option>
                        <option>최근 6개월</option>
                    </select>
                    </td>
                </tr>
                
                <tr>
                	<th class="tabel_th" style="width:50px">번호</th>
                    <th class="tabel_th" style="width:200px">환불일자</th>
                    <th class="tabel_th" style="width:110px">이미지</th>
                    <th class="tabel_th" style="width:550px">주문정보</th>
                    <th class="tabel_th" style="width:150px">상태</th>
                    <th class="tabel_th" style="width:200px">확인/신청</th>
                </tr>
                
      <%--   <c:if test="${cnt > 0}"> <!-- 환불 주문이 있으면! /취소완료는 결제완료 전 취소처리하는거 --> --%>
                <c:forEach var="dto" items="${orderList}" varStatus="aa">
        <c:if test="${dto.state =='환불완료' || dto.state =='환불요청' || dto.state == '취소완료'}">
                <tr name="refund_list">
                	<td> ${number} <c:set var="number" value="${number -1}" /></td>
                    <td>
                        <fmt:formatDate type="both" pattern="yyyy-MM-dd" value="${dto.r_date}" />
                    	<div>
                    	<input type="button" value="주문 상세보기" class="order_detail" onclick="o_detail('#o_detail${aa.count}');"
                    	style="width:120px; height:40px; line-height: 40px;">
                    	</div>	
              
      <!-- 주문 상세정보 팝업 띄우기 / ★★  에 ★★ 러 ★★  주문정보가 한번씩 밖에 안뜸...ㅋㅋㅋㅋㅋㅋㅋㅋ  -->              	
     <div class="Pstyle" id="o_detail${aa.count}">
     <span class="b-close"><img src="${root}m_top_close.png" style="width:30px; height:30px"></span>
      <div class="content2" style="height:auto; width:600px; padding-top:20px;"> 
	       <div style="font-weight:bold; font-size:20px; padding-bottom:20px;">[주문 상세 보기]</div>
	       <div>환불일자 : <input type="text" class="text_box" value="<fmt:formatDate type="both" pattern="yyyy년 MM월 dd일 /HH시mm분" value="${dto.r_date}" />" disabled></div>
	       <div>상품명 :  <input type="text" class="text_box" value="${dto.p_code}(${dto.p_name})" disabled></div>
	       <div>받는분 : <input type="text" class="text_box" value="${dto.o_name}" disabled></div>
	       <div>연락처: <input type="text" class="text_box" value="${dto.o_phone}" disabled></div>
	       <div>배송지 : <input type="text" class="text_box" value="${dto.address}" disabled></div>
	       <div>결제금액 : <input type="text" class="text_box" value="<fmt:formatNumber value="${dto.o_price}" pattern="#,###" />원" disabled></div>
      	   <div>처리상태 : <input type="text" class="text_box" value="${dto.state}" disabled></div>
      </div>
 	  </div>
                    </td>
                    <td><img src="${root}p_detail/${dto.p_image}"></td>
                    <td>
                        <p class="p_info">${dto.p_name}</p>
                        <p class="p_option"> 수량: <span>${dto.o_count}</span>개 / 결제금액: <span><fmt:formatNumber value="${dto.o_price}" pattern="#,###" /></span>원 </p>
                                         
                    </td>
                    <td><span style="font-weight:bold; font-size:20px; color:#F15F5F;">${dto.state}</span></td>
                    <td> 
                    	<!--★★ 
                    	환불요청 --: 관리자 승인후 환불완료처리 예정 (결제가 있으면 미환불상태 / 상품재고 복귀전 ) 
						환불완료 --: 환불처리 완료 (결제가 있으면 환불완료/ 상품 복귀완료!) -->
						
                    	<c:if test="${dto.state == '환불요청'}">
	                    	<p style="margin:0px;"><small> 관리자의 환불승인을 기다리고 있습니다. </small></p>
                    	</c:if>
                    	<c:if test="${dto.state == '환불완료'}">
                    	<!-- 환불완료처리도 된 상태에서 고객이 삭제를 누르면 실제 오더DB테이블 삭제가 아니라 뷰에서만 삭제됨. -->
	                    	<input type="button" value="삭제" id="order_delete${aa.count}" onclick="order_delete(id);"
	                    		style="width:100px; height:40px; line-height: 40px; margin-top:10px; 
	                    		background-color:#8C8C8C; color:white;">
	                    		
	                    		<script type="text/javascript">
									function order_delete(id){
										alert("삭제하나여?? " + id);
										var refund_list = document.getElementsByName("refund_list");
										alert(refund_list);
										refund_list.style.display = "none";
										/* 그 한줄만 지우려면 이렇게하면 안되고ㅠㅠ 구분할 수 있는 값이 있어야함..모르게써ㅠㅠ */
									}
								</script>
	                    		
	                    	<p style="margin:0px;"><small>결제가 취소완료되었습니다.(상품복귀도 완료)</small></p>
                    	</c:if>
                    	
                    </td>
                </tr>    
                
      </c:if>
             </c:forEach>
              
     
       <!-- id별, 주문건이 하나도 없으면 , 결제랑은 전혀 관련 없음 ㅠㅠ  -->
       <%-- <c:if test="${cnt < 0 || cnt == 0}"> --%>
      <c:forEach var="dto" items="${orderList}"> <!-- foreach문 안에있어서 다른 사람 주문건 만큼 내역이 없다고 찍힘 .ㅠㅠ  -->
       <c:if test="${cnt <= 0}">
      		<tr>
                <th colspan="6" align="center" style="padding-top:40px; padding-bottom:30px;">
                   		내역이 없습니다. 
                </th>
            </tr>
      </c:if>
        </c:forEach>
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
                        <a href="myPage">[◀◀]</a>
                        <a href="myPage?pageNum=${startPage - pageBlock}">[◀]</a>
                    </c:if>
                    
                    <!-- 블록내의 페이지 번호  forEach문 돌리기-->
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <c:if test="${i == currentPage}">
                            <span><b>[${i}]</b></span>
                        </c:if>
                        
                        <c:if test="${i != currentPage}">
                            <span><b><a href="myPage?pageNum=${i}">[${i}]</a></b></span>
                        </c:if>
                    </c:forEach>
                    
                
                    <!-- 다음블록 [▶] / 끝 [▶▶] -->
                    <c:if test="${pageCount > endPage}">
                        <a href="myPage?pageNum=${startPage + pageBlock}">[▶]</a>
                        <a href="myPage?pageNum=${pageCount}">[▶▶]</a>
                        <!-- 전체페이지를 세서  -->
                    </c:if>
                </c:if>
            </th>
        </tr>
        
    </table>            
   
   
        </section>
        
        
        <!------- 3. 게시판 (회원꺼만 보임 / 마이페이지에서는) ------->
        
        
        <section class="tab_menu" id="menu_3" style="display:none; margin-bottom: 100px;">     
          
           
            <table class="product_list" style="width:1000px; border-radius:5px; margin: 0 auto;">
            <tr>
                <th class="tabel_th" style="width:100px">번호</th>
                <th class="tabel_th" style="width:100px">카테고리</th>
                <th class="tabel_th">제목</th>
                <th class="tabel_th" style="width:100px">작성자</th>
                <th class="tabel_th" style="width:100px">작성일</th>
                <th class="tabel_th" style="width:20px">X</th>
            </tr>
		         <c:forEach var="dto" items="${boardList}"> 
		         	<c:if test="${dto.writer == sessionScope.memId}">	<!-- 게시판 writer와 memId일치시만 가져옴  -->
			            <tr>
			                <td> ${number} <c:set var="number" value="${number -1}" /></td>
			                <td>배송문의</td>
			                <td><a href="#" style="color:black;">${dto.subject}</a></td>
			                <td>${dto.writer}</td>
			                <td><fmt:formatDate type="both" pattern="yyyy-MM-dd HH:mm" value="${dto.reg_date}" /></td>
			                <td><input type="checkbox"></td>
			            <tr>
			                  
		         	</c:if>
		         </c:forEach>
            	<c:if test="${dto.writer == sessionScope.memId}">
            		<tr>
            			<td colspan="6">
            			작성하신 게시 글이 없습니다. </td> 
            		</tr>
            	
            	</c:if>
            
        </table>
            
            
        </section>
        
        
        <!------- 4.  회원정보변경   ------->
    
    <section class="tab_menu" id="menu_4" style="display:none; margin-bottom:100px;">     
    <form name="modify" action="c_modifyView" method="post">
       

		<table style="width:1000px; border-radius:5px; margin: 0 auto; padding-top:100px; padding-bottom:100px;">
			<tr>
				<th colspan="2">
					고객님의 소중한 정보 변경을 위해 비밀번호를 입력하세요!
				</th>
			</tr>
			<tr>
        		<th colspan="2">ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ</th>
        	</tr>
			<tr>
				<th colspan="2" align="center">
					<input type="password" class="input" name="pwd" maxlength="10" placeholder="비밀번호 입력" autofocus required>
				</th>
			</tr>
		
			<tr>
				<th colspan="2">
					<input type="submit" id=modi_button value="정보수정">
				</th>
			</tr>
		
		</table>

    </form>
    </section>
        
    </div>
 
 
<!------화면 맨 하단 footer---------->
<%@ include file="../common/footer.jsp" %>
 
<!-- </form>  -->
</body>
</html>
 