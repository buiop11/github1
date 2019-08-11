<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="setting.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
    content="width=device-width,initial-scale=1,shrink-to-fit=no">
<title>ARTBOX</title>
 
<style>

/* ----------- 메인 시작 ------------------------ */
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


/* ---------------------------베스트 아이템   css ---------------------------- */
.Best_Item{
	width: 1200px;
	height:700px; /* auto로 주거나 px로 하기!! */
}

.Best_Item li {
    list-style: none;
    float: left;
    width: 220px;
}
.Best_Item li a {
    text-decoration: none;
    font-size: 5px;
}
.imageNumber {
    width: 100px; /* 사이즈가 안먹으셈 ㅠㅠㅠㅠㅠㅠㅠㅠ */
    height: 100px;
    border-radius: 50%;
    background-color: #8f8f8f;
    color: #ffffff;
    font-size: 26px;
    line-height: 48px;
    text-align: center;
    font-family: 'Saira Condensed';
    padding-left:5px;
    padding-right:5px;
}
.imageNumber.num1 {
    background-color: red;
}
.imageBackGround {
    width: 210px;
    height: 210px;
    border-radius: 50%;
    background: #000000;
    opacity: 0.03;
    filter: alpha(opacity = 3);
    -ms-filter: alpha(opacity = 3);
}
.Best_Item li img.ItemImg {
    width: 210px;
    height: 210px;
    border-radius: 50%;
}
.Best_Item li span.ItemName {
    width: 210px;
    margin: 10px 0 0 0;
    text-align: center;
    font-size: 16px;
    line-height: 16px;
    color: #000000;
    text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
}
.Best_Item li span.ItemPrice {
    width: 210px;
    margin: 7px 0 5px 0;
    text-align: center;
    font-size: 16px;
    line-height: 16px;
    color: #000000;
    font-weight: bold;
}
.newArrival{width:1200px; height:600px;}
.newArrival img{
    margin-top : 20px;
    float:left;
}

.newArrival div{float:left;}

.a_font span {
	font-size: 25px;
	font-weight:bold;
	font-color:black;
}

.Event{width:1200px; height:800px; margin-bottom:50px;}
.Event ul {
	 float:left;
	 height: 350px;
	 background-color: #f8f8f8;
	 padding-top:50px;
	 text-align: center;
}

a {text-decoration: none;}

.Event ul li {
    list-style: none;
    width: 280px; height:300px;
    box-sizing: border-box;
    text-align: center;
    display: inline-block;
    padding-right : 35px;
    vertical-align: middle;
}

</style>
 
</head>

<body>

<!-- ★★★★★★★★★★ loginPro 를 타지 않아서 이메일 인증 확인 못함 ㅠㅠㅠ 팝업 못띄움  ★★★★★★★★★★ -->

<c:if test="${cnt == 1 && auth.auth == 1}">
	<script type="text/javascript">
		alert("로그인 되었습니다!");
	</script>
</c:if>

<!-- 이메일 인증이 되지 않았을 때도 로그인이 되지 않는다.  // 이건 혹시 몰라 남겨둠 -->
<c:if test="${cnt ==1 && auth.auth==0}">
	<script type="text/javascript">
		alert("이메일 인증되지 않은 계정입니다. \n 인증 후 다시 로그인하세요.");
	</script>
</c:if>



<!------목록보여주기 header----->
<%@ include file="header.jsp" %>
	
    <!-----------중간본문 section------------>
        <!-- !!!!!!!!전체 중앙 정렬 !!!!!!!!!!!  -->
 
    <div style="margin: 0 auto; width: 1200px;">
        
        <div class="content" >
	        <div class="mainImg">
	        	
	        home(연결계정 : <sec:authentication property="name"/>) 메인화면<br><br>
	            <img src="${root}PC_TopRollingurl_1 (1).jpg"> <!-- 젤큰 메인페이지 -->
	        </div>
 
            <!----------  중짜리 이미지 !! ---------->
 			<br>
            <div class="main2Img">
                
                <div style="width:600px; height:200px; float:left">
                <a href="" alt="">
                <img src="${root}PC_EventBannerurl_1.jpg" style="float:left;"> 
               		<p class="a_font" style="width:250px; position:absolute; margin-top:40px; padding-left:20px; margin-left:30px">
               		<span>차티켓을 부탁해<br></span> <br>주차번호판부터 거치대, 디퓨저까지- <br>센스만점 아트박스 차량용품</p>
                </a></div>
                
                <div style="width:600px; height:200px; float:left">
                <a href="" alt="">
                <img src="${root}PC_EventBannerurl_2 (1).jpg" style="float:left;">
                	<p class="a_font" style="width:250px; position:absolute; margin-top:40px; padding-left:20px; margin-left:30px">
                	<span>무더위 전초전<br></span> <br>급더워진 날씨!지금부터 여름내내 땀날 틈 없이- <br>미리미리 쿨템 준비!</p>
                </a></div>
                
            </div>
 
            <!---------- 베스트 상품 안내 !! ----------->
 			<br>
            <div class="ProductTitle">
                BEST ITEM <img src="${root}gogo_pc.png">
            </div>
 
            <div class="Best_Item">
                <ul>
                    <li><a href="#" alt=""> <span class="imageNumber num1">01</span>
                            <span class="imageBackGround"></span> <img class="ItemImg"
                            src="${root}PC_DesignFinderurl_2.jpg"> 
                            <span class="ItemName">노트 핑크오토 900 (03007927)</span> 
                            <span class="ItemPrice">900원</span>
                    </a></li>
 
                    <li><a href="#" alt=""> <span class="imageNumber">02</span>
                            <span class="imageBackGround"></span> <img class="ItemImg"
                            src="${root}PC_DesignFinderurl_3.jpg"> 
                            <span class="ItemName">노트 핑크오토 900 (03007927)</span> 
                            <span class="ItemPrice">900원</span>
                    </a></li>
 
 
                    <li><a href="#" alt=""> <span class="imageNumber">03</span>
                            <span class="imageBackGround"></span> <img class="ItemImg"
                            src="${root}PC_DesignFinderurl_4.jpg"> 
                            <span class="ItemName">노트 핑크오토 900 (03007927)</span> 
                            <span class="ItemPrice">900원</span>
                    </a></li>
 
                    <li><a href="#" alt=""> <span class="imageNumber">04</span>
                            <span class="imageBackGround"></span> <img class="ItemImg"
                            src="${root}PC_DesignFinderurl_5.jpg"> 
                            <span class="ItemName">노트 핑크오토 900 (03007927)</span> 
                            <span class="ItemPrice">900원</span>
                    </a></li>
 
                    <li><a href="#" alt=""> <span class="imageNumber">05</span>
                            <span class="imageBackGround"></span> <img class="ItemImg"
                            src="${root}PC_DesignFinderurl_6 (1).jpg"> 
                            <span class="ItemName">노트 핑크오토 900 (03007927)</span> 
                            <span class="ItemPrice">900원</span>
                    </a></li>
                </ul>
 
                <ul>
                    <li><a href="#" alt=""> <span class="imageNumber">06</span>
                            <span class="imageBackGround"></span> 
                            <img class="ItemImg" src="${root}PC_DesignFinderurl_6.jpg"> 
                            <span class="ItemName">노트 핑크오토 900 (03007927)</span> 
                            <span class="ItemPrice">900원</span>
                    </a></li>
 
                    <li><a href="#" alt=""> <span class="imageNumber">07</span>
                            <span class="imageBackGround"></span> 
                            <img class="ItemImg" src="${root}PC_DesignFinderurl_7.jpg"> 
                            <span class="ItemName">노트 핑크오토 900 (03007927)</span> 
                            <span class="ItemPrice">900원</span>
                    </a></li>
 
                    <li><a href="#" alt=""> <span class="imageNumber">08</span>
                            <span class="imageBackGround"></span> 
                            <img class="ItemImg" src="${root}PC_DesignFinderurl_8.jpg"> 
                            <span class="ItemName">노트 핑크오토 900 (03007927)</span> 
                            <span class="ItemPrice">900원</span>
                    </a></li>
 
                    <li><a href="#" alt=""> <span class="imageNumber">09</span>
                            <span class="imageBackGround"></span> <img class="ItemImg"
                            src="${root}PC_DesignFinderurl_9 (1).jpg"> 
                            <span class="ItemName">노트 핑크오토 900 (03007927)</span> 
                            <span class="ItemPrice">900원</span>
                    </a></li>
 
                    <li><a href="#" alt=""> <span class="imageNumber">10</span>
                            <span class="imageBackGround"></span> <img class="ItemImg"
                            src="${root}PC_DesignFinderurl_7 (1).jpg"> 
                            <span class="ItemName">노트 핑크오토 900 (03007927)</span> 
                            <span class="ItemPrice">900원</span>
                    </a></li>
                </ul>
            </div>
 
 
            <!--------- 신상품, 캐릭터소개 ---------->
 
             <br><br>
              <div class="ProductTitle">
                NEW ARRIVAL <img src="${root}gogo_pc.png">
              </div>
             <br>
             <div class="newArrival">
                
                <div style="width:390px; height:380px float:left">
                <a href ="" alt="">
             	<img src ="${root}PC_NewArrivalurl_1 (1).jpg" style="width:350px;">
               		<p class="a_font" style="width:250px; position:absolute; margin-top:50px; padding-left:20px; margin-left:20px">
               		<span>핑쿠핑쿠 꿀잠 친구 !</span> <br> 토끼무드등(2 COLORS)</p></a>
                </div>
                
                <div style="width:390px; height:380px">
                <a href ="" alt="">
             	<img src ="${root}PC_NewArrivalurl_2.jpg" style="width:350px;">
             		<p class="a_font" style="width:250px; position:absolute; margin-top:50px; padding-left:20px; margin-left:20px">
               		<span>에어팟에 완벽 핏!</span> <br> 에어팟 케이스(2 COLORS)</p>
             	</a>
                </div>
             	
             	<div style="width:390px; height:380px">
             	<a href ="" alt="">
             	<img src ="${root}PC_NewArrivalurl_3.jpg" style="width:350px;">
					<p class="a_font" style="width:250px; position:absolute; margin-top:50px; padding-left:20px; margin-left:20px">
               		<span>문콕사고 조심하개!</span> <br> 도어가드(2 TYPES))</p>
				</a>             	
             	</div>
                
                <a href ="http://www.artboxmall.com/home/company/AboutArtboxCharacters.asp">
             	<img src ="${root}PC_AboutArtboxurl_1.jpg">
                </a>
     
             </div>

            <!-------------------  이벤트 안내 !! --------------------->
 
 
            <div class="ProductTitle">
                EVENT♡ <img src="${root}gogo_pc.png">
            </div>
 
            <div class="Event">
                <ul>   
                    <li><a href="#" alt="">
                    <img src="${root}PC_EventRollingurl_1.jpg"><p>이벤트기간 2019.05.21~2019.5.30</p></a></li>
                    <li><a href="#" alt="">
                    <img src="${root}PC_EventRollingurl_3.jpg"><p>이벤트기간 2019.05.21~2019.5.30</p></a></li>
                    <li><a href="#" alt="">
                    <img class="EventImg" src="${root}PC_EventRollingurl_1 (1).jpg"><p>이벤트기간 2019.05.21~2019.5.30</p></a></li>
                    <li><a href="#" alt="">
                    <img class="EventImg" src="${root}PC_EventRollingurl_1 (2).jpg"><p>이벤트기간 2019.05.21~2019.5.30</p></a></li>
                </ul>
            </div>
	 
        </div>
    </div>


<!------화면 맨 하단 footer---->
 <%@ include file ="footer.jsp" %>
 
 
</body>
</html>
