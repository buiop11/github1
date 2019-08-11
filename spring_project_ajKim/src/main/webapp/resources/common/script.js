/**
 * validation check 
 */

// ------------------메세지 따로 뺴기 (필수 체크) -------------------
var msg_id = "아이디를 입력하세요!";
var msg_pwd = "비밀번호를 입력하세요!";
var msg_repwd = "비밀번호를 확인하세요!";
var msg_pwdChk ="비밀번호가 일치하지 않습니다!!";
var msg_name = "이름을 입력하세요!!";
var msg_jumin1 = "주민번호 앞자리를 입력하세요!";
var msg_jumin2 = "주민번호 뒷자리를 입력하세요!";
var msg_email1 = "이메일을 입력하세요!!";
var msg_emailChk = "이메일 형식이 일치하지 않습니다!!"
var msg_confirmId = "중복확인을 해주세요.!!";

//------------- DB 에러 insert, update, delete 에러-------
var insertError = "회원가입에 실패했습니다. \n확인 후 다시 시도하세요!!";
var updateError = "회원정보 수정에 실패했습니다. \n확인 후 다시 시도하세요!!";
var deleteError = "회원탈퇴에 실패했습니다. \n확인 후 다시 시도하세요!";
var pwdError = "입력하신 비밀번호가 일치하지 않습니다. \n확인 후 다시 시도하세요!!";



//중복확인창에서 id입력 여부 
function confirmIdCheck() {
  if(!document.confirmform.id.value){
      alert(msg_id);
      document.confirmform.id.focus();
      return false;
  }
  
}


// 이메일 select
function selectEmailChk(){
	  
  var email2 = document.inputform.email2;
  var email3 = document.inputform.email3;
  // 함수마다 설정하던지 다 쓰던지 해야함 
  
  // 직접입력 
  if(email3.value == 0) { 
      email2.value ="";     // 값을 초기화하고  focus() 가져다 둠 
      email2.focus();
  }else {
  // 이메일 직접입력이 아닌 경우 select box의 값(email3)을 email2의 값으로 설정 
      email2.value = email3.value; //  email2자리에 email3의 값을 줘라 
  }
  
}


function confirmId(){        
	  
  //id값 미입력 후 중복확인 버튼클릭시 
  if(!document.inputform.id.value){
	  alert(document.inputform.id.value);
      alert("아이디를 입력해주세요!");
      document.inputform.id.focus();
      return false;
  }
  
  //get방식으로 id값 가져오기 
  var url = "confirmId?id=" + document.inputform.id.value;
  
  /*
   * window.open("파일명"(url),"윈도우명","창속성");
   * url = "주소?속성=" + 속성값;   -> get 방식
   */
  window.open(url, "confirm", "menubar=no, width=500, height=500");
  // -> confirmId.do 서블릿 지정     
      
}


//opener : window 객체의 open() 메소드로 열린 새창(=중복 확인창)에서, 열어준 부모창(=회원가입창)에 접근할 때 사용
//self.close() : 메세지없이 현재창을 닫을때 사용
//hiddenId : 중복확인 버튼 클릭여부 체크(0: 클릭안함, 1: 클릭함)
function setId(id){
opener.document.inputform.id.value = id;     // 부모쪽(연쪽)으로 (넘겨받은)값을 전달 
opener.document.inputform.hiddenId.value ="1"; // 히든아이디를 1로 체크
self.close();
}

// 회원가입 히든값 체크 
function hiddenChk(){
	if(document.inputform.hiddenId.value == 0) {
	      alert(msg_confirmId);
	      document.inputform.dupChk.focus();
	      return false;
	  }
}


// 에러 경고창 
function errorAlert(msg){
	alert(msg);
}


// 회원탈퇴 확인창 
function c_deleteConfirm(){
	var confirmfig = confirm("회원탈퇴를 하시면 정보가 모두 사라집니다. \n 정말로 탈퇴하시겠습니까?");
	
	if(confirmfig){ // "네" 선택시  삭제페이지로 이동 
		window.location="c_deletePro";
	}else{
		window.history.back();
	}
}

