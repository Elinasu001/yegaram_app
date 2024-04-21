<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="com.wizvera.service.*" %>
<%@ page import="java.security.cert.X509Certificate" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
		<meta name="viewport" content="width=device-width" />
		<title>서명 test</title>
		
<%@ include file="../svc/delfino.jsp" %>		

    </head>


<body>

<%
	String pkcs7 = request.getParameter(SignVerifier.PKCS7_NAME);
	String vid = request.getParameter(SignVerifier.VID_RANDOM_NAME);
%>


<%
SignVerifierResult result=null;

	try {
		
		pkcs7 = SignVerifier.toContentInfo(pkcs7);
		SignVerifier verifier = new SignVerifier();
		result = verifier.verifyPKCS7WithoutCertValidation(pkcs7);
		
		
		X509Certificate cert = result.getSignerCertificate();
		
		out.println("<br/><br/> Certificate issuer:" + cert.getIssuerX500Principal().getName());
		out.println("<br/> Certificate subject:" + cert.getSubjectX500Principal().getName());
		out.println("<br/> Certificate Serial Number:" + cert.getSerialNumber());
		out.println("<br/><br/>");

	} catch (Exception e) {
		out.println("<p/>");
		out.println("Error Occured:" + e.toString());
		out.println("pkcs7:" + pkcs7);
		out.println("<p/>");
		e.printStackTrace();
	}

%>

<%if(result!=null){ %>

	전자서명원문데이터:<%=result.getSignedRawData()%>
	<br/>	
	PKCS7:<%=pkcs7%><br/>
	<p/>
	PKCS7:
	<pre>
	<%=com.wizvera.crypto.PKCS7Dump.dumpAsString(pkcs7)%>
	</pre>

<%} %>


<br/>
<a href="index.jsp"> 처음으로 </a>
</body>
</html>