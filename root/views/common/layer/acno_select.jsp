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
	confirm : function(bkcd, acno, prodNm, name, stsCd, posbYn, kncd){
		// 선택li 활성화
		//$("#${reqDs.id} .list-icon li").eq(idx).addClass("active");
		
		var resParam = {};
		resParam.bkcd = bkcd;		// 은행코드
		resParam.bknm = UtilFunc.getBankName(bkcd);	// 은행명
		resParam.acno = acno; 		// 계좌번호
		resParam.name = name;		// 예금주
		resParam.prodNm = prodNm;	// 상품명
		resParam.kncd = kncd;		// 상품종류
		resParam.stsCd = stsCd;		// 상태코드
		resParam.posbYn = posbYn;	// 출금가능여부
		
		// 레이어 업무 선택 및 입력 완료 처리 
		${reqDs.id}_Func.callback(resParam);
	},
	// 호출 화면 콜백 처리	
	callback : function(){}
});
$(document).ready(function(){
	$(".tab-item").find("li").click(function(){
		$(".tab-item").find("li").removeClass("on");
		$(this).addClass("on");
		var tab = $(this).data("tab"); 
		$("#tab-cont01").hide();
		$("#tab-cont02").hide();
		$("#tab-cont03").hide();
		$("#tab-cont04").hide();
		$("#"+tab).show();
	});
});
</script>
<div class="content-wrap">
	<div class="pop-header">
		<h2 class="pop-title">계좌 선택</h2>
		<button type="button" name="button" class="btn-layer-close"
			data-focus="btn-layer-close"
			onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
	</div>
	<div class="default-wrap">
		<section class="tabs-wrap">
			<div class="tabs">
				<ul class="tab-item">
					<li <c:if test="${reqDs.selectTab eq '1'}">class="on"</c:if> data-tab="tab-cont01"><a href="#none" title="선택됨">최근입금</a></li>
					<li <c:if test="${reqDs.selectTab eq '2'}">class="on"</c:if> data-tab="tab-cont02" class=""><a href="#none">자주쓰는</a></li>
					<li <c:if test="${reqDs.selectTab eq '3'}">class="on"</c:if> data-tab="tab-cont03"><a href="#none">내 계좌</a></li>
					<li <c:if test="${reqDs.selectTab eq '4'}">class="on"</c:if> data-tab="tab-cont04" class=""><a href="#none">입금지정</a></li>
				</ul>
				<div class="scroll-area">
					<!-- 최근입금  API_TrnImtrRigt0101_02 -->
					<!-- OPEN_BKCD 은행코드 / MNRC_ACNO_20 계좌번호 -->
					<div id="tab-cont01" class="tab-content <c:if test="${reqDs.selectTab ne '1'}">dp-none</c:if>">
						<ul class="bank_list">
							<c:if test="${not empty resDs.REC1 }">
								<c:forEach var="item" items="${resDs.REC1 }">
									<li class="bank_${item.OPEN_BKCD }">
										<a href="#none" onclick="javascript:${reqDs.id}_Func.confirm('${item.OPEN_BKCD }', '${item.MNRC_ACNO_20 }', '', '${item.MNRC_NM }','', '', '');"> 
											<script>
												var bknm = UtilFunc.getBankName("${item.OPEN_BKCD}");
												$("#title1").text(bknm+" "+'${item.MNRC_NM }');
											</script>
											<strong class="tit" id="title1"></strong> 
											<span class="exp">${item.MNRC_ACNO_20 }</span>
										</a>
									</li>
								</c:forEach>
							</c:if>
							<c:if test="${empty resDs.REC1 }">
								<li class="none">최근 입금 계좌가 없습니다</li>
							</c:if>
						</ul>
					</div>
					
					<!-- 자주쓰는 API_TrnImtrRigt0101_02 -->
					<!-- BKCD 은행코드 / WB_ACNO 계좌번호 / ACCO_KRN_NM 예금주명 / ACCO_ALS 별칭 -->
					<div id="tab-cont02" class="tab-content <c:if test="${reqDs.selectTab ne '2'}">dp-none</c:if>">
						<ul class="bank_list">
							<c:if test="${not empty resDs.REC2 }">
								<c:forEach var="item" items="${resDs.REC2 }">
									<li class="bank_${item.BKCD }">
										<a href="#none" onclick="javascript:${reqDs.id}_Func.confirm('${item.BKCD }', '${item.WB_ACNO }', '${item.ACCO_ALS }', '${item.ACCO_KRN_NM }','', '', '');"> 
											<script>
												var bknm = UtilFunc.getBankName("${item.BKCD}");
												$("#title2").text(bknm+" "+'${item.ACCO_KRN_NM }');
											</script>
											<strong class="tit" id="title2"></strong> 
											<span class="exp">${item.WB_ACNO }</span>
										</a>
									</li>
								</c:forEach>
							</c:if>
							<c:if test="${empty resDs.REC2 }">
								<li class="none">자주쓰는 계좌가 없습니다</li>
							</c:if>
						</ul>
					</div>
					
					<!-- 내계좌 -->
					<!-- PROD_NM 상품명 / ACNO 계좌번호
						ACCO_STS_CD 계좌상태코드 00 활동계좌
						BNKB_WTCH_POSB_YN 통장출금가능여부 1:가능
						ACCO_KNCD 1.요구성 2.적금 3.정기예금 4.대출 -->
					<div id="tab-cont03" class="tab-content <c:if test="${reqDs.selectTab ne '3'}">dp-none</c:if>">
						<ul class="bank_list">
							<c:if test="${not empty SS_LOGIN.ACNT_RS }">
								<c:forEach var="item" items="${SS_LOGIN.ACNT_RS }">
									<li class="bank_050">
										<a href="#none" onclick="javascript:${reqDs.id}_Func.confirm('050', '${item.ACNO }', '${item.PROD_NM }', '${SS_CUST.CUST_NM }','${item.ACCO_STS_CD }', '${item.BNKB_WTCH_POSB_YN }', '${item.ACCO_KNCD }');"> 
											<strong class="tit">${item.PROD_NM}</strong> 
											<span class="exp">${item.ACNO}</span>
										</a>
									</li>
								</c:forEach>
							</c:if>
							<c:if test="${empty SS_LOGIN.ACNT_RS }">
								<li class="none">내 계좌가 없습니다</li>
							</c:if>
						</ul>
					</div>
					
					<!-- 입금지정 API_IbaDeptJore0100 -->
					<!-- BKCD 은행코드 / WB_ACNO 계좌번호 -->
					<div id="tab-cont04" class="tab-content <c:if test="${reqDs.selectTab ne '4'}">dp-none</c:if>">
						<ul class="bank_list">
							<c:if test="${not empty resDs.REC3 }">
								<c:forEach var="item" items="${resDs.REC3 }">
									<li class="bank_${item.BKCD }">
										<a href="#none" onclick="javascript:${reqDs.id}_Func.confirm('${item.BKCD }', '${item.WB_ACNO }', '', '','', '', '');"> 
											<script>
												var bknm = UtilFunc.getBankName("${item.BKCD}");
												$("#title3").text(bknm);
											</script>
											<strong class="tit" id="title3"></strong>
											<span class="exp">${item.WB_ACNO }</span>
										</a>
									</li>
								</c:forEach>
							</c:if>
							<c:if test="${empty resDs.REC3 }">
								<li class="none">입금지정 계좌가 없습니다</li>
							</c:if>
						</ul>
					</div>
					
				</div>
			</div>
		</section>
	</div>
</div>