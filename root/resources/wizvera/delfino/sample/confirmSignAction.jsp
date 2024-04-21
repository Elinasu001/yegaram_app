<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.net.*"%>
<%@ page import="com.wizvera.crypto.PKCS7Verifier" %>
<%@ page import="com.wizvera.crypto.CertificateVerifier" %>
<%@ page import="java.security.cert.X509Certificate" %>

<%
	String signData = request.getParameter("PKCS7");
	PKCS7Verifier p7helper = null;
	String signedRawData="";
	String errorMessage=null;
	X509Certificate signerCert = null;
	try {	
		p7helper = new PKCS7Verifier(signData, "utf8");
		signedRawData = p7helper.getOriginSignedRawData();		
		signerCert = p7helper.getSignerCertificate();
	} catch (Exception e) {
		errorMessage = "Error Occured:" + e.toString();
		e.printStackTrace();
	}
		
	String expectFormat = (String)session.getAttribute("confirmSign.format");
	if(!p7helper.getUserConfirmFormatRawData().equals(expectFormat)){
		errorMessage = "포맷검증 실패";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
	<title>전자서명</title>
<%@ include file="../svc/delfino.jsp" %>
</head>
<body>

<%if(errorMessage!=null){ %>
<h1>서명확인 실패</h1>
<div><%=errorMessage%></div>
<%}else{ %>
<h1>서명확인 성공</h1>
<%}%>

<%if(signerCert!=null){ %>
<div>
<h3>인증서 정보</h3>
<ul>
<li>발급자 : <%=signerCert.getIssuerX500Principal().getName()%></li>
<li>주체 : <%=signerCert.getSubjectX500Principal().getName()%></li>
<li>시리얼번호 : <%=signerCert.getSerialNumber()%></li>
</ul>
</div>
<%} %>

<div>
<h3>서명 데이터</h3>
<ul>
<li>signData : <%=signData%></li>
<li>서명원문 : <%=signedRawData%></li>
<li>format : <%=p7helper.getUserConfirmFormatRawData()%></li>
<li>format : <%=p7helper.getSignedParameter(PKCS7Verifier.USER_CONFIRM_FORMAT_NAME)%></li>
</ul>
</div>

<div>
<h3>PKCS7 Dump</h3>
<pre>
<%=com.wizvera.crypto.PKCS7Dump.dumpAsString(signData)%>
</pre>
</div>

<br/><br/>
<a href="index.jsp">처음으로</a>
<a href="javascript:history.back(-1);">뒤로</a>
</body>
</html>
