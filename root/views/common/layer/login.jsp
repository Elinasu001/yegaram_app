<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var ${reqDs.id}_Func = ({
	// 닫기  
	close : function(){},
	// 취소 (그만하기)
	cancel : function(){},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(){
		var loginForm = makeForm("loginForm");
		addFormData(loginForm, "txGbnCd", "I");
		addFormData(loginForm, "USER_ID_12", $("#USER_ID_12").val());
		addFormData(loginForm, "E2E_USR_PWD", nshc.encrypted("USR_PWD"));
		doAction("LOGIN", loginForm, function(resDs){
			if (typeof(resDs.LOGIN_YN) != 'undefined' && resDs.LOGIN_YN == 'Y') {
				setCookie("LAST_LOGIN_MTH_CD", "ID"); // 최종로그인 수단 ID
				// location.reload();
				// 로그인 정상 콜백수행
				${reqDs.id}_Func.callback();
			} else {
				if (typeof(resDs.API_RS_MSG) != 'undefined' && resDs.API_RS_MSG.indexOf('ECB10667') > -1) {
					//ECB10667,비밀번호 미등록 상태입니다. 최초 비밀번호를 등록해주세요.
					biz.confirm("최초 비밀번호 미등록 상태입니다. 본인인증 로그인 후 최초 비밀번호를 등록해주세요.", function(){
						
						userCertLogin('FRST');
					});
				} else {
					biz.alert(resDs.API_RS_MSG);	
				}
			}
		});
	},
	// 호출 화면 콜백 처리	
	callback : function(){
		doReload();
	}
});

$(document).ready(function(){
	dynamicInput();
	initializedNFilter();
	// LAST_LOGIN_MTH_CD : ID(아이디) kakao, fincert, toss, naver2 
	var lastLoginMthCd = getCookie("LAST_LOGIN_MTH_CD");
	if (typeof(lastLoginMthCd) != 'undefined') {
		// 마지막 로그인 수단 존재
		switch (lastLoginMthCd) {
		case "fincert":
		case "toss":
		case "kakao":
		case "naver2":
			certLogin(lastLoginMthCd);
			break;
		case "S": // 간편비밀번호
		case "P": // 패턴
		case "B": // 바이오인증
			appLogin(lastLoginMthCd);
			break;
		case "ID":
			// ID/PWD
			break;
		default:
			break;
		}
	}
});

function initializedNFilter() {
	// TODO 초기화 시점 변경필요
    // 키패드 초기화 시작
    nshc.setOnInitStart();
    // Open Web nFilter 키패드 설정
    nshc.setCommon(document.getElementById('USR_PWD'), "mode=mCKpd"); // pcCKpd
    nshc.ownCallback = function (msg, inputID) {
        if (msg == "close") {
        	$("label[for='"+inputID+"']").addClass("onbasic");
        }  else if (msg == "open") {
        	$("label[for='"+inputID+"']").removeClass("onbasic");
        } 
    }
}

/*
 * 본인인증 로그인 
 */
function userCertLogin(type) {
	// type LOGIN FRST PWD
	biz.userAuth(function(succYn){
		if (succYn == 'Y') {
			var loginForm = makeForm("loginForm");
			addFormData(loginForm, "txGbnCd", "A");
			doAction("LOGIN", loginForm, function(resDs){
				if (typeof(resDs.LOGIN_YN) != 'undefined' && resDs.LOGIN_YN == 'Y') {
					
					if ("FRST" == type) { // 최초패스워드 등록대상 처리
						doActionFrame('usr/mng/usrFrtPswd1');
					} else if ("PWD" == type) { // 비밀번호 찾기 로그인
						doActionFrame('usr/mng/usrPwErr1');	
					} else {
						// 로그인 정상 콜백수행
						${reqDs.id}_Func.callback();
					}
					
				} else {
					biz.alert(resDs.API_RS_MSG);
				}
			});
		}
	});
}
/*
 * 인증서로그인
 */
function certLogin(authType) {
	var signOptions = {};
    signOptions.provider = authType;
    signOptions.displayProviders = authType;
    signOptions.addNonce = true;
    
	var cgUserInfo = {};
	cgUserInfo.userName = '${SS_CUST.CUST_NM}';
    cgUserInfo.userPhone = '${SS_CUST.PHONE_NO}';
    cgUserInfo.userBirthday = '${SS_CUST.BIRTH_DAY}';
    signOptions.userInfo = cgUserInfo;
      
    Delfino.auth("login=certLogin", signOptions, function(result){
		if(result.status == 1){
			
			var certLoginReqForm = makeForm("certLoginReqForm")
			addFormData(certLoginReqForm, "txGbnCd", "C");
			addFormData(certLoginReqForm, "signedData", result.signData);
			doAction("LOGIN", certLoginReqForm, function(resDs){
				if (typeof(resDs.LOGIN_YN) != 'undefined' && resDs.LOGIN_YN == 'Y') {
					setCookie("LAST_LOGIN_MTH_CD", authType); // 최종로그인 수단 kakao naver2 fincert
					${reqDs.id}_Func.callback();
					
				} else {
					biz.alert(resDs.API_RS_MSG);									
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
}
</script>
<div class="content-wrap">

    <div class="pop-header">
        <h2 class="pop-title">${reqDs.title }</h2>
        <button type="button" name="button" class="btn-layer-close" data-focus="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
    </div>
    
    <div class="pop-con-wrap">
		
		<div class="default-wrap mt15 mb20">
			
			<p class="install-logo"><img src="../../resources/images/main/logo.png" alt="예가람저축은행 로고"></p>
			
			<div class="form-wrap form-line mt0">
				<label for="USER_ID_12" class="formlabel onbasic">아이디</label>
				<div class="input">
					<input type="text" title="아이디" id="USER_ID_12" class="inp" name="" value="" required="">
				</div>
				<p class="error-txt">아이디를 입력해주세요</p>
			</div>
			<div class="form-wrap mt0">
				<label for="USR_PWD" class="formlabel onbasic">비밀번호</label>
				<div class="input">
					<input type="password" title="비밀번호" id="USR_PWD" class="inp" name="" value="" placeholder="" required="" maxlength="50">
				</div>
				<p class="error-txt">비밀번호를 입력해주세요</p>
			</div>

			<div class="btn-cont-wrap mt40"> 
				<a id="" href="#none" class="btn btn-login" onclick="javascript:${reqDs.id}_Func.confirm();">로그인</a>
			</div>
				
			<ul class="button-list border-none mt20">
                <li><a href="#none" onclick="javascript:userCertLogin('PWD');">비밀번호 찾기 &gt;</a></li>
            </ul>

			<ul class="button-list border-none">
                <li><a href="#none" onclick="javascirpt:openPopupUp('certSelectLayer');">다른 인증수단 선택</a></li>
            </ul>

			<dl class="list-bull"><!-- [퍼블] 클래스 변경 -->
				<dt>알아두세요</dt>
				<dd>예가람저축은행 계좌를 개설하실 때 가입하신 전자금융 아이디를 입력해주세요</dd>
				<dd>비밀번호를 다섯 번 잘못 입력하실 경우 비밀번호 오류를 해제 하셔야해요</dd>
				<dd>아이디가 기억나지 않으실 경우 본인인증을 통해서도로그인이 가능해요</dd>
			</dl>
			<div class="btn-cont-wrap btn-sm btn-mini type2">
                <a href="#none" class="btn" onclick="javascript:userCertLogin('LOGIN');">본인인증 로그인</a>
            </div>

			<div class="sub-cal-wrap typeColor mt40">
				<p class="s-txt">예가람저축은행 계좌를 개설하시면</p>
				<p class="txt">다양한 금융서비스를<br>이용하실 수 있어요</p>
				<a href="#none">빠른계좌개설하기</a>
			</div>

		</div>
	</div>
</div>
	
	<!-- s: 인증수단 선택 바텀시트 -->
    <div id="certSelectLayer" class="layerpopup layer-up">
        <div class="content-wrap">
            <div class="pop-header">
                <h2 class="pop-title">인증수단 선택</h2><!-- D: 2023-07-17 .pop-title text 수정 -->
                <button type="button" name="button" class="btn-layer-close" data-focus="btn-layer-close">닫기</button>
            </div>
            <div class="default-wrap">
                <ul class="list-icon certification"><!-- 인증수단 노출방식 변경 : 클래스 변경 적용 필요 -->
                    <c:if test="${activeEnv eq 'APP' }">
                    <li class="pw"><a href="#none" onclick="appLogin('S');">간편비밀번호</a></li>
                    <li class="pattern"><a href="#none" onclick="appLogin('P');">패턴인증</a></li>
                    <li class="bio"><a href="#none" onclick="appLogin('B');">바이오인증</a></li>
                    <li class="joint"><a href="#none" onclick="certLogin('delfino');">공동인증서</a></li>
                    </c:if>
                    <li class="finance"><a href="#none" onclick="certLogin('fincert');">금융인증서</a></li>
                    <li class="toss"><a href="#none" onclick="certLogin('toss');">토스인증</a></li>
                    <li class="kakao"><a href="#none" onclick="certLogin('kakao');">카카오인증</a></li>
                    <li class="naver"><a href="#none" onclick="certLogin('naver2');">네이버인증</a></li>
                </ul>
            </div>
        </div>
    </div>
    <!-- e: 인증수단 선택 바텀시트 -->