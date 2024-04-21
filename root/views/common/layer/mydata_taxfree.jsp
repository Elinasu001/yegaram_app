<%@page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
var MYDATA_REQ_LIST = {
		"TAX_FREE":""
	};
var ${reqDs.id}_Func = ({
	// 닫기  
	close : function(){},
	// 취소 (그만하기)
	cancel : function(){},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(data){
		// 처리 여부 확인 
		${reqDs.id}_Func.callback(data);	
	},
	// 호출 화면 콜백 처리	
	callback : function(){},
	mydataReq : function() {
		
		$("#mydata_icon_stop").hide();
		$("#mydata_icon_start").show();
		progressBar(true);
		
		$.each(MYDATA_REQ_LIST, function(k, v){
			if (v != 'Y') {
				var myDataReqForm = makeForm("myDataReqForm");
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
	} else {
		$("#mydata_"+data.REQ_TYCD).removeClass("ic-pass");
		$("#mydata_"+data.REQ_TYCD).addClass("ic-clo");
		$("#mydata_"+data.REQ_TYCD).addClass("on");
	}
	
	var succCnt = 0;
	$.each(MYDATA_REQ_LIST, function(k, v){
		if (v == 'Y') succCnt++;
	});
	
	/*
	  LVTP_MNBD_DVCD 첨부서류구분코드
		900-ODD-030-0	[SB]비과세예금 증빙-장애인	장애인			
		900-ODD-031-0	[SB]비과세예금 증빙-기초생활	기초생활수급자			
		900-ODD-032-0	[SB]비과세예금 증빙-독립유공자	독립유공자 유/가족			
		900-ODD-033-0	[SB]비과세예금 증빙-국가유공자	국가유공자			
		900-ODD-034-0	[SB]비과세예금 증빙-5.18민주	5.18민주유공자			
		900-ODD-035-0	[SB]비과세예금 증빙-고엽제	고엽제후유증환자			
	 */
	if (succCnt > 0) {
		$("#mydata_icon_stop").show();
		$("#mydata_icon_start").hide();
		progressBar(false);
		
		$("#mydataConfirmBtn").html("제출");
		$("#mydataConfirmBtn").unbind();
		$("#mydataConfirmBtn").click(function(){
			progressBar(false);
			${reqDs.id}_Func.confirm("900-ODD-033-0");	// LVTP_MNBD_DVCD 증빙서류
		});
	}
	// TODO 오류 처리에 대한 기획 나오면 추가
}
</script>
<div class="content-wrap">
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
				<dd class="" id="mydata_TAX_FREE">비과세증명</dd>
				<!-- 2023-06-21, D: 성공시   ic-pass, 실패시 ic-clo 사용  //-->
			</dl>
		</div>
    </div>
    <div class="btn-wrap fixed-btn-wrap type-popup"><!-- [D] 클래스 type-popup : 팝업에서 사용하는 버튼에 추가 -->
        <a href="#none" class="btn" onclick="javascript:${reqDs.id}_Func.mydataReq();" id="mydataConfirmBtn">조회</a><!-- [D] 버튼에 btn 클래스 필수 (normal style) -->
    </div>
</div>