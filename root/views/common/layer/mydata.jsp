<%@page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
var MYDATA_REQ_LIST = {
		"MinWon":""
	   ,"NHIS_1":""
	   ,"NHIS_2":""
	};
var ${reqDs.id}_Func = ({
	// 닫기  
	close : function(){},
	// 취소 (그만하기)
	cancel : function(){},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(data){
		// 응답데이터
		var mydataResJson = {
		    "SUCC_YN":data
		   ,"MinWon":$("#MYDATA_RES_MinWon").val()
		   ,"NHIS_1":$("#MYDATA_RES_NHIS_1").val()
		   ,"NHIS_2":$("#MYDATA_RES_NHIS_2").val()
		};
		${reqDs.id}_Func.callback(mydataResJson);	
	},
	// 호출 화면 콜백 처리	
	callback : function(){},
	mydataReq : function() {
		
		$("#mydata_icon_stop").hide();
		$("#mydata_icon_start").show();
		progressBar(true);
		var reqIdx = 0;
		$.each(MYDATA_REQ_LIST, function(k, v){
			if (v != 'Y') {
				var myDataReqForm = makeForm("myDataReqForm"+(reqIdx++));
				addFormData(myDataReqForm, "REQ_TYCD", k);
				doAction("MYDATA_SELECT", myDataReqForm, fnMyDataRes, false);	
			}
		});
	}
});

function fnMyDataRes(data) {
	MYDATA_REQ_LIST[data.REQ_TYCD] = data.SUCC_YN;
	if ("Y" == data.SUCC_YN) {
		$("#mydata_"+data.REQ_TYCD).removeClass("ic-clo");
		$("#mydata_"+data.REQ_TYCD).addClass("ic-pass");
		$("#mydata_"+data.REQ_TYCD).addClass("on");
		$("#MYDATA_RES_"+data.REQ_TYCD).val(data.MYDATA);
		
	} else {
		$("#mydata_"+data.REQ_TYCD).removeClass("ic-pass");
		$("#mydata_"+data.REQ_TYCD).addClass("ic-clo");
		$("#mydata_"+data.REQ_TYCD).addClass("on");
	}
	
	var succCnt = 0;
	$.each(MYDATA_REQ_LIST, function(k, v){
		if (v == 'Y') succCnt++;
	});
	
	if (succCnt > 2) {
		$("#mydata_icon_stop").show();
		$("#mydata_icon_start").hide();
		progressBar(false);
		
		$("#mydataConfirmBtn").html("제출");
		$("#mydataConfirmBtn").unbind();
		$("#mydataConfirmBtn").click(function(){
			progressBar(false);
			${reqDs.id}_Func.confirm("Y");	
		});
	}
}
</script>
<div class="content-wrap">
	<input type="hidden" id="MYDATA_RES_MinWon" />
	<input type="hidden" id="MYDATA_RES_NHIS_1" />
	<input type="hidden" id="MYDATA_RES_NHIS_2" />
	
    <div class="pop-header">
        <h2 class="pop-title">${reqDs.title }</h2>
        
        <button type="button" name="button" class="btn-layer-close" data-focus="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
    </div>
    <div class="default-wrap">
    	<div class="pop-desc">직접서류를 제출하지 않아도 마이데이터로 간편하게 금융서비스 이용이 가능해요</div>    
    	<div class="mydata-wrap">
			<p id="mydata_icon_stop"><img src="/resources/images/common/ico-mydata-bg.png" alt="마이데이터 송수신"></p>
			<p id="mydata_icon_start" style="display: none;"><img src="/resources/images/common/ico-mydata-bg.gif" alt="마이데이터 송수신"></p>
			<dl class="list-bull"><!-- [퍼블] 클래스 변경 -->
				<dt><b>조회목록</b></dt>
				<dd class="" id="mydata_MinWon">주민등록표등·초본</dd>
				<dd class="" id="mydata_NHIS_2">보험료 납부확인서</dd>
				<dd class="" id="mydata_NHIS_1">자격득실 확인서</dd>
				<!-- 2023-06-21, D: 성공시   ic-pass, 실패시 ic-clo 사용  //-->
			</dl>
		</div>
    </div>
    <div class="btn-wrap fixed-btn-wrap type-popup"><!-- [D] 클래스 type-popup : 팝업에서 사용하는 버튼에 추가 -->
        <a href="#none" class="btn" onclick="javascript:${reqDs.id}_Func.mydataReq();" id="mydataConfirmBtn">조회</a><!-- [D] 버튼에 btn 클래스 필수 (normal style) -->
    </div>
</div>