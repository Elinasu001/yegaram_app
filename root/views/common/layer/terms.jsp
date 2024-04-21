<%@page import="co.gnbsoftec.common.util.StringUtils"%>
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
		// 레이어 업무 선택 및 입력 완료 처리 
		${reqDs.id}_Func.callback(true);
	},
	// 호출 화면 콜백 처리	
	callback : function(){}
	
});
</script>
<!-- s: contents -->
<div class="pop-header">
	<h2 class="pop-title">약관</h2>
	<button type="button" name="button" class="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
</div>

<div class="pop-con-wrap">
	<div class="default-wrap mb0"><!-- [퍼블] 클래스 변경 -->
		<div class="info-wrap terms-view"><!-- [퍼블] 클래스 변경 -->
			<iframe src="/resources/pdfjs/web/viewer.html?file=/resources/terms/${reqDs.terms_cd }.pdf" style="width:100%; height:100%;"></iframe>
		</div>
		<div class="plus-minus-wrap">
			<button type="button"><span>+</span></button>
			<button type="button"><span>-</span></button>
		</div>
	</div>
</div>


<div class="btn-wrap fixed-btn-wrap">
	<a href="javascript:void(0);" class="btn" onclick="javascript:${reqDs.id}_Func.confirm();">확인했어요</a>
</div>
