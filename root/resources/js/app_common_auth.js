/**
 * 예가람저축은행 인증 공통기능 
 */
var AuthFunc = {
    providerValue:'', //사설인증파람
	certSignType: '', // finCert, cert
	certType: '',
	authType: '',
	certSignedData: '',
	certPopAction: '',
	showAuthAllPopAction: '',
	showAuthAllPopLoginAfterUrl:'',
    resultCallback: null,
    resultAllAuthCallback: null,//전체인증, 여신로그인인증콜백
    initScript: null, 
    kakao_intervalId: null,//카카오타이머ID
    getAuthType: function (event) {//인증타입취득
    	return AuthFunc.authType;
    },
	showFinCertAuth: function (authType, callback) {//인증레이어 팝업실행
		console.log("AuthFunc.showFinCertAuth authType    "+authType); 
		AuthFunc.resultCallback = callback;
		if(authType == 'finCertLogin'){
			FuncCert.actionType = "LOGIN";
			FuncAppChk.getAppironData('LOGIN','finCert', 0);
		} else if(authType == 'finCertRegUserPw' || authType == 'finCertClearUserPw'){
			FuncCert.actionType = "CERTNON";
			FuncAppChk.getAppironData('CERTNON', 'finCert', '-2');
		} else if(authType == 'finCertAdd'){
			FuncCert.actionType = "CERTADD";
			FuncAppChk.getAppironData('CERTADD', 'finCert', 0);
		} else if(authType == 'finCertDel'){
			FuncCert.actionType = "CERTDEL";
			FuncAppChk.getAppironData('CERTDEL', 'finCert', 0);
		} else {
			FuncCert.actionType = "AUTH";
			FuncCert.checkFinCert('sineData');
		}
	},
    showAuthPop: function (authType, callback) {//인증레이어 팝업실행
    	$("#certi").html("");
    	
    	if (authType == 'cert' && ( AuthFunc.certPopAction == 'nonInput' ||  AuthFunc.certPopAction == 'nonPhoneInput')) {
	    	if(!AuthFunc.authValidation(authType, 0)) {
	    		return;
	    	}    		
    	}
    	    	
    	AuthFunc.authType = authType;
		var param = {
			auth_type : authType
			, certPopAction : AuthFunc.certPopAction
   		}
		if (AuthFunc.getAuthType() == 'ars' || AuthFunc.getAuthType() == 'arsonly' ) {
			if (ArsAuthFunc.userId != '') {
				 param = {
					auth_type : authType
					, userId : ArsAuthFunc.userId
				 }				
			}
		}
		
		if (AuthFunc.getAuthType() == 'phone_non') {
			param = {
				auth_type: authType
				, p_name : $.trim($('#a_name').val())
				, p_phoneNo1 : $.trim($("#a_telno1 option:selected").val())
				, p_phoneNo2 : $.trim($('#a_telno2').val())
				, p_phoneNo3 : $.trim($('#a_telno3').val())
				, p_jumin1 : $.trim($('#a_jumin1').val())
		   	}
		}
		
		if (AuthFunc.getAuthType() == 'phone_socket') {
			param = {
				auth_type: authType
				, p_name : $.trim($('#a_name').val())
				, p_phoneNo1 : $.trim($("#a_telno1 option:selected").val())
				, p_phoneNo2 : $.trim($('#a_telno2').val())
				, p_phoneNo3 : $.trim($('#a_telno3').val())
				, p_jumin1 : $.trim($('#a_jumin1').val())
				, p_jumin2 : $.trim($('#a_jumin2').val())
		   	}
		}
				
    	if (typeof callback === 'function') {
    		AuthFunc.resultCallback = callback;
    	}
   	    	
   		AjaxFunc.ajaxAsyncHtml(
			'/common/auth/getPopUp.ajax'
			,param
			,function(data){
				hideSplash();
				$("#certi").html(data);
				openPopup('certi');				
				if(AuthFunc.getAuthType() == 'idpw') {//아이디 패스워드 로그인 경우
					idpwInit();
				}
				
				return;
			}
			,ajax_error
   		);    	
    	
    },
    showAuthAllPop: function (callback) {//본인인증 방법선택 팝업
    	$("#certiSubAll").html("");   	
    	$("#certiAll").html("");
    	if (typeof callback === 'function') {
    		AuthFunc.resultAllAuthCallback = callback;
    	}    	
   		AjaxFunc.ajaxAsyncHtml(
			'/common/auth/getAllAuthPopUp.ajax'
			,{authAllPopAction : AuthFunc.showAuthAllPopAction, AFTER_URL : AuthFunc.showAuthAllPopLoginAfterUrl}
			,function(data) {
				$("#certiAll").html(data).trigger('create');
				openPopup('certiAll');		
				return;
			}
			,ajax_error
   		);
    },
    showAuthSubAllPop: function (callback) {//여신 로그인 방법선택 팝업
    	$("#certiSubAll").html("");
    	$("#certiAll").html("");
    	if (typeof callback === 'function') {
    		AuthFunc.resultAllAuthCallback = callback;
    	}	
   		AjaxFunc.ajaxAsyncHtml(
			'/common/auth/getAllAuthSubPopUp.ajax'
			,{AFTER_URL : AuthFunc.showAuthAllPopLoginAfterUrl}
			,function(data) {
				$("#certiSubAll").html(data);
				openPopup('certiSubAll');		
				return;
			}
			,ajax_error
   		);
    },    
    showHasCustNoPop: function () {//고려고객팝업	
   		AjaxFunc.ajaxAsyncHtml(
			'/common/auth/getHasCustNoPopUp.ajax'
			, {}
			, function(data) {
				$("#hasCustNoId").html(data);
				openPopup('hasCustNoId');		
				return;
			}
			,ajax_error
   		);
    },      

    doCheckAfter : function (type, idx) {


    	if (type == 'securityCard') {//보안카드
    		AuthFunc.auth_securityCard();
    	} else if (type == 'otp') {//OTP
    		AuthFunc.auth_otp();
    	} else if (type == 'ars') {//ARS
    		AuthFunc.auth_ars(); 
    	} else if (type == 'pin') {//PIN인증
    		AuthFunc.auth_simple(type);
    	} else if (type == 'pattern') {//PATTERN인증
    		AuthFunc.auth_simple(type);
    	} else if (type == 'finger') {//FINGER인증	
    		AuthFunc.auth_simple(type);
    	} else if (type == 'face') {//FACE인증	
    		AuthFunc.auth_simple(type);
    	} else if (type == 'motp') {//MOTP인증	
    		AuthFunc.auth_motp();
    	} else if (type == 'app') {//APP인증	
    		AuthFunc.auth_app(); 
    	//} else if (type == 'phone') {//KCB인증	
    		//AuthFunc.auth_kcb_mobile();    
    	} else if (type == 'phone2') {//NICE인증	
    		AuthFunc.auth_nice_mobile();     		
    	//} else if (type == 'phone_socket') {//KCB_socket인증	
    	//	AuthFunc.auth_kcb_mobile_socket();    
    	} else if (type == 'certPass') {//공동인증서
			FuncCert.actionType = FuncAppChk.actionType;
			FuncCert.checkCertInfo(idx);  
    	} else if (type == 'certPass2') {//공동인증서
			FuncCert.actionType = FuncAppChk.actionType;
			FuncCert.checkCertInfo(idx);  			
    	} else if (type == 'finCert' && idx == '-2') {//금융인증서
			FuncCert.actionType = FuncAppChk.actionType;
			FuncCert.checkFinCertInfo();  
           		
    	}else if (type == 'provider') {//사설인증서
          
				document.authfrm.authType.value = $.trim('certNonStop');
    	    	document.authfrm.appDeviceInfo.value = FuncUserData.deviceEncData;
    	    	document.authfrm.custNm.value = $.trim($('#a_name').val());
    	    	document.authfrm.jumin1.value = $.trim($('#a_jumin1').val());
    	    	document.authfrm.jumin2.value = $.trim($('#a_jumin2').val());    	
           
			var param = $("#authfrm").serialize();
	    	var url = '/common/auth/init.ajax';
	    	AjaxFunc.ajaxAsync( url, param, function(res) {
	    		if(res.resultCode == '200') {
		
				    FuncCert.actionType = FuncAppChk.actionType;
		            FuncCert.providerValue = FuncAppChk.providerValue;
		    		FuncCert.checkProviderCertInfo();  			
	    			
	    		} else {
	    			AuthFunc.on_error(res);
	    		}
	    	}, function(res) {
	    		AuthFunc.on_error(res);
	    	});

            
        } else if (type == 'certNon') {//공동인증서
			FuncCert.actionType = FuncAppChk.actionType;
			FuncCert.checkCertInfo(idx);  			
    	} else {//휴대폰, 신용카드, 카카오뱅크, iPin, 공동인증서의 경우
    		if(type == 'certNonStop' || (type == 'finCert' && idx == '-1')) {
    	    	document.authfrm.authType.value = $.trim('certNonStop');
    	    	document.authfrm.appDeviceInfo.value = FuncUserData.deviceEncData;
    	    	document.authfrm.custNm.value = $.trim($('#a_name').val());
    	    	document.authfrm.jumin1.value = $.trim($('#a_jumin1').val());
    	    	document.authfrm.jumin2.value = $.trim($('#a_jumin2').val());    			
    		} else {
    	    	if(!AuthFunc.authValidation(type, idx)) {
    	    		return;
    	    	}    			
    		}

	    	
	    	var param = $("#authfrm").serialize();
	    	var url = '/common/auth/init.ajax';
	    	AjaxFunc.ajaxAsync( url, param, function(res) {
	    		if(res.resultCode == '200') {
	    			if(type == 'phone') {
	    				AuthFunc.auth_kcb_mobile();
	    				//AuthFunc.auth_nice_mobile();
	    			} else if(type == 'phone_socket') {
	    				AuthFunc.auth_kcb_mobile_socket();
	    			} else if(type == 'cert') {
	    				FuncCert.actionType = FuncAppChk.actionType;
	    				FuncCert.checkCertInfo(idx);	    				
	    			} else if(type == 'ipin') {
	    				AuthFunc.auth_ipin();
	    			} else if(type == 'kakao') {
	    				AuthFunc.auth_kakao();
	    			} else if(type == 'credit') {
	    				AuthFunc.auth_kcb_credit();		
	    			} else if(type == 'certNonStop') {
	    				FuncCert.actionType = FuncAppChk.actionType;
	    				FuncCert.checkCertInfo(idx);	    				
	    			} else if(type == 'finCert') {
						FuncCert.actionType = FuncAppChk.actionType;
						FuncCert.checkFinCertInfo();
	    			} 
	    		} else {
	    			AuthFunc.on_error(res);
	    		}
	    	}, function(res) {
	    		AuthFunc.on_error(res);
	    	});
    	}

    }, 
    doLoginAfter : function (type, idx) {//로그인	  
    	if(type == 'cert') {//인증서 로그인
    		FuncCert.actionType = 'LOGIN';
    		FuncCert.checkCertInfo(idx);
    	} else if(type == 'finCert') {//금융 인증서 로그인
    		FuncCert.actionType = 'LOGIN';
    		FuncCert.checkFinCertInfo();
    	} else if(type == 'id') {//아이디패스워드 로그인
    		doLoginAction()
    	} else if(type == 'pin') {//핀로그인
    		doSimpleLoginAction(type);
    	} else if(type == 'pattern') {//패턴 로그인
    		doSimpleLoginAction(type);
    	} else if(type == 'finger') {//생체인증 로그인
    		doSimpleLoginAction(type);
    	} else if(type == 'face') {//생체인증 로그인
    		doSimpleLoginAction(type);
    	}
    }, 
    doCertActionAfter : function (actionType, type, idx) {//타기관공동인증서 등록 및 삭제 || 공동인증서 복사
		FuncCert.actionType = actionType;
		if(type == 'finCert'){
			FuncCert.checkFinCertInfo();
		} else {
			FuncCert.checkCertInfo(idx);
		}
    },
    auth_kakao: function() {//카카오인증
    	var kakaoPopId = 'kakaoPop';
    	if (AuthFunc.kakao_intervalId != null) {
    		clearInterval(AuthFunc.kakao_intervalId);
    	}
    	var url = '/common/auth/kakao.ajax';
    	AjaxFunc.ajaxAsync( url, {}, function(res) {
    		if(res.resultCode == '200') {
    			AuthFunc.timer_kakao(kakaoPopId);
    			openPopup(kakaoPopId);
    		} else {
				var resultJson = {};
				resultJson.resultSuccess = false;  
				authResultCallBack(JSON.stringify(resultJson));
				return;	
    		}
    	}, function(res) {
			var resultJson = {};
			resultJson.resultSuccess = false;  
			authResultCallBack(JSON.stringify(resultJson));
			return;	
    	});
    },
    auth_kakao_result: function() {//카카오인증결과확인
    	var kakaoPopId = 'kakaoPop';    	
    	var param = $("#authfrm").serialize();
    	var url = '/common/auth/kakaoAuthResult.ajax';
    	AjaxFunc.ajaxAsync( url, param, function(res) {
    		if(res.resultCode == '200') {
    			clearInterval(AuthFunc.kakao_intervalId);
    			closePopup('kakaoPop');
    			//kakaoAuthComplete(res);
				var resultJson = {};
				resultJson.resultSuccess = true;  
				resultJson.hasCustNo = res.data.hasCustNo;
				authResultCallBack(JSON.stringify(resultJson));
    			return;	
    		} else {
    			clearInterval(AuthFunc.kakao_intervalId);
    			closePopup('kakaoPop');
				var resultJson = {};
				resultJson.resultSuccess = false;  
				authResultCallBack(JSON.stringify(resultJson));
				return;	
    		}
    	}, function(res) {
    		AuthFunc.on_error(res);
    	});
    },    
    timer_kakao : function(id) { // 타이머
    	// 제한시간.
    	var timelimit = 300;
    	// 시간 표기 초기화.
    	var $span = $('#kakao_timelimit');
    	$span.css('color', 'black');
    	var min = '0' + parseInt(timelimit / 60);
    	var sec = timelimit % 60;
    	sec = sec < 10 ? '0' + sec : sec;
    	$span.text(min + ':' + sec);
    	var start = new Date();
    	// 1초에 1번씩 시간 체크.
    	var intervalTime = 1000;
    	AuthFunc.kakao_intervalId = setInterval(
			function(){
				// 숨겨진상태일 경우, interval 종료. 
				var display = document.getElementById(id).style.display != 'none';
				if(!display) {
					clearInterval(AuthFunc.kakao_intervalId);
					return;
				}
				// 경과된 시간
				var passed = Math.floor((new Date() - start) / 1000);
				// 표기 시각
				var time = timelimit - passed;
				var min = '0' + parseInt(time / 60);
				var sec = time % 60;
				sec = sec < 10 ? '0' + sec : sec;
				$span.text(min + ':' + sec);
				
				if(time >= 0) {
					if(time < 30) {
						$span.css('color', 'red');
					}else {
						$span.css('color', 'black');
					}
				}else {
					clearInterval(AuthFunc.kakao_intervalId);
					closePopup(id);
					customAlert({title : '안내', message : '인증 시간이 만료되었습니다.', btn_txt1:"확인"});
					return;
				}
			}, intervalTime);
    },  
    auth_ipin : function (){    	
    	var url = '/common/auth/ipin.ysb';
    	FuncPopup.open(url,'' ,'' ,'auth_res' ,'');
    },   
    auth_kcb_credit : function () {   	
    	var url = '/common/auth/mobileAndCredit.ysb';
    	FuncPopup.open(url,'' ,'' ,'auth_res' ,'');    		
    },   
    auth_kcb_mobile : function () {
    	var url = '/common/auth/mobileAndCredit.ysb';
    	FuncPopup.open(url,'' ,'' ,'auth_res' ,'');
    },
    auth_kcb_mobile_socket : function () {
    	sendAuthPhoneNum();
    },
    auth_nice_mobile : function () {
    	sendAuthPhoneNum();
    },    
    auth_securityCard : function () {
    	//securityCard.jsp
    	doGetSecurityCardConfirm();
    },
    auth_otp : function () {
    	//otp.jsp
    	doGetOtpConfirm();
    },  
    auth_ars : function () {
    	//ars.jsp
    	doGetARSConfirm();
    },
    auth_simple : function (type) {
		var param =	{ 
			"signedData":FuncSimpleAuth.signedData
			, "rnd" : FuncSimpleAuth.rnd
			, "msg" : FuncSimpleAuth.msg
			, "action" : FuncSimpleAuth.action
			, "type" : type
		};

		AjaxFunc.ajaxAsync(
			'/common/simpleAuth.ajax'
			,param
			,function(result){
				if(result.resultSuccess) {
					var resultJson = {};
					resultJson.resultSuccess = true;
					resultJson.resultPlainPin = FuncSimpleAuth.plainPin; 
					FuncSimpleAuth.resultCallback(JSON.stringify(resultJson));
					FuncSimpleAuth.init();
				} else {
					commonCodeErrorMsg(result.resultCode, result.resultMsg);
				}	
			}
			,ajax_error
		); 
    },
    auth_motp : function () {
		var param =	{ 
			"signedData":FuncSimpleAuth.signedData
			, "rnd" : FuncSimpleAuth.rnd
			, "msg" : FuncSimpleAuth.msg
			, "action" : FuncSimpleAuth.action
		};

		AjaxFunc.ajaxAsync(
			'/common/simpleMotp.ajax'
			,param
			,function(result){
				if(result.resultSuccess) {
					var resultJson = {};
					resultJson.resultSuccess = true;					
					FuncSimpleAuth.resultCallback(JSON.stringify(resultJson));
				} else {
					if (result.resultCode == '4302') {
				        customAlert({
				            title: "알림",
				            message: "mOTP발급시 아이디와 로그인된 아이디가 일치하지 않습니다.현재 로그인된 아이디로 mOTP를 발급받아야 인증이 가능합니다.mOTP를 재발급 받으시겠습니까?",
				            type: 'confirm',
				            btn_txt1: "취소",
				            btn_txt2: "확인"}, 
				        function () {

				        }, function () {

				        });	
					} else {
						commonCodeErrorMsg(result.resultCode, result.resultMsg);
					}
				}	
			}
			,ajax_error
		); 
    },
    auth_app : function () {
		var param =	{ 
			"signedData":FuncSimpleAuth.signedData
			, "rnd" : FuncSimpleAuth.rnd
			, "msg" : FuncSimpleAuth.msg
			, "action" : FuncSimpleAuth.action
		};

		AjaxFunc.ajaxAsync(
			'/common/simpleApp.ajax'
			,param
			,function(result){
				if(result.resultSuccess) {
					var resultJson = {};
					resultJson.resultSuccess = true;					
					FuncSimpleAuth.resultCallback(JSON.stringify(resultJson));
				} else {
					if (result.resultCode == '4302') {
				        customAlert({
				            title: "알림",
				            message: "앱인증 발급시 등록된 아이디와 로그인된 아이디가 일치하지 않습니다.현재 로그인된 아이디로 앱인증번호를 발급받아야 인증이 가능합니다.앱인증번호를 재발급 받으시겠습니까?",
				            type: 'confirm',
				            btn_txt1: "취소",
				            btn_txt2: "확인"}, 
				        function () {

				        }, function () {

				        });						
					} else {
						commonCodeErrorMsg(result.resultCode, result.resultMsg);
					}
				}	
			}
			,ajax_error
		); 
    },    
    
    securityAuthOpen : function (authType, callback, certYn) {
		
		if (typeof callback === 'function') {
			if((authType == 'C' || authType=='O') && certYn == 'Y' ){
			   	AuthFunc.certCallback = callback;
			} else {
				AuthFunc.resultCallback = callback;
			}
		}

		if ("M" == authType) {//mOTP			
			if(!FuncDeviceToken.getIsExistMotpCsno()) {
			 	customAlert({
					 	title: "알림",
					 	message: "등록된 mOTP가 없습니다.\nmOTP를 등록하시겠습니까?",
					 	type: 'confirm',
					 	btn_txt1: "취소",
					 	btn_txt2: "이동"
				 	}, function () {
				 		showSplash();
				 		commonMoveUrl('move',"/common/mOTPRegInfo.ysb");
				 	}, function () {}
				 );
			} else {
				var displayTitle ={	"title"	: "mOTP 비밀번호 입력" ,
						"titleSub"	: "",
						"step" 		: "",
						"contents"	: ""
				}
				
				if (typeof(certYn) !='undefined' && certYn == 'Y') {
					FuncSimpleAuth.motpAuth(displayTitle, AuthFunc.callAuthCert);  
				} else {
					FuncSimpleAuth.motpAuth(displayTitle, callback); 
				}
			}			
		} else if("O" == authType) {//OTP
			if (typeof(certYn) !='undefined' && certYn == 'Y') {
				AuthFunc.showAuthPop('otp', AuthFunc.callAuthCert);  
			} else {
				AuthFunc.showAuthPop('otp', callback);  
			}
			   	
		} else if("C" == authType) {//보안카드
			if (typeof(certYn) !='undefined' && certYn == 'Y') {
				AuthFunc.showAuthPop('securityCard', AuthFunc.callAuthCert);   
			} else {
				AuthFunc.showAuthPop('securityCard', callback);  
			}
		}		
    },
    
    /*
     * 마지막 로그인 또는 (보안 매체 호출일경우엔 certYn == Y면 공동인증서 필수)
     */
    lastAuthOpen : function(authType, certYn, callback) { 
    	
    	if (typeof callback === 'function') {
			AuthFunc.resultCallback = callback;
    	} 
    	
    	var lastLoginWay = FuncUserData.getLastLoginWay();
    	if (lastLoginWay == 'pin') {
    		FuncSimpleAuth.auth(callback, 'P','PIN','AUTH');
    	} else if (lastLoginWay == 'pattern') {
    		FuncSimpleAuth.auth(callback, 'P','PATTERN','AUTH');
    	} else if (lastLoginWay == 'finger') {
    		FuncSimpleAuth.auth(callback, 'P','FINGER','AUTH');
    	} else if (lastLoginWay == 'face') {
    		FuncSimpleAuth.auth(callback, 'P','FACE','AUTH');
    	} else {
    		if((authType == 'C' || authType=='O') && certYn == 'Y' ){
    			if (typeof callback === 'function') {
                	AuthFunc.certCallback = callback;
                }
            }
			 if (lastLoginWay == 'finCert') {
				AuthFunc.certType = "S000700007"  // 금융인증서
			}
            AuthFunc.securityAuthOpen(authType, callback, certYn);
        }
    }, 
    
    /*
     * 마지막 로그인 또는 공동인증서 호출 
     */
    lastAuthOpen2 : function(callback) { 
    	
    	if (typeof callback === 'function') {
			AuthFunc.resultCallback = callback;
    	} 
    	
    	var lastLoginWay = FuncUserData.getLastLoginWay();
    	if (lastLoginWay == 'pin') {
    		FuncSimpleAuth.auth(callback, 'P','PIN','AUTH');
    	} else if (lastLoginWay == 'pattern') {
    		FuncSimpleAuth.auth(callback, 'P','PATTERN','AUTH');
    	} else if (lastLoginWay == 'finger') {
    		FuncSimpleAuth.auth(callback, 'P','FINGER','AUTH');
    	} else if (lastLoginWay == 'face') {
    		FuncSimpleAuth.auth(callback, 'P','FACE','AUTH');
    	} else if (lastLoginWay == 'finCert') {
				AuthFunc.resultCallback = callback;
				//FuncCert.actionType = "AUTH";
				//FuncCert.checkFinCert('sineData');
				FuncAppChk.getAppironData('AUTH','finCert', '');
    	} else {
    		AuthFunc.onlyCertAuth(callback);	//공동인증서 호출 
    	} 
    },  
    
	/**
	 * 이체시 호출하는 보안매체 처리
	 * type => nonSimple : 인증처리후 콜백, afterCert : 인증처리후 공동인증서 호출  
	 */
    checkTrnImtrAuthType : function (p_type, p_acno, p_price, callBack) {
		
		var param = {
			type : p_type
			, price : p_price
			, acno : p_acno
			, lastLoginWay : FuncUserData.getLastLoginWay()
			, pin_yn : FuncDeviceToken.getIsExistPinCsno() ? 'Y': 'N'
			, finger_yn : FuncDeviceToken.getIsExistFingerCsno() ? 'Y': 'N'
			, face_yn : FuncDeviceToken.getIsExistFaceCsno() ? 'Y': 'N'
			, pattern_yn : FuncDeviceToken.getIsExistPatternCsno() ? 'Y': 'N'
			, face_yn : 'N'
			, motp_yn : FuncDeviceToken.getIsExistMotpCsno() ? 'Y': 'N'
		}

		if(p_type == 'afterCert' || p_type == 'nonSimple' || p_type == 'finCert') {
			if (typeof callBack === 'function') {
	    		AuthFunc.certCallback = callBack;
	    	}
		}
		
		AjaxFunc.ajaxAsync(
			'/common/auth/checkTrnImtrAuthType.ajax'
			,param
			,function(result) {
				if (result.resultSuccess) {
					if (typeof callBack === 'function') {
						if(result.data == 'C' || result.data =='O'){
							AuthFunc.certCallback = callBack;
						}
				   	}
					if (result.data == 'pin') {
						FuncSimpleAuth.auth(callBack, 'P','PIN','AUTH');
					} else if (result.data == 'pattern') {
						FuncSimpleAuth.auth(callBack, 'P','PATTERN','AUTH');
					} else if (result.data == 'finger') {
						FuncSimpleAuth.auth(callBack, 'P','FINGER','AUTH');
					} else if (result.data == 'face') {
						FuncSimpleAuth.auth(callBack, 'P','FACE','AUTH');
					} else if (result.data == 'O') {
						if(p_type == 'afterCert' || p_type == 'nonSimple' || p_type == 'finCert') {
							AuthFunc.showAuthPop('otp', AuthFunc.callAuthCert);  
						} else {
							AuthFunc.showAuthPop('otp', callBack);
						}
					} else if (result.data == 'C') {
						if(p_type == 'afterCert' || p_type == 'nonSimple' || p_type == 'finCert') {					
							AuthFunc.showAuthPop('securityCard', AuthFunc.callAuthCert);  
						} else {
							AuthFunc.showAuthPop('securityCard', callBack);
						}						
					} else if (result.data == 'M') {
						var displayTitle ={	"title"	: "mOTP 비밀번호 입력" ,
								"titleSub"	: "" ,
								"step" 		: "",
								"contents"	: ""
						}
						
						if(p_type == 'afterCert' || p_type == 'nonSimple' || p_type == 'finCert') {	
							FuncSimpleAuth.motpAuth(displayTitle, AuthFunc.callAuthCert); 
						} else {
							FuncSimpleAuth.motpAuth(displayTitle, callBack);
						}
					}
				} else {
					commonCodeErrorMsg(result.resultCode, result.resultMsg);
				}
				return;
			}
			,ajax_error
   		); 
    },  
    
	/**
	 * 이체시 호출하는 보안매체 처리
	 * p_type => 보안매체 타입
	 * p_price => 1회 이체 금액  
	 */    
    checkTrnImtrAuthType2 : function (p_type, p_price, callBack) {

    	if (typeof callBack === 'function') {
			if(p_type == 'C' || p_type =='O'){
			   	AuthFunc.certCallback = callBack;
			} else {
				AuthFunc.resultCallback = callBack;
			}
    	}
		
		if (p_type == 'O') {
			if(p_price < 100000000){
				AuthFunc.showAuthPop('otp', AuthFunc.callAuthCert); 
			}
		} else if (p_type == 'C') {
	
			if(p_price > 50000000){
				commonCodeErrorMsg('7004', '이체 가능한 보안매체(OTP)가 없습니다.');
			} else {
				AuthFunc.showAuthPop('securityCard', AuthFunc.callAuthCert);  
			}
	
		} else if (p_type == 'M') {
	
			if(p_price > 10000000){
				commonCodeErrorMsg('7003', '이체 가능한 보안매체(OTP, 보안카드)가 없습니다.');
			} else {
				var displayTitle ={	"title"	: "mOTP 비밀번호 입력" ,
						"titleSub"	: "" ,
						"step" 		: "",
						"contents"	: ""
				}
				
				FuncSimpleAuth.motpAuth(displayTitle, AuthFunc.callAuthCert); 
			}
			
		}
		
		return;
    },
    
	/**
	 * mOTP, OTP, 보안카드 인증후 공인인증 호출  
	 */
    callAuthCert: function (authResult) {
		if(($("#CERT_CD").val() != undefined && $("#CERT_CD").val() == "S000700007") || AuthFunc.certType == "S000700007"){ // 금융인증서
			if(AuthFunc.certCallback != null) {
				AuthFunc.resultCallback = AuthFunc.certCallback;
			}
			//FuncCert.actionType = "CERTPASS2";
			//FuncCert.checkFinCert('sineData');
	        FuncAppChk.getAppironData('CERTPASS2','finCert', '-2');
		} else {
			if(AuthFunc.certCallback != null) {
				AuthFunc.resultCallback = AuthFunc.certCallback;
			}
			var result = JSON.parse(authResult);
			if(result.resultSuccess) {
				closeAuthPopAction();
				AuthFunc.showAuthPop('certPass2', AuthFunc.resultCallback);  //공인인증
			} else {
				customAlert({title:"에러", message:"인증이 실패하였습니다.", btn_txt1:"완료"}, ''
					, function() {
					closeAuthPopAction();
					return;
					}
				);
			}
		}
    },
    
    on_error : function (err) {
    	console.log(err);
    	removeLoading();
    	hideSplash();
    	if(UtilFunc.isNull(err)){
    		err.message = "서비스중 오류가 발생하였습니다.\n잠시 후 다시 시도해주세요.";
    	}
    	if(!UtilFunc.isNull(err.resultMsg)) {
    		err.message = err.resultMsg;
    	}
    	customAlert({title:"알림 [" + err.resultCode + "]", message:err.resultMsg, btn_txt1:"닫기"}, ''
        		, function(){
    				return false;	
        		}
        );
    	return false;	
    },    
    authValidation : function (type, idx) {
    	var inputFormValidate = [
    		{id : 'a_name',	fieldName : '성명', validate : [ 'NotNull' ]},
    		{id : 'a_jumin1', fieldName : '주민등록번호', validate : [ 'NotNull', 'Jumin1' ]},
    		{id : 'a_jumin2Dummy', fieldName : '주민등록번호', validate : [ 'NotNull', 'Jumin2' ]},
    		{id : 'a_telno2', fieldName : '휴대폰번호',	 validate : [ 'NotNull', 'TelNo2' ]},
    		{id : 'a_telno3', fieldName : '휴대폰번호',	 validate : [ 'NotNull' , 'TelNo3']}
    	];    	
    	
    	if (type == 'cert' && AuthFunc.certPopAction == 'nonPhoneInput') {
        	var inputFormValidate = [
        		{id : 'a_name',	fieldName : '성명', validate : [ 'NotNull' ]},
        		{id : 'a_jumin1', fieldName : '주민등록번호', validate : [ 'NotNull', 'Jumin1' ]},
        		{id : 'a_jumin2Dummy', fieldName : '주민등록번호', validate : [ 'NotNull', 'Jumin2' ]}
        	];     		
    	}

		if (type == 'finCert' && AuthFunc.certPopAction == 'nonPhoneInput') {
        	var inputFormValidate = [
        		{id : 'a_name',	fieldName : '성명', validate : [ 'NotNull' ]},
        		{id : 'a_jumin1', fieldName : '주민등록번호', validate : [ 'NotNull', 'Jumin1' ]},
        		{id : 'a_jumin2Dummy', fieldName : '주민등록번호', validate : [ 'NotNull', 'Jumin2' ]}
        	];     		
    	}
    	
    	if (systemDevice == 'pc') {
    		inputFormValidate = [
        		{id : 'a_name',	fieldName : '성명', validate : [ 'NotNull' ]},
        		{id : 'a_jumin1', fieldName : '주민등록번호', validate : [ 'NotNull', 'Jumin1' ]},
        		{id : 'a_jumin2', fieldName : '주민등록번호', validate : [ 'NotNull', 'Jumin2' ]},
        		{id : 'a_telno2', fieldName : '휴대폰번호',	 validate : [ 'NotNull', 'TelNo2' ]},
        		{id : 'a_telno3', fieldName : '휴대폰번호',	 validate : [ 'NotNull' , 'TelNo3']}
        	];       		
    	}
    	
    	if(!PageValidate.validate(inputFormValidate)) {
    		return false;
    	}
    	
    	if (type == 'cert' && AuthFunc.certPopAction != 'nonInput' && AuthFunc.certPopAction != 'nonPhoneInput') {
    		if (idx == -1) {
    			customAlert({title : '알림', message:'인증서를 선택해 주세요.', btn_txt1:"닫기"});
    			return false;
    		}
    	}
   	
    	document.authfrm.authType.value = $.trim(type);
    	document.authfrm.appDeviceInfo.value = FuncUserData.deviceEncData;
    	document.authfrm.custNm.value = $.trim($('#a_name').val());
    	document.authfrm.phoneNo1.value = $.trim($("#a_telno1 option:selected").val());
    	document.authfrm.phoneNo2.value = $.trim($('#a_telno2').val());
    	document.authfrm.phoneNo3.value = $.trim($('#a_telno3').val());
    	document.authfrm.jumin1.value = $.trim($('#a_jumin1').val());
    	document.authfrm.jumin2.value = $.trim($('#a_jumin2').val());
    	return true;
    },
    
	/**
	 * 공동인증서 인증 모듈 호출  
	 */
	onlyCertAuth: function (lastCallback) {
		if (typeof lastCallback === 'function') {
			AuthFunc.resultCallback = lastCallback;
    	}
		AuthFunc.showAuthPop('cert', lastCallback);  //공인인증
	},
	
	/**
	 * 공동인증서 인증 모듈 호출 (입력값없는버전) 
	 */
	onlyCertAuthNon: function (lastCallback) {
		if (typeof lastCallback === 'function') {
			AuthFunc.resultCallback = lastCallback;
    	}
		AuthFunc.showAuthPop('certNon', lastCallback);  //공인인증
	},	
	
	/**
	 * ARS 인증 모듈 호출  
	 */
	arsCertAuth: function (arsType, arsActionType, arsSubActionType, lastCallback) {
		if (typeof lastCallback === 'function') {
			AuthFunc.resultCallback = lastCallback;
    	}
		ArsAuthFunc.showAuthPop(arsType , arsActionType, arsSubActionType, lastCallback);
	},    
    
	/**
	 * 최종 callback  
	 */
	authResultCallBack: function(authResult) {
		var result = JSON.parse(authResult);
		if(result.resultSuccess) {
			closeAuthPopAction();   
			AuthFunc.resultCallback;
		} else {
		   	customAlert({title:"에러", message:"인증이 실패하였습니다.", btn_txt1:"완료"}, ''
		       	, function() {
		   			closeAuthPopAction();
		   			return;	
		       	}
		   );
		}
	}    
    
};

var ssn1 = "";
var FuncCert = ({

	inputUrl : null, // input url
	inputType : null, // input Type
	actionType : '',
	// 공동인증서 리스트 가져오기
	getCertList : function(){
		showSplash();	
		delfino.getList(
			function(rt){	
				hideSplash();
				var resObj = '';
				if(getOsType()  == "and"){
					resObj = JSON.stringify(rt);		
				} else if(getOsType()  == "ios"){
					resObj = JSON.stringify(rt);
				}	
				if(resObj) {
					if (AuthFunc.getAuthType() == 'certLogin') {
						subCertInit(resObj);
					} else {
						certInit(resObj); 
					}
				} else {
					var resObj = rt;
					errorCert(resObj);
				}

			},function(rt){
				
				hideSplash();
				var j = JSON.stringify(rt);
				var resObj = JSON.parse(j);
				var resText = resObj.errMsg;
				if(appDelfinoErr.ERR_9290.cd == resObj.errCode){
					resText = appDelfinoErr.ERR_9290.msg;
					customAlert({title:"알림", message: resText, btn_txt1:"닫기"}, '', function(){ return; });
				}else if(appDelfinoErr.ERR_9291.cd == resObj.errCode){
					//resText = appDelfinoErr.ERR_9291.msg;
					//customAlert({title:"알림2", message: resText, btn_txt1:"닫기"}, '', function(){ return; });
					if (AuthFunc.getAuthType() == 'certLogin') {
						subCertInit('');
					} else {
						certInit('');
					}
				}else{
					PageFunc.errorCert(resObj);
				}
			}
		);
		
	},
	// 공동인증서 리스트 가져오기
	checkCertList : function(url){
		showSplash();
		delfino.getList(
			function(rt) {
				hideSplash();
				var cnt = 0;
				var resObj = JSON.stringify(rt);
				resObj.forEach(function(item, idx) {
					cnt++;
				});
				if (cnt == 0) {
					checkCertListCall(false);
				} else {
					checkCertListCall(true);
				}

			},function(rt){
				hideSplash();
				var j = JSON.stringify(rt);
				var resObj = JSON.parse(j);
				var resText = resObj.errMsg;
				if(appDelfinoErr.ERR_9290.cd == resObj.errCode){
					resText = appDelfinoErr.ERR_9290.msg;
					customAlert({title:"알림", message: resText, btn_txt1:"닫기"}, '', function(){ return; });
				}else if(appDelfinoErr.ERR_9291.cd == resObj.errCode){
				}else{
					PageFunc.errorCert(resObj);
				}
			}
		);
	},	
	// 전자계약 마지막 인증서 다건 가져오기
	getCertListInfoSet : function() {
		showSplash();		
		delfino.getList(
			function(rt){
				//var resObj = JSON.parse(rt);
				var resObj = JSON.stringify(rt);
				resObj = JSON.parse(resObj);
				if(resObj){
					var execSc ="(function() { resData = "+rt+";})()";
					PageFunc.certInfoSet(resObj);
				}else{
					var resObj = JSON.parse(rt);
				}
             hideSplash();
         },function(rt){
				hideSplash();
				var j = JSON.stringify(rt);
				var resObj = JSON.parse(j);				
				
				var resText = resObj.errMsg;
				if(appDelfinoErr.ERR_9290.cd == resObj.errCode){
					resText = appDelfinoErr.ERR_9290.msg;
					customAlert({title:"알림", message: resText, btn_txt1:"닫기"}, '', function(){ return; });
				}else if(appDelfinoErr.ERR_9291.cd == resObj.errCode){
					resText = appDelfinoErr.ERR_9291.msg;
					customAlert({title:"알림", message: resText, btn_txt1:"닫기"}, '', function(){ return; });
				}else{
					PageFunc.errorCert(resObj);
				}
			}
		);
	},
// 사설인증서 인증하기 
checkProviderCert : function(sineData) {

    if(UtilFunc.isEmpty(sineData)){
        sineData = "G10";
    }
    var title = "G10"; 
    hideSplash();

    DelfinoG10.auth(sineData, title, FuncCert.providerValue,
        function(rt){
            console.log(rt)
            var result = rt;
            var param = {  
                "actionType" : FuncCert.actionType
                , "authIdx" : "0"//selectVal
                , "vidRandom" : result.vidRandom
                , "signedData" : result.signData
                , "deviceInfo" : FuncUserData.deviceEncData
            }
            if(FuncCert.actionType == 'CERTPASS') {
                param = {
                    "actionType" : FuncCert.actionType
                    , "authIdx" : "0"
                    , "vidRandom" : result.vidRandom
                    , "signedData" : result.signData
                    , "deviceInfo" : FuncUserData.deviceEncData
                    , "jumin1" : $('#a_jumin1').val()
                    , "jumin2" : $('#a_jumin2').val()
                    , "jumin2Plain" : $('#a_jumin2Plain').val()
                }
            }  
            if(FuncCert.actionType == 'CERTPASS2') {
                param = {
                    "actionType" : FuncCert.actionType
                    , "authIdx" : "0"
                    , "vidRandom" : result.vidRandom
                    , "signedData" : result.signData
                    , "deviceInfo" : FuncUserData.deviceEncData
                }   
            }         
            if(FuncCert.actionType == 'CERTNONSTOP') {
                param = {
                    "actionType" : FuncCert.actionType
                    , "authIdx" : "0"
                    , "vidRandom" : result.vidRandom
                    , "signedData" : result.signData
                    , "deviceInfo" : FuncUserData.deviceEncData
                    , "jumin1" : $('#a_jumin1').val()
                    , "jumin2" : $('#a_jumin2').val()
                    , "jumin2Plain" : $('#a_jumin2Plain').val()
                    , "plainText" : $.trim(result.plainText)
                    , "originCertData" : result.certificate
                    , "provider" : "Y"
                }
            } 
            //alert(param.signedData); 
            //alert(param.deviceInfo);
            
            AjaxFunc.ajaxAsync(
                '/common/auth/certResultAjax.ajax'
                , param
                , function(res) {
                    hideSplash();
                    if(res.resultSuccess){
                        
                        if(FuncCert.actionType == 'AUTH') {
                            closeAuthPopAction();
                            var resultJson = {};
                            resultJson.resultSuccess = true;
                            resultJson.hasCustNo = res.data.hasCustNo; 
                            AuthFunc.resultCallback(JSON.stringify(resultJson));
                        } else if(FuncCert.actionType == 'LOGIN') {
                            FuncUserData.saveLastLoginWay("finCert");
                            doCommonLoginAction(res);
                        } else if(FuncCert.actionType == 'CERTADD') {
                            window.localStorage.setItem("attrYn", "Y");
                            window.location= '/cert/otherCertEnd.ysb?action=1';
                        } else if(FuncCert.actionType == 'CERTDEL') {
                            window.localStorage.setItem("attrYn", "N");
                            window.location= '/cert/otherCertEnd.ysb?action=2';
                        } else if(FuncCert.actionType == 'CERTCOPY') {
                            var resObj = JSON.parse(res);
                        } else if(FuncCert.actionType == 'CERTPASS') {
                            var resultJson = {};
                            resultJson.resultSuccess = true;
                            resultJson.cIndex = "0";
                            resultJson.vid = result.vidRandom;
                            resultJson.data = result.signData;
                            resultJson.plainText = $.trim(result.plainText);
                            resultJson.jumin1 = $.trim($('#a_jumin1').val());
                            resultJson.jumin2 = $.trim($('#a_jumin2Plain').val());	
                            
                            if(!UtilFunc.isNull(res.data)){
                                resultJson.defaultSignedData = res.data.defaultSignedData;
                            } else {
                                resultJson.defaultSignedData = '';
                            }

                            if(!UtilFunc.isNull(result.originCertData)) {
                                resultJson.originCertData = result.certificate;
                            } else {
                                resultJson.originCertData = '';
                            }								
                            
                            closeAuthPopAction();
                            AuthFunc.resultCallback(JSON.stringify(resultJson));
                        } else if(FuncCert.actionType == 'CERTPASS2') {
                            var resultJson = {};
                            resultJson.resultSuccess = true;
                            resultJson.cIndex = "0";
                            resultJson.vid = result.vidRandom;
                            resultJson.data = result.signData;
                            
                            if(!UtilFunc.isNull(res.data)){
                                resultJson.defaultSignedData = res.data.defaultSignedData;
                            } else {
                                resultJson.defaultSignedData = '';
                            }
                            if(!UtilFunc.isNull(result.certificate)) {
                                resultJson.originCertData = result.certificate;
                            } else {
                                resultJson.originCertData = '';
                            }								
                             
                            closeAuthPopAction();
                            AuthFunc.resultCallback(JSON.stringify(resultJson));  
                        } else if(FuncCert.actionType == 'CERTNON') {
                            var resultJson = {};
                            resultJson.resultSuccess = true;
                            closeAuthPopAction();
                            AuthFunc.resultCallback(JSON.stringify(resultJson));
                        } else if(FuncCert.actionType == 'CERTNONSTOP') {
                            
                            var resultJson = {};
                            resultJson.resultSuccess = true;
                            closeAuthPopAction();
                            AuthFunc.resultCallback(JSON.stringify(resultJson));
                        }
                    } else {
                        //app error
                        hideSplash();
                        if (res.resultCode == 'NCB00007') {
                            commonCodeErrorMsg(res.resultCode, '저축은행에 등록되어있지 않은 금융인증서입니다.');
                        } else {
                            commonCodeErrorMsg(res.resultCode, res.resultMsg);
                        }
                    }
                }
                ,ajax_error
            );
        }, // success
        function(rt){
            console.log("err ::: " + rt);
            //app error
            hideSplash();				
            var j = JSON.stringify(rt);
            var resObjErr = JSON.parse(j);
        
            var resText = resObjErr.errMsg;
            if(appDelfinoErr.ERR_9291.cd == resObjErr.errCode){
                resText = appDelfinoErr.ERR_9291.msg;

            }else if(appDelfinoErr.ERR_9210.cd == resObjErr.errCode){
                resText = appDelfinoErr.ERR_9210.msg;

            }else if(appDelfinoErr.ERR_9290.cd == resObjErr.errCode){
                resText = appDelfinoErr.ERR_9290.msg;

            }else if(appDelfinoErr.ERR_9220.cd == resObjErr.errCode){
                resText = appDelfinoErr.ERR_9220.msg;

            }else if("-103" == resObjErr.errCode){
                resText = "공동인증서 비밀번호를 확인해 주세요.";
            }else if("9102" == resObjErr.errCode){
                resText = "공동인증서 비밀번호를 확인해 주세요.";					
            }else if("9003" == resObjErr.errCode){

            }else{
                resText = "시스템 오류가 발생하였습니다.\n잠시 후 다시 시도해주시길 바랍니다.[" + resObjErr.errCode + "]";
            }
            if ("9003" != resObjErr.errCode) {
                customAlert({title:"알림", message:resText, btn_txt1:"닫기"}, '', function(){ return; });
            }
        } // err
    );
},



	// 금융인증서 인증하기
	checkFinCert : function(sineData) {
		if(UtilFunc.isEmpty(sineData)){
			sineData = "G10";
		}
		var title = "G10";
		hideSplash();
		DelfinoG10.login(sineData, title,
			function(rt){
				console.log(rt)
				var result = rt;
				var param = {
					"actionType" : FuncCert.actionType
					, "authIdx" : "0"//selectVal
					, "vidRandom" : result.vidRandom
					, "signedData" : result.signData
					, "deviceInfo" : FuncUserData.deviceEncData
				}
				if(FuncCert.actionType == 'CERTPASS') {
					param = {
						"actionType" : FuncCert.actionType
						, "authIdx" : "0"
						, "vidRandom" : result.vidRandom
						, "signedData" : result.signData
						, "deviceInfo" : FuncUserData.deviceEncData
						, "jumin1" : $('#a_jumin1').val()
						, "jumin2" : $('#a_jumin2').val()
						, "jumin2Plain" : $('#a_jumin2Plain').val()
					}
				}
				if(FuncCert.actionType == 'CERTPASS2') {
					param = {
						"actionType" : FuncCert.actionType
						, "authIdx" : "0"
						, "vidRandom" : result.vidRandom
						, "signedData" : result.signData
						, "deviceInfo" : FuncUserData.deviceEncData
					}
				}
				if(FuncCert.actionType == 'CERTNONSTOP') {
					param = {
						"actionType" : FuncCert.actionType
						, "authIdx" : "0"
						, "vidRandom" : result.vidRandom
						, "signedData" : result.signData
						, "deviceInfo" : FuncUserData.deviceEncData
						, "jumin1" : $('#a_jumin1').val()
						, "jumin2" : $('#a_jumin2').val()
						, "jumin2Plain" : $('#a_jumin2Plain').val()
						, "plainText" : $.trim(result.plainText)
						, "originCertData" : result.certificate
					}
				}
				//alert(param.signedData);
				//alert(param.deviceInfo);
				
				AjaxFunc.ajaxAsync(
					'/common/auth/certResultAjax.ajax'
					, param
					, function(res) {
						hideSplash();
						if(res.resultSuccess){

                            					
							if(FuncCert.actionType == 'AUTH') {
								closeAuthPopAction();
								var resultJson = {};
								resultJson.resultSuccess = true;
								resultJson.hasCustNo = res.data.hasCustNo; 
								AuthFunc.resultCallback(JSON.stringify(resultJson));
                                
							} else if(FuncCert.actionType == 'LOGIN') {
								FuncUserData.saveLastLoginWay("finCert");
								doCommonLoginAction(res);
							} else if(FuncCert.actionType == 'CERTADD') {
								window.localStorage.setItem("attrYn", "Y");
								window.location= '/cert/otherCertEnd.ysb?action=1';
							} else if(FuncCert.actionType == 'CERTDEL') {
								window.localStorage.setItem("attrYn", "N");
								window.location= '/cert/otherCertEnd.ysb?action=2';
							} else if(FuncCert.actionType == 'CERTCOPY') {
								var resObj = JSON.parse(res);
							} else if(FuncCert.actionType == 'CERTPASS') {
								var resultJson = {};
								resultJson.resultSuccess = true;
								resultJson.cIndex = "0";
								resultJson.vid = result.vidRandom;
								resultJson.data = result.signData;
								resultJson.plainText = $.trim(result.plainText);
								resultJson.jumin1 = $.trim($('#a_jumin1').val());
								resultJson.jumin2 = $.trim($('#a_jumin2Plain').val());	
								
								if(!UtilFunc.isNull(res.data)){
									resultJson.defaultSignedData = res.data.defaultSignedData;
								} else {
									resultJson.defaultSignedData = '';
								}

								if(!UtilFunc.isNull(result.originCertData)) {
									resultJson.originCertData = result.certificate;
								} else {
									resultJson.originCertData = '';
								}								
								
								closeAuthPopAction();
								AuthFunc.resultCallback(JSON.stringify(resultJson));
							} else if(FuncCert.actionType == 'CERTPASS2') {
								var resultJson = {};
								resultJson.resultSuccess = true;
								resultJson.cIndex = "0";
								resultJson.vid = result.vidRandom;
								resultJson.data = result.signData;
								if(!UtilFunc.isNull(res.data)){
									resultJson.defaultSignedData = res.data.defaultSignedData;
								} else {
									resultJson.defaultSignedData = '';
								}
								if(!UtilFunc.isNull(result.certificate)) {
									resultJson.originCertData = result.certificate;
								} else {
									resultJson.originCertData = '';
								}								
								
								closeAuthPopAction();
								AuthFunc.resultCallback(JSON.stringify(resultJson));
                               
							} else if(FuncCert.actionType == 'CERTNON') {
								var resultJson = {};
								resultJson.resultSuccess = true;
								closeAuthPopAction();
								AuthFunc.resultCallback(JSON.stringify(resultJson));
							} else if(FuncCert.actionType == 'CERTNONSTOP') {
								var resultJson = {};
								resultJson.resultSuccess = true;
								closeAuthPopAction();
								AuthFunc.resultCallback(JSON.stringify(resultJson));
							}
						} else {
							//app error
							hideSplash();
							if (res.resultCode == 'NCB00007') {
								commonCodeErrorMsg(res.resultCode, '저축은행에 등록되어있지 않은 금융인증서입니다.');
							} else {
								commonCodeErrorMsg(res.resultCode, res.resultMsg);
							}
						}
					}
					,ajax_error
				);
			}, // success
			function(rt){
				console.log("err ::: " + rt);
				//app error
				hideSplash();				
				var j = JSON.stringify(rt);
				var resObjErr = JSON.parse(j);
			
				var resText = resObjErr.errMsg;
				if(appDelfinoErr.ERR_9291.cd == resObjErr.errCode){
					resText = appDelfinoErr.ERR_9291.msg;

				}else if(appDelfinoErr.ERR_9210.cd == resObjErr.errCode){
					resText = appDelfinoErr.ERR_9210.msg;

				}else if(appDelfinoErr.ERR_9290.cd == resObjErr.errCode){
					resText = appDelfinoErr.ERR_9290.msg;

				}else if(appDelfinoErr.ERR_9220.cd == resObjErr.errCode){
					resText = appDelfinoErr.ERR_9220.msg;

				}else if("-103" == resObjErr.errCode){
					resText = "공동인증서 비밀번호를 확인해 주세요.";
				}else if("9102" == resObjErr.errCode){
					resText = "공동인증서 비밀번호를 확인해 주세요.";					
				}else if("9003" == resObjErr.errCode){
	
				}else{
					resText = "시스템 오류가 발생하였습니다.\n잠시 후 다시 시도해주시길 바랍니다.[" + resObjErr.errCode + "]";
				}
				if ("9003" != resObjErr.errCode) {
					customAlert({title:"알림", message:resText, btn_txt1:"닫기"}, '', function(){ return; });
				}
			} // err
		);
	},
	// 금융인증서 전자서명하기
	signFinCert : function(sineData) {
		if(UtilFunc.isEmpty(sineData)){
			sineData = "G10";
		}
		var title = "G10";
		hideSplash();
		DelfinoG10.sign(sineData, title, 
            
			function(rt){
				
				var result = rt;
				var param = {
					"actionType" : FuncCert.actionType
					, "authIdx" : "0"//selectVal
					, "vidRandom" : result.vidRandom
					, "signedData" : result.signData
					, "deviceInfo" : FuncUserData.deviceEncData
				}
				if(FuncCert.actionType == 'CERTPASS') {
					param = {
						"actionType" : FuncCert.actionType
						, "authIdx" : "0"
						, "vidRandom" : result.vidRandom
						, "signedData" : result.signData
						, "deviceInfo" : FuncUserData.deviceEncData
						, "jumin1" : $('#a_jumin1').val()
						, "jumin2" : $('#a_jumin2').val()
						, "jumin2Plain" : $('#a_jumin2Plain').val()
					}
				}
				if(FuncCert.actionType == 'CERTPASS2') {
                    
					param = {
						"actionType" : FuncCert.actionType
						, "authIdx" : "0"
						, "vidRandom" : result.vidRandom
						, "signedData" : result.signData
						, "deviceInfo" : FuncUserData.deviceEncData
					}
				}
				if(FuncCert.actionType == 'CERTNONSTOP') {
					param = {
						"actionType" : FuncCert.actionType
						, "authIdx" : "0"
						, "vidRandom" : result.vidRandom
						, "signedData" : result.signData
						, "deviceInfo" : FuncUserData.deviceEncData
						, "jumin1" : $('#a_jumin1').val()
						, "jumin2" : $('#a_jumin2').val()
						, "jumin2Plain" : $('#a_jumin2Plain').val()
						, "plainText" : $.trim(result.plainText)
						, "originCertData" : result.certificate
					}
				}
				//alert(param.signedData);
				//alert(param.deviceInfo);
				
				AjaxFunc.ajaxAsync(
					'/common/auth/certResultAjax.ajax'
					, param
					, function(res) {
						hideSplash();
						if(res.resultSuccess){
							
							if(FuncCert.actionType == 'AUTH') {
								closeAuthPopAction();
								var resultJson = {};
								resultJson.resultSuccess = true;
								resultJson.hasCustNo = res.data.hasCustNo; 
								AuthFunc.resultCallback(JSON.stringify(resultJson));
							} else if(FuncCert.actionType == 'LOGIN') {
								FuncUserData.saveLastLoginWay("finCert");
								doCommonLoginAction(res);
							} else if(FuncCert.actionType == 'CERTADD') {
								window.localStorage.setItem("attrYn", "Y");
								window.location= '/cert/otherCertEnd.ysb?action=1';
							} else if(FuncCert.actionType == 'CERTDEL') {
								window.localStorage.setItem("attrYn", "N");
								window.location= '/cert/otherCertEnd.ysb?action=2';
							} else if(FuncCert.actionType == 'CERTCOPY') {
								var resObj = JSON.parse(res);
							} else if(FuncCert.actionType == 'CERTPASS') {
								var resultJson = {};
								resultJson.resultSuccess = true;
                            	resultJson.cIndex = "0";
								resultJson.vid = result.vidRandom;
								resultJson.data = result.signData;
								resultJson.plainText = $.trim(result.plainText);
								resultJson.jumin1 = $.trim($('#a_jumin1').val());
								resultJson.jumin2 = $.trim($('#a_jumin2Plain').val());	
								
								if(!UtilFunc.isNull(res.data)){
									resultJson.defaultSignedData = res.data.defaultSignedData;
								} else {
									resultJson.defaultSignedData = '';
								}

								if(!UtilFunc.isNull(result.originCertData)) {
									resultJson.originCertData = result.certificate;
								} else {
									resultJson.originCertData = '';
								}								
								
								closeAuthPopAction();
								AuthFunc.resultCallback(JSON.stringify(resultJson));
							} else if(FuncCert.actionType == 'CERTPASS2') {
								var resultJson = {};
								resultJson.resultSuccess = true;
								resultJson.cIndex = "0";
								resultJson.vid = result.vidRandom;
								resultJson.data = result.signData;
                                
								if(!UtilFunc.isNull(res.data)){
									resultJson.defaultSignedData = res.data.defaultSignedData;
								} else {
									resultJson.defaultSignedData = '';
								}
								if(!UtilFunc.isNull(result.certificate)) {
									resultJson.originCertData = result.certificate;
								} else {
									resultJson.originCertData = '';
								}								
								
								closeAuthPopAction();
								AuthFunc.resultCallback(JSON.stringify(resultJson));
                                
							} else if(FuncCert.actionType == 'CERTNON') {
								var resultJson = {};
								resultJson.resultSuccess = true;
								closeAuthPopAction();
								AuthFunc.resultCallback(JSON.stringify(resultJson));
							} else if(FuncCert.actionType == 'CERTNONSTOP') {
								var resultJson = {};
								resultJson.resultSuccess = true;
								closeAuthPopAction();
								AuthFunc.resultCallback(JSON.stringify(resultJson));
							}
						} else {
							//app error
							hideSplash();
							if (res.resultCode == 'NCB00007') {
								commonCodeErrorMsg(res.resultCode, '저축은행에 등록되어있지 않은 금융인증서입니다.');
							} else {
								commonCodeErrorMsg(res.resultCode, res.resultMsg);
							}
						}
					}
					,ajax_error
				);
			}, // success
			function(rt){
				console.log("err ::: " + rt);
				//app error
				hideSplash();				
				var j = JSON.stringify(rt);
				var resObjErr = JSON.parse(j);
			
				var resText = resObjErr.errMsg;
				if(appDelfinoErr.ERR_9291.cd == resObjErr.errCode){
					resText = appDelfinoErr.ERR_9291.msg;

				}else if(appDelfinoErr.ERR_9210.cd == resObjErr.errCode){
					resText = appDelfinoErr.ERR_9210.msg;

				}else if(appDelfinoErr.ERR_9290.cd == resObjErr.errCode){
					resText = appDelfinoErr.ERR_9290.msg;

				}else if(appDelfinoErr.ERR_9220.cd == resObjErr.errCode){
					resText = appDelfinoErr.ERR_9220.msg;

				}else if("-103" == resObjErr.errCode){
					resText = "공동인증서 비밀번호를 확인해 주세요.";
				}else if("9102" == resObjErr.errCode){
					resText = "공동인증서 비밀번호를 확인해 주세요.";					
				}else if("9003" == resObjErr.errCode){
	
				}else{
					resText = "시스템 오류가 발생하였습니다.\n잠시 후 다시 시도해주시길 바랍니다.[" + resObjErr.errCode + "]";
				}
				if ("9003" != resObjErr.errCode) {
					customAlert({title:"알림", message:resText, btn_txt1:"닫기"}, '', function(){ return; });
				}
			} // err
		);
	},
	// 공동인증서 인증하기
	checkCert : function(idx, sineData) {
        
		hideSplash();
		var selectVal = '' + idx;
		delfino.check(selectVal, sineData,
			function(rt){
				var result = rt;
				var param = {
					"actionType" : FuncCert.actionType
					, "authIdx" : selectVal
					, "vidRandom" : result.vidRandom
					, "signedData" : result.signedData
					, "deviceInfo" : FuncUserData.deviceEncData
		   		}
				
				if(FuncCert.actionType == 'CERTPASS') {
					 param = {
						"actionType" : FuncCert.actionType
						, "authIdx" : selectVal
						, "vidRandom" : result.vidRandom
						, "signedData" : result.signedData
						, "deviceInfo" : FuncUserData.deviceEncData
						, "jumin1" : $('#a_jumin1').val()
						, "jumin2" : $('#a_jumin2').val()
						, "jumin2Plain" : $('#a_jumin2Plain').val()
					 }					
				}
				
				if(FuncCert.actionType == 'CERTPASS2') {
					 param = {
						"actionType" : FuncCert.actionType
						, "authIdx" : selectVal
						, "vidRandom" : result.vidRandom
						, "signedData" : result.signedData
						, "deviceInfo" : FuncUserData.deviceEncData
					 }					
				}				

				if(FuncCert.actionType == 'CERTNONSTOP') {
					 param = {
						"actionType" : FuncCert.actionType
						, "authIdx" : selectVal
						, "vidRandom" : result.vidRandom
						, "signedData" : result.signedData
						, "deviceInfo" : FuncUserData.deviceEncData
						, "jumin1" : $('#a_jumin1').val()
						, "jumin2" : $('#a_jumin2').val()
						, "jumin2Plain" : $('#a_jumin2Plain').val()
						, "plainText" : $.trim(result.plainText)
						, "originCertData" : result.originCertData
					 }					
				}				

	   			AjaxFunc.ajaxAsync(
					'/common/auth/certResultAjax.ajax'
					, param
					, function(res) {
						hideSplash();
                        
						if(res.resultSuccess){
							if(FuncCert.actionType == 'AUTH') {
								closeAuthPopAction();
								var resultJson = {};
								resultJson.resultSuccess = true;
								resultJson.hasCustNo = res.data.hasCustNo; 
								AuthFunc.resultCallback(JSON.stringify(resultJson));
							} else if(FuncCert.actionType == 'LOGIN') {
								FuncUserData.saveLastLoginWay("cert");
								doCommonLoginAction(res);
							} else if(FuncCert.actionType == 'CERTADD') {
								window.localStorage.setItem("attrYn", "Y");
								window.location= '/cert/otherCertEnd.ysb?action=1';
							} else if(FuncCert.actionType == 'CERTDEL') {
								window.localStorage.setItem("attrYn", "N");
								window.location= '/cert/otherCertEnd.ysb?action=2';
							} else if(FuncCert.actionType == 'CERTCOPY') {
								var resObj = JSON.parse(res);
							} else if(FuncCert.actionType == 'CERTPASS') {
								var resultJson = {};
								resultJson.resultSuccess = true;
								resultJson.cIndex = selectVal;
								resultJson.vid = result.vidRandom;
								resultJson.data = result.signedData;
								resultJson.plainText = $.trim(result.plainText);
								resultJson.jumin1 = $.trim($('#a_jumin1').val());
								resultJson.jumin2 = $.trim($('#a_jumin2Plain').val());	
								
								if(!UtilFunc.isNull(res.data)){
									resultJson.defaultSignedData = res.data.defaultSignedData;
								} else {
									resultJson.defaultSignedData = '';
								}

								if(!UtilFunc.isNull(result.originCertData)) {
									resultJson.originCertData = result.originCertData;
								} else {
									resultJson.originCertData = '';
								}								
								
								closeAuthPopAction();
								AuthFunc.resultCallback(JSON.stringify(resultJson));
							} else if(FuncCert.actionType == 'CERTPASS2') {
								var resultJson = {};
								resultJson.resultSuccess = true;
								resultJson.cIndex = selectVal;
								resultJson.vid = result.vidRandom;
								resultJson.data = result.signedData;
									
								if(!UtilFunc.isNull(res.data)){
									resultJson.defaultSignedData = res.data.defaultSignedData;
								} else {
									resultJson.defaultSignedData = '';
								}

								if(!UtilFunc.isNull(result.originCertData)) {
									resultJson.originCertData = result.originCertData;
								} else {
									resultJson.originCertData = '';
								}								
								
								closeAuthPopAction();
								AuthFunc.resultCallback(JSON.stringify(resultJson));								
							} else if(FuncCert.actionType == 'CERTNON') {
								var resultJson = {};
								resultJson.resultSuccess = true;
								closeAuthPopAction();
								AuthFunc.resultCallback(JSON.stringify(resultJson));
							} else if(FuncCert.actionType == 'CERTNONSTOP') {
								var resultJson = {};
								resultJson.resultSuccess = true;
								closeAuthPopAction();
								AuthFunc.resultCallback(JSON.stringify(resultJson));
							}
						} else {
							//app error
							hideSplash();
							if (res.resultCode == 'NCB00007') {
								commonCodeErrorMsg(res.resultCode, '저축은행에 등록되어있지 않은 공동인증서입니다.');
							} else {
								commonCodeErrorMsg(res.resultCode, res.resultMsg);
							}
						}
					}
					,ajax_error
	   			);
			},function(rt){
				//app error
				hideSplash();				
				var j = JSON.stringify(rt);
				var resObjErr = JSON.parse(j);
			
				var resText = resObjErr.errMsg;
                
				if(appDelfinoErr.ERR_9291.cd == resObjErr.errCode){
					resText = appDelfinoErr.ERR_9291.msg;

				}else if(appDelfinoErr.ERR_9210.cd == resObjErr.errCode){
					resText = appDelfinoErr.ERR_9210.msg;

				}else if(appDelfinoErr.ERR_9290.cd == resObjErr.errCode){
					resText = appDelfinoErr.ERR_9290.msg;

				}else if(appDelfinoErr.ERR_9220.cd == resObjErr.errCode){
					resText = appDelfinoErr.ERR_9220.msg;

				}else if("-103" == resObjErr.errCode){
					resText = "공동인증서 비밀번호를 확인해 주세요.";
				}else if("9102" == resObjErr.errCode){
					resText = "공동인증서 비밀번호를 확인해 주세요.";					
				}else if("9003" == resObjErr.errCode){
	
				}else{
					resText = "시스템 오류가 발생하였습니다.\n잠시 후 다시 시도해주시길 바랍니다.[" + resObjErr.errCode + "]";
				}
				if ("9003" != resObjErr.errCode) {
					customAlert({title:"알림", message:resText, btn_txt1:"닫기"}, '', function(){ return; });
				}

			}
		);
	}
	//인증서체크 
	, checkCertInfo : function(idx) {
		if (FuncCert.actionType == 'LOGIN') {
			FuncCert.checkCert(idx, AuthFunc.certSignedData);
		} else if (FuncCert.actionType == 'AUTH') {
			FuncCert.checkCert(idx, AuthFunc.certSignedData);
		} else if (FuncCert.actionType == 'CERTPASS') {
			FuncCert.checkCert(idx, AuthFunc.certSignedData);
		} else if (FuncCert.actionType == 'CERTPASS2') {
			FuncCert.checkCert(idx, AuthFunc.certSignedData);
		} else if (FuncCert.actionType == 'CERTNONSTOP') {
			FuncCert.checkCert(idx, AuthFunc.certSignedData);			
		} else if (FuncCert.actionType == 'CERTNON') {
			FuncCert.checkCert(idx, AuthFunc.certSignedData);			
		} else if (FuncCert.actionType == 'CERTADD') {
			FuncCert.checkCert(idx, AuthFunc.certSignedData);
		} else if (FuncCert.actionType == 'CERTDEL') {
			FuncCert.checkCert(idx, AuthFunc.certSignedData);
		} else if (FuncCert.actionType == 'CERTCOPY') {
			FuncCert.checkCert(idx, AuthFunc.certSignedData);
		} else if (FuncCert.actionType == 'CERTCHECK') {
			FuncCert.checkCert(idx, AuthFunc.certSignedData);
		}
	}
	//인증서체크 
	, checkFinCertInfo : function() {

           
		if (FuncCert.actionType == 'LOGIN') {
			FuncCert.checkFinCert(AuthFunc.certSignedData);
		} else if (FuncCert.actionType == 'AUTH') {
			FuncCert.checkFinCert(AuthFunc.certSignedData);
		} else if (FuncCert.actionType == 'CERTADD') {
			FuncCert.checkFinCert(AuthFunc.certSignedData);
		} else if (FuncCert.actionType == 'CERTDEL') {
			FuncCert.checkFinCert(AuthFunc.certSignedData);
		} else if (FuncCert.actionType == 'CERTNON') {
			FuncCert.checkFinCert(AuthFunc.certSignedData);
		} else if (FuncCert.actionType == 'CERTNONSTOP') {
			FuncCert.checkFinCert(AuthFunc.certSignedData);
		} else if (FuncCert.actionType == 'CERTPASS2') {
			FuncCert.signFinCert(AuthFunc.certSignedData);
		} else if (FuncCert.actionType == 'CERTPASS') {
			FuncCert.checkFinCert(AuthFunc.certSignedData);
		}
	}

    //사설인증서체크 
    , checkProviderCertInfo : function() {
        if (FuncCert.actionType == 'LOGIN') {
            FuncCert.checkProviderCert(AuthFunc.certSignedData);
        } else if (FuncCert.actionType == 'AUTH') {
            FuncCert.checkProviderCert(AuthFunc.certSignedData);
        } else if (FuncCert.actionType == 'CERTADD') {
            FuncCert.checkProviderCert(AuthFunc.certSignedData);
        } else if (FuncCert.actionType == 'CERTDEL') {
            FuncCert.checkProviderCert(AuthFunc.certSignedData);
        } else if (FuncCert.actionType == 'CERTNON') {
            FuncCert.checkProviderCert(AuthFunc.certSignedData);
        } else if (FuncCert.actionType == 'CERTNONSTOP') {
            FuncCert.checkProviderCert(AuthFunc.certSignedData);
        } else if (FuncCert.actionType == 'CERTPASS2') {
            FuncCert.signFinCert(AuthFunc.certSignedData);
        } else if (FuncCert.actionType == 'CERTPASS') {
            FuncCert.checkProviderCert(AuthFunc.certSignedData);
        }
    }
	//인증서창 닫기
	, closeCertInfo : function() {
		window.shouldClose =  true;
		window.shouldCloseData = 'cancel';
	}	
	

});

var FuncSimpleAuth = ({
	clientIndex: '',
	typeIndex : '',
	action : '',
	token: '',
	rnd : '',
	msg : '',
	signedData : '',
	encPin : '',
	plainPin : '',
	getAction : '',
	displayTitle : '',
	moveUrl : '',
	/* 함수명 : SateToken 사설인증 함수
	 * clientIndex : 인증타입 (M: motp ,A: 앱인증 , P : 간편인증(PIN,Pattern,지문))
	 * typeIndex : 사설인증 타입 (PIN : pin , PATTERN : 패턴 , FACE : 페이스 , FINGER : 지문)
	 * action : 사용 구분 (LOGIN : 로그인용, AUTH : 인증용)
	 * token : 서버인증토큰
	 * msg : 메세지
	 * rnd : 랜덤값
	 * signedData : 전자서명값
	 * encPin : 서버용 pin
	 * plainPin : 네이티브용 pin
	 * getAction : 간편인증등록시 액션 JOIN
	 */
	init : function(){
		FuncSimpleAuth.clientIndex = '';
		FuncSimpleAuth.typeIndex = '';
		FuncSimpleAuth.action = '';
		FuncSimpleAuth.token = '';
		FuncSimpleAuth.rnd = '';
		FuncSimpleAuth.msg = '';
		FuncSimpleAuth.encPin = '';
		FuncSimpleAuth.plainPin = '';
	},
	pinGet : function(clientIndex, getAction, displayTitle, callback){
		FuncSimpleAuth.clientIndex = clientIndex;
		FuncSimpleAuth.getAction = getAction;
		FuncSimpleAuth.displayTitle = displayTitle;
		
		if (typeof callback === 'function') {
			FuncSimpleAuth.resultCallback = callback;
		}
		
		/** Token 발급전 PIN 번호 검증*/
		//NATIVE TASK : 간편인증 registerTokenBefore param 추가 (jumin , phone) _ 아리아 암호화
		SafeToken.registerTokenBefore(clientIndex, displayTitle, function(result) {
			FuncSimpleAuth.encPin = result.encPin;
			FuncSimpleAuth.plainPin = result.plainPin;
			FuncSimpleAuth.pinValidation();
		}, function(result) {
			console.log("error");
			console.log(result);
		});
	},
	pinValidation : function(){
		var param = {"encPin" : FuncSimpleAuth.encPin , "plainPin" : FuncSimpleAuth.plainPin}
		AjaxFunc.ajaxAsyncHtml(
			'/common/pinValidation.ajax'
			,param
			,function(result){
				var res = JSON.parse(result).result;
				var msg = JSON.parse(result).msg;
				if(res == true){
					FuncSimpleAuth.tokenIssue();
				}else if(res == false){
					customAlert({title : '알림', message:msg, btn_txt1:"다시 입력"}, '', function(){
						FuncSimpleAuth.pinGet(FuncSimpleAuth.clientIndex,FuncSimpleAuth.getAction,FuncSimpleAuth.displayTitle,FuncSimpleAuth.resultCallback);
					});
					return false;
				}
				return;
			},ajax_error
		); 
	},
	tokenIssue : function(){
		/** 등록전 Token 발급 */
		var param = {"clientIndex" :FuncSimpleAuth.clientIndex}
		
		AjaxFunc.ajaxAsyncHtml(
			'/common/doGetToken.ajax'
			,param
			,function(result){
				FuncSimpleAuth.token = JSON.parse(result).data.token;
				FuncSimpleAuth.registerToken();
				return;
			},ajax_error
		); 
	},
	registerToken : function(){
		SafeToken.registerTokenAfter(FuncSimpleAuth.clientIndex, FuncSimpleAuth.token, FuncSimpleAuth.plainPin , function(result){
			if(FuncSimpleAuth.clientIndex == 'M'){
				if(FuncSimpleAuth.getAction == "UNTACT"){ //csno 존재함
					var resultJson = {};
					resultJson.resultSuccess = true;
					resultJson.resultToken = FuncSimpleAuth.token;
					resultJson.resultMsg = result.resultMsg;
					FuncSimpleAuth.resultCallback(JSON.stringify(resultJson));
				} else {
					FuncSimpleAuth.mOTPSet("01",FuncSimpleAuth.token);
				}
			}else if(FuncSimpleAuth.clientIndex =='A'){
				FuncSimpleAuth.resultCallback();
			}else if(FuncSimpleAuth.clientIndex =='P'){
				//20220518 회원가입관련(간편등록 핀번호 등록완료시 ) 이벤트 추가
				FuncAdbrix.event('Main_Sign_Up_4_SimpleAuth_Pin');
				
				var displayTitle = "";
				if(FuncSimpleAuth.getAction=='JOIN') {
					displayTitle = {"title":"간편인증 등록","titleSub":"","step":"","contents":"신규 패턴 입력"}
				}else {
					displayTitle ={	"title":"간편인증 등록/재등록","titleSub":"패턴 등록" ,"step":"3/5","contents": "등록할 패턴을 입력해주세요."}
				}
				FuncSimpleAuth.registerPattern(FuncSimpleAuth.plainPin, displayTitle);
			}
		}, function(result){
			if(FuncSimpleAuth.clientIndex == 'M'){
				if(result.errCode == "9701"){
					showSplash();
					window.location = "/main.ysb";
				}else if(result.errCode == "9702"){
					showSplash();
					commonMoveUrl('move','/common/mOTPRegInfo.ysb');
				}else{
					customAlert({title: "알림", message: "[" + result.errCode +"] 다시 시도해주세요.", btn_txt1: '확인'});	
				}
			}else if(FuncSimpleAuth.clientIndex =='A'){
				if(result.errCode == "9701"){
					window.location = "/main.ysb";
				}else if(result.errCode == "9702"){
					if(FuncSimpleAuth.displayTitle.title == "추가인증서비스 가입"){
						showSplash();
						commonMoveUrl('move','/security/callRegAddAuthNotice.ysb');
					}else{
						showSplash();
						commonMoveUrl('move','/security/callDelAddAuth.ysb');
					}
				}else{
					customAlert({title: "알림", message: "[" + result.errCode +"] 다시 시도해주세요.", btn_txt1: '확인'});
				}
			}else if(FuncSimpleAuth.clientIndex =='P'){
				if(FuncSimpleAuth.getAction=='JOIN') {
					if(result.errCode == "9701"){
					}else{
						customAlert({title: "알림", message: "[" + result.errCode +"] 다시 시도해주세요.", btn_txt1: '확인'});
					}
				}else {
					if(result.errCode == "9701"){
						showSplash();
						window.location = "/main.ysb";
					}else if(result.errCode == "9702"){
						showSplash();
						commonMoveUrl('move','/common/info.ysb');
					}else{
						customAlert({title: "알림", message: "[" + result.errCode +"] 다시 시도해주세요.", btn_txt1: '확인'});
					}	
				}
			} else {
				customAlert({title: "알림", message: "[SI008] 다시 시도해주세요.", btn_txt1: '확인'});
			}
		});
	},
	registerPattern : function(plainPin, displayTitle){
		SafeToken.registerPattern('P', plainPin , displayTitle, function(result){
			if(FuncSimpleAuth.clientIndex != ''){
				// ======================== 회원가입 > 패턴 성공 ===========================
				if(FuncSimpleAuth.getAction=='JOIN') {
					if(FuncDeviceToken.getBioType() == 'FINGER'){
						displayTitle = { "title": "간편인증 등록","titleSub": "","step":"","contents":"지문 등록" };
						FuncSimpleAuth.registerBiometric(plainPin, displayTitle);
					}else if(FuncDeviceToken.getBioType() == "NULL") {
						
						//20220518 회원가입관련(간편등록 패턴 등록완료시 ) 이벤트 추가
						FuncAdbrix.event('Main_Sign_Up_4_SimpleAuth_Pattern');
						
						showSplash();
						window.location= "/join/completeJoin.ysb";
					}else{
						displayTitle ={ "title": "간편인증 등록","titleSub": "","step":"","contents":"페이스아이디 등록" };
						FuncSimpleAuth.registerBiometric(plainPin, displayTitle);
					}
				}else {
				// ====================== 간편비밀번호 최초등록 > 패턴 성공 =====================
					if(FuncDeviceToken.getBioType() == 'FINGER'){
						displayTitle ={	"title" : "간편인증 등록/재등록", "titleSub" : "지문 등록" , "step" : "4/5","contents" : "지문 등록" };
						FuncSimpleAuth.registerBiometric(plainPin, displayTitle);
					}else if(FuncDeviceToken.getBioType() == "NULL") {
						showSplash();
						FuncSimpleAuth.getAction = "REG";
						FuncSimpleAuth.moveUrl = "/common/simpleAuthRegFinish.ysb?type=0";
						FuncUserData.deviceInfoNeedCallBack = true;
						FuncUserData.callBackFunction = FuncSimpleAuth.deviceInfoCallBack;
						FuncUserData.getDeviceInfo();
					}else{
						displayTitle ={ "title" : "간편인증 등록/재등록", "titleSub" : "페이스아이디 등록" , "step" : "4/5","contents" : "페이스아이디 등록" };
						FuncSimpleAuth.registerBiometric(plainPin, displayTitle);
					}
				}
			}else{
				// ======================= 패턴 등록/변경시 > 패턴 성공 =======================
				showSplash();
				FuncSimpleAuth.getAction = "REG"
				FuncSimpleAuth.moveUrl = "/common/simpleAuthRegFinish.ysb?type=1";
				FuncUserData.deviceInfoNeedCallBack = true;
				FuncUserData.callBackFunction = FuncSimpleAuth.deviceInfoCallBack;
				FuncUserData.getDeviceInfo();
			}
		}, function(result){
			if(FuncSimpleAuth.clientIndex != ''){
					if(FuncSimpleAuth.getAction=='JOIN') {
						// ==================== 회원가입 > 패턴 건너뛰기 ========================
						if(FuncDeviceToken.getBioType() == "NULL") {
							showSplash();
							window.location= "/join/completeJoin.ysb";
						}else if(result.errCode == "9704"){
							if(FuncDeviceToken.getBioType() == 'FINGER'){
								displayTitle = { "title": "간편인증 등록","titleSub": "","step":"","contents":"지문 등록" }
							}else{
								displayTitle ={ "title": "간편인증 등록","titleSub": "페이스아이디 등록","step":"4/5","contents":"페이스아이디 등록" }
							}
							FuncSimpleAuth.registerBiometric(plainPin, displayTitle);
						}else{
							customAlert({title: "알림", message: "[" + result.errCode +"] 다시 시도해주세요.", btn_txt1: '확인'});
						}
					} else {
						// ================= 간편비밀번호 최초등록 > 패턴 건너뛰기 ==================
						if(result.errCode == "9704"){
							if(FuncDeviceToken.getBioType() == 'FINGER'){
								displayTitle ={	"title" : "간편인증 등록/재등록", "titleSub" : "지문 등록" , "step" : "4/6","contents" : "지문 등록" }
							}else{
								displayTitle ={ "title" : "간편인증 등록/재등록", "titleSub" : "페이스아이디 등록" , "step" : "4/6","contents" : "페이스아이디 등록" }
							}
							FuncSimpleAuth.registerBiometric(plainPin, displayTitle);
						}else if(result.errCode == "9701"){
						// ================= 간편비밀번호 최초등록 > 닫기버튼 클릭 ==================
							showSplash();
							window.location = "/main.ysb";
						}else if(result.errCode == "9702"){
						// ================= 간편비밀번호 최초등록 > 뒤로가기 버튼 클릭 ===============
							showSplash();
							commonMoveUrl('move','/common/info.ysb');
						}else{
							customAlert({title: "알림", message: "[" + result.errCode +"] 다시 시도해주세요.", btn_txt1: '확인'});
						}
					}
			}else{
				// ======================= 패턴 등록/변경시 > 패턴 실패 =======================
				customAlert({title: "알림", message: "[SI009] 다시 시도해주세요.", btn_txt1: '확인'});
			}
		});
	},
	registerBiometric : function(plainPin, displayTitle){
		SafeToken.registerBiometric('P', plainPin , displayTitle, function(result){
			if(FuncSimpleAuth.clientIndex != ''){	//간편비밀번호 최초등록 > 생체인증 성공
				if(FuncSimpleAuth.getAction=='JOIN') {
					
					//20220518 회원가입관련(간편등록 지문 or 페이스 등록완료시 ) 이벤트 추가
					if(displayTitle.contents.indexOf('지문') > -1){
						FuncAdbrix.event('Main_Sign_Up_4_SimpleAuth_Finger');
					} else if(displayTitle.contents.indexOf('페이스') > -1){
						FuncAdbrix.event('Main_Sign_Up_4_SimpleAuth_Face');
					} 
					
					showSplash();
					window.location= "/join/completeJoin.ysb";
				} else {
					showSplash();
					FuncSimpleAuth.getAction = "REG"
					FuncSimpleAuth.moveUrl = "/common/simpleAuthRegFinish.ysb?type=0";
					FuncUserData.deviceInfoNeedCallBack = true;
					FuncUserData.callBackFunction = FuncSimpleAuth.deviceInfoCallBack;
					FuncUserData.getDeviceInfo();
				}
			}else{									//지문 등록/변경시 > 생체인증 성공
					showSplash();
					FuncSimpleAuth.getAction = "REG"
					if(FuncDeviceToken.getBioType() == 'FINGER'){
						FuncSimpleAuth.moveUrl = "/common/simpleAuthRegFinish.ysb?type=2";
					}else {
						FuncSimpleAuth.moveUrl = "/common/simpleAuthRegFinish.ysb?type=3";
					}
					FuncUserData.deviceInfoNeedCallBack = true;
					FuncUserData.callBackFunction = FuncSimpleAuth.deviceInfoCallBack;
					FuncUserData.getDeviceInfo();
			}
		}, function(result){
			if(FuncSimpleAuth.clientIndex != ''){	//간편비밀번호 최초등록일때 > 생체인증 실패
				if(FuncSimpleAuth.getAction=='JOIN') {
						showSplash();
						window.location= "/join/completeJoin.ysb";
				} else {
					if(result.errCode == "9704"){
						showSplash();
						FuncSimpleAuth.getAction = "REG";
						FuncSimpleAuth.moveUrl = "/common/simpleAuthRegFinish.ysb?type=0";
						FuncUserData.deviceInfoNeedCallBack = true;
						FuncUserData.callBackFunction = FuncSimpleAuth.deviceInfoCallBack;
						FuncUserData.getDeviceInfo();
					}else if(result.errCode == "9701"){
						showSplash();
						window.location = "/main.ysb";
					}else if(result.errCode == "9702"){
						showSplash();
						commonMoveUrl('move','/common/info.ysb');
					}else{
						customAlert({title: "알림", message: "[" + result.errCode +"] 다시 시도해주세요.", btn_txt1: '확인'});
					}
				}
			}else{									//생체인증 등록/변경시 > 생체인증 실패
				customAlert({title: "알림", message: "[SI010] 다시 시도해주세요.", btn_txt1: '확인'});
			}
		});
	},
	mOTPSet : function(index, token){ //01 등록 , 03 해제
			param = {"index" :index , "token":token};
			AjaxFunc.ajaxAsyncHtml(
			'/common/doMotpSet.ajax'
			,param
			,function(result){
				var resultSuccess = JSON.parse(result).resultSuccess;
				if(resultSuccess) {
					if(index=='01'){
						showSplash();
						window.location="/common/mOTPRegFinish.ysb";
					}else if(index=='03'){
						showSplash();
						window.location="/common/mOTPDelFinish.ysb";
					}
					return;
				} else {
					var resultMsg = JSON.parse(result).resultMsg.split(",");
					customAlert({
						title: "알림 ["+resultMsg[0]+"]", 
						message: resultMsg[1], 
						btn_txt1: "닫기"
						}, function () {
						}, function(){
							commonMoveUrl('move',"/main.ysb");//닫기 누를시 수행됨
						}
					);
				}
			},ajax_error
		); 
	},
	auth : function(callback, clientIndex,typeIndex,action){
		if (typeof callback === 'function') {
			FuncSimpleAuth.resultCallback = callback;
		}
		FuncSimpleAuth.rndCreate(clientIndex,typeIndex,action);
	},
	motpAuth : function(displayTitle, callback){
		if (typeof callback === 'function') {
			FuncSimpleAuth.resultCallback = callback;
		}
		FuncSimpleAuth.displayTitle = displayTitle;
		FuncSimpleAuth.rndCreate('M', '', '');
	},	
	appAuth : function(callback){
		if (typeof callback === 'function') {
			FuncSimpleAuth.resultCallback = callback;
		}
		var displayTitle ={	"title"	: "스마트 앱인증 핀번호 입력" ,
				"titleSub"	: "" ,
				"step" 		: "",
				"contents"	: ""
		}
		FuncSimpleAuth.displayTitle = displayTitle;
		FuncSimpleAuth.rndCreate('A', '', '');
	},		
	
	rndCreate : function(clientIndex,typeIndex,action){
		/** 인증전 Random 발급 */
		FuncSimpleAuth.clientIndex = clientIndex;
		FuncSimpleAuth.typeIndex = typeIndex;
		FuncSimpleAuth.action = action;
		
		if(FuncSimpleAuth.clientIndex == 'M'){
			FuncSimpleAuth.msg = "YGRmopt";
		}else if(FuncSimpleAuth.clientIndex =='A'){
			FuncSimpleAuth.msg = "YGRsmartApp";
		}else if(FuncSimpleAuth.clientIndex =='P'){
			FuncSimpleAuth.msg = "YGRsimpleAuth";
		}

		var param = {}
		AjaxFunc.ajaxAsync(
			'/common/doGetRandom.ajax'
			,param
			,function(result){
				if(result.resultSuccess) {
					FuncSimpleAuth.rnd = result.data;
					FuncSimpleAuth.sign();
				} else {
					commonCodeErrorMsg(result.resultCode, result.resultMsg);
				}
				return;
			}
			,ajax_error
		);
	},
	sign : function(){
		if(FuncSimpleAuth.clientIndex == "P"){
			var displayTitle = "";
			if(FuncSimpleAuth.action=="LOGIN"){
				if(FuncSimpleAuth.typeIndex=="PIN"){
					displayTitle ={"title" : "간편인증 로그인" , "titleSub": "" , "step" : "", "contents": "간편비밀번호 로그인" };
				}else if(FuncSimpleAuth.typeIndex=="PATTERN"){
					displayTitle ={"title" : "패턴 로그인" , "titleSub": "" , "step" : "", "contents": "" };
				}else if(FuncSimpleAuth.typeIndex=="FINGER"){
					/*displayTitle ={ "title" : "지문 로그인" , "titleSub" : "" , "step" : "", "contents" : "로그인을 위해 손가락을 \n 지문인식 버튼에 올려주세요." };*/
					displayTitle ={ "title" : "지문 로그인" , "titleSub" : "" , "step" : "", "contents" : "지문인식 버튼에 올려주세요." };
				}else if(FuncSimpleAuth.typeIndex=="FACE"){
					/*displayTitle ={ "title" : "페이스아이디 로그인" , "titleSub" : "" , "step" : "", "contents" : "로그인을 위해 \n 페이스아이디영역을 터치해주세요." };*/
					displayTitle ={ "title" : "페이스아이디 로그인" , "titleSub" : "" , "step" : "", "contents" : "페이스아이디영역을 터치해주세요." };
				}
			}else if(FuncSimpleAuth.action=="AUTH"){
				if(FuncSimpleAuth.typeIndex=="PIN"){
					displayTitle ={ "title" : "간편인증 본인인증" , "titleSub" : "" , "step" : "", "contents" : "" };
				}else if(FuncSimpleAuth.typeIndex=="PATTERN"){
					displayTitle ={ "title"	: "패턴 본인인증" , "titleSub" : "" , "step" : "", "contents" : "" };
				}else if(FuncSimpleAuth.typeIndex=="FINGER"){
					/*displayTitle ={ "title" : "지문 본인인증" , "titleSub" : "" , "step" : "", "contents" : "본인인증을 위해 손가락을 \n 지문인식 버튼에 올려주세요." }*/
					displayTitle ={ "title" : "지문 본인인증" , "titleSub" : "" , "step" : "", "contents" : "지문인식 버튼에 올려주세요." }
				}else if(FuncSimpleAuth.typeIndex=="FACE"){
					/*displayTitle ={ "title" : "페이스아이디 본인인증" , "titleSub" : "" , "step" : "", "contents": "페이스아이디영역을 \n 터치해주세요." }*/
					displayTitle ={ "title" : "페이스아이디 본인인증" , "titleSub" : "" , "step" : "", "contents": "페이스아이디영역을 터치해주세요." }
				}
			}else if(FuncSimpleAuth.action=="REGPATTERN"){
				displayTitle ={ "title" : "패턴 등록/재등록" , "titleSub" : "간편비밀번호 인증" , "step" : "2/4", "contents": "사용중인 간편비밀번호 입력" }
			}else if(FuncSimpleAuth.action=="REGFINGER"){
				displayTitle ={ "title" : "지문 등록/재등록" , "titleSub" : "간편비밀번호 인증" , "step" : "2/4", "contents": "사용중인 간편비밀번호 입력" }
			}else if(FuncSimpleAuth.action=="REGFACE"){
				displayTitle ={ "title" : "페이스아이디 등록/재등록" , "titleSub" : "간편비밀번호 인증" , "step" : "2/4", "contents": "사용중인 간편비밀번호 입력" }
			}else if(FuncSimpleAuth.action=="DELFINGER"){
				displayTitle ={ "title" : "지문 해지" , "titleSub" : "간편비밀번호 인증" , "step" : "1/3", "contents" : "사용중인 간편비밀번호 입력" }
			}else if(FuncSimpleAuth.action=="DELFACE"){
				displayTitle ={ "title": "페이스아이디 해지" , "titleSub" : "간편비밀번호 인증" , "step" : "1/3","contents" : "사용중인 간편비밀번호 입력" }
			}
			FuncSimpleAuth.displayTitle = displayTitle;
		}
		if(FuncSimpleAuth.clientIndex == "M" || FuncSimpleAuth.clientIndex == "A" ){
			FuncSimpleAuth.typeIndex = "PIN";
		}
		hideSplash();
		SafeToken.sign(FuncSimpleAuth.clientIndex, FuncSimpleAuth.typeIndex, FuncSimpleAuth.msg, FuncSimpleAuth.rnd, FuncSimpleAuth.displayTitle, function(result){
			if(FuncSimpleAuth.clientIndex == 'M'){
				FuncSimpleAuth.signedData = result.signedData;
				FuncSimpleAuth.typeIndex = 'PIN';
				FuncAppChk.getAppironData('AUTH','motp', '');
			}else if(FuncSimpleAuth.clientIndex =='A'){
				FuncSimpleAuth.signedData = result.signedData;
				FuncSimpleAuth.typeIndex = 'PIN';
				FuncAppChk.getAppironData('AUTH','app', '');
			}else if(FuncSimpleAuth.clientIndex =='P'){
				FuncSimpleAuth.plainPin = result.plainPin;
				FuncSimpleAuth.signedData = result.signedData;
				switch(FuncSimpleAuth.action){
					case "LOGIN":
						if ( FuncSimpleAuth.typeIndex == 'PIN' ) {//핀
							FuncAppChk.getAppironData('LOGIN','pin', '');
						} else if ( FuncSimpleAuth.typeIndex == 'PATTERN' ) {//패턴
							FuncAppChk.getAppironData('LOGIN','pattern', '');
						} else if ( FuncSimpleAuth.typeIndex == 'FINGER' ) {//지문
							FuncAppChk.getAppironData('LOGIN','finger', '');
						} else if ( FuncSimpleAuth.typeIndex == 'FACE' ) {//페이스 아이디
							FuncAppChk.getAppironData('LOGIN','face', '');
						}
						break;
					case "AUTH":
						if ( FuncSimpleAuth.typeIndex == 'PIN' ) {//핀
							FuncAppChk.getAppironData('AUTH','pin', '');
						} else if ( FuncSimpleAuth.typeIndex == 'PATTERN' ) {//패턴
							FuncAppChk.getAppironData('AUTH','pattern', '');
						} else if ( FuncSimpleAuth.typeIndex == 'FINGER' ) {//지문
							FuncAppChk.getAppironData('AUTH','finger', '');
						} else if ( FuncSimpleAuth.typeIndex == 'FACE' ) {//페이스 아이디
							FuncAppChk.getAppironData('AUTH','face', '');
						}
						break;
					default : 
						FuncAppChk.getAppironData('AUTH','pin', '');
				}
			}
		}, function(result) {
			if(FuncSimpleAuth.clientIndex == 'M') {
				if(result.errCode == "9706"){ //motp 6자리 오류로 인한 에러
					customAlert({
						title: "알림",
						message: "mOTP 5회 오류로 서비스를 이용하실 수 없습니다. \n  mOTP를 재등록하시고 사용해주세요. \n mOTP를 재등록 하시겠습니까? ",
						type: 'confirm',
						btn_txt1: "취소",
						btn_txt2: "확인"}, 
						function () {
							showSplash();
							commonMoveUrl('move',"/common/mOTPRegInfo.ysb");
					}, function () {
					});
				}
			}else if(FuncSimpleAuth.clientIndex =='A'){
				if(result.errCode == "9706"){ //appAuth 6자리 오류로 인한 에러
					
				}
			}else if(FuncSimpleAuth.clientIndex =='P'){ //pin	
				if(result.errCode == "9706" || result.errCode == "9707" || result.errCode == "9700"){
					if(FuncSimpleAuth.typeIndex == "PIN"){
						customAlert({
							title: "알림",
							message: "간편비밀번호 5회 오류로 서비스를 이용하실 수 없습니다. \n 간편비밀번호를 재등록하시고 사용해주세요. \n 간편비밀번호를 재등록 하시겠습니까?",
							type: 'confirm',
							btn_txt1: "취소",
							btn_txt2: "확인"},
							function () {
								showSplash();
								commonMoveUrl('move',"/common/simpleAuthRegIntro.ysb");
						}, function () {
						});
					}else if(FuncSimpleAuth.typeIndex=="PATTERN"){
						customAlert({
							title: "알림",
							message: "패턴 5회 오류로 서비스를 이용하실 수 없습니다. \n 패턴을 재등록하시고 사용해주세요. \n 패턴을 재등록 하시겠습니까?",
							type: 'confirm',
							btn_txt1: "취소",
							btn_txt2: "확인"},
							function () {
								showSplash();
								commonMoveUrl('move',"/common/simpleAuthRegInfo.ysb?type=1");
						}, function () {
							
						});
					}
				}else if(result.errCode == "-20005" || result.errCode == "9708"){ //지문,FaceID 재등록한 경우
					var loginType='';
					if(FuncSimpleAuth.typeIndex=="FINGER"){
						loginType = 'FINGER';
					}else{
						loginType = 'FACE';
					}
					customAlert({
						title: "알림",
						message: "지문/Face ID 정보가 변경되었습니다. \n지문/Face ID 등록을 다시 해주세요. \n서비스에 등록하시겠습니까?\n서비스 등록은 로그인 후 진행됩니다.",
						type: 'confirm',
						btn_txt1: "취소",
						btn_txt2: "확인"}, 
						function () {
							FuncUserData.saveUserLoginWay('pin');
							pinLoginAction(loginType);
					}, function () {
					});
					
				}
			}
		})
	},
	deleteToken : function(clientIndex,typeIndex,displayTitle,callback){
		FuncSimpleAuth.clientIndex = clientIndex;
		FuncSimpleAuth.typeIndex = typeIndex;
		if (typeof callback === 'function') {
			AuthFunc.resultCallback = callback;
		}
		SafeToken.deleteToken(clientIndex, typeIndex, displayTitle , function(result){
			if(clientIndex == 'M'){
				AuthFunc.resultCallback();
			}else if(clientIndex =='A'){
				AuthFunc.resultCallback();
			}else if(clientIndex =='P'){
				if(typeof callback === 'function'){
					AuthFunc.resultCallback();
					return;
				}
				FuncSimpleAuth.getAction = "DEL";
				FuncUserData.deviceInfoNeedCallBack = true;
				FuncUserData.callBackFunction = FuncSimpleAuth.deviceInfoCallBack;
				
				if (typeIndex == 'PIN') {				//핀
					showSplash();
					FuncSimpleAuth.moveUrl = "/common/simpleAuthDelFinish.ysb?type=0";
					FuncUserData.getDeviceInfo();
				} else if (typeIndex == 'PATTERN' ) {	//패턴
					showSplash();
					FuncSimpleAuth.moveUrl = "/common/simpleAuthDelFinish.ysb?type=1";
					FuncUserData.getDeviceInfo();
				} else if (typeIndex == 'FINGER' ) {		//지문
					showSplash();
					FuncSimpleAuth.moveUrl = "/common/simpleAuthDelFinish.ysb?type=2";
					FuncUserData.getDeviceInfo();
				} else if (typeIndex == 'FACE' ) {		//페이스
					showSplash();
					FuncSimpleAuth.moveUrl = "/common/simpleAuthDelFinish.ysb?type=3";
					FuncUserData.getDeviceInfo();
				}else {
				}
			}
			FuncSimpleAuth.init();
		}, function(result){

			if(FuncSimpleAuth.clientIndex == 'M'){
				customAlert({title: "알림", message: "mOTP 삭제를 실패했습니다", btn_txt1: '확인'});
			}else if(FuncSimpleAuth.clientIndex =='A'){
				customAlert({title: "알림", message: "스마트앱 삭제를 실패했습니다", btn_txt1: '확인'});
			}else if(FuncSimpleAuth.clientIndex =='P'){
				customAlert({title: "알림", message: "간편인증 삭제를 실패했습니다", btn_txt1: '확인'});
			}
		})
	}, 
	deviceInfoCallBack : function(data){
		AjaxFunc.ajaxAsync(
				'/common/simpleAuthCsno.ajax'
				, ""
				, function(csno){
					if(csno != null) FuncSimpleAuth.getTokenInfo("P",csno,FuncSimpleAuth.tokenInfoCallBack); 
				}
				, ajax_error
			);
	},
	tokenInfoCallBack : function(type, result){
		if(FuncSimpleAuth.getAction=='DEL'){
			FuncSimpleAuth.tokenSet("03",FuncUserData.deviceEncData, "");
		}else if(FuncSimpleAuth.getAction=='REG'){
			FuncSimpleAuth.tokenSet("01",FuncUserData.deviceEncData, "");
		}
	},
	tokenSet : function(TRMN_TRN_DVCD, deviceInfo, action){
		if(action == "JOIN"){
			FuncSimpleAuth.getAction = "JOIN"
		}
		/** 간편비밀번호 인증 관리 */		
		var param = {	"TRMN_TRN_DVCD" : TRMN_TRN_DVCD,	//01:등록, 03:해제
						"deviceInfo" 	: deviceInfo,
						"PIN_USE_YN"	: FuncDeviceToken.getIsExistPinCsno(),				//디바이스 핀 사용여부
						"BIO_ATHN_USE_YN":  FuncDeviceToken.getIsExistFingerCsno(),		//디바이스 생체인증 여부
						"FRMN_ATHN_USE_YN":  FuncDeviceToken.getIsExistPatternCsno(),		//디파이스 패턴인증 여부
					}
		AjaxFunc.ajaxAsync(
			'/common/doSimplepAuthSet.ajax'
			,param
			,function(result){
				if(result.resultSuccess) {
					if(FuncSimpleAuth.getAction != 'JOIN') {
						showSplash();
						
						var form = $('<form></form>');
						form.attr('action',FuncSimpleAuth.moveUrl);
						form.attr('method',"post");
						form.appendTo('body');
						var name = $('<input type="hidden" value="'+result.data.name+'" name="name">');
						form.append(name);
						form.submit();
						
					}
				} else commonCodeErrorMsg(result.resultCode, result.resultMsg);
				return;
			}
			,ajax_error
		); 
	}, 
	getTokenInfo : function(type, sessionCsno ,callback){
		if (typeof callback === 'function') {
			FuncSimpleAuth.resultCallback = callback;
		}
		if (getOsType() == 'pc') {
		}else{
			SafeToken.getTokenInfo(type, function(result) {
				if(sessionCsno == ""){
					FuncDeviceToken.setIsExistPinCsno(false);
					FuncDeviceToken.setIsExistPatternCsno(false);
					FuncDeviceToken.setIsExistFingerCsno(false);
					FuncDeviceToken.setIsExistFaceCsno(false);
					FuncDeviceToken.setBioType(result.bioType);
				}else if(type=="M"){
					if(result.isExistToken){
						var csno = result.uid.split("$")[3].split("#")[0];
						if(csno == sessionCsno ) FuncDeviceToken.setIsExistMotpCsno(result.bindPin);
						else FuncDeviceToken.setIsExistMotpCsno(false);
					}else FuncDeviceToken.setIsExistMotpCsno(false);
					if(callback != ''){
						FuncSimpleAuth.resultCallback(result);
					}
				}else if(type =="A"){
					if(result.isExistToken){
						var csno = result.uid.split("$")[3].split("#")[0];
							if(csno == sessionCsno) FuncDeviceToken.setIsExistAppAuthCsno(result.bindPin);
							else FuncDeviceToken.setIsExistAppAuthCsno(false);
					}else FuncDeviceToken.setIsExistAppAuthCsno(false);
					if(callback != ''){
						FuncSimpleAuth.resultCallback(result);
					}
				}else{
					if(result.bindPin){
						var csno = result.uid.split("$")[3].split("#")[0];
						if(!UtilFunc.isEmpty("${LOGIN_SESSION}")||!UtilFunc.isEmpty("${SESSION_JOIN_USERINFO}")){	//로그인했을때
							if(csno == sessionCsno){
								FuncDeviceToken.setIsExistPinCsno(result.bindPin);
								FuncDeviceToken.setIsExistPatternCsno(result.bindPattern);
								FuncDeviceToken.setBioType(result.bioType);
								
								if(result.bioType=="FINGER"){
									FuncDeviceToken.setIsExistFingerCsno(result.bindBiometric);
									FuncDeviceToken.setIsExistFaceCsno(false);
								}else{ //페이스일때
									FuncDeviceToken.setIsExistFingerCsno(false);
									FuncDeviceToken.setIsExistFaceCsno(result.bindBiometric);
								}
								
							}else { //토큰정보와 사용자아이디가 불일치할때
								FuncDeviceToken.setIsExistPinCsno(false);
								FuncDeviceToken.setIsExistPatternCsno(false);
								FuncDeviceToken.setIsExistFingerCsno(false);
								FuncDeviceToken.setIsExistFaceCsno(false);
								FuncDeviceToken.setBioType(result.bioType);
							}
						}
					}else{	//토큰 없을때
						FuncDeviceToken.setIsExistPinCsno(false);
						FuncDeviceToken.setIsExistPatternCsno(false);
						FuncDeviceToken.setIsExistFingerCsno(false);
						FuncDeviceToken.setIsExistFaceCsno(false);
						FuncDeviceToken.setBioType(result.bioType);
					}
					if(callback != ''){
						FuncSimpleAuth.resultCallback(type, result);
					}
				}
			}, function(result) {
				FuncSimpleAuth.resultCallback(result);
			});
		}
	}, loginWayToken : function(callback){
		
		if (typeof callback === 'function') {
			FuncSimpleAuth.resultCallback = callback;
		}
		
		if (getOsType() == 'pc') {
			var result = {"bindPin" : false , "bindPattern" : false , "bindBiometric" : false }
			FuncSimpleAuth.resultCallback(result);
		}else{
			SafeToken.getTokenInfo("P", function(result) {
				FuncSimpleAuth.resultCallback(result);
			} ,function(result) {
				FuncSimpleAuth.resultCallback(result);
			});	
		}
	}
});

/**
 * ARS 인증 공통기능 
 */
var ArsAuthFunc = {
	actionType : '',
	subActionType : '',
	userId : '',
    showAuthPop: function (authType, actionType, subActionType, callback) {//인증레이어 팝업실행
    	ArsAuthFunc.actionType = actionType;
    	ArsAuthFunc.subActionType = subActionType;
    	if (authType == 'ars' || authType == 'arsonly') {
    		AuthFunc.showAuthPop(authType, callback);
    	}
    }	    
};

/**
 * GET UUID 
 */
var FuncUUID = {
	getUUID: function () {//인증레이어 팝업실행
		if (getOsType() == 'pc') {
			return "tempPCUUID";
		}else if(getOsType()  == "and"){
			return android.getUUID();		
		}else if(getOsType()  == "ios"){
			return "tempIOSUUID";
		}
	}
};

function closeAuthPopAction() {
	closePopup('certi');
	$("#certi").html("");
}

function pinLoginAction(loginType) {
	var tNowCheckVal = window.localStorage.getItem("LOGIN_WAY");
	
	if (tNowCheckVal == 'null') {
		customAlert({
			title: "알림",
			message: "로그인 방법을 선택하지 않으셨습니다.\n변경사항 없이 종료 하시겠습니까? ",
			type: 'confirm',
			btn_txt1: "취소",
			btn_txt2: "이동"}, 
			function () {
				window.location= '/login/login.ysb';
				}, function () {

		});		
	} else {
		var firstDeviceId = window.localStorage.getItem("FIRST_DEVICE_ID");
		var afterUrl = '';
		
		if('FINGER' == loginType){
			afterUrl = '/common/simpleAuthRegInfo.ysb?type=2';
			window.localStorage.setItem("IS_EXIST_FINGER_CSNO", false);
		}else{
			afterUrl = '/common/simpleAuthRegInfo.ysb?type=3';
			window.localStorage.setItem("IS_EXIST_FACE_CSNO", false);
		}
		
		window.location = '/login/login.ysb?LOGIN_WAY='+tNowCheckVal+'&AFTER_URL='+afterUrl+'&FIRST_DEVICE_ID='+firstDeviceId;
	}
}