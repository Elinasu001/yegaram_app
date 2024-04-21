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
		// 레이어 업무 선택 및 입력 완료 처리 
		${reqDs.id}_Func.callback(yn);
	},
	// 호출 화면 콜백 처리	
	callback : function(){}
});
$(document).ready(function(){
	fnSecuCardNoInq();
});

// 보안카드 인증번호요청
function fnSecuCardNoInq() {
	
	var reqForm = makeForm("reqForm");
	addFormData(reqForm, "txGbnCd", "P");
	doAction("SECU_CARD_AUTH", reqForm, function(resDs){
		if (resDs.API_RS_MSG == 'SUCCESS') {
			$("#SECUNO_IDX1").val(resDs.SECUNO_IDX1);
			$("#SECUNO_IDX2").val(resDs.SECUNO_IDX2);
			$("#SECUNO_IDX1_text").html(resDs.SECUNO_IDX1);
			$("#SECUNO_IDX2_text").html(resDs.SECUNO_IDX2);	
		} else {
			biz.alert(resDs.API_RS_MSG);
		}
	});
}

// 보안카드 인증
function fnSecuCardAuth(){
	
	var sucuPwd1 = $("#iptCrtf01_1").val() + $("#iptCrtf01_2").val();
	var sucuPwd2 = $("#iptCrtf02_3").val() + $("#iptCrtf02_4").val();
	
	if(sucuPwd1.length < 2){
		biz.alert("보안카드번호 앞 두자리를 입력하세요");
		return;
	} else if(sucuPwd2.length < 2){
		biz.alert("보안카드번호 뒤 두자리를 입력하세요");
		return;
	}
	
	var reqForm = makeForm("reqForm");
	addFormData(reqForm, "txGbnCd", "R");
	addFormData(reqForm, "SECU_CARD_INDC_NO1", $("#SECUNO_IDX1").val()); 	// 보안카드 지시번호#1
	addFormData(reqForm, "SECU_CARD_PWD1_700", sucuPwd1); 					// 보안카드 비밀번호1
	addFormData(reqForm, "SECU_CARD_INDC_NO2", $("#SECUNO_IDX2").val()); 	// 보안카드 지시번호#2
	addFormData(reqForm, "SECU_CARD_PWD2_700", sucuPwd2); 					// 보안카드 비밀번호2
	//addFormData(reqForm, "SECU_CARD_SRNO", ""); 							// 보안카드 일련번호 끝3자리
	
	doAction("SECU_CARD_AUTH", reqForm, function(resDs){
		if (resDs.API_RS_MSG == 'SUCCESS') {
			biz.alert("인증되었습니다.", "확인", function(){${reqDs.id}_Func.confirm('Y');});
		} else {
			biz.alert(resDs.API_RS_MSG);
		}
	});
}
</script>
<div class="content-wrap">
	<input type="hidden" id="SECUNO_IDX1" />
	<input type="hidden" id="SECUNO_IDX2" />
	
	<div class="pop-header">
		<h2 class="pop-title">${reqDs.title }</h2>
		<button type="button" name="button" class="btn-layer-close" data-focus="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
	</div>

	<div class="pop-con-wrap">
			<div class="default-wrap">
				<div class="tit-wrap"><!-- [퍼블] 클래스 변경 -->
					<p class="txt"><b>보안카드 번호</b>를 입력해주세요</p>
				</div>

				<div class="form-wrap form-crtf mt10">
					<div class="input">
						<p class="txt-crtf"><span id="SECUNO_IDX1_text"></span> 앞 두자리</p>
						<span>
							<input type="tel" title="" id="iptCrtf01_1" placeholder="" required="" numberonly maxlength="1" onfocus="$(this).val('');" onkeyup="validChk('${reqDs.id}'); if(this.value.length == 1){$('#iptCrtf01_2').focus();}" class="${reqDs.id}_validChk">
						</span>
						<span>
							<input type="tel" title="" id="iptCrtf01_2" placeholder="" required="" numberonly maxlength="1" onfocus="$(this).val('');" onkeyup="validChk('${reqDs.id}'); if(this.value.length == 1){$('#iptCrtf02_3').focus();}" class="${reqDs.id}_validChk">
						</span>
						<span class="disabled">
							<input type="tel" title="" id="iptCrtf01_3" placeholder="1" required="" numberonly maxlength="1" disabled>
						</span>
						<span class="disabled">
							<input type="tel" title="" id="iptCrtf01_4" placeholder="2" required="" numberonly maxlength="1" disabled>
						</span>
					</div>
				</div>

				<div class="form-wrap form-crtf mt40">
					<div class="input">
						<p class="txt-crtf"><span id="SECUNO_IDX2_text"></span> 뒤 두자리</p>
						<span class="disabled">
							<input type="tel" title="" id="iptCrtf02_1" placeholder="3" required="" numberonly maxlength="1" disabled>
						</span>
						<span class="disabled">
							<input type="tel" title="" id="iptCrtf02_2" placeholder="4" required="" numberonly maxlength="1" disabled>
						</span>
						<span>
							<input type="tel" title="" id="iptCrtf02_3" placeholder="" required="" numberonly maxlength="1" onfocus="$(this).val('');" onkeyup="validChk('${reqDs.id}'); if(this.value.length == 1){$('#iptCrtf02_4').focus();}" class="${reqDs.id}_validChk">
						</span>
						<span>
							<input type="tel" title="" id="iptCrtf02_4" placeholder="" required="" numberonly maxlength="1" onfocus="$(this).val('');" onkeyup="validChk('${reqDs.id}'); if(this.value.length == 1){$('#${reqDs.id}_procBtn').focus();}" class="${reqDs.id}_validChk">
						</span>
					</div>
				</div>
				<p class="info-txt mt50">5회 오류 시 서비스 이용이 중단되고 메인으로 이동해요<br>오류 해제를 원하실 경우 영업점에 방문해 이용제한 해제를 하셔야 해요</p>
			</div>	
		</div>

		<div class="fixed-btn-wrap">
			<div class="btn-wrap">
				<a href="#none" class="btn disabled" id="${reqDs.id}_procBtn" onclick="javascript:fnSecuCardAuth();">인증</a>
			</div>
		</div>
	
</div>