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
		confirm : function(authType, idx){
			// 선택li 활성화
			//$("#${reqDs.id} .list-icon li").eq(idx).addClass("active");
			// 레이어 업무 선택 및 입력 완료 처리 
			${reqDs.id}_Func.callback(authType);
		},
		// 호출 화면 콜백 처리	
		callback : function(){}
	});
</script>
<div class="content-wrap">
	<div class="pop-header">
		<h2 class="pop-title">${reqDs.title }</h2>
		<button type="button" name="button" class="btn-layer-close"
			data-focus="btn-layer-close"
			onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
	</div>
	<div class="default-wrap">
		<%--
          <ul class="ly-select-list">
              <li><button type="button" onclick="javascript:${reqDs.id}_Func.confirm('fincert',0);">금융인증서</button></li>
              <li><button type="button" onclick="javascript:${reqDs.id}_Func.confirm('kakao',1);">카카오페이</button></li>
              <li><button type="button" onclick="javascript:${reqDs.id}_Func.confirm('toss',2);">토스</button></li>
              <li><button type="button" onclick="javascript:${reqDs.id}_Func.confirm('naver2',3);">네이버</button></li>
              <c:if test="${reqDs.type eq 'AUTH'}">
          	   <li><button type="button" onclick="javascript:${reqDs.id}_Func.confirm('mno',4);">휴대폰</button></li>
          	   </c:if>
          </ul> --%>
          
		<ul class="list-icon certification"><!-- [퍼블] 클래스 변경 -->
			<!-- <li class="pw"><a href="#none">간편비밀번호</a></li>
             <li class="pattern"><a href="#none">패턴인증</a></li>
             <li class="bio"><a href="#none">바이오인증</a></li>
             <li class="id"><a href="#none">사용자아이디</a></li>
             <li class="joint"><a href="#none">공동인증서</a></li> -->
			<li class="finance"><a href="#none"
				onclick="javascript:${reqDs.id}_Func.confirm('fincert',0);">금융인증서</a></li>
			<li class="toss"><a href="#none"
				onclick="javascript:${reqDs.id}_Func.confirm('toss',1);">토스인증</a></li>
			<li class="kakao"><a href="#none"
				onclick="javascript:${reqDs.id}_Func.confirm('kakao',2);">카카오인증</a></li>
			<li class="naver"><a href="#none"
				onclick="javascript:${reqDs.id}_Func.confirm('naver2',3);">네이버인증</a></li>
			<c:if test="${reqDs.type eq 'AUTH'}">
			<li class="hp"><a href="#none"
				onclick="javascript:${reqDs.id}_Func.confirm('mno',4);">휴대폰인증</a></li>
			</c:if>
		</ul>
	</div>
</div>