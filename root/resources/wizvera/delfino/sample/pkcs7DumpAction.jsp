<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.wizvera.crypto.PKCS7Verifier" %>
<%@ page import="com.wizvera.crypto.CertificateVerifier" %>
<%@ page import="java.security.cert.X509Certificate" %>

<%
	String pkcs7 = request.getParameter(PKCS7Verifier.PKCS7_NAME);
	String pkcs7Dump = com.wizvera.crypto.PKCS7Dump.dumpAsString(pkcs7);
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
		<meta name="viewport" content="width=device-width" />
    </head>
<body>
PKCS7:<%=pkcs7%><br/>
<p/>
dump
<pre>
<%=pkcs7Dump %>
</pre>
<a href="index.jsp"> 처음으로 </a>
</body>
</html>