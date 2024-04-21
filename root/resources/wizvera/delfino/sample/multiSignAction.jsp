<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.wizvera.crypto.PKCS7Verifier" %>
<%@ page import="java.security.cert.X509Certificate" %>

<html>
<body>

<%
	request.setCharacterEncoding("utf8"); 
	String pkcs7s = request.getParameter("PKCS7");
	String vid = request.getParameter("VID_RANDOM");
%>

PKCS7:<%=pkcs7s%><br/>
VID_RANDOM:<%=vid%><br/>

<%
	try { 
		
		String[] pkcs7Array = pkcs7s.split("\\|");
		for(int i=0; i<pkcs7Array.length; i++){
			String pkcs7 = pkcs7Array[i];
			PKCS7Verifier p7 = null;
			String encoding = request.getCharacterEncoding();
			p7 = new PKCS7Verifier(pkcs7,encoding);
	
			String a = p7.getSignedParameter("a");
			String b = p7.getSignedParameter("b");
			String c = p7.getSignedParameter("c");
		
			X509Certificate cert = p7.getSignerCertificate(); 
		
			out.println("<br/> a:" + a);
			out.println("<br/> b:" + b);
			out.println("<br/> c:" + c);
			out.println("<br/> signedRawData:" + p7.getSignedRawData());
			
			out.println("<br/> Certificate issuer:" + cert.getIssuerX500Principal().getName());
			out.println("<br/> Certificate subject:" + cert.getSubjectX500Principal().getName());
			out.println("<br/> Certificate Serial Number:" + cert.getSerialNumber());
			out.println("<br/>");
		}

	} catch (Exception e) {
		out.println("<p/>");
		out.println("Error Occured:" + e.toString());
		out.println("<p/>");
		e.printStackTrace();
	}

%>

</body>
</html>
