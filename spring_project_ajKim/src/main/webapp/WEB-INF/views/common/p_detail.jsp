<%@page import="org.springframework.security.core.Authentication"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>ARTBOX - 상품상세페이지 </title>

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

/* --------------------------- 상품 상세 내역 css   ---------------------------- */

/* 상품 사진슬라이드 */
ul,li{list-style:none;}
#slide{width:500px; height:500px; position:relative;overflow:hidden; background:rightgrey;}

/* ul크기 */
#slide ul{width:300%;height:100%;transition:1s; padding:0px;}
#slide ul:after{content:"";display:block;clear:both;}

/* li크기  */
#slide li{float:left; width:500px; height:500px;}

#slide li:nth-child(1){background:#faa;}
#slide li:nth-child(2){background:#ffa;}
#slide li:nth-child(3){background:#faF;}
#slide input{display:none;}
#slide label{display:inline-block;vertical-align:middle;width:10px;height:10px;border:2px solid #666;background:#fff;transition:0.3s;border-radius:50%;cursor:pointer;}
#slide .pos{text-align:center;position:absolute;bottom:10px;left:0;width:100%;text-align:center;}
#pos1:checked~ul{margin-left:0%;}
#pos2:checked~ul{margin-left:-100%;}
#pos3:checked~ul{margin-left:-200%;}
#pos1:checked~.pos>label:nth-child(1){background:#666;}
#pos2:checked~.pos>label:nth-child(2){background:#666;}
#pos3:checked~.pos>label:nth-child(3){background:#666;}

section {display:block;}
section .iteminfo{width:1200px; height:550px;}
.iteminfo{margin-top : 30px;}
.iteminfo div {float:left;}
/* .iteminfo div span{display:block;} */

#pro_buy {border-left: 1px dotted; margin-left: 10px; width:660px; height:500px; padding: 10px 10px;}

/* 사진 바로 옆  ---- 테이블 아래  */
.proName{font-size: 20px; text-weight:bold; width:600px; 
		padding:30px 0px 20px 20px; margin-bottom:20px; border-bottom: 1px dotted;}
.price {float:left;}
.deliveryPrice {float:left;}

.ipt_layer input[type=button] {
    border: 0;
    margin: 0;
    padding: 0;
    background-color: #ffffff;
    font-size: 25px;
    color: #717171;
    font-weight: bold;
}

.btn_minus {
	margin-left: 10px;
	font-weight: bold;
	font-size: 15px;
	border-radius: 5px;
}

.btn_plus {
	font-weight: bold;
	font-size: 15px;
	border-radius: 5px;
}

.btnCart input[type=submit] {
    width: 200px;
    height: 55px;
    padding: 0;
    margin-left: 10px;
    border: 1px solid #646464;
    background-color: #ffffff;
    border-radius: 5px;
    font-size: 20px;
    color: #000000;
}

.btnOrder input[type=submit] {
    width: 200px;
    height: 55px;
    padding: 0;
    margin-left: 10px;
    border: 1px solid #e71e22;
    background-color: #e71e22;
    border-radius: 5px;
    font-size: 20px;
    color: #ffffff;
    font-weight: bold;
}

.btnWish img{margin-left: 25px; margin-right: 5px;}

/* 상품 컨텐츠  - css  */
.itemContent{margin-top: 50px; padding-top: 100px; border-top: 1px dotted; margin-bottom: 50px;}

/* 밑에 정보!!!!!!!!!!!!! */
.content_info {
	witdh : 500px; height: auto;
    border: 1px solid #000000;
    border-radius: 5px;
    margin: 25px 0 0 0;
}

.content_info2 {
	witdh : 500px; height: auto;
    border: 1px solid #000000;
    border-radius: 5px;
    margin: 25px 0 0 0;
   /*  margin-bottom: 150px; */
}

#div_toggle {
    background: url(resources/images/p_detail/img_toggle_up.gif) no-repeat right 20px center;
    display: block;
    cursor: pointer;
    padding: 20px 18px;
    color: #000000;
    font-size: 20px;
    border-bottom: 1px solid;
}

#div_toggle2 {
    background: url(resources/images/p_detail/img_toggle_up.gif) no-repeat right 20px center;
    display: block;
    cursor: pointer;
    padding: 20px 18px;
    color: #000000;
    font-size: 20px;
    border-bottom: 1px solid;
}

.content_info table {
    display: block;
    display: table;
    border-collapse: separate;
    border-spacing: 2px;
    border-color: grey;
    text-align: left;
}

</style>

<script type="text/javascript" src="https://code.jquery.com/jquery-latest.js"></script> 
<script type="text/javascript"> 

	$(document).ready(function(){ 
		
		/* 상품정보 여닫기 */
	  $("#div_toggle").click(function () { 
	    if ($("#div_toggle_content").is(":hidden")) { 
	      $("#div_toggle_content").slideDown("fast"); 
	      $("#btn_toggle").removeClass("b").addClass("a").html("[접기]"); 
	      } else { 
	      $("#div_toggle_content").slideUp("fast"); 
	      $("#btn_toggle").removeClass("a").addClass("b").html("[펼치기]"); 
	   } 
	}); 
	  
	  $("#div_toggle2").click(function () { 
		    if ($("#div_toggle_content2").is(":hidden")) { 
		      $("#div_toggle_content2").slideDown("fast"); 
		      $("#btn_toggle2").removeClass("b").addClass("a").html("[접기]"); 
		      } else { 
		      $("#div_toggle_content2").slideUp("fast"); 
		      $("#btn_toggle2").removeClass("a").addClass("b").html("[펼치기]"); 
		   } 
		}); 
	  
	  
	  /* --------수량 추가 함수 -function이벤트-----------*/
	  $("#plus").click(function (){
		 	/* html 값을 변수에 넣기  */
		  	var num = $("#number").text();
		 	var num_int = parseInt(num);
		 	
		  	if(num_int < 10){
		 		num_int++; /* 누를때마다 증가 */
			  	$("#number").text(num_int);	/* 갯수값 올리기 */
			  	$("input[name=p_cnt]").val(num_int);
		 	}else{
		 		alert("최대 10개까지만 주문 가능합니다.");
		 	}
		 	
		 	/* 1개 가격 가져오기 */
		  	var price = $("#salePrice").attr("price");  // 내가 정해놓은 price라는 값을 가져옴  .text()는 그냥 통쨰로 다 갖고옴
		  	price = parseInt(price);
		  	var total = price * num_int	/* 수와 값을 곱해라 */
		  	/* 최종값 변경 */
		  	$("#totalprice").text(numberWithCommas(total));
		  	$("input[name=p_total]").val(total);
	  });
	  
	  
	  /* --------수량 빼기 함수 -function이벤트-----------*/
	  $("#minus").click(function (){
		 	/* html 값을 변수에 넣기  */
		  	var num = $("#number").text();
		 	var num_int = parseInt(num);
		 	
		 	if(num_int > 1){
		 		num_int--; /* 누를때마다 감소 */
			  	$("#number").text(num_int);	/* 갯수값 내리기 */
			  	$("input[name=p_cnt]").val(num_int);
		 	}else{
		 		alert("1개 이상은 주문해야합니다.");
		 	}
		 	
		 	/* 1개 가격 가져오기 */
		  	var price = $("#salePrice").attr("price");
		  	var total = price * num_int;	/* 수와 값을 곱해라 */
		  	
		  	/* 최종값 변경 */
		  	$("#totalprice").text(numberWithCommas(total));  
	  });
	  
	  
	  // 마우스를 올리면 3만원이상무료배송 나오게 
	  $("#delivery_fee").mouseover(function(){
		  	$("#title").css("display","inline-block");
		});
	  // 마우스를 벗어나면 다시 사라짐
	  $("#delivery_fee").mouseout(function(){
		  	$("#title").css("display","none");
		});

	  	
	}); 
	
// 가격에 ',' 작성  
function numberWithCommas(x) {   
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}


// 아이디 체크 
function idCheck(){
	alert("주문은 로그인 후 가능합니다.");
	window.location="login";
	return false;
}


</script> 
 
</head>
<body>
 
 <!--------목록보여주기 header---------->
 <%@ include file="header.jsp" %>
 
 <form action="product_order" name="product_detail" method="post">
 

	<!-- 주문 페이지에 넘길 값 설정  -->
	<input type="hidden" name="p_cnt" value="1">
	<input type="hidden" name="p_code" value="${vo.p_code}">
	<input type="hidden" name="p_total" value="${vo.p_price}">
	<!-- 아래 두개는 장바구니에 넘길값  -->
	<input type="hidden" name="p_name" value="${vo.p_name}">
	<input type="hidden" name="p_image" value="${vo.p_image}">


    <!-------------중간본문 section-------------------->
 	<!-- 상품상세 시작  -->
 home(연결계정 : <sec:authentication property="name"/>) 메인화면<br><br>
 
    <div style="margin: 0 auto; width: 1200px; height:auto;" id="header" >
        
		<section >
  
		<div class="iteminfo">
		
	
			<div id="slide">
			 	  <input type="radio" name="pos" id="pos1" checked>
				  <input type="radio" name="pos" id="pos2">
				  <input type="radio" name="pos" id="pos3">
				  <ul style="padding-left: 0px;">
				    <li><img src="${root}p_detail/${vo.p_image}" style="width:500px; height:500px;"></li>
				    <li><img src="${root}p_detail/1905071198_detail2.jpg" style="width:500px; height:500px;"></li>
				    <li><img src="${root}p_detail/1905071198_detail3.jpg" style="width:500px; height:500px;"></li>
				  </ul>
				  <p class="pos">
				    <label for="pos1"></label>
				    <label for="pos2"></label>
				    <label for="pos3"></label>
				  </p>
			</div>
			
			
			<!-- 사진 옆  -->
		
			<div id= "pro_buy">	
				<table style="width:100%;">
					<tr>
						<td colspan="3" style="padding: 20px 20px 20px 10px; border-bottom: 1px dotted;">
							<big style="font-size:25px;">${vo.p_name}(${vo.p_code})</big>
							<br>
							<a href="product_list.box?category=${vo.category}"><small>인형/토이 ></small></a>	
							<a href="product_list.box?category=${vo.category}"><small>피규어</small></a><br>						
						</td>
					</tr>
						
					<tr>
						<td style="width:200px; padding: 10px 10px 10px 10px">판매가</td>
						<td colspan="2" style="padding: 10px 10px 10px 10px">
						<div id="salePrice" price="${vo.p_price}">
						<fmt:formatNumber value="${vo.p_price}" pattern="#,###" /></div>원</td>
						<!-- jstl 자체적으로 , 를 찍을 수 있는 기능있음  -->
					</tr>
					
					<tr>
						<td style="width:200px; padding: 10px 10px 10px 10px">배송비</td>
						<td colspan="2" style="padding: 10px 10px 10px 10px">2,500원  <a class="btnOverlay" style="display:inline-block; 
						cursor:pointer; border:1px solid #000000; border-radius:5px; width:78px; height:22px; line-height:20px; 
						text-align:center; font-size:13px; color:#000000;" id="delivery_fee">배송비 안내
						<span id="title" style="display:none; position:absolute; font-weight:bold; color:pink;"><pre>  3만원이상 주문시 무료배송!</pre></span></a></td>
					</tr>
					<tr>
						<td style="width:200px; padding: 10px 10px 10px 10px">꿈캔디</td>
						<td colspan="2" style="padding: 10px 10px 10px 10px">
						<fmt:formatNumber value="${vo.p_price * 0.01}" pattern="###" /></td>
					</tr>
					
					<tr>
						<td style="width:200px; padding: 10px 10px 10px 10px">상품코드</td>
						<td colspan="2" style="padding: 10px 10px 10px 10px">${vo.p_code}</td>
					</tr>
					
					<tr>
						<td style="width:200px; padding: 10px 10px 10px 10px">캐쉬백</td>
						<td colspan="2" style="padding: 10px 10px 10px 10px; border-bottom: 1px dotted;">1% 적립</td>
					</tr>
					
					<tr>
						<td style="width:200px; padding: 10px 10px 10px 10px">주문수량</td>
						<td colspan="2" style="padding: 10px 10px 10px 10px; border-bottom:1px dotted;">
							<input type="button" class="btn_minus" value="-" id="minus">
								<div class="ipt_layer">
									<span id=number>1</span>개
								</div>
							<input type="button" class="btn_plus" value="+" id="plus"> 
						</td>
					</tr>
					<tr>
						<td style="width:200px; padding: 10px 10px 10px 10px">재고수량</td>
						<td colspan="2" style="padding: 10px 10px 10px 10px">
						${vo.p_count}개</td>
					</tr>
					
					<tr>
						<td style="width:200px; padding: 10px 10px 10px 10px;">총 합계금액</td>
						<td  style="padding: 10px 10px 10px 10px;"><div id="totalprice">
							<fmt:formatNumber value="${vo.p_price}" pattern="#,###" /></div>원</td>
					</tr>
									
				</table>

				<div class="btn" style="display:inline; margin-top: 10px">
					
					<%
						Authentication auth = (Authentication)request.getUserPrincipal();
						String id ="";
								
						if(auth == null){
					%>		
					
						<div class="btnCart">
							<input type="submit" value="장바구니 담기" name="btnState" onclick="return idCheck();"></div> 
							
						<div class="btnOrder">
							<input type="submit" value="바로 구매하기" name="btnState" onclick="return idCheck();"></div>	
						
						
					<%		
						}else{
							
					%>			
					
						<div class="btnCart">
							<input type="submit" value="장바구니 담기" name="btnState"></div> 
				
						<div class="btnOrder">
							<input type="submit" value="바로 구매하기" name="btnState"></div>	
								
					<%		
						}
					
					%>		
											
					<div class="btnWish"><img src="${root}wish_off.png"></div> <!-- ★★  위시리스트 -->
					<div class="btnShare"><img src="${root}btn_share.png"></div> <!-- ★★  상품공유 -->
				</div>

			</div>
		</div>
		</section>
	
		<section> <!-- 상품 설명 이미지 -->
			
			<div class= "itemContent" align="center"> 
				<img src="${root}p_detail/${vo.p_info}">
			</div>


	<!-- 상품  아래 -->
	<div class="content_info">
		
		<span id="div_toggle">★ 상품정보제공 고시 상세정보</span>

		<table id="div_toggle_content">
			<tbody>
			<tr>
				<th style="width:600px; padding: 10px 10px 10px 10px;">구분</th>
				<td style="padding: 10px 10px 10px 10px;">기타</td>
			</tr>
			
			<tr>
				<th style="width:600px; padding: 10px 10px 10px 10px;">품명 및 모델명</th>
				<td style="padding: 10px 10px 10px 10px;">${vo.p_name}(${vo.p_code})</td>
			</tr>
			
			<tr>
				<th style="width:600px; padding: 10px 10px 10px 10px;">법에 의한 인증ㆍ허가 등을 받았음을 확인할 수 있는 경우 그에 대한 사항</th>
				<td style="padding: 10px 10px 10px 10px;">해당없음</td>
			</tr>
			
			<tr>
				<th style="width:600px; padding: 10px 10px 10px 10px;">제조국 또는 원산지</th>
				<td style="padding: 10px 10px 10px 10px;">한국</td>
			</tr>
			
			<tr>
				<th style="width:600px; padding: 10px 10px 10px 10px;">제조자, 수입품의 경우 수입자를 함께 표기</th>
				<td style="padding: 10px 10px 10px 10px;">Dreams Inc., Japan</td>
			</tr>
			
			<tr>
				<th style="width:200px; padding: 10px 10px 10px 10px;">A/S 책임자와 전화번호 또는 소비자상담 관련 전화번호</th>
				<td style="padding: 10px 10px 10px 10px;">고객감동센터 1577-9081</td>
			</tr>
			
			</tbody>
		</table>
	</div>
				
			<!--  2번째 정보  -->
		<div class="content_info2">
			<span id="div_toggle2">★ 배송/교환/환불 정보</span>

			<table id="div_toggle_content2">
				<tbody>
					<tr><th style="padding: 10px 10px 10px 10px;"><big><br>* 배송정보 *<br></big></th></tr>
				
					<tr>
						<td style="padding: 10px 10px 10px 10px;">
						<br>
						배송기간은 주문일(또는 결제완료일)로부터 1일(24시간)~5일 정도 걸립니다. (지방일 경우 최장 7일) <br>
						주문금액이 30,000원 이상일 경우 무료배송 <br>
						지정일 배송은 택배회사에 관련된 사항이므로 택일이 불가합니다.
						<br>
						</td>
					</tr>
					
					<tr><th style="padding: 10px 10px 10px 10px;"><big><br> * 교환/반품/환불 정보 *<br></big></th></tr>
					
					<tr>
						<td style="padding: 10px 10px 30px 10px;">
						<br>
						배송완료 후 7일 이내에 신청할 수 있으며, 다음의 경우는 교환/반품 신청이 불가할 수 있습니다.<br>
						반품/교환 가능 기간이 경과된 경우<br>
						포장을 개봉하였거나 포장이 훼손되어 상품가치가 현저히 감소한 경우<br>
						고객의 주문을 확인한 후 상품제작에 들어가는 주문제작상품인 경우<br>
						소비자가 책임 있는 사유로 상품 등이 멸실 또는 훼손된 경우<br>
						시간의 경과에 의해 재판매가 곤란할 정도로 상품 등의 가치가 현저히 감소한 경우<br>
						복제가 가능한 재화 등의 포장을 훼손한 경우<br>
						단순변심에 의한 반품/교환 택배비는 고객님이 부담하셔야 하며, 반품 접수 없이 임의로 반송하거나 <br>
						우편으로 보낼 경우 상품 확인이 어려워 환불이 불가능 할 수 있습니다.
						<br>
						</td>
					</tr>
					
				</tbody>
			</table>
			
			
		</div>
			<div style="float:right; margin-bottom:100px; margin-top:15px;">
				<a href="#"><input type="button" value="맨위로"></a>
			</div>
						
		</section>


	</div>
	</form>	

 
<!---------화면 맨 하단 footer---------->
 <%@ include file="footer.jsp" %>

 
 
</body>
</html>
