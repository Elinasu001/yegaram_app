<%@page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
var USR_ID_ONLY_YN = '${reqDs.USR_ID_ONLY_YN}';
var USR_ID_CHECK_FLAG = false;
var ${reqDs.id}_Func = ({
	// 닫기  
	close : function(){},
	// 취소 (그만하기)
	cancel : function(){},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(succYn){
		// 레이어 업무 선택 및 입력 완료 처리 
		${reqDs.id}_Func.callback(succYn);
	},
	// 호출 화면 콜백 처리	
	callback : function(){}
});
$(document).ready(function(){
	dynamicInput();
	initializedNFilter();
	if ("Y" == "${reqDs.USR_ID_ONLY_YN}") {
		if(ACTIVE_MODE == 'local') {
			var imgData = "iVBORw0KGgoAAAANSUhEUgAAAGQAAAA2CAIAAAC+xqv/AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA4RpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQ1IDc5LjE2MzQ5OSwgMjAxOC8wOC8xMy0xNjo0MDoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo0MmFjMjNkNC02NTQ4LTA2NDktYjBjOC02ODcwODAzNzZhYjQiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NTk2OTlDOUI4MkVBMTFFQTkzQjdDNjAxMzIwMkUzRDkiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NTk2OTlDOUE4MkVBMTFFQTkzQjdDNjAxMzIwMkUzRDkiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTkgKFdpbmRvd3MpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6MDJhNWRhNGYtM2Q0MS1hMDQyLTlmZmEtODBkNGY4NjJiM2E2IiBzdFJlZjpkb2N1bWVudElEPSJhZG9iZTpkb2NpZDpwaG90b3Nob3A6Yjg3YzIxODEtNWMwOC1lOTQ5LWJkYjUtOWUxNDIxZmUwOTg2Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+S1r26AAACK5JREFUeNrsm31sE+cZwO985/O34yS284XJF5AvCiwJIQQKUZlgdKu6rlJpu6nQ/bEP1rI/mNjKVvoHa7Wt0rSt7TRpa8WY1A22tUwMWClt0gINShPIIKQEQmycL+PYju1cfB++e28PPvuIQ7JNleKES169ss7P85z93s/P13uX4JIkYYvj/xuaRQSLsGZlkHP79RKGouwwzflYISKiOKGhCq21Bq0NSUJf4Iwo8RqcJDQ6PWk1U06rvgjeLkxYkmesrcd/CjBNllr1LoAF4Lr9J6euVUOVZDdVOrZRhGkBwRIQ3zZwaCDy72kWpDEkPA5jRXGqTmS6/R/cCF5Yv3RnoaVmgcCSWjy/H4hcmVYHkSjbTAMrMVgx+l7f65tKni3PblA/rG5/641Q12SJnjQXWlbk6At0pFlPWqZ4lo402XR5IWYojjjllPf737JUOp2mEjXDiovcuaFjLBIUTJuX7qjMbSTuydyKjV2X/3jVj0RJ6A22nxv8K82H5VA+7T70jZUvYRiu2tahN9QRYsfAa2AiTLujan+NfeO9pKBTlm1g8gjdCU+crLY3PVX9IklYZbl3vN8T6VFzn3U1dJFBSJ6r87bkGgpmslTMuEl7DAuV01T0qKLqDnaoOQwHxr1MKhkVW6tm7r8wxYxPz/RltpWKapAeUDMsHxtgEmEFA5+5w2SEmGLGpe9eDaRJUYX4qJphMaI0ISYv1Ut7l9uqpzVD2F0zNoVGHkE2qKhETKvmnGXQ2ccRkufpoZaZzJAkKWYxlOZZnwY6FZVV71QzrKXWZTRC8uwKX28Z+XimnKWYMdJdz4oJsaOe44pqZc4aNcNqLthEi0iZL19+wzNdkgY8ig1EbiqE2R92vuKNBWV5kbm0uWCjmmGtyq6uzlkVQZI8fXHmu+0H/WzonjDEFBs6keBPDH30aOtzLaOXFfnOZU8ROKHy+1kHVj1HEWYGYfK8Tvt2tr0U5sentg4pAz4RhdsLN/3kgd2VWRWK/AeXfjPKjakclsuY99u1PyZxk4C08uyJDO9qe5kRufQ7E0mtKN0p2Roc3+Ss/cvGnz3u+pIs97Oxn3YfVjksGI32mj82vmjUWJGolWdnwPN8++sSphQ+XFEhdLe/IXHilTXfrjCXy6p3PG0e2qdyWHd4OaqPPHjASmQLAinPE95Lb/e3KntDRS4KaYkJeO0qe1jRHnGfUz+sRLIvPdq8n9JYBETJ82DXMT55swFXhHIYpoOuUrTn/X0LAhaMGpvr53XPIJGS52iM+2jkWsKzcEUooalteq7OomiH6YmFAgvGE6WNkPKBiDxvRPyyZykSCU3tD8I8M0mbuR0bOeewoMxVZBX3R+lUEdSkDqjkBlCa6lkfj9xUtE69fQHBggp4PRTAxeRKSi325C2JlAQX0zxrIs7/sqtV0TY6yhcQrOPuHvdYBE+shNRoNuaXywgVHNikMOwNj+5u/Ztij2P4k8vqFgqs2zF679mTSie1xVWRrTMk+6yU0DfBHL520Tcxfn7E0zroTvRiSdUzlbUVNseCgBXluR0nj4zQrLwMAscPNHxR2e4osHpD4d0fnkiddNfL6p2Fv9j4cCYXPGewgizzteNHO277lTUc3PBQTW7q/pSE//cyt6Oi5rXm7UZSq35YPcHAE/881hceUxbwQsP6PV9YN9lGFKdZm54gt5WU7q1vaMgvzPyy5wBWTBBOuT3bS5bzokjHeVYUn66s+nJZWboV5KxkxBWYzXvr6rP1+pIsa60zz6TVzlU0zAEsI0nura//3y1FKgxdJtue2lpsHgwSm5cjsd1JehaFa+fJquYprASv5NqIBQuLFUSYkyV0PC6kP+wKs/wwHVO2hCZSN09g4Rn4A9xX267s++DzP2eHtt6kJc0UCQdpS8exLB01WdL+zUcoQnN/exYTRxj6/NcgICwiCBFGmLa0Tn6DZvmHzwQshHAMEdj9PzIBi4tL6oCViZw1EIn57mwA0+KFF9C0xnEkzRRNUyrD3V4fSfHEI/7HqooIDX5/w1LNyEQYhmKMWUcFJmIRlqMIwqrX+cbpSof9qn80x2DINuihdYDX0YnYUHQ812gIxpgCi3lknK6w54YYBuT5ZhO8wikRlsVxfCASJXA832KG+viZP9DgKoQTbXq9maLue8861Hk5jkS4mN7RICsINoN+Q7HrgndwOEo/37T2ZG8fJwjf39Dwq/PtzWXF799wNy4tojl+jGEvDo84zaaty8s+vOlZv3QJnMKLKEuvY+Lxaqfjs9EAYH2ovKQ/NPbaJx37mzdsXVEK3zJ7F5KhBxat/bfAEWryHOAykGL+dOnKthXl4A7gYu0Dw594B+U81TV8Gw6u+Pzga9V5dhNF8YIIQg2OwymAElQdgyOlObYKR+6dbaZW27CkEJA9UrX88KXLakjw5zwDcHltCVeCMCzLsTUVLznrHugcGnkg3+kwGSF2iqyWHn8AnOj0jX5vOFrpyL047Kty2Md5LsryEKRblpW83XV1S3kJOJTdaFyWmw0GwB1i+bHqCojZ9sHh76yrNc7mPYnFBD/PEvwF7xAkHROlHef4JVnWXXWr3uzogt9oZ+2qJ//87r7NjTQfvxkci3IcZHcC10AkwoF7LLzOVfj37mtfX7NydUHe/vdaIBj3bV7/vX/869df2fqtd0/+7qvbW923wO8gu8GHQ7KHD9TO5nYnEzkLSL3QvAGIhFkWwhAkq/PzvOEI5O9NpS53KNJ2axBqJSR1KJe9gaB/YqJr5PaeprVQK7UEISZ8P8rxEJ7AtK6o4J2rvSvzHH/4tIvm4mf63AYtWV9UcCscmdVSmCFY64uXvHq2DeIdcs3Ta2rkpjTMcmf6PMXZWZB0wGXKcrL1JKkjiGfrVkMuc5qMUByhUK6w5wBKOMWio/ItplO9N4ttWVD+8swmI6UF9A+WuKCrmIjHoywHrO/7BK+asfifrIuwZmf8R4ABAAWEBfRL62RVAAAAAElFTkSuQmCC";
			befProc(imgData);
		} else {
			biz.ocrAuth(function(succYn, imgData){
				befProc(imgData);
			});
		}
	}
});

// 전자금융만 신청시 전처리
function befProc(imgData) {
	var reqForm = makeForm("reqForm");
	addFormData(reqForm, "txGbnCd", "P");
	addFormData(reqForm, "PHOTO", imgData);
	doAction("USR_ID_REG", reqForm, function(resDs){
		if (resDs.API_RS_MSG != 'SUCCESS') {
			biz.alert('전자금융 가입 처리 중 오류가 발생하였습니다.['+ resDs.API_RS_MSG +"]");
		}
	});	
}

function fnUsrIdCheck() {
	// 아이디 중복체크
	var checkUsrId = $.trim($("#REG_USR_ID").val());
	if (checkUsrId == '') {
		biz.alert("아이디를 입력해주세요");
		
	} else {
		var reqForm = makeForm("reqForm");
		addFormData(reqForm, "USER_ID", checkUsrId);
		addFormData(reqForm, "txGbnCd", "I"); // I:이용가능ID조회 R:전자금융신청 P:전자금융만 신청 시 전처리
		doAction("USR_ID_REG", reqForm, function(resDs){
			if (resDs.API_RS_MSG == 'SUCCESS') {
				biz.alert("사용가능한 ID입니다","확인",function(){
					$("#REG_USR_ID").attr("readonly", true);
					USR_ID_CHECK_FLAG = true;
					$("#REG_USR_ID_CHK_BTN").attr("disabled", true);
				});
			} else {
				if (typeof(resDs.MESG) != 'undefined' && resDs.MESG != '') {
					biz.alert(resDs.MESG);	
				} else {
					biz.alert("사용 불가능한 ID입니다");
				}
			}
		});
	}
}
function fnUsrIdReg() {
	var usrIdPwd = nshc.encrypted("USR_ID_PWD");
	var usrIdPwd2 = nshc.encrypted("USR_ID_PWD2");
	//비밀번호 매칭여부 확인
	var confirmForm = makeForm("confirmForm");
	addFormData(confirmForm, "E2E_PSWD1", usrIdPwd);
	addFormData(confirmForm, "E2E_PSWD2", usrIdPwd2);
	doAction("PSWD_MNG", confirmForm, function(resDs){
		if (resDs.MATCH_YN == 'Y') {
			// 본거래
			var reqForm = makeForm("reqForm");
			addFormData(reqForm, "USER_ID", $("#REG_USR_ID").val());
			addFormData(reqForm, "txGbnCd", "R"); // I:이용가능ID조회 R:전자금융신청 P:전자금융만 신청 시 전처리 C:전자금융만 신청 시 완료처리
			addFormData(reqForm, "TI1_TRNF_LMIT_AMT", $("#TI1_TRNF_LMIT_AMT").val()); // 1회이체한도
			addFormData(reqForm, "DD1_TRNF_LMIT_AMT", $("#DD1_TRNF_LMIT_AMT").val()); // 1일이체한도
			addFormData(reqForm, "E2E_PWD", usrIdPwd); 						  		  // 패스워드
			addFormData(reqForm, "OTP_VNDR_CD", $("#OTP_VNDR_CD").val()); 			  // OTP벤더코드
			addFormData(reqForm, "OTP_SRNO_VAL", $("#OTP_SRNO_VAL").val()); 		  // OTP일련번호값
			addFormData(reqForm, "MBL_OTP_SRNO_VAL", UtilFunc.isEmpty($("#MBL_OTP_SRNO_VAL").val()) ? "GORYOSBMOBILWEB" : $("#MBL_OTP_SRNO_VAL").val());   // 모바일OTP일련번호값
			
			doAction("USR_ID_REG", reqForm, function(resDs){
				if (resDs.API_RS_MSG == 'SUCCESS') {
					if ('${reqDs.USR_ID_ONLY_YN}' == 'Y') {
						
						// 1원송금
						biz.fsbAcnoAuth(function(data) {
							if("Y" == data) {
								// C:전자금융만 신청 시 완료처리
								var cpltForm = makeForm("cpltForm");
								addFormData(cpltForm, "txGbnCd", "C");
								doAction("USR_ID_REG", cpltForm, function(resDs){
									if (resDs.API_RS_MSG == 'SUCCESS') {
										${reqDs.id}_Func.confirm('Y');	
									} else {
										biz.alert(resDs.API_RS_MSG);
									}
								});
							}
						});
						
					} else {
						${reqDs.id}_Func.confirm('Y');
					}
				}
			});
		} else {
			biz.alert("입력하신 비밀번호가 일치하지 않습니다.");
		}
	});
}

function initializedNFilter() {
    // 키패드 초기화 시작
    nshc.setOnInitStart();
    // Open Web nFilter 키패드 설정
    nshc.setCommon(document.getElementById('USR_ID_PWD'), "mode=mCKpd"); // pcCKpd
    nshc.setCommon(document.getElementById('USR_ID_PWD2'), "mode=mCKpd"); // pcCKpd
    
    // Open Web nFilter 초기화
    nshc.ownCallback = function (msg, inputID) {
        if (msg == "enter") {
        	removeErr($("#"+inputID));
            validChk();
        } else if (msg == "close") {
        	validChk();
        } 
    }
}

/** 입력값 자동증가 
* @input plusVal	 증가값
*/
function incrsAmt(obj, targetId, plusVal){
	// border 활성화
	$(".radio-list >li").removeClass("active");
	var parentDiv = $(obj).closest("li");
	parentDiv.addClass("active");
	/*
		DD1_TRNF_LMIT_AMT
		TI1_TRNF_LMIT_AMT
		DD1_TRNF_LMIT_AMT_TEXT
		TI1_TRNF_LMIT_AMT_TEXT
	*/
	
	var resultVal = 0;	// 화면세팅값
	
	// 초기화여부 체크
	if (plusVal == 0){
		resultVal = plusVal;
		$("#"+targetId).val(resultVal);
		
	} else {
		var inputVal  = calcFunc.removeComma($("#"+targetId).val());   // 현재입력값	
		if (inputVal == "") inputVal = 0;
		resultVal = calcFunc.addComma(parseInt(inputVal) + plusVal); // 현재입력값+증가값		
		$("#"+targetId).val(calcFunc.removeComma(resultVal));
	}
	// 텍스트 화면세팅 
	$("#"+targetId+"_TEXT").text(resultVal);
}
</script>
<div class="pop-header">
	<h2 class="pop-title">전자금융가입</h2>
	<button type="button" name="button" class="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
</div>

<div class="pop-con-wrap">

	<input type="hidden" id="MBL_OTP_SRNO_VAL" />
	<input type="hidden" id="OTP_VNDR_CD" />
	
	<div class="default-wrap">
		
		<div class="tit-wrap"><!-- [퍼블] 클래스 변경 -->
        	<p class="txt"><strong>전자금융가입</strong>을 <br> 진행할게요</p>
		</div>
		
		<div class="form-wrap form-line mt0">
			<label for="REG_USR_ID" class="formlabel onbasic">아이디</label>
				<div class="input">
					<span class="mb0">
						<input type="text" title="아이디 입력" id="REG_USR_ID" class="inp" name="" value="" placeholder="사용자아이디를 입력해주세요" required="">
						<button type="button" class="btn-certi" id="REG_USR_ID_CHK_BTN" onclick="javascirpt:fnUsrIdCheck();">중복확인</button>
					</span>
				</div>
				<p class="error-txt">아이디를 입력해주세요</p>
			</div>
			<ul class="list-bull"><!-- [퍼블] 클래스 변경 -->
				<li>영문(소문자), 숫자를 조합한 6~12 자리를 입력해주세요</li>
			</ul>

			<div class="form-wrap password">
				<label for="USR_ID_PWD" class="formlabel">비밀번호</label>
				<div class="input">
					<span>
						<input type="text" id="USR_ID_PWD" class="inp" name="" value="" placeholder="전자금융아이디의 비밀번호를 입력해주세요" required="" minlength="4" maxlength="50">
					</span>
				</div>
				<p class="error-txt">비밀번호를 입력해주세요</p>
			</div>
			
			<div class="form-wrap password"><!-- [D] 비밀번호 일치시 클래스 ok 추가 / 비밀번호 불일치시 클래스 error 추가 -->
				<label for="USR_ID_PWD2" class="formlabel">비밀번호 확인</label>
				<div class="input">
					<span>
						<input type="text" id="USR_ID_PWD2" class="inp" name="" value="" placeholder="전자금융아이디의 비밀번호를 다시 입력해주세요" required="" minlength="4" maxlength="50">
					</span>
				</div>
				<span class="valid-ok">일치</span><!-- [D] 비밀번호 일치시 노출 -->
				<span class="valid-txt">불일치</span><!-- [D] 비밀번호 불일치시 노출 -->
				<p class="error-txt">비밀번호를 입력해주세요</p>
			</div>
			<!-- <ul class="list-bull"> [퍼블] 삭제 -->
				<p class="info-txt">영문, 숫자, 특수문자를 조합한 8~12 자리를 입력해주세요</p><!-- [퍼블] 태그 변경 : li ==> p -->
				<p class="info-txt">고객님의 주민등록번호, 휴대폰번호, 전화번호, 아이디와 4자이상 일치하는 입력 값은 사용하실 수 없어요</p><!-- [퍼블] 태그 변경 : li ==> p -->
			<!-- </ul> [퍼블] 삭제 -->

			<div class="form-wrap type2">
            	<label for="DD1_TRNF_LMIT_AMT">1일 이체한도</label>
                    <div class="input">
                        <input type="tel" title="" class="validChk" id="DD1_TRNF_LMIT_AMT" value="0" placeholder="1일 이체한도를 입력해주세요." maxlength="12" required="">
                        <div class="value-wrap">
                            <strong class="value" id="DD1_TRNF_LMIT_AMT_TEXT"></strong>
                            <span class="unit">원</span>
                        </div>
                    </div>
					<p class="error-txt">1일 이체한도를 입력해주세요</p>
            </div>
			<div class="inquiry-set-wrap mt15"> 
                 <div class="type-area">
                     <ul class="radio-list style-button"> <!-- // 06.29 클래스 style-button 추가-->
                         <li><button type="button" onclick="incrsAmt(this, 'DD1_TRNF_LMIT_AMT', 100000);">10만</button></li>
                         <li><button type="button" onclick="incrsAmt(this, 'DD1_TRNF_LMIT_AMT', 1000000);">100만</button></li>
                         <li><button type="button" onclick="incrsAmt(this, 'DD1_TRNF_LMIT_AMT', 10000000);">1000만</button></li>
                         <li><button type="button" onclick="incrsAmt(this, 'DD1_TRNF_LMIT_AMT', 100000000);">1억</button></li>
                         <li><button type="button" onclick="incrsAmt(this, 'DD1_TRNF_LMIT_AMT', 0);">초기화</button></li>
                     </ul>
            	</div>
            </div>
                
            <div class="form-wrap type2">
            	<label for="TI1_TRNF_LMIT_AMT">1회 이체한도</label>
                    <div class="input">
                        <input type="tel" title="" class="validChk" id="TI1_TRNF_LMIT_AMT" value="0" placeholder="1회 이체한도를 입력해주세요." maxlength="12" required="">
                        <div class="value-wrap">
                            <strong class="value" id="TI1_TRNF_LMIT_AMT_TEXT"></strong>
                            <span class="unit">원</span>
                        </div>
                    </div>
					<p class="error-txt">1회 이체한도를 입력해주세요</p>
            </div>
			<div class="inquiry-set-wrap mt15"> 
                 <div class="type-area">
                     <ul class="radio-list style-button"> <!-- // 06.29 클래스 style-button 추가-->
                         <li><button type="button" onclick="incrsAmt(this, 'TI1_TRNF_LMIT_AMT', 100000);">10만</button></li>   
                         <li><button type="button" onclick="incrsAmt(this, 'TI1_TRNF_LMIT_AMT', 1000000);">100만</button></li> 
                         <li><button type="button" onclick="incrsAmt(this, 'TI1_TRNF_LMIT_AMT', 10000000);">1000만</button></li>
                         <li><button type="button" onclick="incrsAmt(this, 'TI1_TRNF_LMIT_AMT', 100000000);">1억</button></li> 
                         <li><button type="button" onclick="incrsAmt(this, 'TI1_TRNF_LMIT_AMT', 0);">초기화</button></li>
                     </ul>
            	</div>
            </div>

			<p class="form-txt mt30">보안매체등록</p>
 
			<div class="otp-wrap">
			
				<div class="form-wrap">
					<div class="input">
						<div class="select-wrap">
							<div class="select-box" tabindex="1" onclick="openPopupUp('secuTypePop');">
								<label for="">보안매체 선택</label>
								<span class="option" id="secuTycdNm">미선택</span>
							</div>
						</div>
					</div>
					<p class="error-txt">보안매체를 선택해주세요</p>
				</div>
				
				<!-- s: 보안매체 OTP를 선택한 경우 -->
				<div class="form-wrap mt0 OTP_DIV" style="display: none;">
					<div class="input">
						<div class="select-wrap">
							<div class="select-box" tabindex="1" onclick="biz.select('벤더사','O001200000',function(res){$('#OTP_VNDR_CD_TEXT').html(res.NAME); $('#OTP_VNDR_CD').val(res.CODE); });">
								<label for="">벤더사</label>
								<span class="option" id='OTP_VNDR_CD_TEXT'>미선택</span>
							</div>
						</div>
					</div>
					<p class="error-txt">벤더사를 선택해주세요</p>
				</div>

				<div class="form-wrap form-line mt0 OTP_DIV" style="display: none;">
					<label for="ipt06" class="formlabel onbasic">등록할 OTP 일련번호(S/N)</label>
					<div class="input">
						<span class="mb0">
							<input type="text" title="등록할 OTP 일련번호(S/N)" id="OTP_SRNO_VAL" class="inp" name="" value="" required="">
						</span>
					</div>
					<p class="error-txt">아이디를 입력해주세요</p>
				</div>

				<ul class="mt30">
					<li>보유하고계신 OTP의 뒷면에서 일련번호 및 벤더코드를 확인하실 수 있어요</li>
				</ul>

				<div class="mt30 OTP_DIV" style="display: none;">
					<img src="../../resources/images/common/img-otp.png" alt="OTP 일련번호, OTP 벤더코드" />
				</div>
			</div>
			<!-- s: 보안매체 OTP를 선택한 경우 -->
	</div>
</div>

<div class="fixed-btn-wrap">
	<div class="btn-wrap type-popup">
		<a href="#none" class="btn"  id="${reqDs.id}_nextBtn" onclick="javascript:fnUsrIdReg();">확인</a>
	</div>
</div>

<div id="secuTypePop" class="layerpopup layer-up">
	<div class="content-wrap">
	   <div class="pop-header">
	       <h2 class="pop-title">보안매체</h2>
	       <button type="button" name="button" class="btn-layer-close" data-focus="btn-layer-close" onclick="closePopupUp('secuTypePop');">닫기</button>
	   </div>
	   <div class="ly-scroll-con ly-select">
	       <ul class="ly-select-list">
       			<li><button type="button" onclick="$('.OTP_DIV').hide();$('#secuTycdNm').html($(this).html());">보안카드</button></li>
       			<li><button type="button" onclick="$('.OTP_DIV').show();$('#secuTycdNm').html($(this).html());">OTP</button></li>
       			<li><button type="button" onclick="$('.OTP_DIV').hide();$('#secuTycdNm').html($(this).html());">mOTP</button></li>
	       </ul>
	    </div>
	</div>
</div>