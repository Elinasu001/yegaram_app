<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
var ${reqDs.id}_Func = ({
	// 닫기  
	close : function(){},
	// 취소 (그만하기)
	cancel : function(){},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(result){
		// 레이어 업무 선택 및 입력 완료 처리 
		${reqDs.id}_Func.callback(result);
	},
	// 호출 화면 콜백 처리	
	callback : function(){
	},
	/*********************
	* 계좌 예금주 조회
	**********************/
	checkAccount : function(){
		
		var selBkcd = $('#FSB_AUTH_BKCD').val();
		var selAcno = $.trim($('#FSB_AUTH_ACNO').val()); 

		if (selBkcd == "") {
			biz.alert("은행을 선택해 주세요");
			return;
		}
		if (selAcno == "") {
			biz.alert("계좌번호를 입력해 주세요");
			return;
		}
		
		var fsbAcnoAuthForm = makeForm("fsbAcnoAuthForm");
		addFormData(fsbAcnoAuthForm, "txGbnCd", "R");
		addFormData(fsbAcnoAuthForm, "BKCD", selBkcd);
		addFormData(fsbAcnoAuthForm, "ACNO", selAcno);
		
		addFormData(fsbAcnoAuthForm, "PROD_KNCD", "10");	// TODO 
		
		doAction("FSB_ACNO_AUTH", fsbAcnoAuthForm, function(resDs){
			//if (resDs.API_RS_MSG == 'SUCCESS' && resDs.RESP_CD == '000') {
			if (resDs.API_RS_MSG == 'SUCCESS') {
				// 이체성공 입력값 레이어 기동
				biz.fsbAcnoAuthConfirm(${reqDs.id}_Func.isAcctChkCallback, selBkcd, selAcno);
			} else {
				if (resDs.RESP_MSG_CNTN != '') {
					biz.alert(resDs.RESP_MSG_CNTN);
				} else {
					biz.alert(resDs.API_RS_MSG);	
				}
			}
		});
	}

	/*********************
	* 계좌인증 완료
	**********************/
	, isAcctChkCallback : function(data){
		if (data == "Y") {
			$("#fsbAcnoAuthBtn").removeClass("disabled");	
		}
	}
	, procBtn : function() {
		if ($("#fsbAcnoAuthBtn").hasClass("disabled")) {
			biz.alert("계좌인증이 완료되지 않았습니다");
		} else {
			${reqDs.id}_Func.callback("Y");	
		}
	}
});

$(function(){
	dynamicInput(); //라벨 이벤트
});

// 입금은행 선택 후 선택값 세팅
function srchRcvBankCallback(data){		// type, val, name, code
	$("#FSB_AUTH_BKNM").text(data.BKNM); 	// 송금계좌 은행명
	$("#FSB_AUTH_BKCD").val(data.BKCD); 	// 송금계좌 은행코드
	$("#div_FSB_AUTH_BKNM").addClass("on");
 	inputFocus($("#FSB_AUTH_ACNO"));
}

</script>
<div class="content-wrap">
	<div class="pop-header">
		<h2 class="pop-title">${reqDs.title }</h2>
		<button type="button" name="button" class="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
	</div>
	<div class="pop-con-wrap">
		
		<div class="default-wrap mt15 mb20">

			<div class="tit-wrap mt20">
				<p class="txt"><strong>타행본인계좌인증</strong>을<br> 진행할게요</p>
			</div>

			<!-- s: 타행 계좌 정보 -->
			<div class="bank-input-warp">
				<!-- <p class="s-txt">본인명의의 타행 계좌정보를 입력해주세요</p> [퍼블] 삭제 -->
				<div class="form-wrap">
					<div class="select-wrap" id="div_FSB_AUTH_BKNM"><!-- 2023-06-15 클래스 type2 추가 -->
						<div class="select-box" tabindex="1" onclick="removeErr(this); biz.bank(srchRcvBankCallback);">
							<label for="FSB_AUTH_BKNM">은행</label><!-- 2023-06-16 구조 추가 -->
							<span class="option" id="FSB_AUTH_BKNM">미선택</span>
						</div>
						<input type="hidden" id="FSB_AUTH_BKCD" value=""/>
					</div>
					<p class="error-txt">은행을 선택하세요</p>
				</div>
				<div class="form-wrap form-line mt0"><!-- 2023-06-15 클래스 mt0 추가 -->
					<label for="FSB_AUTH_ACNO" class="formlabel onbasic">계좌번호</label>
					<div class="input">
						<input type="tel" title="계좌번호" id="FSB_AUTH_ACNO" class="inp" value="" placeholder="계좌번호을 입력해주세요" numberOnly pattern="[0-9]*" 
						oninput="UtilFunc.inputMaxLength(this);" onclick="removeErr(this);" maxlength="20" required="required">
						<button type="button" class="btn-certi" onclick="${reqDs.id}_Func.checkAccount('RCV');" >계좌인증</button>
					</div>
					<p class="error-txt">계좌번호를 입력해주세요</p>
				</div>
			</div>
			<!-- e: 대출금 입금 계좌 정보 -->
		</div>
	</div>
	<div class="fixed-btn-wrap">
		<div class="btn-wrap">
			<a href="#none" class="btn disabled" id="fsbAcnoAuthBtn" onclick="${reqDs.id}_Func.procBtn();">다음</a>
		</div>
	</div>
</div>