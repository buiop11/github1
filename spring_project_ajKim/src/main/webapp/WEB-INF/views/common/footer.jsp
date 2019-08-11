<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<body>

    <hr>
    <footer>
            <div class="office_logo">
                <ul>
                    <li class="FooterLink">
                   		<a href="" target="_balnk">회사소개</a></li>
                    <li class="FooterLink">
                    	<a href="" target="_blank">이용약관</a></li>
                    <li class="FooterLink"> 
                   	 <a href="" target="_blank">개인정보취급방침</a></li>
                    <li class="FooterLink">
                    	<a href="" target="_blank">이메일주소무단수집거부</a></li>

			<!-- 관리자 로그인 -->
                    <li class="FooterLink" style="font-weight: bold; border-radius: 10px; background-color:#f3f3f3">
                    	<a href="admin/main" target="_blank">관리자로그인</a></li>
                    	<!-- 시큐리티로 이동  -->
                    <li class="family_site">
	                    <select
	                        onchange="if(this.value){        
	                            window.open(this.value,'_blank');
	                            this[0].selected=true;}">
	                            <option value>패밀리사이트</option>
	                            <!-- select - onchange 있어야함!!-->
	                            <option value="http://www.poom.co.kr">POOM</option>
	                            <option value="http://www.sysmax.co.kr">SYSMAX</option>
	                    </select>
                    </li>
                    <li class="instagram">
                    	<a href="http://recruit.artbox.co.kr/" target="_blank"><img src="${root}instagram.png"> </a></li>
                    <li class="facebook">
	                    <a href="http://recruit.artbox.co.kr/" target="_blank"> <img src="${root}facebook.png"></a></li>
                </ul>
            </div>
    
    
        <!-------------- 고객 센터 !! ----------------->
        <div class ="CustomerSeivce">
            <ul>
                <li class ="callCenter" style="float:left;">
                <a href="board" onclick="">
                    <b class="string">고객감동센터</b>
                    <b class="number">1577-9081</b>
                    
                    	운영시간 09:00 - 18:00, 점심시간 12:30 - 13:30<br>
               		 <small>*주말 및 공휴일은 1:1 문의/상담을 이용해주세요.</small>
                </a>
                </li>
                
                <!-- 다 게시판으로 이동 ㅋㅋㅋ -->
                <li class="twoButton" style="float:left;">
                    <a href ="board" onclick="">
                    <img src="${root}footer_btn2.png">1:1 문의상담
                    </a>
                    
                    <a href ="location" onclick="">
                    <img src="${root}footer_btn1.png">아트박스 위치
                    </a>
                    
                </li>
                
                <li class="information" style="float:left;">
                    <big>(주)아트박스</big>
                    <br>
                    
	                (06653) 서울특별시 서초구 반포대로 12길 41  
	                	대표이사 : 조석현  사업자등록번호 214-81-06825  
	                <a href="">사업자 등록확인</a>
	                <br>
				                통신판매업신고 제 2011-서울서초-0404호  
				                개인정보 책임자 : 정정설  호스팅제공자 : (주)아트박스
	                <br>
	                	E-MAIL: customer@poom.co.kr
	                <br>
	               		COPYRIGHT © 2011 ARTBOX CO., LTD ALL RIGHTS RESERVED.
                </li>
            
            </ul>
            
        </div>
    
    </footer>
 

</body>
</html>