<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>장바구니</title>

<style>
/* -----카트 시작 !! css ------- */
h1 {
 display: block; width: 1200px;
 height: 25px;  line-height: 25px;
 font-size: 25px;  text-align: center;
 margin: 0 auto;  padding: 50px 0 40px 0;}

.return input[type=button]{
width: 300px; margin: 0;
height: 56px; line-height: 56px;
font-size: 15px; border: 0;
background-color: #f3f3f3; color:#777777;
border-radius: 5px;} 
 
 .CartCount {
 width: 100%;
 text-align: left;
 line-height: 16px;
 font-size: 16px;
 color: #646464;
 padding: 20px 0 20px 0;}

.CartCount b { color: #000000; font-size: 18px;}
    
#all_check, #all_check2 {
    display: inline-block;
    width: 115px;  height: 35px;
    line-height: 33px;  font-size: 15px;
    color: #424242;  background-color: #ffffff;
    text-align: center;
    border: 1px solid #424242;
    border-radius: 5px;  margin: 0 7px 0 0;
}

.CartBuyButton a {
    display: inline-block;
    width: 250px;
    height: 56px;
    line-height: 56px;
    font-size: 23px;
    color: #ffffff;
    background-color: #000000;
    text-align: center;
    border-radius: 5px;
    margin: 0;
    font-weight: bold;
}

.CartList { width: 100%; margin: 15px 0; border-top: 1px solid #e4e4e4;}
.CartListItemName {
    text-align: left;  font-size: 20px;
    color: #000000;  line-height: 20px;}

.CartRow { border-bottom: 1px solid #e4e4e4;}
.tableDiv dl { display: table-row;}
.trCart dt.tdCheck { width: 27px;}
.trCart dt {vertical-align: middle;}
.tableDiv dt {
    display: table-cell;
    vertical-align: top;
    position: relative;
}

input[type=checkbox] { width: 23px; height: 23px; vertical-align:top;}
input[type=button], #cartToOrder{
    border: 0;  margin: 0; padding: 0;
    background-color: #ffffff;
    font-size: 25px;
    color: #717171;
    font-weight: bold;
}

.CartPrice {
    width: 100%;
    background-color: #f5f5f5;
    border-radius: 5px;
    margin: 30px 0 15px;  padding: 20px;
}

.CartPrice .PriceDetail { float: left; width: 50%;}
.CartPrice .PriceTotal {
    float: left;  width: 50%;
    font-size: 20px;
    line-height: 20px;
    color: #565656;  text-align: right;
}

.CartPrice .PriceTotal span {
    font-size: 40px;  color: #e71f22;
    font-weight: bold;
}

.clear { display: block; clear: both;}
.CartBottom { width: 100%;}
 
</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>

$(function(){
		
		// 전체선택/해제
		var ischeck = false; // 상태값 설정 
		$("#all_check").click(function(){
			var t_price = 0;
			var count = 0;
			
			if(ischeck == false){
				$(".product").prop("checked",true);
				
				// .product는 여러개라서 for문을 돌려야 정확한 값을 산출할 수 있다. ㅠㅠ
				$.each($(".c_price"), function(i, v){	// 제이쿼리의 for-each문!! 
					t_price += parseInt($(v).attr("price")) * parseInt($(v).attr("count"));	
				});
				
				ischeck = true;
				
			}else{
				$(".product").prop("checked",false);
				$("#total").html(t_price);
				
				ischeck = false;
			}
			
			
			$("#total").text(numberWithCommas(t_price));
			$("#total2").text(numberWithCommas(t_price));
			
		});
		
		//최종결제금액 불러오기 
		//1번 체크박스 선택 -> 최종결제금액 += 선택한 price 
		//체크박스 해제 ->  최종결제금액 -= 선택한 price 
		$(".product").click(function(){
			// product클래스들 중에서도 this를 쓰면, 그 선택된 값을 가지고 올 수 있다. 
			
			var tmp = $("#total").text();// 0,000
			var total = parseInt(tmp.replace(',' , ''));
			var tmp2 = $(this).parent().parent().next().find($(".c_price")).attr("price");
			var price = parseInt(tmp2);
			var tmp3 = $(this).parent().parent().next().find($(".c_price")).attr("count");
			var count = parseInt(tmp3);
			
			var delivery = 0; // 초기화 
			
			// 체크가 되어있다, 그럼 total 가격에 계속더함 
			if($(this).prop("checked")){
				total += price * count;
				
				/* if(delivery == 0){
					if(total < 30000){
						delivery = 2500;
					}
				}else{
					if(total >= 30000){
						delivery = -2500;
					}
				} */
				
			}else{	 // 체크가 되어있지 않다, 그럼 total에 가격을 계속 뺀다. 
				total -= price * count;
			
				/* if(delivery == 0){
					if(total < 30000){
						delivery = 2500;
					}
				}else{
					if(total >= 30000){
						delivery = -2500;
					}
				} */
			}
			
			$("#deliveryFee").html(numberWithCommas(delivery));
			$("#total").html(numberWithCommas(total));
			$("#total2").html(numberWithCommas(total));
			//$("input[name=p_total]").val(numberWithCommas(total));
			// 인풋 태그에 넣을 때는 value()로 해야한다!!!! 
		});
		
});


//가격에 ',' 작성  
function numberWithCommas(x) {   
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

</script>
 
</head>
<body>
 
<!-------목록보여주기 header------->
<%@ include file="../common/header.jsp" %>



    <!---------게시판  시작~~~~~~ ---------->
        <!-- !!!!!!!전체 중앙 정렬 !!!!!!!  -->
   
    <div style="margin: 0 auto; width: 1200px;">

		<h1>장바구니</h1>
		
 <!-- 장바구니 담긴게 없을 때 보여주는 페이지  -->
 <c:if test="${cart == null}">
	    <div class= "cart_0" style="text-align:center; height: 500px; display:block;">
		    <img src="${root}cart_empty_pc.png">
		    <h2>장바구니에 담긴 상품이 없습니다.<br>관심있는 상품을 담아보세요.</h2>
		    
		    <div class="return" style="margin-bottom:50px;">
		    <a href="main"><input type="button" value="쇼핑하러 가기"></a></div>
	    </div> 	
 
 </c:if>
   
	     
 <!-- 장바구니 담겨 있을떄 페이지! -->
<c:if test="${cart != null}">
	<c:forEach var="dto" items="${cart}" varStatus="aa">
<form action="product_order" name="" method="get">

		
	<div class="CartList" style="height:auto;">
		
		<table class="tableDiv CartRow">
			<tr class="tdCheck">
				<td style="padding-right:20px;">
					<label>
						<input type="checkbox" class="product"  name="product" value="${dto.p_code}">
						<img src="${root}p_detail/${dto.p_image}" style="width:150px; height:150px; padding-top: 5px; padding-bottom: 5px;">
					</label>
				
				</td>
				<td  style="width:1200px;">
					<div class="CartListItemName">${dto.p_name} (${dto.p_code})</div>
					<div class="CartListPrice">
					<span class="c_price" price="${dto.c_price}" count="${dto.c_count}"><fmt:formatNumber value="${dto.c_price / dto.c_count}" pattern="#,###"/></span> X ${dto.c_count}개 = <fmt:formatNumber value="${dto.c_price * dto.c_count}" pattern="#,###" />원
					<!-- ★★ price나 count 처럼 속성값을 마음대로 지정할 수 있다.! -->
					
					<!-- 넘길값 하나 히든으로 지정  -->
					<input type="hidden" name="p_cnt" value="${dto.c_count}"> 
					<input type="hidden" name="p_code" value="${dto.p_code}">
					<input type="hidden" name="p_name" value="${dto.p_name}">
					<input type="hidden" name="p_image" value="${dto.p_image}">
					<!-- 1개만구매하는 바로 구매하기일때. -->
					</div>
				</td>
				
				<td>
					<!--★★바로 주문하기 -1개만! / 1개만 구매할 때는 그냥 가격에 3000만원 이상인지 확인한 후 배달금액확인한다. -->
					<c:set var="dv_total" value="${dto.c_price}"/> <!-- dv_total : 변수 선언  -->
					<c:if test="${dto.c_price >= 30000}">
						<c:set var="dv_total" value="${dto.c_price + 2500}" />
					</c:if>
					
					<input type="hidden" name="p_total" value="${dv_total}"> <!-- 1개 최종값 -->
					<input type="submit" name="btnState" value="바로 주문하기" id="cartToOrder">
					 <!-- 삭제버튼 -->
					 <a href="cartdelete?cartNum=${dto.cartNum}">
					<span style="float:right; padding-top:5px;">삭제하기<img src="${root}m_top_close.png" style="width:30px; height:30px; vertical-align:middle;"></span></a>
				</td>
			</tr>
		</table>
	</div>
</form>	
	</c:forEach>
		
		
	<div style="margin-bottom:100px;">	
		<input type="button" id="all_check" value="전체선택/해제">
		<input type="button" id="all_check2" value="선택삭제">
		<div class="CartPrice">
			<div class="PriceDetail">
				<div class="tableDiv">
					<dl>
						<dt>총 상품금액</dt>
						<dd><span id="total2">0</span> 원</dd>
					</dl>
					
					<dl>
						<dt>배송비</dt>
						<dd>
							<span id="deliveryFee">2,500</span> 원
						</dd>
					</dl>
				</div>
			</div>
			<div class="PriceTotal">
				총 주문금액 <span id="total">0</span> 원 <!--★★ 제이쿼리에서 설정된 값 넘어옴  -->
			</div>
			<div class="clear"></div>
		</div>
		
		<div class="CartBottom">
			<div class="CartBuyButton" style="float:right;">
				<a href="#">주문하기</a></div>
			<div class="CartComment">
				장바구니에 담긴 상품은 30일 이후 자동으로 삭제됩니다.<br>
				단, 판매가 종료된 상품은 장바구니에서 삭제될 수 있습니다.<br>
				쿠폰은 <b>[주문 결제]</b> 페이지에서 적용됩니다.
			</div>
			<div class="clear" style="margin-bottom:100px;"></div>
		</div>
		
	</div>	
		
		</c:if>
		</div>
		

	

<!---------화면 맨 하단 footer---------->
<%@ include file="../common/footer.jsp" %>

</body>
</html>
