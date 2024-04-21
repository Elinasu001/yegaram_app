<%@page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
var ${reqDs.id}_Func = ({
	// 닫기  
	close : function(){},
	// 취소 (그만하기)
	cancel : function(){},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(yn){
		${reqDs.id}_Func.callback(yn);
	},
	// 호출 화면 콜백 처리	
	callback : function(){}
});
$(document).ready(function(){
	biz.keypad('OTP 비밀번호', 6, fnOtpAuth);
});
function fnOtpAuth(encData) {

	var reqForm = makeForm("reqForm");
	addFormData(reqForm, "E2E_OTP_OTPT_VAL", encData); 	// OTP인증값
	doAction("OTP_AUTH", reqForm, function(resDs){
		if (resDs.API_RS_MSG == 'SUCCESS') {
			biz.alert("인증되었습니다.", "확인", function(){${reqDs.id}_Func.confirm('Y');});
		} else {
			biz.alert(resDs.API_RS_MSG);
			${reqDs.id}_Func.confirm('N');
		}
	});
	
}
</script>
<div class="content-wrap">
    <div class="pop-header">
        <h2 class="pop-title">${reqDs.title }</h2>
        <button type="button" name="button" class="btn-layer-close" data-focus="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
    </div>
</div>