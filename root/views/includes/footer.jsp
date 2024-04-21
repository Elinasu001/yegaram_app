<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.wizvera.WizveraConfig"%>
<%@ page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String footerType = request.getParameter("type"); // DEFAULT MENU
	footerType = StringUtils.isEmpty(footerType) ? "DEFAULT" : footerType;
%>
<footer>
<!-- 푸터 타입별 정의 -->
</footer>

<!-- 업무공통 -->
<jsp:include page="/WEB-INF/views/includes/common_biz.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/includes/common_efn.jsp"></jsp:include>
<c:if test="${resDs.APP_HEADER.errYn eq 'Y' }">
<script type="text/javascript">
	<%-- E90000=본인인증 후 이용 가능한 거래입니다. --%>
	<c:if test="${resDs.APP_HEADER.respCd eq 'E90000' }">
		biz.confirm('${resDs.APP_HEADER.respMsg}', function(){
			biz.login(function(resDs){
				doReload();
			});
		}, goMainPage, "로그인", "홈으로");
	</c:if>
	<%-- E90001=로그인 후 이용 가능한 거래입니다. --%>
	<c:if test="${resDs.APP_HEADER.respCd eq 'E90001' }">
		biz.confirm('${resDs.APP_HEADER.respMsg}', function(){
			biz.login(function(resDs){doReload();});
		}, goMainPage, "로그인", "홈으로");
	</c:if>
	<%-- E90002=전자금융 가입 후 이용 가능한 거래입니다. --%>
	<c:if test="${resDs.APP_HEADER.respCd eq 'E90002' }">
		biz.confirm('${resDs.APP_HEADER.respMsg}', function(){
			biz.usrIdReg('Y', function(){
				doReload();
			});	
		}, goMainPage, "가입하기", "홈으로");
	</c:if>
	<%-- E90003=계좌개설 후 이용 가능한 거래입니다. --%>
	<c:if test="${resDs.APP_HEADER.respCd eq 'E90003' }">
		biz.alert('${resDs.APP_HEADER.respMsg}', "확인", goMainPage);
	</c:if>
</script>
</c:if>

<!-- //업무공통 -->
<%if ("MENU".equals(footerType)) {%>
<div class="bottom-menu-area">
    <ul class="bottom-menu-list">
        <!-- s: 2023-06-23 수정 범위 -->
        <li class="on"><a href="javascript:goMainPage();">홈</a></li>
        <li><a href="javascript:doActionMenu('lon/inq/loanList','BBS_SELECT');">대출</a></li>
        <li><a href="javascript:doActionMenu('dep/inq/depList','BBS_SELECT');">예/적금</a></li>
        <li><a href="javascript:openMenu('menuWrap');">전체메뉴</a></li>
        <!-- e: 2023-06-23 수정 범위 -->
    </ul>
</div>
<script type="text/javascript">
$(document).ready(function(){
	$("#menuDiv").load("/includes/menu.frm", {"LINK_ACT":"MAIN_SELECT","txGbnCd":"MNU"}, 
			function(){});	
});
</script>
<div id="menuDiv"></div>
<%}%>
<!-- 프로그레스바 -->
<div class="loading" id="loading" style="display:none">
	<div class="loader-square-9"></div>
</div>

<!-- 토스트 -->
<div class="toast" style=""><p>테스트</p></div>
<style type="text/css">
.toast {
	position: fixed;
	right: 50%;
	bottom: -10%;
	transform: translateX(50%);
	z-index: 100;
}
.toast p {
	display: none;
	font-size: 16px;
	font-weight: 400;
	color: #333;
	background: #fff;
	padding: 14px 20px;
	box-shadow: 0 4px 13px 0 rgba(0, 0, 0, 0.16);
	border-radius: 10px;
	font-family: 'Spoqa Han Sans Neo', sans-serif;
}
</style>
<%-- Wizvera Delfino G10 --%>
<%
	String systemMode = ""; // test, real
	String systemLang = "KOR";
	String siteName = "delfino";
	String moduleType = "";
	String userAgent = request.getHeader("User-Agent");
	String clientIP = request.getHeader("X-Forwarded-For");
	String _delfinoNoCache = new java.text.SimpleDateFormat("yyMMdd_HHmm").format(new java.util.Date());

	if (clientIP == null || clientIP.length() == 0 || "unknown".equalsIgnoreCase(clientIP))
		clientIP = request.getHeader("Proxy-Client-IP");
	if (clientIP == null || clientIP.length() == 0 || "unknown".equalsIgnoreCase(clientIP))
		clientIP = request.getHeader("WL-Proxy-Client-IP");
	if (clientIP == null || clientIP.length() == 0 || "unknown".equalsIgnoreCase(clientIP))
		clientIP = request.getHeader("HTTP_CLIENT_IP");
	if (clientIP == null || clientIP.length() == 0 || "unknown".equalsIgnoreCase(clientIP))
		clientIP = request.getHeader("HTTP_X_FORWARDED_FOR");
	if (clientIP == null || clientIP.length() == 0 || "unknown".equalsIgnoreCase(clientIP))
		clientIP = request.getRemoteAddr();
%>
<script type="text/javascript">
	<c:if test="${spring.profiles.active eq 'prod'}">
		var _SITE_SystemMode = "real"; // real, test
	</c:if>
	<c:if test="${spring.profiles.active ne 'prod'}">
		var _SITE_SystemMode = "test"; // real, test
	</c:if>
    var _SITE_SystemLang = "<%=systemLang%>"; // KOR, ENG, CHN, JPN
    var _SITE_SiteName = "<%=siteName%>";     // pc, mobile, tablet
    var _SITE_ModuleType = "<%=moduleType%>"; // "", G2, G3, G4

</script>
<script src="<c:url value='/resources/wizvera/delfino/delfino_config.js?<%=_delfinoNoCache%>'/>" charset="utf-8"></script>
<script src="<c:url value='/resources/wizvera/delfino/delfino_internal.min.js?<%=_delfinoNoCache%>'/>" charset="utf-8"></script>
<script src="<c:url value='/resources/wizvera/delfino/delfino.js?<%=_delfinoNoCache%>'/>" charset="utf-8"></script>
<script src="<c:url value='/resources/wizvera/delfino/delfino_site.js?<%=_delfinoNoCache%>'/>" charset="utf-8"></script>
<!-- Open Web nFilter 가상키패드 -->
<%@include file="/resources/nfilter/jsp/open_nFilter.jsp" %>
<script type="text/javascript">
//Delfino G10 Setting
Delfino.setModule('G10');
// 가상키패드 서버키
nshc.setInit();
</script>

<%-- 
<jsp:include page="/WEB-INF/views/includes/v3_common.jsp"></jsp:include>
--%>