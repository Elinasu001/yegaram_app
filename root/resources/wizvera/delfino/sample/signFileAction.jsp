
<%-- --------------------------------------------------------------------------
 - File Name   : sigFileAction.jsp(전자서명 샘플)
 - Include     : NONE
 - Author      : WIZVERA
 - Last Update : 2015/11/16
-------------------------------------------------------------------------- --%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.lang.*, java.text.*, java.net.*" %>
<%@ page import="java.security.cert.X509Certificate" %>

<%@ page import="com.wizvera.service.SignVerifier" %>
<%@ page import="com.wizvera.service.SignVerifierResult" %>
<%@ page import="com.wizvera.service.ScourtFileSignVerifier" %>
<%@ page import="com.wizvera.service.ScourtFileSignVerifierResult" %>
<%@ page import="com.wizvera.service.DelfinoServiceException" %>
<%
    java.text.DateFormat logDate = new java.text.SimpleDateFormat("[yyyy/MM/dd HH:mm:ss] ");
    System.out.println(logDate.format(new java.util.Date())+request.getRequestURI()+" "+request.getMethod()+"[" + request.getRemoteAddr() + "]");
%>
<%
    String pkcs7 = request.getParameter(SignVerifier.PKCS7_NAME);
    String vidRandom = request.getParameter(SignVerifier.VID_RANDOM_NAME);
    String tbsFilePath = request.getParameter("tbsFilePath");    
    String signature = request.getParameter("signature");
    String cert = request.getParameter("cert");
    
    boolean validationCert = true;
%>
<%
    out.println("<b>파일 전자서명 검증 결과</b>");
    try{
        SignVerifier signVerifier = null;
    	ScourtFileSignVerifierResult result = null;
	    SignVerifierResult signVerifierResult = null;
      
		signVerifier = new SignVerifier();
	    signVerifierResult = signVerifier.verifySignatureOfFile(signature, tbsFilePath, cert, validationCert);
	        
	    out.println("<br/>-. signVerifier.verifySignatureOfFile: <b>OK</b>");
	    out.println("<br/>--. signer cert dn:<b>" + signVerifierResult.getSignerCertificate().getSubjectDN().getName() + "</b>");
	    if( validationCert ){
	    	out.println("<br/>--. signer cert valdiation result:<b>OK</b>");
		}
    
    } catch(DelfinoServiceException e) {
        out.println("<br/><hr/><b>DelfinoServiceException - ERR(?)</b>");
        out.println("<br/>getServletPath: " + request.getServletPath());
        out.println("<br/>getMessage: " + e.getMessage());
        out.println("<br/>getErrorCode: " + e.getErrorCode());
        out.println("<br/>getErrorUserMessage(kr): " + e.getErrorUserMessage());
        out.println("<br/>getErrorUserMessage(en): " + e.getErrorUserMessage(com.wizvera.service.util.ErrorConvert.LOCALE_EN));
        java.io.StringWriter sw = new java.io.StringWriter();
        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
        e.printStackTrace();
        e.printStackTrace(pw);
        out.println("<br><br><b>printStackTrace</b><br>");
        out.println("<font size='2'>" + sw.toString() + "<font>");
    } catch(Exception e) {
        out.println("<br/><hr/><b>Exception - ERR(?)</b>");
        out.println("<br/>FileName: " + request.getServletPath());
        out.println("<br/>getMessage: " + e.getMessage());
        java.io.StringWriter sw = new java.io.StringWriter();
        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
        e.printStackTrace(pw);
        out.println("<br><br><b>printStackTrace</b><br>");
        out.println("<font size='2'>" + sw.toString() + "<font>");
    } finally {
        out.println("<!--\n" + pkcs7 + "\n-->");
        if (pkcs7 != null && !"".equals(pkcs7)) out.println("<!--\n" + com.wizvera.crypto.PKCS7Dump.dumpAsString(pkcs7) + "\n-->");
    }
%>
