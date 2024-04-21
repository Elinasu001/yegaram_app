<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
	var ${reqDs.id}_Func = ({
		// 닫기  
		close : function(){},
		// 취소 (그만하기)
		cancel : function(){},
		// 확인 (처리 완료 버튼, 또는 처리완료 선택)
		confirm : function(yn,text){
			var ${reqDs.id}_callbackData = {
				"yn" : yn
				,"text" : text
			}
			// 레이어 업무 선택 및 입력 완료 처리  Y / N
			${reqDs.id}_Func.callback(${reqDs.id}_callbackData);
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
       <ul class="ly-select-list">
	       	<li><button type="button" value="Y" onclick="javascript:${reqDs.id}_Func.confirm('Y','${reqDs.btnNmY}');">${reqDs.btnNmY}</button></li>
    	    <li><button type="button" value="N" onclick="javascript:${reqDs.id}_Func.confirm('N','${reqDs.btnNmN}');">${reqDs.btnNmN}</button></li>
        </ul>
    </div>
</div>