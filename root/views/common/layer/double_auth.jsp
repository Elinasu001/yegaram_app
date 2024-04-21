<%@page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
/*
 * 목적 서비스
 * 01 : 아이디 조회
 * 02 : 공인 인증서 관리
 * 03 : 단말기 지정 관리
 * 04 : 단말기 등록 관리
 * 05 : 미지정 단말 이체
 * 06 : 고객 정보 변경
 * 07 : 서비스 관리  
 
 목적상세
	01 : 추가인증 서비스 신청  
	02 : 추가인증 서비스 해제  
	03 : OTP 등록  
	04 : OTP 해지  
	05 : 예적금 해지  
	06 : OTP 온라인 사고회복  
	07 : 장기 미접속 해제 추가 
	08 : 내계좌 한눈에 서비스 숨김계좌 등록 추가 
	09 : 내계좌 한눈에 서비스 숨김계좌 해제 추가 
	10 : 사용자 비밀번호 5회 오류 해제 추가 
	11 : 사용자 비밀번호 분실 재등록 추가
 
 */
var arsAuthType = '${reqDs.authType }'; // 인증타입
var arsAuthDetail = '${reqDs.authDetail }'; // 인증타입 상세  
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
	fnArsPhonNoInq();
});

// ARS인증용 전화번호 조회
function fnArsPhonNoInq() {
	
	var reqForm = makeForm("reqForm");
	addFormData(reqForm, "txGbnCd", "P");
	doAction("ARS_AUTH", reqForm, function(resDs){
		
		if (resDs.ARS_JOIN_YN == "Y") {
			$("#ARS_AUTHTELNO_text").html(resDs.CEL_TLNO);
			$("#ARS_AUTHTELNO").val(resDs.CEL_TLNO);
			/* 집 회사 번호
			resDs.CEL_TLNO
			resDs.HOME_TLNO
			resDs.COM_TLNO
			*/	
		} else {
			
			biz.confirm("추가인증 서비스(ARS)에 가입되어 있지 않습니다. 가입 후 진행할까요?", function(){
				var reqForm = makeForm("reqForm");
				addFormData(reqForm, "ADDT_ATHN_MTH", "20"); // 10.스마트폰 20.ARS 
				addFormData(reqForm, "txGbnCd", "R"); 	 // R.등록
				addFormData(reqForm, "bzwrDvcd", "A"); 	 // A.추가인증
				doAction("PRVT_FRUD_MNG", reqForm, function(resDs){
					if (resDs.API_RS_MSG == 'SUCCESS') {
						fnArsPhonNoInq();
					} else {
						biz.alert("추가인증 수단 등록 처리 중 오류가 발생하였습니다.["+resDs.API_RS_MSG+"]");				
					}
				});
			});
		}
	});
}

// ARS 인증번호요청
function fnArsReqAuthNo() {
	var reqForm = makeForm("reqForm");
	addFormData(reqForm, "txGbnCd", "R1");
	addFormData(reqForm, "ARS_AUTHTELNO", $("#ARS_AUTHTELNO").val());
	addFormData(reqForm, "ARS_TARGETSERVICE", arsAuthType);
	addFormData(reqForm, "ARS_SVCMANWORKCD", arsAuthDetail);
	doAction("ARS_AUTH", reqForm, function(resDs){
		if (resDs.API_RS_MSG == 'SUCCESS') {
			$("#ARS_TRANSID").val(resDs.ARS_TRANSID);
			$("#ARS_SSN").val(resDs.ARS_SSN);
			$("#ARS_SSN_text").html(resDs.ARS_SSN);
			openPopup('lyPullPop02'); // 승인버튼 팝업 
			setTimeout(fnArsCallReq, 1000);
		} else {
			biz.alert(resDs.API_RS_MSG);
		}
	});
}

function fnArsCallReq(){
	var reqForm = makeForm("reqForm");
	addFormData(reqForm, "txGbnCd", "R2");
	addFormData(reqForm, "ARS_AUTHTELNO", $("#ARS_AUTHTELNO").val());
	addFormData(reqForm, "ARS_TARGETSERVICE", arsAuthType);
	addFormData(reqForm, "ARS_SVCMANWORKCD", arsAuthDetail);
	addFormData(reqForm, "ARS_TRANSID", $("#ARS_TRANSID").val());
	addFormData(reqForm, "ARS_SSN", $("#ARS_SSN").val());
	
	doAction("ARS_AUTH", reqForm, function(resDs){
		if (resDs.ARS_RESULTCODE == '0000' && resDs.API_RS_MSG == 'SUCCESS') {
			// 정상케이스
		} else {
			biz.alert("전화를 받지 않았거나 승인되기 전 전화를 끊었습니다.");
		}
	});
}

//ARS 인증번호확인
function fnArsReqAuthNoConfirm() {
	var reqForm = makeForm("reqForm");
	addFormData(reqForm, "txGbnCd", "C");
	addFormData(reqForm, "ARS_AUTHTELNO", $("#ARS_AUTHTELNO").val());
	addFormData(reqForm, "ARS_TARGETSERVICE", arsAuthType);
	addFormData(reqForm, "ARS_SVCMANWORKCD", arsAuthDetail);
	addFormData(reqForm, "ARS_TRANSID", $("#ARS_TRANSID").val());
	addFormData(reqForm, "ARS_SSN", $("#ARS_SSN").val());
	
	doAction("ARS_AUTH", reqForm, function(resDs){
		if (resDs.API_RS_MSG == 'SUCCESS') {
			${reqDs.id}_Func.confirm("Y");
		} else {
			//openPopup("lyPullPop03"); TODO 메시지 출력여부
			biz.alert(resDs.API_RS_MSG);
		}
	});
}
 
</script>
<div class="content-wrap">
	<input type="hidden" id="ARS_AUTHTELNO" />
	<input type="hidden" id="ARS_TRANSID" />
	<input type="hidden" id="ARS_SSN" />
	
	<div class="pop-header">
		<h2 class="pop-title">${reqDs.title }</h2>
		<button type="button" name="button" class="btn-layer-close" data-focus="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
	</div>

	<div class="pop-con-wrap">
			<div class="default-wrap">

				<div class="tit-wrap"><!-- [퍼블] 클래스 변경 -->
					<p class="txt"><b>추가인증 방법</b>을<br>선택해주세요</p>
				</div>
				<ul class="check-box">
					<li class="ars">
						<fieldset>
							<input type="radio" id="Chk01_1" name="Chk01" value="" class="" checked>
							<label for="Chk01_1">ARS인증</label>
						</fieldset>
					</li>
					<li class="app">
						<fieldset>
							<input type="radio" id="Chk01_2" name="Chk01" value="" class="" disabled="disabled">
							<label for="Chk01_2">스마트 앱인증</label>
						</fieldset>
					</li>
				</ul>

				<!-- // 1. ars 인증 선택 시 노출 -->
				<!-- <p class="s-txt ta-c">전화번호 선택 후 <b>[ARS요청]</b> 버튼을 눌러주세요</p> [퍼블] 삭제 -->

				<!-- // d: 등록된 전화번호가 1개인 경우 -->
				<div class="form-wrap mt60">
					<div class="input"> 
						<div class="select-wrap on">
							<div class="select-box" tabindex="1">
								<label for="">연락처</label>
								<span class="option" id="ARS_AUTHTELNO_text"></span>
							</div>
						</div>
					</div>
				</div>
				<!-- d: 등록된 전화번호가 1개인 경우 // -->

				<!-- // d: 등록된 전화번호가 2개 이상인 경우 -->
				<div class="form-wrap mt60" style="display: none;">
					<div class="input">
						<div class="select-wrap">
							<div class="select-box" tabindex="1" onclick="openPopupUp('lySel')">
								<label for="">연락처</label>
								<span class="option">미선택</span>
							</div>
						</div>
					</div>
					<p class="error-txt">휴대폰번호를 입력해주세요.</p>
				</div>
				<!-- d: 등록된 전화번호가 2개 이상인 경우 // -->

				<dl class="list-bull caption"><!-- [퍼블] 클래스 변경 -->
					<!-- [퍼블] 수정 범위 -->
					<dt>알아두세요</dt>
					<dd>전화가 안 오면 착신 정지가 되어 있는지 확인하세요</dd>
					<dd>ARS 수신번호 02-1877-9900</dd>
					<!-- // [퍼블] 수정 범위 -->
				</dl>
				<!-- 1. ars 인증 선택 시 노출 // -->

			</div>
		</div>

        <div class="fixed-btn-wrap">
			<div class="btn-wrap">
				<!-- 1. ars 인증 선택 시 노출 -->
				<a href="#none" class="btn" onclick="javascript:fnArsReqAuthNo();"><span>ARS</span> 요청</a>
				<!-- 2. 스마트 앱인증 선택 시 노출 -->
				<a href="#none" class="btn" style="display: none;"><span>스마트 앱</span>인증</a>
			</div>
		</div>
		
		
	<!-- // 등록된 전화번호가 2개 이상인 경우 select popup -->
	<div id="lySel" class="layerpopup layer-up" data-focus="btn-layer-close">
		<div class="content-wrap">
			<div class="pop-header">
				<h2 class="pop-title">연락처를 선택해주세요</h2>
				<button type="button" name="button" class="btn-layer-close">닫기</button>
			</div>
			<div class="ly-scroll-con ly-select">
				<ul class="ly-select-list">
					<li><button>010-1234-5678</button></li>
					<li><button>010-1234-5678</button></li>
					<li><button>010-1234-5678</button></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- 등록된 전화번호가 2개 이상인 경우 select popup // -->
	<!-- D: 추가인증 선택 // -->
	<!-- e: 2023-06-21 풀팝업 형태로 수정 -->

	<!-- s: 2023-06-21 ars 인증번호 화면 추가 -->
	<div id="lyPullPop02" class="layerpopup laypop-all" tabindex="0" data-focus-prev="btn-menu-close">
		<div class="pop-header">
			<h2 class="pop-title">추가인증</h2>
			<button type="button" name="button" class="btn-layer-close">닫기</button>
		</div>
		<div class="pop-con-wrap">
			<div class="default-wrap">

				<div class="gray-box-wrap mt60">
					<p class="txt">인증번호</p>
					<p class="num" id="ARS_SSN_text"></p>
				</div>
				<p class="s-txt ta-c mb40">요청하신 전화번호 ARS 본인인증을 진행중이에요.<br>인증 전화를 받으신 후 안내음성에 따라<br>인증번호를 입력하세요</p>
				<p class="s-txt ta-c">ARS 인증이 완료되면 <b>[ARS 인증]</b> 버튼을 눌러주세요</p>
				<dl class="list-bull"><!-- [퍼블] 클래스 변경 -->
					<dt>알아두세요</dt>
					<dd>전화가 오지 않는 경우 전화번호가 다르게 입력되었거나, 착신이 정지되었는지 확인해주세요</dd>
					<dd>ARS 수신번호는 02-1877-9900 입니다</dd>
				</dl>

			</div>
		</div>
		<div class="fixed-btn-wrap">
			<div class="btn-wrap">
				<a href="#none" class="btn" onclick="javascript:fnArsReqAuthNoConfirm();"><span>ARS</span> 인증</a>
			</div>
		</div>
	</div>
	<!-- e: 2023-06-21 ars 인증번호 화면 추가 -->

	<!-- s: 2023-06-21 ars 인증 실패 화면 추가 -->
	<div id="lyPullPop03" class="layerpopup laypop-all" tabindex="0" data-focus-prev="btn-menu-close">
		<div class="pop-header">
			<h2 class="pop-title">추가인증</h2>
			<button type="button" name="button" class="btn-layer-close">닫기</button>
		</div>
		<div class="pop-con-wrap">
			<div class="default-wrap">
				<div class="result-area exclamation search-txt">
					<p>ARS인증에 실패하셨어요</p>
				</div>
			</div>
		</div>
		<div class="fixed-btn-wrap">
			<div class="btn-wrap">
				<a href="#none" class="btn">확인</a>
			</div>
		</div>
	</div>
	<!-- e: 2023-06-21 ars 인증 실패 화면 추가 -->
	
</div>