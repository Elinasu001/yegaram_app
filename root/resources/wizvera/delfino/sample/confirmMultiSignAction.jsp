<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.wizvera.crypto.PKCS7Verifier" %>
<%@ page import="java.security.cert.X509Certificate" %>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0; width=device-width" />
</head>
<body>

<%
	request.setCharacterEncoding("utf8"); 
	String pkcs7s = request.getParameter("PKCS7");
%>

PKCS7:<%=pkcs7s%><br/>

<%
	try { 
		
		String[] pkcs7Array = pkcs7s.split("\\|");
		String expectFormats = (String)session.getAttribute("confirmSign.format");
		String[] expectFormatArray = expectFormats.split("\\|");
		System.out.println("pkcs7 size:"+ pkcs7Array.length);
		for(int i=0; i<pkcs7Array.length; i++){
			String signData = pkcs7Array[i];
			String expectFormat = expectFormatArray.length==1 ?  expectFormatArray[0] : expectFormatArray[i];
			X509Certificate signerCert = null;
			PKCS7Verifier p7helper=null;
			
			String signedRawData="";
			String errorMessage="";
			try {	
				p7helper = new PKCS7Verifier(signData, "utf8");		
				//signedRawData = p7helper.getSignedRawData();
				signerCert = p7helper.getSignerCertificate();
			} catch (Exception e) {
				errorMessage = "Error Occured:" + e.toString();
				e.printStackTrace();
			}
			
			out.println("format:" + p7helper.getUserConfirmFormatRawData());
			
			if(!p7helper.getUserConfirmFormatRawData().equals(expectFormat)){
				errorMessage = "포맷검증 실패<br/>";
				errorMessage += "expect:" + expectFormat + "<br/>";
				errorMessage += "format:" + p7helper.getUserConfirmFormatRawData()+ "<br/>";
			}
			
			if(errorMessage.length()>0){
				out.println("Error Occured:" + errorMessage);
			}
			
			X509Certificate cert = p7helper.getSignerCertificate();
				
			out.println("<br/> signedRawData:" + p7helper.getSignedRawData());
			
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
