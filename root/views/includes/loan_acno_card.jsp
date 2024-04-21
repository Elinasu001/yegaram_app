<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ft" uri="/WEB-INF/tag.tld"%>
<script type="text/javascript">
//여신계좌상세조회 화면으로 이동
function goAcnoSrch(acno, pdNm, mthNm, prgs) {
	var dataForm = makeForm("dataForm");
	addFormData(dataForm, "LINK_ACT", "LOAN_ACNO_DETAIL");
	addFormData(dataForm, "txGbnCd", "D");
	addFormData(dataForm, "ACNO", acno);
	addFormData(dataForm, "PROD_NM", pdNm);
	addFormData(dataForm, "LOAN_RPAY_MTH_NM", mthNm);
	addFormData(dataForm, "PRGS_PERCENT", prgs);
	doActionFrame("lon/inq/loanAcnoSrch", dataForm);
}

//여신거래내역조회메뉴로 이동
function goTrnHist(acno){
	var dataForm = makeForm("dataForm");
	addFormData(dataForm, "txGbnCd", "D");
	addFormData(dataForm, "ACNO", acno);
	addFormData(dataForm, "LINK_ACT", "LOAN_ACNO_DETAIL");
	doActionFrame("lon/inq/loanTrnHist", dataForm); 	
}

//이자즉시출금메뉴로 이동
function goIntrWthd(acno){
	var dataForm = makeForm("dataForm");
	addFormData(dataForm, "txGbnCd", "P");
	addFormData(dataForm, "LOAN_ACNO", acno);
	addFormData(dataForm, "LOAN_BZWR_DVCD_5", "1");
	addFormData(dataForm, "LINK_ACT", "LOAN_RPAY_MNG");
	doActionFrame("lon/mng/intrWthd1", dataForm); 	
}

// 추가대출화면이동  TODO 현재 대출상품화면으로 이동. 추가대출 화면 정해지면 변경
function loanApply(){
	doActionMenu('lon/inq/loanList','BBS_SELECT');
}

$(document).ready(function(){
	// 계좌번호 복사
	$(".btn-copy").unbind();
	$(".btn-copy").on("click", function() {
		var accNum = $(this).prev().text().replace(/\-/g,"");
		copyToClipboard(accNum);
		toastPopup('복사되었습니다.', 1500);
	});
});
</script>
<c:if test="${resDs.LOAN_CCNT ne 0}">
	<h2 class="area-title">내 대출</h2>

	<c:forEach var="item" items="${resDs.REC4 }" varStatus="status">
		<c:if test="${fn:substring(item.ACNO,5,7) ne '76'}">
			<div class="visaul-info-box mb20 mt10 tab-cont02">
				<c:forEach var="bfInqResDs" items="${item }">
					<input type="hidden" id="${status.count}_${bfInqResDs.key }"
						value="${bfInqResDs.value }">
				</c:forEach>
				<a class="info-tit ico-arrow"
					onclick="goAcnoSrch('${item.ACNO}', '${item.PROD_NM}', '${item.LOAN_RPAY_MTH_NM}', '${item.PRGS_PERCENT}')"><em
					class="flag style2 ">종합통장</em>${item.PROD_NM }</a>
				<div class="account-area">
					<p class="account">
						<ft:format type="acno" value="${item.ACNO }"></ft:format>
					</p>
					<button type="button" class="btn-copy">복사하기</button>
				</div>

				<div class="account-info">
					<div class="account-amount">
						<p class="amount-on">
							<span><ft:format type="comma" value="${item.LOAN_PRNC }"></ft:format>
							</span>원
						</p>
						<p class="amount-off" style="display: none;">잔액숨김</p>
					</div>
				</div>

				<div class="btn-cont-wrap mt20">
					<a href="#none" class="btn btn-info"
						onclick="goTrnHist'${item.ACNO}')">거래내역보기</a> <a href="#none"
						class="btn btn-primary" onclick="transBtn('${item.ACNO}')">이체하기</a>
				</div>
			</div>
		</c:if>

		<c:if test="${fn:substring(item.ACNO,5,7) eq '76'}">
			<div class="visaul-info-box mb20 tab-cont03">
				<c:forEach var="bfInqResDs" items="${item }">
					<input type="hidden" id="${status.count}_${bfInqResDs.key }"
						value="${bfInqResDs.value }">
				</c:forEach>
				<a class="info-tit ico-arrow"
					onclick="goAcnoSrch('${item.ACNO}', '${item.PROD_NM}', '${item.LOAN_RPAY_MTH_NM}', '${item.PRGS_PERCENT}')"><em
					class="flag style5">신용대출</em>${item.PROD_NM }</a>
				<div class="account-area">
					<p class="account">
						<ft:format type="acno" value="${item.ACNO }"></ft:format>
					</p>
					<button type="button" class="btn-copy">복사하기</button>
				</div>

				<div class="account-info">
					<dl>
						<dt>내대출금</dt>
						<dd>
							<ft:format type="comma" value="${item.LOAN_PRNC }"></ft:format>
						</dd>
						<dd>월 35만원 납입${fn:substring(item.ACNO, 5, 2)}</dd>
						<dd>${item.LOAN_RPAY_MTH_NM }</dd>
					</dl>
					<div class="account-amount">
						<p class="amount-on">
							대출금액 <span><ft:format type="comma"
									value="${item.ACNT_BLNC }"></ft:format> </span>원
						</p>
						<p class="amount-off" style="display: none;">잔액숨김</p>
					</div>
				</div>

				<div class="progress-area">
					<div class="progress-wrap pb0">
						<div class="progress-line">
							<div class="progress-bar" style="width:${item.PRGS_PERCENT}%;">
								<em class="current">${item.PRGS_PERCENT}%</em>
								<!-- d-day -->
							</div>
						</div>
						<ul class="progress-txt">
							<li>최근 <span><ft:format type="date"
										value="${item.LAST_ITRV_DT }"></ft:format></span></li>
							<li><span>${item.INSM_NTM}회차</span>/<span>${item.CNPD_MMCO}개월</span></li>
							<li class="flag-right"><span> <!-- TODO 납입뱃지 설정 --> <!-- 납입완료 : 납부일자에 정상 납부 완료 -->
									<!-- 예정 : 예정 납부일 기준으로 D-7일 경우 --> <!-- 지연 : 예정 납부일에 납입하지 않은 경우 -->
									<!-- 예금 상품인 경우 납입완료 단일 표시 --> <em class="flag">${item.PAMN_STS_NM }</em>
							</span></li>
							<!-- [퍼블] 수정범위 클래스 변경-->
							<!-- 정상납부 -->
							<!-- <li class="flag-right"><span><em class="flag style8">예정</em></span></li> -->
							<!-- 응당일 7일전 -->
							<!-- <li class="flag-right"><span><em class="flag style3">지연</em></span></li> -->
							<!-- 지연 -->
							<!-- // [퍼블] 수정범위 클래스 변경-->
						</ul>
						<!-- 진행률 20%미만인 경우 -->
						<div class="progress-message">
							<c:if test="${item.PRGS_PERCENT < 20}">
								<!-- 진행률 20%미만인 경우 -->
								<span>잘 하실 수 있으세요! 파이팅</span>
							</c:if>
							<c:if
								test="${item.PRGS_PERCENT >= 20 and item.PRGS_PERCENT < 80}">
								<!-- 진행률 20%이상~ 80% 미만인 경우 -->
								<span>잘 하고 계시네요! 우리 함께 힘 내봐요</span>
							</c:if>
							<c:if
								test="${item.PRGS_PERCENT >= 80 and item.PRGS_PERCENT < 100}">
								<!-- 진행률 80% 이상 100%미만인 경우 -->
								<span>거의 다 왔어요 조금만 힘내세요!</span>
							</c:if>
							<c:if test="${item.PRGS_PERCENT == 100}">
								<!-- 진행률 만기인 경우 노출 -->
								<span>축하드려요! 만기에요</span>
								<a href="#none">상담원연결 &gt;</a>
							</c:if>
						</div>

						<!-- 진행률 20%이상~ 80% 미만인 경우-->
						<!-- <div class="progress-message"><span>잘 하고 계시네요! 우리 함께 힘 내봐요</span></div> -->

						<!-- 진행률 80% 이상 100%미만인 경우 -->
						<!-- <div class="progress-message"><span>거의 다 왔어요 조금만 힘내세요!</span></div> -->

						<!-- 진행률 만기인 경우 노출 -->
						<!-- <div class="progress-message"><span>축하드려요! 만기에요</span><a href="#none">상담원연결 &gt;</a></div> -->
					</div>
				</div>

				<div class="btn-cont-wrap mt20">
					<a href="#none" class="btn btn-info"
						onclick="goIntrWthd('${item.ACNO }')">이자즉시출금요청</a> <a href="#none"
						class="btn btn-primary" onclick="loanApply()">추가대출</a>
				</div>
			</div>
		</c:if>
	</c:forEach>

	<div class="banner-wrap">
		<a href="#none"
			onclick="doActionURL('/lon/inq/loanDetail.frm?LINK_ACT=BBS_SELECT&PDCD=P000000020');">
			<p>
				추가 대출이 필요하세요?
				<button type="button" class="banner-colse">닫기</button>
			</p>
			<dl>
				<dt>더좋은니즈론</dt>
				<dd>
					<p>당사의 신용/보증 대출을 이용한 고객님이면 가능해요!</p>
					<span>최대한도<br />
					<strong>7,000만원</strong></span>
				</dd>
			</dl>
		</a>
	</div>
</c:if>
