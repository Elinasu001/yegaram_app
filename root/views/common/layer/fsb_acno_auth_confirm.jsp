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
	
	// 적요번호 입력 시 다음 인풋 클릭
	changeRemark : function(obj){
		if(!UtilFunc.isNull($(obj).val())){
			// 다음요소클릭
			if($(obj).attr("id") != "REMARK4")$(obj).parent().next().find("input").focus();
			${reqDs.id}_Func.acnoAuthNextBtn();
		} 
	},                                 
	
	// 다음버튼 활성화
	 acnoAuthNextBtn : function() {
		 if(!UtilFunc.isNull($('#REMARK1').val()) && !UtilFunc.isNull($('#REMARK2').val()) 
					&& !UtilFunc.isNull($('#REMARK3').val()) && !UtilFunc.isNull($('#REMARK4').val())){
		 	$("#${reqDs.id}_nextBtn").removeClass("disabled");
		} else {
			$("#${reqDs.id}_nextBtn").addClass("disabled");
		}
	},

	/*********************
	* 인증번호 valid
	**********************/
	checkInput : function(){
		//적요번호
		var remark = $('#REMARK1').val() + $('#REMARK2').val() + $('#REMARK3').val() + $('#REMARK4').val();
		
		if(remark.length != 4){
			biz.alert("인증번호를 입력해주세요.");
			
		} else {
			var fsbAcnoAuthConfirmForm = makeForm("fsbAcnoAuthConfirmForm");
			addFormData(fsbAcnoAuthConfirmForm, "txGbnCd", "A"); // 인증거래
			addFormData(fsbAcnoAuthConfirmForm, "ACNO", $("#FSB_AUTH_CONFIRM_ACNO").val()); // 계좌번호
			addFormData(fsbAcnoAuthConfirmForm, "BKCD", $("#FSB_AUTH_CONFIRM_BKCD").val()); // 은행코드
			addFormData(fsbAcnoAuthConfirmForm, "AUTN_STR", remark); // 인증문자열
			addFormData(fsbAcnoAuthConfirmForm, "PROD_KNCD", "10");	// TODO 
			
			doAction("FSB_ACNO_AUTH", fsbAcnoAuthConfirmForm, function(res){
				if (res.AUTH_SUCC_YN == "Y") {
					biz.alert("<span class='pop-con'>계좌 인증이<br>완료되었어요</span>","확인", function () {
						${reqDs.id}_Func.confirm("Y");
					});
				} else {
					biz.alert("<span class='pop-con'>입력하신 인증번호가 일치하지 않아요.<br>인증번호를 확인해주세요</span>","확인");
				}
			});
		}
	}
});

$(document).ready(function(){
	
});
$(function(){
	//타이머 기동
	initOtuAthnNoTimer();
});

/*********************
* 타이머 스크립트
**********************/
function initOtuAthnNoTimer() {
	//타이머 초기화
	var intervalId = $('#otuAthnNoIntervalId').val();
	if(intervalId != ''){
		window.clearInterval(intervalId);
	}
	otuAthnNoTimer(14.99); //4.99
}

function otuAthnNoTimer(duration) {
	var timer = duration * 60;
	var minutes, seconds;
	var interval = setInterval(function(){
		$('#otuAthnNoIntervalId').val(interval);
		minutes = parseInt(timer / 60 % 60, 10);
		seconds = parseInt(timer % 60, 10);
		minutes = minutes < 10 ? "0" + minutes : minutes;
		seconds = seconds < 10 ? "0" + seconds : seconds;
		$('#otuAthnNoTimerTxt').html('<span id="timeCheck">' + minutes + ":" + seconds + '</span>');
		if (--timer < 0) {
			timer = 0;
			clearInterval(interval);
		}
	}, 1000);
}
</script>

<div class="pop-header">
	<h2 class="pop-title">${reqDs.title }</h2>
	<button type="button" name="button" class="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
</div>		
<input type="hidden" id="FSB_AUTH_CONFIRM_BKCD" value="${reqDs.bkcd}"> 
<input type="hidden" id="FSB_AUTH_CONFIRM_ACNO" value="${reqDs.acno}"> 
<input type="hidden" id="otuAthnNoIntervalId" />

<div class="pop-con-wrap">
	<!-- s: default-wrap -->
	<div class="default-wrap">
		<div class="tit-wrap mb30">
			<p class="txt"><b>입력하신 계좌</b>로<br><b><span>1원</span>을</b> 보내드렸어요</p>
		</div>
		<div class="imgbox-wrap crtf">
			<img src="/resources/images/common/img_accountCrtf.png" alt="본인계좌 인증 예시이미지. 보낸사람:SB1234, 입금:1원.">
		</div>
		<p class="s-txt ta-c"><b>입금자명 뒤쪽 4자리 숫자</b>를 입력하세요</p>

		<div class="form-wrap form-crtf">
			<div class="input">
				<span>
					<input type="tel" title="" id="REMARK1" placeholder="1" required="" numberonly maxlength="1" onkeyup="${reqDs.id}_Func.changeRemark(this)">
				</span>
				<span>
					<input type="tel" title="" id="REMARK2" placeholder="2" required="" numberonly maxlength="1" onkeyup="${reqDs.id}_Func.changeRemark(this)">
				</span>
				<span>
					<input type="tel" title="" id="REMARK3" placeholder="3" required="" numberonly maxlength="1" onkeyup="${reqDs.id}_Func.changeRemark(this)">
				</span>
				<span>
					<input type="tel" title="" id="REMARK4" placeholder="4" required="" numberonly maxlength="1" onkeyup="${reqDs.id}_Func.changeRemark(this)">
				</span>
				<p class="verifi-time">남은 입력시간:<span class="txt-numb" id="otuAthnNoTimerTxt">4:52</span></p>
			</div>
		</div>
	</div>
	<!-- e: default-wrap -->
</div>

<div class="fixed-btn-wrap">
	<div class="btn-wrap">
		<a href="#none" class="btn disabled" id="${reqDs.id}_nextBtn" onclick="javascript:${reqDs.id}_Func.checkInput();">확인</a>
	</div>
</div>
		