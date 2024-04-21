<%@page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ft" uri="/WEB-INF/tag.tld"%>
<script type="text/javascript">
var ${reqDs.id}_Func = ({
	// 닫기  
	close : function(){},
	// 취소 (그만하기)
	cancel : function(){},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(){
		$(".bankbook-copy-section").css("padding", "10px");
		html2canvas(document.querySelector("#${reqDs.id}_capture")).then(canvas => {
				var uri = canvas.toDataURL('image/jpg');
				var link = document.createElement('a');
				if (typeof link.download === 'string') {
					link.href = uri;
					link.download = '통장사본(${resDs.ACNO}).jpg'
					document.body.appendChild(link);
					link.click();
					document.body.removeChild(link);
				} else {
					window.open(uri);
				}
				$(".bankbook-copy-section").css("padding", "");
		});
	},
	// 호출 화면 콜백 처리	
	callback : function(){}
});
</script>
<div class="pop-header">
	<h2 class="pop-title">통장사본</h2>
	<button type="button" name="button" class="btn-layer-close" onclick="${reqDs.id}_Func.close()">닫기</button>
</div>
<div class="pop-con-wrap">
	<div class="default-wrap">
		<div class="bankbook-copy-section" id="${reqDs.id}_capture">
			<strong class="logo">예가람저축은행</strong>
			<!-- <p class="desc">아래와 같이 계좌가 개설되어 있음을 확인합니다.</p> QA 삭제 -->
			<div class="bankbook-info-area">
				<div class="depositor">
					<span>예금주</span>
					<strong>${SS_CUST.CUST_NM} 님</strong>
				</div>
				<ul class="account-info-list">
					<li>
						<span>예금종류</span>
						<strong>${resDs.AC_NM}</strong>
					</li>
					<li>
						<span>계좌번호</span>
						<strong><ft:format type="acno" value="${resDs.ACNO}"/></strong>
					</li>
					<li>
						<span>신규일</span>
						<strong>
							<c:if test="${reqDs.ACCO_KNCD eq '1'}"><ft:format type="date" value="${resDs.NEW_DT}"/></c:if>
							<c:if test="${reqDs.ACCO_KNCD ne '1'}"><ft:format type="date" value="${resDs.NEW_DATE}"/></c:if>
						</strong>
					</li>
				</ul>
			</div>
			<div class="confirm-area">
				<p class="desc">위와 같이 계좌가 개설되어 있음을 확인합니다.</p>
				<span class="date"><ft:dateTag type="toDay" format="yyyy년 MM월 dd일"/></span>
			</div>
			<div class="seal-area">
				<strong>예가람저축은행</strong>
				<!-- <div class="seal-wrap">
					<img src="../../../resources/images/common/seal.png" alt="">
				</div> QA 삭제 -->
			</div>
		</div>
		<dl class="list-bull"><!-- [퍼블] 클래스 변경 -->
			<dt>알아두세요</dt>
			<dd>
				이 통장은 수신거래 기본약관 및 해당 상품별 거래약관이
				함께 적용됩니다.
			</dd>
			<dd>
				이 통장 사본은 실제 거래를 위한 통장이 아니라, 예금주 및
				당행에 존재하는 계좌임을 확인하는 이미지 출력물임을
				알려드립니다.
			</dd>
		</dl>
	</div>
</div>
<div class="fixed-btn-wrap">
	<div class="btn-wrap">
		<a href="#none" class="btn" onclick="javascript:${reqDs.id}_Func.confirm();">저장하기</a>
	</div>
</div>
