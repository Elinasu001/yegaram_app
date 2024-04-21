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
		confirm : function(acno, prodNm, stsCd, posbYn, kncd){
			var resParam = {};
			resParam.acno = acno; 		// 계좌번호
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
</script>
<div class="content-wrap">
	<div class="pop-header">
		<h2 class="pop-title">계좌 선택</h2>
		<button type="button" name="button" class="btn-layer-close"
			data-focus="btn-layer-close"
			onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
	</div>
	<div class="default-wrap">
		<div class="scroll-area">
			<ul class="bank_list">
				<c:if test="${not empty SS_LOGIN.ACNT_RS }">
				
					<%-- 수신전계좌목록 --%>
					<c:if test="${reqDs.accoKncd eq '0'}">
						<c:forEach var="item" items="${SS_LOGIN.ACNT_RS }" >
							<c:if test="${item.ACCO_KNCD ne '4'}">
								<li class="bank_050">
									<a href="#none" onclick="javascript:${reqDs.id}_Func.confirm('${item.ACNO }', '${item.PROD_NM }', '${item.ACCO_STS_CD }', '${item.BNKB_WTCH_POSB_YN }', '${item.ACCO_KNCD }');"> 
										<strong class="tit">${item.PROD_NM }</strong> 
										<span class="exp">${item.ACNO }</span>
										<%--
										ACCO_STS_CD 계좌상태코드 00 활동계좌
										BNKB_WTCH_POSB_YN 통장출금가능여부 1:가능
										 --%>
									</a>
								</li>
							</c:if>
						</c:forEach>
					</c:if>
					
					
					<%-- 요구불계좌목록 --%>
					<c:if test="${reqDs.accoKncd eq '1'}">
						<c:forEach var="item" items="${SS_LOGIN.ACNT_RS }" >
							<c:if test="${item.ACCO_KNCD eq '1'}">
								<li class="bank_050">
									<a href="#none" onclick="javascript:${reqDs.id}_Func.confirm('${item.ACNO }', '${item.PROD_NM }', '${item.ACCO_STS_CD }', '${item.BNKB_WTCH_POSB_YN }', '${item.ACCO_KNCD }');"> 
										<strong class="tit">${item.PROD_NM }</strong> 
										<span class="exp">${item.ACNO }</span>
										<%--
										ACCO_STS_CD 계좌상태코드 00 활동계좌
										BNKB_WTCH_POSB_YN 통장출금가능여부 1:가능
										 --%>
									</a>
								</li>
							</c:if>
						</c:forEach>
					</c:if>
					
					<%-- 적금계좌목록 --%>
					<c:if test="${reqDs.accoKncd eq '2'}">
						<c:forEach var="item" items="${SS_LOGIN.ACNT_RS }" >
							<c:if test="${item.ACCO_KNCD eq '2'}">
								<li class="bank_050">
									<a href="#none" onclick="javascript:${reqDs.id}_Func.confirm('${item.ACNO }', '${item.PROD_NM }', '${item.ACCO_STS_CD }', '${item.BNKB_WTCH_POSB_YN }', '${item.ACCO_KNCD }');"> 
										<strong class="tit">${item.PROD_NM }</strong> 
										<span class="exp">${item.ACNO }</span>
										<%--
										ACCO_STS_CD 계좌상태코드 00 활동계좌
										BNKB_WTCH_POSB_YN 통장출금가능여부 1:가능
										 --%>
									</a>
								</li>
							</c:if>
						</c:forEach>
					</c:if>
					
					<%-- 정기예금계좌목록 --%>
					<c:if test="${reqDs.accoKncd eq '3'}">
						<c:forEach var="item" items="${SS_LOGIN.ACNT_RS }" >
							<c:if test="${item.ACCO_KNCD eq '3'}">
								<li class="bank_050">
									<a href="#none" onclick="javascript:${reqDs.id}_Func.confirm('${item.ACNO }', '${item.PROD_NM }', '${item.ACCO_STS_CD }', '${item.BNKB_WTCH_POSB_YN }', '${item.ACCO_KNCD }');"> 
										<strong class="tit">${item.PROD_NM }</strong> 
										<span class="exp">${item.ACNO }</span>
										<%--
										ACCO_STS_CD 계좌상태코드 00 활동계좌
										BNKB_WTCH_POSB_YN 통장출금가능여부 1:가능
										 --%>
									</a>
								</li>
							</c:if>
						</c:forEach>
					</c:if>
					
					<%-- 대출계좌목록 --%>
					<c:if test="${reqDs.accoKncd eq '4'}">
						<c:forEach var="item" items="${SS_LOGIN.ACNT_RS }" >
							<c:if test="${item.ACCO_KNCD eq '4'}">
								<li class="bank_050">
									<a href="#none" onclick="javascript:${reqDs.id}_Func.confirm('${item.ACNO }', '${item.PROD_NM }', '${item.ACCO_STS_CD }', '${item.BNKB_WTCH_POSB_YN }', '${item.ACCO_KNCD }');"> 
										<strong class="tit">${item.PROD_NM }</strong> 
										<span class="exp">${item.ACNO }</span>
										<%--
										ACCO_STS_CD 계좌상태코드 00 활동계좌
										BNKB_WTCH_POSB_YN 통장출금가능여부 1:가능
										 --%>
									</a>
								</li>
							</c:if>
						</c:forEach>
					</c:if>
					
				</c:if>
				<c:if test="${empty SS_LOGIN.ACNT_RS }">
					<li class="none">내 계좌가 없습니다</li>
				</c:if>
				<%-- <li>
					<a href="#none" onclick="javascript:${reqDs.id}_Func.confirm('${item.ACNO }');"> 
						<strong class="tit">${item.PROD_NM }</strong> 
						<span class="exp">${item.ACNO }</span>
						
						ACCO_STS_CD 계좌상태코드 00 활동계좌
						BNKB_WTCH_POSB_YN 통장출금가능여부 1:가능
						
					</a>
				</li> --%>
			</ul>
		</div>
	</div>
</div>