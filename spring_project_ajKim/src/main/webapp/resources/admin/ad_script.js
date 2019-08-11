/**
 *     validation check 
 */

var pwdError= "비밀번호가 일치하지 않습니다. \n 확인후 다시 시도하세요!";
var updateError = "글수정에 실패했습니다. \n 확인후 다시 시도하세요!";
var deleteError = "글삭제에 실패했습니다. \n 확인후 다시 시도하세요!";
var insertError = "글작성에 실패했습니다. \n 확인후 다시 시도하세요!";
var payApproval = "결제승인에 실패했습니다. \n 확인후 다시 시도하세요!";
var refundApproval = "환불승인에 실패했습니다. \n 확인후 다시 시도하세요!";

function errorAlert(msg){
	alert(msg);
	window.history.back();
}

function goodbyeAlert(){
	alert("수고했습니다. ^^");
}