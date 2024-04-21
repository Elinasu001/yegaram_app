<%@page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
var ${reqDs.id}_Func = ({
	// 닫기  
	close : function(){},
	// 취소 (그만하기)
	cancel : function(){},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(){
		var inputData = $("#${reqDs.id}_INPUT").val();
		// 레이어 업무 선택 및 입력 완료 처리 
		${reqDs.id}_Func.callback(inputData);
	},
	// 호출 화면 콜백 처리	
	callback : function(){}
});
</script>
<div class="content-wrap">
    <div class="pop-header">
        <h2 class="pop-title">${reqDs.title }</h2>
        <button type="button" name="button" class="btn-layer-close" data-focus="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
    </div>
    <div class="ly-scroll-con ly-select">
        <div class="txtbox-wrap">
            <div class="form-wrap mt10 view-wrap form-type2">
                <div class="input">
                    <input type="text" id="${reqDs.id}_INPUT" class="inp" pattern=".+@\." placeholder="${reqDs.title }을(를) 입력해주세요" required>
                </div>
                <p class="error-txt">${reqDs.title }을(를) 입력해주세요</p>
            </div>
        </div>
    </div>
    <div class="btn-wrap fixed-btn-wrap type-popup"><!-- [D] 클래스 type-popup : 팝업에서 사용하는 버튼에 추가 -->
        <a href="#none" class="btn" onclick="javascript:${reqDs.id}_Func.confirm();">확인</a><!-- [D] 버튼에 btn 클래스 필수 (normal style) -->
    </div>
</div>