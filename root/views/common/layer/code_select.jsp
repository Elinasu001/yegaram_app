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
		confirm : function(code, name){
			$("#"+code+"_li").addClass("active");	// 선택한 li 활성화
			      
			var resParam = {};
			resParam.code = code; 
			resParam.name = name;
			// 레이어 업무 선택 및 입력 완료 처리 
			${reqDs.id}_Func.callback(resParam);
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
       <c:forEach var="item" items="${resDs.record }">
       		<c:if test="${item.CODE ne item.UPPER_CODE }">
	       		<c:if test="${item.VALUE ne '' }"><c:set var="CODE" value="${item.VALUE }"></c:set></c:if>
	       		<c:if test="${item.VALUE eq '' }"><c:set var="CODE" value="${item.CODE }"></c:set></c:if>
	       		<li id="${CODE }_li"><button type="button" value="${item.VALUE }" onclick="javascript:${reqDs.id}_Func.confirm('${CODE}', '${item.NAME }');">${item.NAME }</button></li>
       		</c:if>
       </c:forEach>
       </ul>
    </div>
</div>