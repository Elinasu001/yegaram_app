<%@ page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
=CODE=
PC00000012 - 햇살론
PC00000013 - 신용대출
PC00000034 - 종통
PC00000030 - 온라인햇살론
TA00500000 - 비대면보통예금약관
TA00600000 - 비대면정기예금약관
TA00700000 - 비대면정기적금약관
TA00800000 - 정기예금 단리
TA03000000 - 정기예금 복리
TA02900000 - 회전 정기예금 단리
TA03100000 - 회전 정기예금 복리
TA00900000 - 정기적금가입 단리
TA03200000 - 특판 정기예금 단리
TA03300000 - 특판 정기예금 복리
TA03400000 - 특판 정기적금가입
TA01400000 - 예담대약관1차
TA01500000 - 예담대약관2차

TA02700000 - 온라인상담
TA01200000 - 계좌비밀번호 3회 오류해제
TA01100000 - 이체한도 증액

T001200001 - 전자계약
TA02100100 - 상품서비스 안내
--%>
<script type="text/javascript">
$(document).ready(function(){
	
	// 전체동의 시 필수동의 모두 체크 또는 해제
	$("#TERMS_ALL_CHECK").click(function(){
		var chkFlag = false;
		if ($(this).is(":checked")) chkFlag = true;
		$(".check").prop("checked", chkFlag);
		validChk();
	});
	
	// 마케팅동의 선택 시 하위 모두 체크 또는 해제
	$(".mktChk").click(function(){
		var mktFlag = false;
		if ($(this).prop("checked")) mktFlag = true; 
		$(".mktYn").prop("checked", mktFlag);	
	});
	
	// 마케팅동의 한개라도 체크된 경우
	$(".mktYn").click(function(){
		var flag = false;
		$.each($(".mktYn"),function(idx,obj){
		    if ($(obj).prop("checked")) flag = true;
		});
		if (flag) {
			$(".mktChk").prop("checked", true);			
		} else{
			$(".mktChk").prop("checked", false);
		}
	});
	
	// 하단버튼 컨트롤 호출
	$(".validChk").click(function(){
		validChk();
		
		var validYn = true;
		
		$.each($(".validChk"), function(){
			if(validYn){
				if ($(this).is(":checked") == false) {
					validYn = false;
				}
			}
		});
		
		$("#TERMS_ALL_CHECK").prop("checked", validYn);
	});
		
});
function validateTerms(){
	
	var TERMS_AGREEMENT_YN = "";
	var MARKETING_YN = "";
	var validYn = true;
	$.each($(".validChk"), function(){
		if ($(this).is(":checked") == false) {
			
			biz.alert($(this).parent().find("span").text() + "에 동의해주세요"); // .child("span").text()
			validYn = false;
			return false;
		}
	});
	
	if (validYn) {
		$.each($(".agreeYn"), function(){
			if ($(this).is(":checked")) {
				TERMS_AGREEMENT_YN += "Y|";
			} else {
				TERMS_AGREEMENT_YN += "N|";
			}
		});
		
		$.each($(".mktYn"), function(){
			if ($(this).is(":checked")) {
				MARKETING_YN += "Y|";
			} else {
				MARKETING_YN += "N|";
			}
		});
		if (TERMS_AGREEMENT_YN.length > 0) TERMS_AGREEMENT_YN = TERMS_AGREEMENT_YN.slice(0,-1);
		if (MARKETING_YN.length > 0) MARKETING_YN = MARKETING_YN.slice(0,-1);
		
		$("#TERMS_AGREEMENT_YN").val(TERMS_AGREEMENT_YN);
		$("#MARKETING_YN").val(MARKETING_YN);
		return true;
	}
	
}

//전체선택
function fnAllChk(){
	
}
</script>
<input type="hidden" id="TERMS_AGREEMENT_YN">
<input type="hidden" id="MARKETING_YN">

<div class="terms-wrap level1 chk-all">
	<fieldset>
		<input type="checkbox" id="TERMS_ALL_CHECK" class="check all" data-TERMS_CODE="${reqDs.CODE }">
		<label for="TERMS_ALL_CHECK"><span>약관에 모두 동의할게요</span></label>
	</fieldset>
</div>

<!-- 약관목록반복 -->
<c:forEach var="item" items="${resDs.REC }">
<div class="terms-wrap level2">
	<fieldset>
		<c:set var="validChk" value=""></c:set>
		<c:set var="mktChk" value=""></c:set>
		<c:if test="${item.NEED_YN eq 'Y' }"><c:set var="validChk" value="validChk"/></c:if>
		<c:if test="${item.TERMS_CODE eq 'T000800003' }"><c:set var="mktChk" value="mktChk"/></c:if>
		<input type="checkbox" id="chk_${item.TERMS_CODE }" name="check" value="Y" class="check agreeYn ${validChk} ${mktChk}"
			onclick="biz.terms('${item.TERMS_CODE }', $('#chk_${item.TERMS_CODE }'));">
		<label for="chk_${item.TERMS_CODE }"><span>
		<c:if test="${item.NEED_YN eq 'Y' }">[필수] </c:if>
		<c:if test="${item.NEED_YN ne 'Y' }">[선택] </c:if>
		${item.TERMS_NAME } </span></label>
	</fieldset>
	
	<c:if test="${item.TERMS_CODE eq 'T000800003' }">
	<div class="etc level3">
		<div class="terms-wrap">
			<input type="checkbox" id="svcCheck01" name="check" value="" class="check mktYn">
			<label for="svcCheck01">문자</label>
		</div>
		<div class="terms-wrap">
			<input type="checkbox" id="svcCheck02" name="check" value="" class="check mktYn">
			<label for="svcCheck02">이메일</label>
		</div>
		<div class="terms-wrap">
			<input type="checkbox" id="svcCheck03" name="check" value="" class="check mktYn">
			<label for="svcCheck03">전화</label>
		</div>
		<div class="terms-wrap">
			<input type="checkbox" id="svcCheck04" name="check" value="" class="check mktYn">
			<label for="svcCheck04">DM</label>
		</div>
	</div>
	</c:if>
</div>
</c:forEach>