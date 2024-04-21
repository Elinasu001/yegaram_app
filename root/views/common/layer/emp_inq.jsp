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
	confirm : function(empNo, empNm){
		var resParam = {};
		resParam.empNo = empNo;
		resParam.empNm = empNm;
		${reqDs.id}_Func.callback(resParam);
	},
	// 호출 화면 콜백 처리	
	callback : function(){}
});
function fnSelectSgstEmp(empNo, empNm) {
	${reqDs.id}_Func.confirm(empNo, empNm);
}

function fnSgstEmpInq() {
	
	if ($.trim($("#SRCH_NM").val()) == "") {
		biz.alert("추천인 이름을 입력해주세요");
	} else {
		var sgstSrchForm = makeForm("sgstSrchForm");
		addFormData(sgstSrchForm, "txGbnCd", "P");	// 거래구분코드 P:조회 R:등록
		addFormData(sgstSrchForm, "SRCH_NM", $("#SRCH_NM").val());
		doAction("SGST_EMP_INQ", sgstSrchForm, function(resDs){
			if (resDs.REC.length == 0) {
				// 조회결과 없음
				$("#SRCH_RESULT").hide();
				$("#SRCH_RESULT_EMPTY").show();
			} else {
				/*
				비대면권유자번호	NECT_SGSR_NO
				권유직원명	SGST_EMP_NM
				지점코드	BOCD
				지점명	BO_NM
				*/
				$("#SRCH_RESULT").html('');
				var srchResultHtml = '<li class="tbl-header"><span>직원명</span><span>영업점</span></li>';
				var tempResultHtml = '<li><span>#이름#(#사번#)</span><span>#지점명#<button type="button" onclick="javascript:fnSelectSgstEmp(#사번선택#, \'#이름선택#\');">선택</button></span></li>';
				
				$.each(resDs.REC, function(idx, ds){
					var temp = tempResultHtml;
					temp = temp.replace("#이름#", ds.SGST_EMP_NM);
					temp = temp.replace("#사번#", ds.NECT_SGSR_NO);
					temp = temp.replace("#지점명#", ds.BO_NM);
					temp = temp.replace("#사번선택#", ds.NECT_SGSR_NO);
					temp = temp.replace("#이름선택#", ds.SGST_EMP_NM);
					srchResultHtml+=temp;
				});
				$("#SRCH_RESULT").html(srchResultHtml);
				$("#SRCH_RESULT").show();
				$("#SRCH_RESULT_EMPTY").hide();
			}
		});
	}
}
</script>
<div class="content-wrap banklistWrap">
	<div class="pop-header">
		<h2 class="pop-title">${reqDs.title }</h2><!-- [퍼블] 태그 변경 -->
		<button type="button" name="button" class="btn-layer-close" data-focus="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
	</div>
	
	<div class="ly-scroll-con type-high">

		<!-- s: 검색 영역 -->
		<div class="search-area">
			<div class="form-wrap">
				<div class="input">
					<input type="search" title="" id="SRCH_NM" class="" placeholder="추천인 이름을 입력해주세요" required="">
				</div>
				<button type="button" class="btn-search" onclick="javascript:fnSgstEmpInq();">검색</button>
				<button type="button" class="btn-delete" onclick="javascript:$('#SRCH_NM').val('');">검색어 삭제</button>
			</div>
		</div>
		<ul class="recommender-wrap" id="SRCH_RESULT">
			<li class="tbl-header">
				<span>직원명</span>
				<span>영업점</span>
			</li>
			<!--D : 검색전 노출 -->
			<li class="search-before">
				<p>추천인 이름으로 검색해주세요</p>
			</li>
			<!--D : 검색전 노출 //-->
		</ul>
		
		<ul class="recommender-wrap" id="SRCH_RESULT_EMPTY" style="display: none;">
			<!--D : 검색결과 오류 시 노출 -->
			<li class="search-before">
				<div class="result-area exclamation">
					<p>검색결과가 존재하지 않아요</p>
				</div>
			</li>
			<!--D : 검색결과 오류 시 노출 //-->
		</ul>
		
		<!-- // e: 검색 영역 -->
	</div>
</div>
<div class="fixed-btn-wrap">
	<div class="btn-wrap type-popup">
		<a href="#none" class="btn" onclick="javascript:${reqDs.id}_Func.close();">닫기</a>
	</div>
</div>