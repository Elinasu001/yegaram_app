<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var ${reqDs.id}_Temp = { // 임시변수
	"CUST_NM" : "${SS_AUTH.CUST_NM}"
   ,"PHONE_NO" : "${SS_AUTH.PHONE_NO}"
   ,"TELECOM" : ""
   ,"BIRTH_DAY" : "${SS_AUTH.BIRTH_DAY}"
   ,"SSN1" : "${SS_AUTH.SSN1}"
   ,"E2E_SSN2" : ""
   ,"CI" : ""
   ,"GENDER" : "${SS_AUTH.GENDER}"
};	
var ${reqDs.id}_Func = ({
	close : function(){}, 	// 닫기  
	cancel : function(){}, 	// 취소 (그만하기)
	selectAuthLayer : function(){
		// 유효성체크
		if (!finalValidChk('${reqDs.id}')) return false;
		
		// 인증수단레이어 호출
		biz.selectAuth('인증수단', 'AUTH', function(authType){
			
			if (${reqDs.id}_Func.validate()) {
				if (authType == "mno") {
					fnPhoneAuthNoReq("");
					
				} else {

					<c:if test="${activeMode eq 'local'}">
					${reqDs.id}_Func.SKIP(authType);
					</c:if>
					<c:if test="${activeMode ne 'local'}">
					// 델피노 호출                                                                              
					var signOptions = {};
			        signOptions.provider = authType;
			        signOptions.displayProviders = authType;
			        signOptions.addNonce = false;
			        
					var cgUserInfo = {};
		            cgUserInfo.userName = ${reqDs.id}_Temp.CUST_NM;
		            cgUserInfo.userPhone = ${reqDs.id}_Temp.PHONE_NO;
		            cgUserInfo.userBirthday = ${reqDs.id}_Temp.BIRTH_DAY;
		            signOptions.userInfo = cgUserInfo;
		           
		            Delfino.auth("login=certLogin", signOptions, function(result){
						if(result.status == 1){
							
							var authReqDs = makeForm("authReqDs")
							addFormData(authReqDs, "signedData", result.signData);
							$.each(${reqDs.id}_Temp, function(k, v){
								addFormData(authReqDs, k, v);	
							});
							
							//인증수단
							if(authType == "fincert"){
								addFormData(authReqDs, "AUTH_CD", "S000700007");	//S000700007:금융인증서
							} else if (authType == "mno"){
								addFormData(authReqDs, "AUTH_CD", "S000700001");	//S000700001:휴대폰인증
							} else {
								addFormData(authReqDs, "AUTH_CD", "S000700004");	//S000700004:카카오페이 인증 TODO 사설인증 코드
							}
							
							doAction("USER_AUTH", authReqDs, function(resJson){
								if (resJson.APP_HEADER.respCd == "N00000") {
									${reqDs.id}_Func.confirm("Y");
								} else {
									biz.alert(resJson.APP_HEADER.respMsg);									
								}
							});
							
						} else {
							if (result.status==0) return; 		// 사용자 취소
							if (result.status==-10301) return; 	// 구동프로그램 설치를 위해 창을 닫을 경우
							if (result.status==1000 || result.status==2000 || result.status==3000) {
							  biz.alert("인증처리 중 오류가 발생하였습니다.");
							  return;
							}
							biz.alert("error:" + result.message + "[" + result.status + "]");
						}
					});
		            </c:if>
				}
			}
		});
	},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(data){
		// 레이어 업무 선택 및 입력 완료 처리 
		${reqDs.id}_Func.callback(data);
	},
	// 호출 화면 콜백 처리	
	callback : function(){},
	validate : function(){
		var custNm = $("#A_CUST_NM").val();
		var ssn1 = $("#A_SSN1").val()
		var ssn2 = $("#A_SSN2").val()
		var phoneNo = $("#A_PHONE_NO").val()
		var telecom = ${reqDs.id}_Temp.TELECOM;
		var gender = ${reqDs.id}_Temp.GENDER;
		var birthDay = (Number(gender) > 2) ? "20" : "19";
		birthDay = birthDay + ssn1;
		
		// TODO 유효성 확인 및 변수처리
		
		 ${reqDs.id}_Temp.CUST_NM = custNm;
         ${reqDs.id}_Temp.PHONE_NO = phoneNo;
         ${reqDs.id}_Temp.TELECOM = telecom;
         ${reqDs.id}_Temp.BIRTH_DAY = birthDay;
         ${reqDs.id}_Temp.SSN1 = ssn1;
         ${reqDs.id}_Temp.E2E_SSN2 = ssn2;
         ${reqDs.id}_Temp.GENDER = gender;
         
         if(UtilFunc.isNull($("#A_CUST_NM").val())){
 			biz.alert("성명을 확인해주세요.","확인", function () {
 				inputFocus($("#A_CUST_NM"));
 			});
 			return false;
 		}
         if(UtilFunc.isNull($("#A_SSN1").val())){
  			biz.alert("주민등록번호 앞자리를 확인해주세요","확인", function () {
  				inputFocus($("#A_SSN1"));
  			});
  			return false;
  		}
         if(UtilFunc.isNull($("#A_SSN2").val())){
  			biz.alert("주민등록번호 뒷자리를 확인해주세요.","확인", function () {
  				inputFocus($("#A_SSN2"));
  			});
  			return false;
  		}
         if(UtilFunc.isNull($("#A_PHONE_NO").val())){
   			biz.alert("휴대폰번호를 확인해주세요.","확인", function () {
   				inputFocus($("#A_PHONE_NO"));
   			});
   			return false;
   		}
         
         return true;
    }
	<c:if test="${activeMode eq 'local'}">
	,
    SKIP : function(authType){
    	var authReqDs = makeForm("authReqDs")
		addFormData(authReqDs, "txGbnCd", "SKIP");
		$.each(${reqDs.id}_Temp, function(k, v){
			addFormData(authReqDs, k, v);	
		});
		//인증수단
		if(authType == "fincert"){
			addFormData(authReqDs, "AUTH_CD", "S000700007");	//S000700007:금융인증서
		} else if (authType == "mno"){
			addFormData(authReqDs, "AUTH_CD", "S000700001");	//S000700001:휴대폰인증
		} else {
			addFormData(authReqDs, "AUTH_CD", "S000700004");	//S000700004:카카오페이 인증 TODO 사설인증 코드
		}
		doAction("USER_AUTH", authReqDs, function(resJson){
			if (resJson.APP_HEADER.respCd == "N00000") {
				${reqDs.id}_Func.confirm("Y");
			} else {
				biz.alert(resJson.APP_HEADER.respMsg);									
			}
		});
    }
	</c:if>
});
function fnPhoneAuthNoReq(reTryYn) {
	var authReqDs = makeForm("authReqDs")
	addFormData(authReqDs, "txGbnCd", "R"); 		  // 인증번호요청
	addFormData(authReqDs, "SMS_RESEND_YN", reTryYn); // 재요청여부
	$.each(${reqDs.id}_Temp, function(k, v){
		addFormData(authReqDs, k, v);	
	});
	
	doAction("MNO_AUTH", authReqDs, function(resDs){
		if (resDs.RSLT_CD == 'B000') {
			// PHONE_AUTH_TIMER 타이머 처리 시작
			initPhoneAuthIntervalTimer();
			$("#PHONE_AUTH_CONFIRM_BTN").show();
			$("#PHONE_AUTH_RESEND_BTN").hide();
			$("#PHONE_AUTH_AREA").show();
		} else {
			errMsg(resDs.RSLT_MSG);
		}
	});
}
function fnPhoneAuthNoConfirm() {
	if (UtilFunc.isNull($("#PHONE_AUTH_OTP_NO").val())) {
		biz.alert("인증번호를 입력해주세요.","확인", function () {
			inputFocus($("#PHONE_AUTH_OTP_NO"));
		});
		return false;
	}
	var authReqDs = makeForm("authReqDs")
	addFormData(authReqDs, "txGbnCd", "A"); 		  	  			 // 인증요청
	addFormData(authReqDs, "OTP_NO", $("#PHONE_AUTH_OTP_NO").val()); // 인증번호
	doAction("MNO_AUTH", authReqDs, function(resDs){
		if (resDs.RSLT_CD == 'B000') {
			${reqDs.id}_Func.confirm("Y");
		} else {
			biz.alert(resDs.RSLT_MSG);
		}
	});
}
/*********************
* 타이머 스크립트
**********************/
function initPhoneAuthIntervalTimer() {
	//타이머 초기화
	var intervalId = $('#PHONE_AUTH_INTEVAL_ID').val();
	if(intervalId != ''){
		window.clearInterval(intervalId);
		$("#PHONE_AUTH_INTEVAL_ID").val("");
	}
	otuAthnNoTimer(2.99); //4.99
}
function otuAthnNoTimer(duration) {
	var timer = duration * 60;
	var minutes, seconds;
	var interval = setInterval(function(){
		$('#PHONE_AUTH_INTEVAL_ID').val(interval);
		minutes = parseInt(timer / 60 % 60, 10);
		seconds = parseInt(timer % 60, 10);
		minutes = minutes < 10 ? "0" + minutes : minutes;
		seconds = seconds < 10 ? "0" + seconds : seconds;
		$('#PHONE_AUTH_TIMER').html('' + minutes + ":" + seconds + '');
		if (--timer < 0) {
			timer = 0;
			clearInterval(interval);
			$("#PHONE_AUTH_INTEVAL_ID").val("");
			$('#PHONE_AUTH_TIMER').html('0:00');
			$("#PHONE_AUTH_CONFIRM_BTN").hide();
			$("#PHONE_AUTH_RESEND_BTN").show();
		}
	}, 1000);
}

var focusActionIng = false;
$(document).ready(function(){
	dynamicInput();
	$("#A_CUST_NM").focusout(function(){
		fnAutoFocusing();
	});
	$("#A_SSN1").keyup(function(){
		if ($("#A_SSN1").val().length == 6) {
			removeErr($("#jumintextId")); 
			biz.keypad('주민번호 뒷자리', 7, setKeypadData);
		}
	});
	$("#A_PHONE_NO").focusout(function(){
		fnAutoFocusing();
	});
});

function setKeypadData(encData) {
	$('#A_SSN2').val(encData);
	var keypadInqForm = makeForm("keypadInqForm");
	addFormData(keypadInqForm, "txGbnCd", "GENDER");
	addFormData(keypadInqForm, "E2E_SSN2", encData);
	doAction("USER_AUTH", keypadInqForm, function(resJson){
		${reqDs.id}_Temp.GENDER = resJson.GENDER;
		fnAutoFocusing();
	});
}

function fnAutoFocusing(){
	if (focusActionIng) return; // 중복 포커싱 방지
	focusActionIng = true;
	setTimeout(function(){
		focusActionIng = false;
	}, 1000);
	if ($.trim($("#A_CUST_NM").val()) == '') {
		$("#A_CUST_NM").focus();
		return;
	} else if ($.trim($("#A_SSN1").val()) == '') {
		$("#A_SSN1").focus();
		return;
	} else if ($.trim($("#A_PHONE_NO").val()) == '') {
		$("#A_PHONE_NO").focus();
		return;
	} else {
		$("#procBtnArea").focus();
		$("#${reqDs.id}_procBtn").removeClass("disabled");
		return;
	}
	
}
</script>
<input type="hidden" id="PHONE_AUTH_INTEVAL_ID" value="" />
<!-- s: contents -->
<!-- 상단타이틀 -->
<div class="pop-header">
	<h2 class="pop-title">${reqDs.title }</h2>
	<button type="button" name="button" class="btn-layer-close"
		data-focus="btn-layer-close"
		onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
</div>

<div class="pop-con-wrap">
	<!-- 2023-06-13 불필요 클래스 bg-ffffff 삭제 -->
	<div class="default-wrap">
		<!-- 2023-06-13 mb0 클래스 삭제 -->
		<div class="tit-wrap"><!-- [퍼블] 클래스명 변경 -->
			<p class="txt">
				<b>본인인증을 진행</b>합니다
			</p>
		</div>

		<div class="form-wrap"><!-- [퍼블] 클래스명 변경 -->
			<label for="A_CUST_NM" class="formlabel onbasic">성명</label>
			<div class="input">
				<input type="text" title="성명" id="A_CUST_NM" name="A_CUST_NM" class="inp ${reqDs.id}_validChk" placeholder="성명을 입력해주세요." 
				value="${SS_AUTH.CUST_NM }" onkeyup="validChk('${reqDs.id}');" onclick="removeErr(this);" />
			</div>
			<p class="error-txt">성명을 입력해주세요</p>
		</div>
		
		<div class="form-wrap w50">
			<label for="A_SSN1" class="formlabel onbasic">주민등록번호</label>
			<div class="input">
				<span> 
					<input type="tel" title="주민등록번호 앞자리" value="${SS_AUTH.SSN1 }" 
					class="inp ${reqDs.id}_validChk" id="A_SSN1" name="A_SSN1" maxlength="6" onkeyup="validChk('${reqDs.id}');" onclick="removeErr(this);" placeholder="주민등록번호 앞자리를 입력해주세요"/>
				</span> 
				<span class="inputTextHyphen">-</span> 
				<span> 
					<input type="hidden" title="주민등록번호 뒷자리(암호화)" id="A_SSN2" class="inp ${reqDs.id}_validChk" name="A_SSN2" value="" readonly="readonly"
					onclick="javascript:removeErr(this); biz.keypad('주민번호 뒷자리', 7, setKeypadData);" onchange="javascript:validChk('${reqDs.id}');" placeholder="주민등록번호 뒷자리를 입력해주세요">
					<span class="jumintext" id="jumintextId" onclick="javascript:removeErr(this); biz.keypad('주민번호 뒷자리', 7, setKeypadData);">●●●●●●●</span>
				</span>
			</div>
			<p class="error-txt">주민등록번호를 입력해주세요.</p>
		</div>

		<div class="form-wrap phone"><!-- [퍼블] 클래스명 변경 -->
			<label for="A_PHONE_NO" class="formlabel">휴대폰번호</label>
			<div class="input">
				<div class="select-wrap type-line"><!-- [퍼블] 클래스명 변경 -->
					<div class="select-box" tabindex="1" onclick="javascript:
					biz.select('통신사 선택', 'S000500000', function(res){ 
						${reqDs.id}_Temp.TELECOM = res.code;
						$('#A_TELECOM').html(res.name);});">
						<span class="option" id="A_TELECOM">선택</span>
					</div>
				</div>
				<span> 
					<input type="tel" title="" class="inp ${reqDs.id}_validChk" id="A_PHONE_NO" name="A_PHONE_NO" 
					value="${SS_AUTH.PHONE_NO }" placeholder="휴대폰번호를 입력해주세요" maxlength="11" required onkeyup="validChk('${reqDs.id}');" onclick="removeErr(this);" >
				</span>
			</div>
			<p class="error-txt">휴대폰번호를 입력해주세요.</p>
		</div>

		<div class="form-wrap form-line" id="PHONE_AUTH_AREA" style="display: none;">
			<label for="ipt03" class="formlabel onbasic">인증번호</label>
			
			<div class="input verification">
				<!-- 2023-06-13 verification 클래스 추가 -->
				<input type="text" title="인증번호" class="inp" id="PHONE_AUTH_OTP_NO" value="" placeholder="인증번호을 입력해주세요" required numberOnly />
				<!-- 2023-06-13 추가 -->
				<button type="button" class="btn-certi"	onclick="javascript:fnPhoneAuthNoConfirm();"
					id="PHONE_AUTH_CONFIRM_BTN">인증요청</button>
				<button type="button" class=".form-wrap.form-line .btnInput"	onclick="javascript:fnPhoneAuthNoReq('Y');"
					id="PHONE_AUTH_RESEND_BTN" style="display: none">재요청</button>
			</div>
			<p class="verifi-time">
				<span class="txt-numb" id="PHONE_AUTH_TIMER">03:00</span>
			</p>
			<p class="error-txt">인증번호을 입력해주세요</p>
		</div>
	</div>
</div>
<!-- //e: contents -->

<!-- s: 2023-06-13 수정 -->
<div class="fixed-btn-wrap no-fixed">
	<div class="btn-wrap">
		<a href="#none" class="btn disabled" id="${reqDs.id}_procBtn" onclick="javascript:${reqDs.id}_Func.selectAuthLayer();">인증방법 선택</a>
		<input type="text" id="procBtnArea" style="display:none;"/>
		<%-- <a href="#none" class="btn" onclick="javascript:${reqDs.id}_Func.SKIP();">인증우회</a> --%>
	</div>
</div>
<!-- e: 2023-06-13 수정 -->