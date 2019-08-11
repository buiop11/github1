<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>ARTBOX-주문하기</title>

<link href ="./main.css" rel="stylesheet" type="text/css">
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
a {text-decoration: none;}

/* -----------  주문하기 페이지!!!!! (고객전용..??)--------- */
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
   
.orderInfo h2 {
	display: block;
	padding: 0;
	margin: 0;
	font-size: 19px;
	line-height: 19px;
	color: #000000;
	font-weight: normal;
}
   
 small{display: inline;}
 .orderInfo a{display: block;}
 .detail_p{float:left;}
 .customer_info{display:block;}
 .discount{display:block;}
   
   
td input[type=text], input[type=button], input[type=submit], input[type=tel],
.customer_info table tr td select, .discount table tr td select {
		width: 100%;
		margin: 0;
		line-height: 56px;
		height: 56px;
		color: #777777;
		font-size: 15px;
		border: 0;
		background-color: #f3f3f3;
		border-radius: 5px;
} 

 /*   table{border:1px solid;} */
   
 #final_payment table tr{
  	 width: 100%;
	 margin: 0;
	 line-height: 56px;
	 height: 56px; 
	 font-size: 15px;
 }

 .final{
 	 width: 50%;
	 margin: 0;
	 line-height: 56px;
	 height: 56px;
	 color: #777777;
	 font-size: 20px;
	 border: 0;
	 background-color: #f3f3f3;
	 border-radius: 5px;
	 text-align:center;
 }
 
</style>
 
 

 <!-- 이용 약관 한꺼번에 선택  -->
 <script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
 <!-- 주소찾기 : 카페에서 가져옴  --> 
 <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
 <script>

	$(function(){
 		
 		$("#all_check").change(function(){
			var is_check = $(this).is(":checked");
			$(".agree_chk").prop("checked", is_check);
 		});
 	});
	
 
 	function addressSearch(){
 		new daum.Postcode({
 			oncomplete: function(data) {
 				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 				
 				// 각 주소의 노출 규칙에 따라 주소를 조합한다. 
 				// 내려오는 변수가 값이 없는 경우엔 공백('') 값을 가지므로, 이를 참고하여 분기한다.
 				console.log(data); // 찍어보기 
 				
 				var fullAddr = '';	// 최종 주소 변수 
 				var extraAddr = ''; // 조합형 주소 변수 
 				
 				// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
 				if(data.userSelectedType === 'R'){	// 사용자가 도로명 주소를 선택했을 경우
 					fullAddr = data.roadAddress;
 				}else{  // 사용자가 지번 주소를 선택했을 경우(J)
 					fullAddr = data.jibunAddress;
 				}
 				
 				// 사용자가 선택한 주소가 도로명 타입일 때 조합한다. 
 				if(data.userSelectedType === 'R'){
 					// 법정동명이 있을 경우 추가한다. 
 					if(data.bname !== ''){
 						extraAddr += data.bname;
 					}
 					// 건물명이 있을 경우 추가한다. 
 					if(data.buildingName !== ''){
 						extraAddr += (extraAddr !== ''? ', ' + data.buildingName : data.buildingName);
 					}
 					// 조합형 주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다. 
 					fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
 				}
 				// 우편번호와 주소 정보를 해당 필드에 넣는다.
 				document.getElementById('sample6_postcode').value = data.zonecode;
 				document.getElementById('sample6_address').value = fullAddr;
 				// 커서를 상세주소 필드로 이동한다. 
 				document.getElementById('sample6_address2').focus();
 				
 			}
 		}).open();
 	}
 
 	
 	// 주문에 필요한 입력 사항 체크 
 	function inputCheck(){
 		var add1 = document.inputform.addcode.value; // 우편코드 
 		var add2 = document.inputform.add1.value;
 		var add3 = document.inputform.add2.value;
 		var address = '';
	 		
			if(add1 != ''){
				address = "[" + add1 + "] " + add2 + " " + add3;
				document.inputform.address.value = address;
			// 우편번호가 없을 때 
			}else{
				address = add2 + " " + add3;
				document.inputform.address.value = address;
			}
 		}
 		
 		// 나머지는 required로 처리 
 	
 </script>
 
 
</head>
<body>
 
<!------목록보여주기 header--------->
 <%@ include file="header.jsp" %>
 
 <!-- 로그인 후에만 이 페이지 입성이 가능하다~!! sessionScope.memId 있음! -->
   <!----------중간본문 section----------->
        <!--!!!!!전체 중앙 정렬 !!!!!!!  -->
 <form action="product_orderPro" name="inputform" method="post" onsubmit="return inputCheck();">
 
    <div style="margin: 0 auto; width: 1200px;">
    
        <h1>주문하기</h1>
        <hr>
      <c:set var = "state" value="${btnState}" />

      <c:if test="${state eq '바로 구매하기'}">
       <!-- ★★  상세페이지에서 넘어올 때는 바로 '구매'하기!  -->
      
        <div class="itemList">
            <div class="orderInfo">
                <span><big> 주문상품 정보 | </big></span><span><small>${vo.p_name}(${vo.p_code})</small></span>
                <hr>
                <a class="detail_p" id="orderItem_detail" href="product_content?p_code=${vo.p_code}">
                <img src="${root}p_detail/${vo.p_image}" style="width:140px; height:140px;"></a>   
                <!-- 오더리스트에서 이미지를 누르면 상세페이지로 이동 -->
                
                <div class="detail_p" style="width:900px; height:140px;">
                    <!-- 카트리스트에서 끌어오는 걸로 진행해야하나봄!!!  -->
                    <div class="cartList_name" style="padding-left:10px; padding-top:35px; font-weight:bold; font-size: 20px;">
                        	${vo.p_name}(${vo.p_code})</div>
                        	
                        	
                    <div class="cartList_price" style="padding-left:10px;">
                    <fmt:formatNumber value="${p_total}" pattern="#,###" />원 X ${p_cnt}개</div>    
                </div>
                
                <div class="detail_p" style="width:160px; height:140px;">
                <p style="text-align:center; vertical-align:meddle; padding-top:40px;"><fmt:formatNumber value="${p_total}" pattern="#,###" />원</p></div>
            </div>
        </div>   
            <hr>
            
            <!-- ★★ 주문정보 숨겨서 보내기/ 가격은 맨아래 최종금액으로 전달  -->
            <input type="hidden" name="p_name" value="${vo.p_name}">
            <input type="hidden" name="p_code" value="${vo.p_code}">
            <input type="hidden" name="o_count" value="${p_cnt}" >
            <input type="hidden" name="id" value="${sessionScope.memId}">
            <input type="hidden" name="p_image" value="${vo.p_image}">
     
      </c:if>
      
      <c:if test="${state eq '바로 주문하기'}"> 
      <!-- ★★  장바구니에서 넘어올때는 바로 '주문'하기!  -->
      
         <div class="itemList">
            <div class="orderInfo">
                <span><big> 주문상품 정보 | </big></span><span><small>${p_name}(${p_code})</small></span>
                <hr>
                <a class="detail_p" id="orderItem_detail" href="product_content?p_code=${p_code}">
                <img src="${root}p_detail/${p_image}" style="width:140px; height:140px;"></a>   
                <!-- 오더리스트에서 이미지를 누르면 상세페이지로 이동 -->
                
                <div class="detail_p" style="width:900px; height:140px;">
                    <!-- 카트리스트에서 끌어오는 걸로 진행해야하나봄!!!  -->
                    <div class="cartList_name" style="padding-left:10px; padding-top:35px; font-weight:bold; font-size: 20px;">
                        	${p_name}(${p_code})</div>
                        	
                        	
                    <div class="cartList_price" style="padding-left:10px;">
                    <fmt:formatNumber value="${p_total}" pattern="#,###" />원 X ${p_cnt}개</div>    
                </div>
                
                <div class="detail_p" style="width:160px; height:140px;">
                <p style="text-align:center; vertical-align:meddle; padding-top:40px;"><fmt:formatNumber value="${p_total}" pattern="#,###" />원</p></div>
            </div>
        </div>   
            <hr>
            
            <!-- ★★ 주문정보 숨겨서 보내기/ 가격은 맨아래 최종금액으로 전달  -->
            <input type="hidden" name="p_name" value="${p_name}">
            <input type="hidden" name="p_code" value="${p_code}">
            <input type="hidden" name="o_count" value="${p_cnt}" >
            <input type="hidden" name="id" value="${sessionScope.memId}">
            <input type="hidden" name="p_image" value="${p_image}">
      
      </c:if>
             
             
 <!-- 본격 주문하기 페이지  -->
 
 		<div style=" width:1200px; height: 100px; margin-top: 30px;">
 
            <section style="width:800px; float:left" >
                <!-- 큰 div 4개를 만들어서 2개는 float로 띄우고 중간에 div clear 주고 그 밑에 2개 큰 div 순서 -->
            	<div class= customer_info>
            		
            		<table style="width:90%; margin-bottom:50px;">
            			<tr>	
            				<td colspan="4" style="font-size:25px; margin:0 auto;"> 주문고객/배송지 정보 <hr></td>
            			</tr>
            			
            			<tr>
            				<td>받는분</td>
            				<td colspan="3"><input type="text" name="o_name" value="${member.name}" required autofocus></td>
            			</tr>
            			
            			<tr>
            				<td>휴대전화</td>
            				<c:set var="hpArr" value="${fn:split(member.phone,'-')}" />
			                <td><input type="text" class="input_text" name="hp1" maxlength="3" value="${hpArr[0]}" required></td>
			                <td><input type="text" class="input_text" name="hp2" maxlength="4" value="${hpArr[1]}" required></td>
			                <td><input type="text" class="input_text" name="hp3" maxlength="4" value="${hpArr[2]}" required></td>
            			</tr>
            			
            			<tr>
            				<td>주소</td>
            				<td colspan="2">
            					<input type="text" name="addcode" id="sample6_postcode" placeholder="우편번호" size="6"></td>
            				<td>
            					<input type="button" name="addBtn" value="주소찾기" onclick="addressSearch();" style="background-color:black; color:white; font-weight:bold;">
            				</td>
            			</tr>
            			
            			<tr>
            				<td></td>
            				<td colspan="3">
            					<input type="text" name="add1" id="sample6_address" placeholder="주소" required>
            					<input type="text" name="add2" id="sample6_address2" placeholder=" 상세주소" required>
            					<input type="hidden" name="address">
            				</td>
            			</tr>
            			
            			
            			<tr>
            				<td>배송메세지</td>
            				<td colspan="3">
            					<select name=delivery_message>
            						<option value="없음" >선택</option>
            						<option value="문앞에 그냥 두고 가세요.">문앞에 그냥 두고 가세요.</option>
            						<option value="부재시 경비실에 맡겨 주세요.">부재시 경비실에 맡겨 주세요.</option>
	            					<option value="방문 전에 미리 연락주세요">방문 전에 미리 연락주세요.</option>
            					</select>
            				
            				</td>
            			</tr>
            		
            		</table>
            	</div>

 <!-- 할인정보 -->           	
            	<div class= "discount">
            		<table style="width:90%; margin-bottom:50px;">
            			<tr>	
            				<td colspan="4" style="font-size:25px; margin:0 auto;">쿠폰/꿈캔디 정보 <hr></td>
            			</tr>
            			
            			<tr>	
            				<td>쿠폰</td>
            				<td colspan="3">
            					<select>
            						<option value="">쿠폰을 선택하세요.</option>
            						<option value="">없음</option>
            					</select>
            				</td>	<!-- select로 바꿔야함 -->
            			</tr>
            			
            			<tr>	
            				<td>꿈캔디</td> <!-- ★★컬럼추가해서 만들기  ★★ -->
            				<td colspan="2"><input type="text"></td>
            				<td>개</td>	 
            			</tr>
            			
            			<tr>
            				<td></td>
            				<td colspan="3">
            			</tr>
            		
            		</table>
            	
            	
            	</div>
            	
 
 <!--  결제정보 !  -->           	
         <div class ="payment">
         		<table style="width:90%; margin-bottom: 50px;">
         			
         			<tr>	
         				<td colspan="4" style="font-size:25px; margin:0 auto;">결제정보 <hr></td>
         			</tr>
         			
         			<tr>
					<td colspan="4"> <!-- radio버튼은 같은 name이 있어야 중복선택이 불가능해진다. -->
						<span class="payRadio"><input type="radio" name="payInfo" value="신용카드" id="card" checked="checked">신용카드</span>
						<span class="payRadio"><input type="radio" name="payInfo" value="무통장입금" id="bank">무통장입금</span>
						<span class="payRadio"><input type="radio" name="payInfo" value="휴대폰결제" id="phonePay">휴대폰결제</span>
					<hr>
					</td>
         			</tr>
         		</table>
         </div>		
            		
       <!-- 이용 약관 동의  -->     		
           	<div class="agreement">
           		<table style="width:90%; margin-bottom: 150px;">
           			<tr>	
         				<td style="font-size:25px; margin:0 auto;">이용약관 동의</td>
         				<td colspan="3">
         				<!-- 전체 선택용 체크 박스   jQury 구현하기-->
							<span>
								<input type="checkbox" id="all_check">
								<label for="all_check">이용약관에 동의합니다. (전체선택)</label>	
								<a href="#">[자세히보기]</a>
							</span>
         				</td>
         			</tr>
         			<tr>
         				<td colspan="4"><hr></td>
         			</tr>
           			
           			<tr>
           				<td colspan ="4">
							
							<!-- 개별 선택용 체크박스 -->
							<p>
								<label for="chk1">전자금융거래 이용약관(필수)</label>
								<input type="checkbox" id="chk1" class="agree_chk" value="전자금융거래" required>동의
							</p>
					
							<p>
								<label for="chk2">고유식별정보 수집 및 이용동의(필수)</label>
								<input type="checkbox" id="chk2" class="agree_chk" value="고유식별정보" required>동의
							</p>
							
							<p>
								<label for="chk3">개인정보 수집 및 이용동의(필수)</label>
								<input type="checkbox" id="chk3" class="agree_chk" value="개인정보" required> 동의
							</p>
							
							<p>
								<label for="chk4">개인정보 제3자 제공 및 위탁동의(필수)</label>
								<input type="checkbox" id="chk4" class="agree_chk" value="개인정보2" required>동의
							</p>	
           				
						</td>
           			</tr>
           		
           		</table>
           	
           	</div>
     </section>	
            	
  <!-- 고정 테이블 , 최종결제 금액  -->
            	
            <section style="width:400px; float:left; margin-bottom:100px;">
            
            	<div id= "final_payment"> 
            		<table style="width:100%; padding-top:100px;"> <!-- 요 안쪽 넓이는 보기좋기 조정하기 -->
            			
            			<tr>
            				<td>상품 가격</td>
            				<td class="final"><span class=price>
            				<fmt:formatNumber value="${p_total}" pattern="##,###" /></span>원</td>
            			</tr>
            			
            			<tr>
            				<td>할인 가격</td>
            				<td class="final"><span class=dis_price>0</span>원</td>
            			</tr>
            			
            			<tr>
            				<td>배송비</td>
            				
            				<c:if test="${p_total >= 30000}">
	            				<td class="final"><span class=deli_price>0</span>원</td>
            				</c:if>
            				<c:if test="${p_total < 30000}">
            					<td class="final"><span class=deli_price>2,500</span>원</td>
            				</c:if>
            			</tr>
            			
            			<tr>
            				<td colspan="2"><hr></td>
            			</tr>
            			
            			
            			<tr>
            				<td colspan="2" class="final"> 총 결제금액 
	            				<span class=f_price style="font-size:40px; font-weight:bold; color:red;">
	            					<c:if test="${p_total >= 30000}">
	            						<fmt:formatNumber value="${p_total}" pattern="#,###" />
	            						<!--★ 최종 결제 금액 주문 테이블로 보내기  -->
            							<input type="hidden" name="o_price" value="${p_total}">
	            					</c:if>
	            					<c:if test="${p_total < 30000}">
	            						<fmt:formatNumber value="${p_total + 2500}" pattern="#,###" />
	            						<!--★ 최종 결제 금액 주문 테이블로 보내기  -->
            							<input type="hidden" name="o_price" value="${p_total + 2500}">
	            					</c:if>
	            				</span>원
            				
            				<!--★★  ★★   꿈캔디 적용시에  장바구니 바로 주문하기 -> 에서 넘어오는 값은 vo.p_price없으니 주의!! c:if로 값만들어야함   -->
            				<br><small>(적립 예정 꿈캔디  <span class="point"><fmt:formatNumber value="${vo.p_price * 0.01}" pattern="###" /></span>개)</small></td>
            			</tr>
            			
            			<tr>
            				<td colspan="2">
            				<input type="submit" value="결제하기" style="background-color:black; color:white; font-weight:bold;">
            				</td>
            			</tr>
            		
            		</table>
            	
            	</div>
			 </section>
  		</div>
 	</div>
  </form>
 
 <!---------화면 맨 하단 footer----------->
<%@ include file="footer.jsp" %>
 
 
</body>
</html>