/**
 * biz_common.js
 */
// 전역변수 ******************************************************************************************
var ACTIVE_MODE = $('#biz_common').attr("data-activeMode"); 					  // 환경구분 local test prod
var ACTIVE_ENV  = $('#biz_common').attr("data-activeEnv"); 					  	  // 실행환경 APP WEB
var SERVICE_CD  = $('#biz_common').attr("data-serviceCd");   			  		  // 서비스코드
var MENU_ID     = $('#biz_common').attr("data-menuId");  	  			  		  // 메뉴ID
var FRAME_ID    = $('#biz_common').attr("data-frameId");  	  			  		  // 화면ID
var SERVER_TIME = $('#biz_common').attr("data-serverTime");  			  		  // 서버시각
var HOST_URL    = $(location).attr('protocol') + "//" + $(location).attr('host'); // 현재 호스트 URL
//****************************************************************************************************
var PAGE_RELOAD_YN = "Y"; // 뒤로가기 시 페이지를 유지해야하는경우 N으로 변경 
window.onpageshow = function(e) {
	if (e.persisted) {
		if (PAGE_RELOAD_YN == "Y") {
			window.location.reload();
		} else {
			progressBar(false);
		}
	}
}
function isLocalServer() {
	return ("local" == ACTIVE_MODE)
}
function isDevServer() {
	return ("test" == ACTIVE_MODE)
}
function isRealServer() {
	return ("prod" == ACTIVE_MODE)
}

$.fn.serializeObject = function () {
  'use strict';
  var result = {};
  var extend = function (i, element) {
    var node = result[element.name];
    if ('undefined' !== typeof node && node !== null) {
      if ($.isArray(node)) {
        node.push(element.value);
      } else {
        result[element.name] = [node, element.value];
      }
    } else {
      result[element.name] = element.value;
    }
  };

  $.each(this.serializeArray(), extend);
  return result;
};

//****************************************************************************************************
//1. Description : 오류메시지 처리 
//2. Parameters : String mesg
//****************************************************************************************************
function errMsg(msg) {
	if (typeof(msg) == 'undefined' || msg == '') {
		biz.alert('처리중 오류가 발생하였습니다');
	} else if (msg.indexOf("ECB") > -1){
		var msgArry = msg.split(",");
		var reMsg = "";
		for (var i=0; i < msgArry.length; i++) {
			if (i == 0) continue;
			reMsg = reMsg + msgArry[i];
		}
		biz.alert(reMsg);
	} else {
		biz.alert(msg);
	}
}

//****************************************************************************************************
//1. Description : RESTFul API 호출 
//2. Parameters : String serviceCd, Form Object, function callback
//3. Return Type : Call Back
//4. progressFlag : true, false
//****************************************************************************************************
function doAction(serviceCd, srcForm, callbackFunc, progressFlag) {
	var progressBarOn = true;
	if (typeof(progressFlag) != "undefined") progressBarOn = progressFlag;
	
	var url = serviceCd + ".act";
	var data;
	if (isFormObject(srcForm)) {
		data = srcForm.serializeObject();	
	} else {
		data = srcForm;
	}
	
	$.ajax({
		 url: HOST_URL + "/" + url
		,type : 'POST'
		,accept: "application/json"
		,contentType: "application/json; charset=utf-8"
		,async : true
		,cache : false
		,headers : {
			 "Content-Type":"application/json; charset=UTF-8"
		}
		,dataType: "json"
		,data : JSON.stringify(data)
		,beforeSend : function (xhr, opts) {
			if (false) {
	            xhr.abort(); // submit Cancel
	        }
			if (progressBarOn) progressBar(true);
		}
		,success: function(resDs){
			if (resDs.APP_HEADER.errYn == "Y") {
				/*
				E90000=본인인증 후 이용 가능한 거래입니다.
				E90001=로그인 후 이용 가능한 거래입니다.
				E90002=전자금융 가입 후 이용 가능한 거래입니다.
				E90003=계좌개설 후 이용 가능한 거래입니다.
				*/
				switch (resDs.APP_HEADER.respCd) {
				case "E90000":
					biz.confirm(resDs.APP_HEADER.respMsg, function(){
						biz.login(function(resDs){
							doReload();
						});
					}, goMainPage, "로그인", "홈으로");
					
					break;
				case "E90001":
					biz.confirm(resDs.APP_HEADER.respMsg, function(){
						biz.login(function(resDs){
							doReload();
						});
					}, goMainPage, "로그인", "홈으로");
					
					break;
				case "E90002":
					// biz.confirm("컨펌문구:필수", "확인펑션", "거절펑션:선택", "확인버튼문구:선택", "거절버튼문구:선택");
					biz.confirm(resDs.APP_HEADER.respMsg, function(){
						biz.usrIdReg('Y', function(){
							doReload();
						});	
					}, goMainPage, "가입하기", "홈으로");
					
					break;
				case "E90003":
					biz.alert(resDs.APP_HEADER.respMsg, "확인", goMainPage);
					break;
				default:
					callbackFunc(resDs);
					break;
				}
				
			} else {
				callbackFunc(resDs);	
			}
		}
		,error: function(request, status, error){
			biz.alert("처리 중 오류가 발생하였습니다. ["+error+"]");
		}
		,complete: function(xhr, status) {
			if (progressBarOn) progressBar(false);
		}
	});
}

//****************************************************************************************************
//1. Description : Form Object 여부 반환 
//2. Parameters : Object 
//3. Return Type : boolean
//****************************************************************************************************
function isFormObject(obj) {
	try {
		if ((obj[0]+"").indexOf("HTMLFormElement") > -1) {
			return true;
		} else {
			return false;
		}
	} catch (e) {
		return false;
	}
}

//****************************************************************************************************
//1. Description : JSP 호출 (동기)
//2. Parameters : String menuId, Object srcForm 
//3. Return Type : void
//****************************************************************************************************
function doActionFrame(menuId, srcForm) {
	setTimeout(function(){progressBar(true);}, 100);
	if (typeof(srcForm) == "undefined") srcForm = makeForm("srcForm");
	var reqForm = copyForm(srcForm);
	var url = HOST_URL + "/" + menuId + ".frm";
	reqForm.attr("action", url);
	reqForm.attr("method", 'POST');
	reqForm.appendTo($(document.body));
	reqForm.submit();
}

//****************************************************************************************************
//1. Description : 메뉴호출
//2. Parameters : String menuId, String linkAct 
//3. Return Type : void
//****************************************************************************************************
function doActionMenu(menuId, linkAct) {
	progressBar(true);
	var reqForm = makeForm("menuForm");
	if (typeof(linkAct) != 'undefined') {
		addFormData(reqForm, "LINK_ACT", linkAct);	
	}
	var url = HOST_URL + "/" + menuId + ".frm";
	reqForm.attr("action", url);
	reqForm.attr("method", 'POST');
	reqForm.appendTo($(document.body));
	reqForm.submit();
}

//****************************************************************************************************
//1. Description : 파일다운로드
//2. Parameters : 
//3. Return Type : void
//****************************************************************************************************
function doActionDownload(reqForm) {
	doAction("ETC_MNG", reqForm, function(resDs){
		if (resDs.SUCC_YN == 'Y') {
			var fileByte = resDs.FILE_BYTE;	// 파일 byte
			var fileExt = resDs.FILE_EXT;	// 파일 확장자
			var fileName = resDs.FILE_NAME; // 파일명
			var fileType = "";				// 파일타입
			// image/jpeg image/png application/pdf application/zip
			/*
			 * jpg jpeg png - image/jpeg image/png
			 * doc - application/msword
			 * pdf - application/pdf
			 * zip - application/zip
			 */
			switch (fileExt) {
			case "jpg":
			case "jpeg":
				fileType = "image/jpeg";
				break;
			case "png":
				fileType = "image/png";
				break;
			case "doc":
				fileType = "application/msword";
				break;
			case "pdf":
				fileType = "application/pdf";
				break;
			case "zip":
				fileType = "application/zip";
				break;	
			default:
				break;
			}
			var link = document.createElement('a');
			link.setAttribute('download', fileName);
			//todo download는 임시로 박아둔거임 추후 해제 해야함
			link.href = "/download" + resDs.SAVED_PATH +"/"+ resDs.SAVED_FILE_NAME;
			document.body.appendChild(link);
			link.click();  
			link.remove();
		}
	});
}


//****************************************************************************************************
//1. Description : JSP 호출 (동기)
//2. Parameters : String menuId, Object srcForm 
//3. Return Type : void
//****************************************************************************************************
function doActionURL(url) {
	progressBar(true);
	location.href = HOST_URL + "/" + url;
}

//****************************************************************************************************
//1. Description : 로그아웃
//2. Parameters :  
//3. Return Type : void
//****************************************************************************************************
function doLogout() {
	var logoutForm = makeForm("logoutForm");
	addFormData(logoutForm, "txGbnCd", "O");
	doAction("LOGIN_MNG", logoutForm, function(resDs){
		goMainPage();
	});
}


//****************************************************************************************************
//1. Description : form data copy
//2. Parameters :Object form 
//3. Return Type : Object form
//****************************************************************************************************
function copyForm(srcForm) {
	var reqForm = srcForm.clone();
	var selects = srcForm.find("select");
	selects.each(function(i) {
		reqForm.find("select").eq(i).val($(this).val());
	});
	return reqForm;
}

//****************************************************************************************************
//1. Description : form 객체생성
//2. Parameters : String formId 
//3. Return Type : Object Form
//****************************************************************************************************
function makeForm(formId) {
	var newForm =  $('<form>', {
		'id' : formId
		,'name' : formId
		,'method' : 'POST'
	});
	return newForm;
}
//****************************************************************************************************
//1. Description : form 객체에 데이터 추가
//2. Parameters : Object form, String name, String value 
//3. Return Type : void
//****************************************************************************************************
function addFormData(form, name, value) {
	var inputField;
	if (typeof($("input[name="+name+"]", form).val()) == 'undefined') {
		inputField = $("<input>").attr("type", "hidden").attr("name", name).val(value);	
		$(form).append($(inputField));
	} else {
		$("input[name="+name+"]", form).val(value);
	}
}

//****************************************************************************************************
//1. Description : 메인페이지 이동
//2. Parameters : 
//3. Return Type : 
//****************************************************************************************************
function goMainPage() {
	doActionFrame("main");
}

//****************************************************************************************************
//1. Description : 화면 새로고침
//2. Parameters : 
//3. Return Type : 
//****************************************************************************************************
function doReload() {
	setTimeout(function(){progressBar(true);}, 100);
	setTimeout(function(){
		location.reload();	
	}, 200);
}

//****************************************************************************************************
//1. Description : 프로그래스바 Layer 호출
//2. Parameters : String flag (true, false)
//3. Return Type : 
//****************************************************************************************************
function progressBar(flag, message) {
	
	if (flag) {
		if ($("#loading").css('display') == "block" || $("#loading02").css('display') == "block") return;
	}
	$("#loading").css('display', 'none');
	$("#loading02").css('display', 'none');
	
	if (flag) {
		if (typeof(message) == "undefined") {
			$("#loading").css('display', 'block');
		} else {
			$("#loading02Txt").html(message);
			$("#loading02").css('display', 'block');
		}
	}
}

//****************************************************************************************************
//1. Description : 컨펌 메시지 Layer 호출
//2. Parameters : String 메시지
//3. Return Type : boolean
//****************************************************************************************************
function confirmView(message, agreeFunc, disAgreeFunc) {
	if (confirm(message)) {
		agreeFunc();
	} else {
		disAgreeFunc();
	}
}

//****************************************************************************************************
//1. Description : Layer 호출 
//2. Parameters : 
/*
		{
			 id : "id"						// 화면 내 중복되지 않는 ID
			,title : "레이어 제목"				// 레이어 상단 제목
			,type : "FULL"					// 레이어 타입 HALF FULL 
			,url : "호출 layer url"			// 레이어 호출 URL 
			,etc : "기타정보"					// 기타 레이어로 전달할 데이터 키|값 추가 가능
			,callback : "레이어 완료시 받을 콜백펑션"	// 레이어 완료 시 전달받을 콜백
			,closeBtn : true | false 		// 닫기버튼
			,cancelBtn : true | false 				// 취소버튼
			,cancelFunc : "레이어 취소, 그만하기 시 호출할 콜백" 	// 취소버튼 클릭 시 호출 될 콜백 (전달인자 없음)
		}
*/
//3. Return Type : Call Back
//****************************************************************************************************
function doOpenLayer(param) {
	var id = param.id;		// 호출 ID 호출 시 고유 값
	var type = param.type; 	// FULL, DEFAULT
	var title = param.title	// 레이어 타이틀
	var url = "/common/layer/" + param.url + ".frm"; // 호출 layer url
	var callback = param.callback;
	var closeBtn = param.closeBtn; 	// 닫기버튼 여부 boolean 
	var cancelBtn = param.cancelBtn; 	// 취소버튼 여부 boolean
	
	// type 타입따라 대상 레이어 분기
	var targetId = (type == "") ? "layer" : "lyFullPopup"; // ID 확인
	
	var loadParam = {};
	$.each(param, function(k, v){
		if (typeof(v) == "string") {
			loadParam[k] = v;
		}
	});
	// url, data, 콜백처리할 함수도 인자로 받아서 success 에서 배치하도록
	$("#"+targetId).load(url, loadParam, function(){

		// 완료 시 콜백 처리
		eval(id + "_Func").callback = function(data) {
			callback(data);
			$("#"+targetId).hide();
		}
		// 닫기버튼 이벤트 처리
		if (closeBtn) {
			eval(id + "_Func").close = function(){
				$("#"+targetId).hide();		
			}
		}
		// 취소버튼 이벤트 처리
		if (cancelBtn) {
			eval(id + "_Func").cancel = function() {
				$("#"+targetId).hide();
				param.cancelFunc();
			}	
		}
		
		$("#"+targetId).show();
	});
}

//****************************************************************************************************
//1. Description : 필수값 체크
//2. Parameters : 
//3. Return Type : boolean
//****************************************************************************************************
function allCheck(layerId){
	var btnFlag = false;
	var validTarget = null;
	if(typeof(layerId) !== "undefined"){
		validTarget = $("."+layerId+"_validChk");
	} else {
		validTarget = $(".validChk");
	}
	$.each(validTarget , function(idx,obj) {
        var thisVal = obj.value;
        var isChecked = $(obj).prop("checked");
	    if(obj.type == "checkbox" &&  isChecked == false){
	    	btnFlag = false;
	    	return false;
	    } else if(obj.type != "checkbox" && (thisVal == undefined || thisVal == "" || thisVal == "0" )) {
	    	btnFlag = false;
	    	return false;
	    } else {
	    	btnFlag = true;
	    }
	});
	return btnFlag;
}

//****************************************************************************************************
//1. Description : 하단 버튼 활성화
//2. Parameters : 
//3. Return Type : boolean
//****************************************************************************************************
function validChk(layerId) {
	
	
	// 버튼컨트롤
	var validBtn = null;
	if(typeof(layerId) !== "undefined"){
		validBtn = $("#"+layerId+"_procBtn");
	} else {
		validBtn = $("#procBtn");
	}
	
	if(allCheck(layerId)) {
		validBtn.removeClass("disabled");
	} else {
		if (!validBtn.hasClass("disabled")) validBtn.addClass("disabled");
	}
}

//****************************************************************************************************
//1. Description : 인풋항목 scroll 및 focus
//2. Parameters : 
//3. Return Type : boolean
//****************************************************************************************************
function inputFocus(obj) {
	// hidden필드의 경우 라벨에 포커싱
	if($(obj).attr("type") == "hidden"){
		obj = $("label[for='"+$(obj).attr('id')+"']");
	} 
	
	$(obj).focus();
	
	// 레이어의 경우 스크롤 기준 재정의
	/*
	var scrollBody = null;
	if($(obj).parents().hasClass("layerpopup")){
		scrollBody = $(obj).parents(".layerpopup");
	} else {
		scrollBody = $('html, body');
	}
	
	scrollBody.animate({scrollTop: $(obj).offset().top - 80}, 400, function(){
		$(obj).focus();
	});
	*/
}

//****************************************************************************************************
//1. Description : 하단버튼 클릭시 최종 validation check
//2. Parameters : validChk 갯수
//3. Return Type : boolean
//****************************************************************************************************
function finalValidChk(layerId){
	var errlab = "";	// 에러메세지
	var errObj;			// 에러포커싱객체
	

	var validTarget = null;//유효성체크타켓
	if(typeof(layerId) !== "undefined"){
		validTarget = $("."+layerId+"_validChk");
	} else {
		validTarget = $(".validChk");
	}
	
	// error클래스 일괄 비활성화
	removeErr();
	
	// 유효성체크 반복부
	$.each(validTarget , function(idx,obj) {
        var thisVal = obj.value;
        var isChecked = $(obj).prop("checked");
        
        // 약관 checkbox
	    if(obj.type == "checkbox" &&  isChecked == false){
	    	if (errlab == "") {
		    	errObj = $(obj);
		    	errlab = "필수약관에 동의해주세요";
	    	}
	    } 
	    
	    // 그외 input
	    if(obj.type != "checkbox" && UtilFunc.isNull(thisVal)) {
	    	// 얼럿 에러메세지 세팅
	    	if (errlab == "") {
	    		console.log(obj);
    			errObj = $(obj);
	    		if (UtilFunc.isNull(obj.placeholder)) {
	    			var labelText = $("label[for='"+obj.id+"']").text();
	    			if (UtilFunc.isNull(labelText)) {
	    				errlab = "필수 항목을 선택해 주십시오.";
	    			} else {
	    				errlab = labelText +" 항목을 선택해 주십시오.";	    				
	    			}
	    		} else {
	    			errlab = obj.placeholder;
	    		}
			}
	    	// error클래스 활성화
	    	$("#"+obj.id).closest(".form-wrap").addClass("error");
	    }
	});
	
	// 미입력항목여부 체크 후 포커싱
	if ($(".form-wrap").hasClass("error") || !UtilFunc.isNull(errlab) ){
		biz.alert( errlab, "닫기", function () {
			inputFocus(errObj);
		});
		return false;
		
	} else {
		return true;
	}
	
}

//****************************************************************************************************
//1. Description : error클래스 일괄 비활성화
//2. Parameters : 
//3. Return Type : 
//****************************************************************************************************
function removeErr(obj){
	if (obj != undefined) {
		// 해당 객체만 비활성화
		var wrapObj = obj.closest(".form-wrap");
		var nowClass = wrapObj.className;
		if(nowClass == undefined) {
			if (wrapObj.hasClass("error")){
				wrapObj.removeClass("error");
			}
		} else {
			if (nowClass.indexOf("error") != -1){
				var removeClass = nowClass.replace("error","");
				wrapObj.className = removeClass;				
			}			
		}
	} else {
		// 일괄 비활성화
		if ($(".form-wrap").hasClass("error")) $(".form-wrap").removeClass("error");			
	}
}


function inputAmtKeyup(obj){
	$(obj).keyup(function(){
		var totalAmount = UtilFunc.getOnlyNumber($(this).val());
		if(totalAmount == undefined){
			totalAmount = 0;
		} else {
			totalAmount = Number(totalAmount);
		}
		$(obj).val(calcFunc.addComma(totalAmount.toString()));
	});
}

//****************************************************************************************************
//1. Description : 잔액표기 라디오 체크
//2. Parameters : 
//3. Return Type : 
//****************************************************************************************************
function amtDisplay(obj){
	if ($(obj).prop("checked")){
		$(".amount-on").css("display","block");
		$(".amount-off").css("display","none");			
	} else {
		$(".amount-on").css("display","none");
        $(".amount-off").css("display","block");
	}
}

//****************************************************************************************************
//1. Description : cookie 등록, 조회, 삭제
//2. Parameters : String id, String val 
//3. Return Type : void
//****************************************************************************************************
function setCookie(id, val) {
	$.cookie(id, val);
}
function getCookie(id) {
	return $.cookie(id);
}
function removeCookie(id) {
	$.removeCookie(id);
}