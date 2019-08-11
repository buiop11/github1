<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.FindId, .FindPwd {
    width: 680px;
    margin: 46px auto 0;
    padding: 0;
} 
.FindIdPwTab {
    border: 1px solid #424242;
    border-radius: 5px;
}
.FindIdPwTab a.Off {
    background-color: transparent;
    color: #424242;
    font-weight: normal;
}
.FindIdPwTab a.On {
    background-color: #000000;
    color: #ffffff;
    font-weight: normal;
}
input[type=password], .inputText, .FindIdResultInner {
    width: 600px;
    padding: 0 22px;
    margin: 0;
    line-height: 56px;
    height: 56px;
    color: #777777;
    font-size: 15px;
    border: 0;
    background-color: #f3f3f3;
    border-radius: 5px;
}
a#TabIdSubmit, a#TabPwSubmit, a#TabIdLogin, a#CallSixNum , a#CheckSixNum{
    display: block;
    width: 312px;
    padding: 0;
    text-align: center;
    margin: 30px auto 0;
    line-height: 56px;
    height: 56px;
    color: #ffffff;
    font-size: 22px;
    border: 0;
    background-color: #000000;
    border-radius: 5px;
    font-weight: bold;
}
.FindIdPwTab a {
    float: left;
    display: block;
    width: 50%;
    text-align: center;
    height: 54px;
    line-height: 54px;
    font-size: 17px;
}
</style>
 
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
 
$(document).ready(function(){
 
   /*  $("input[type=tel]").keyup(function(e){
         if (!Check_Number(e.currentTarget.value)) {
            alert("숫자값만 입력가능합니다.");
            this.value="";
        } 
        if (this.id=="i_memcpnum1"&&this.value.length>=3) {
            document.getElementById("i_memcpnum2").focus();
        }
        if (this.id=="i_memcpnum2"&&this.value.length>=4) {
            document.getElementById("i_memcpnum3").focus();
        }
    }); */
 
    $("input[type=radio]").click(function(){
        if ($("#i_findtypeCPNUM").prop("checked")){
            $("#TableCPNUM").css("display","table");
            $("#TableEMAIL").css("display","none");
        } else if ($("#i_findtypeEMAIL").prop("checked")) {
            $("#TableCPNUM").css("display","none");
            $("#TableEMAIL").css("display","table");
        }
    });
 
    fnTabMenu = function(id){
 
        $("#FindInput").css("display","block");
        $("#FindIdResult").css("display","none");
        $("#FindPwResult").css("display","none");
        $("#TableSIXNUM").css("display","none");
 
        if (id=="TabId") {
 
            $("#TabId").attr("class","On");
            $("#TabPw").attr("class","Off");
            $(".TabIdText").css("display","block");
            $(".TabPwText").css("display","none");
 
            $("dl#trMEMID").css("display","none");
            $("dl#trName").css("display","table-row");
 
            $("a#TabIdSubmit").css("display","block");
            $("a#CallSixNum,a#CheckSixNum").css("display","none");
 
        } else if (id="TabPw") {
 
            $("#TabId").attr("class","Off");
            $("#TabPw").attr("class","On");
            $(".TabIdText").css("display","none");
            $(".TabPwText").css("display","block");
 
            $("dl#trMEMID").css("display","table-row");
            $("dl#trName").css("display","none");
 
            $("a#TabIdSubmit").css("display","none");
            $("a#CallSixNum,a#CheckSixNum").css("display","block");
        }
    }
 
    //************ id -  submit ***************** 
    fnTabIdSubmit = function(){
 
 
        if (!$("#i_memname").val()) {
            alert("이름을 입력해주세요.");
            $("#i_memname").focus();
            return;
        }
 
        param += "&v_memname=" + encodeURI($("#i_memname").val());
 
        if ($("#i_findtypeEMAIL").prop("checked")) {
 
            if (!$("#i_mememail").val()) {
                alert("이메일을 입력해주세요.");
                $("#i_mememail").focus();
                return;
            }
 
            param += "&v_findtype="+"EMAIL";
            param += "&v_mememail=" + encodeURI($("#i_mememail").val());
 
        }
 
        //alert("sdfsdfsdfsfd  타타??"); // 이건탐 
        
        $.ajax({
            url : "/myproject/idFindPro",
            data : param,
            type : "POST",
            dataType : "json",
            success : function(result){
                console.log(result);
                
                var id = result.id; // result의 id가 키니깐 - value 담기는거
                console.log(id);
                
                if (id != null) {
 
                    $(".FindIdResultInner").text(id);
                    $(".FindIdResultInner").css("color","red");
 
                    $("#FindInput").css("display","none");
                    $("#FindIdResult").css("display","block");
                    
                } else {
                    
                    alert("찾으시는 조건의 아이디가 없습니다.");
                } 
        
            },
            error:function(request,status,error){
                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        
        }); 
        
    }
 
    
    //************ pwd -  submit ***************** 
    fnTabPwCheck = function(){
 
        var param = "proctype=find_memid_check";
 
        if (!$("#i_memid").val()) {
            alert("아이디를 입력해주세요.");
            $("#i_memid").focus();
            return;}
 
        param += "&v_memid=" + encodeURI($("#i_memid").val());
 
        /* if (!$("#i_memname").val()) {
            alert("이름을 입력해주세요.");
            $("#i_memname").focus();
            return;
        } */
 
        //param += "&v_memname=" + encodeURI($("#i_memname").val()); 
 
         if (!$("#i_mememail").val()) {
             alert("이메일을 입력해주세요.");
             $("#i_mememail").focus();
             return;
         }

        // param += "&v_findtype="+"EMAIL";
         param += "&v_mememail=" + encodeURI($("#i_mememail").val());
       alert(param);
 		      
 		$.ajax({
            url : "/myproject/pwdFindPro",
            data : param,
            type : "POST",
            dataType : "json",
            success : function(result){
            	
            	console.log(result);

            	if (result== 1) {
            		alert("아이디와 이메일이 확인되어 \n 이메일이 발송되었습니다. ^^");
                    //$("#i_memberidx").val("인증번호를 발송해야함");
                    //fnCallSixNum();
            		$("#TableSIXNUM").css("display","block"); // 인증 블럭 열기
            		
            		// 메일보내기 
            		$.ajax({
                        url : "/myproject/pwdFindPro2",
                        data : param,
                        type : "POST",
                        dataType : "json",
                        success : function(result){
                        	
                        	console.log(result);
                        	console.log("메일전송 보냄!");
                        },
                        error:function(request,status,error){
                            //alert("메일전송 에러!");	// 메일가는데 이게 뜸. ㅠㅠ 
                        }
            		}); 
            		
                } else {
                    //$("#i_memberidx").val("");
                    alert("아이디와 비밀번호가 일치하는 정보가 없습니다. \n 다시 확인해주세요!");
                }  
 
            }
        }); 
    }
 
    
 
    // ***  인증번호 입력 submit *** 
    fnCheckSixNum = function(){
        var param = "proctype=join_sixnum_check";
 
        if (!$("#i_sixnum").val()) {
            alert("인증번호 6자리를 입력해주세요.");
            $("#i_sixnum").focus();
            return;
        }
 
        param += "&v_sixnum=" + $("#i_sixnum").val();
        param += "&v_memid=" + encodeURI($("#i_memid").val());
 
        $.ajax({
            url : "/myproject/pwdFindPro3",
            data : param,
            type : "POST",
            dataType : "json",
            success : function(result){
            	
            	console.log(result);
            	
                 if (result== 1) {
                    alert("비밀번호를 변경하세요");
                    $("#FindInput").css("display","none");
                    $("#FindPwResult").css("display","block"); 
                    
                } else {
					alert("인증값이 다릅니다. \n 다시입력해주세요.");
                }
            },
            error:function(request,status,error){
               alert("인증 에러!");	
            }
        });
    }
 
    
    // **** 비밀번호 변경  submit **** 
    fnTabPwSubmit = function(){
        var param = "proctype=find_mempw_change";
 
 
       /*  if (!$("#i_memberidx").val()) {
            alert("인증값이 유효하지 않습니다. 다시 인증해주세요.");
            return;
        }
        param += "&v_memberidx=" + $("#i_memberidx").val(); */
 
        if (!$("#i_mempwd").val()) {
            alert("비밀번호를 입력해주세요.");
            $("#i_mempwd").focus();
            return;
        }
 
        if ($("#i_mempwd2").val()!=$("#i_mempwd").val()) {
            alert("비밀번호가 일치하지 않습니다.");
            $("#i_mempwd2").focus();
            return;
        }
        param += "&v_mempwd=" + $("#i_mempwd").val();
        param += "&v_memid=" + encodeURI($("#i_memid").val());
 
        $.ajax({
            url : "/myproject/pwdModify",
            data : param,
            type : "POST",
            dataType : "json",
            success : function(result){
            	
            	console.log(result);
 
                if (result== 1) {
                    alert("비밀번호가 변경되었습니다. \n 다시 로그인페이지로 이동합니다!");
                    location.href = "login";
                } else {
                    alert("비밀번호 변경 실패");
                }
            },
            error:function(request,status,error){
                alert("비밀번호 변경 에러!");	
             }
        });
    }
});
 
 
function Check_Number(str) { // only number
    var reg = /^[0-9]*$/;
    return reg.test(str);
}
 
function Check_Id(str) {
    var reg1 = /^[a-zA-Z0-9]{4,16}$/;    // a-z 0-9 중에 4자리 부터 16자리만 허용 한다는 뜻
    var reg4 = /^\d.*/ // 숫자로 시작
 
    return (reg1.test(str)&&!reg4.test(str));
}
 
 
function Check_Email(str) {
    var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
    return (exptext.test(str));
}
 
function Check_Date(str) {
    var exptext = /^(19|20)\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$/;
    return (exptext.test(str));
}
 
</script>
 
<body>
 
<!-------목록보여주기 header------>
<%@ include file="header.jsp" %> 
 
<!-- 본문 시작  -->
<form action="pwdFindPro2" name="pwdFindPro" id="pwdFindProForm" method="post">
 
<div class="FindIdPwWrap" style="width:1200px; margin: 0 auto; margin-bottom:150px; margin-top:50px;">
    <h1 align="center">아이디/비밀번호 찾기</h1>
    <div class="FindIdPwForm" style="width:900px; margin: 0 auto;">
        <div class="FindIdPwTab">
            <a href="javascript:fnTabMenu('TabId');" id="TabId" class="On">아이디 찾기</a>
            <a href="javascript:fnTabMenu('TabPw');" id="TabPw" class="Off">비밀번호 찾기</a>
            <div class="clear"></div>
        </div>
        <h4 class="TabIdText">- 회원정보에 입력한 이메일 주소와 이름으로 아이디를 찾을 수 있습니다.<br />- 개인 정보 보호를 위해 아이디 뒷자리는 *로 표시됩니다.</h4>
        <h4 class="TabPwText" style="display:none">- 회원정보에 입력한 이메일 주소로 인증이 가능합니다.<br />- 본인인증 후, 새로운 비밀번호를 등록해 주세요. </h4>
 
        <div id="FindInput">
            <div class="tableDiv" align="center">
                <dl class="trFindType">
                    <dd>
                        <!-- <input type="radio" id="i_findtypeCPNUM" name="findtype" value="phone" checked="checked" /> 휴대전화
                        &nbsp;&nbsp;&nbsp;&nbsp; -->
                        <input type="radio" id="i_findtypeEMAIL" name="findtype" value="email" checked="checked" /> 이메일
                    </dd>
                </dl>
                <dl class="trJoin" id="trMEMID" style="display:none">
                    <dd>
                        <input type="text" id="i_memid" name="memid" class="inputText" maxlength="16" placeholder="아이디를 입력해주세요." />
                        <p class="null"></p>
                    </dd>
                </dl>
                <dl class="trJoin"  id="trName" style="display:block">
                    <dd>
                        <input type="text" id="i_memname" name="name" maxlength="16"  class="inputText" placeholder="이름을 입력해주세요." />
                        <p class="null"></p>
                    </dd>
                </dl>
            </div>

			<!-- 이메일 보내기  -->
            <div class="tableDiv" id="TableEMAIL" align="center">
                <dl class="trJoin">
                    <dd>
                        <input type="text" id="i_mememail" name="email" class="inputText" maxlength="50" placeholder="예) example@artbox.co.kr" />
                        <p class="null"></p>
                    </dd>
                </dl>
            </div>
            <a id="TabIdSubmit" href="javascript:fnTabIdSubmit();">확인</a>
            <a id="CallSixNum"  href="javascript:fnTabPwCheck();" style="display:none">인증번호 받기</a>
            
            <!-- 인증번호 입력창  -->
            <div class="tableDiv" id="TableSIXNUM" style="display:none; margin:0 auto; margin-top: 50px;">
                <dl class="trJoin" align="center">
                    <dd>
                        <p class="null"></p>
                        <input type="tel" id="i_sixnum" name="sixnum" class="inputText" maxlength="6" placeholder="인증번호 6자리" />
                        <%-- <input type="text" value="${key}"> 전에 있던 값을 가지고옴.--%>
                    </dd>
                    <dd class="blank">&nbsp;</dd>
                    <dd class="findpw">
                        <p class="null"></p>
                        <a id="CheckSixNum" href="javascript:fnCheckSixNum();">인증</a>
                    </dd>
                </dl>
            </div>
        </div>
        <div id="FindIdResult" style="display:none">
            <div class="FindIdResultInner"></div>
            <a id="TabIdLogin" href="main">로그인 화면으로</a>
        </div>
        <div id="FindPwResult" style="display:none">
            <input type="hidden" id="i_memberidx" name="memberidx" />
            <div class="tableDiv">
                <dl class="trJoin">
                    <dd>
                        <input type="password" id="i_mempwd" name="mempwd" maxlength="16" placeholder="새 비밀번호를 입력해주세요." />
                        <p class="null"></p>
                    </dd>
                </dl>
                <dl class="trJoin">
                    <dd>
                        <input type="password" id="i_mempwd2" name="mempwd2" maxlength="16" placeholder="새 비밀번호를 다시 한 번 입력해주세요." />
                        <p class="null"></p>
                    </dd>
                </dl>
            </div>
            <a id="TabPwSubmit" href="javascript:fnTabPwSubmit();">확인</a>
        </div>
    </div>
</div>
 
</form>
 
 
 
<!-------화면 맨 하단 footer--------->
 <%@ include file="footer.jsp" %>
 
 
 
</body>
</html>
