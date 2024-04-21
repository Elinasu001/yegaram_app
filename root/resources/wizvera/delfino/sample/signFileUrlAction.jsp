
<%-- --------------------------------------------------------------------------
 - File Name   : fileSignResult.jsp(전자서명 샘플)
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
	request.setCharacterEncoding("utf8");
    String signFileName = request.getParameter("data");
	System.out.println("signFileName:" + signFileName);

    String signFilePath = "/opt/delfino/upload/" + signFileName;        
    boolean validationCert = false;
%>
<%
    out.println("<b>파일 전자서명 검증 결과</b>");
    try{
        ScourtFileSignVerifier scourtFileSignVerifier = null;
        SignVerifier signVerifier = null;
    	ScourtFileSignVerifierResult result = null;
	    SignVerifierResult signVerifierResult = null;
        
        
        out.println("<br/><b>서명원본파일</b>[" + signFileName + "]");
    	scourtFileSignVerifier = new ScourtFileSignVerifier();
    	result = scourtFileSignVerifier.verifyFileSignData(signFilePath, validationCert);
    	String fileName = result.getFileName();
    	fileName = fileName.replaceAll("/", "_");
    	fileName = fileName.replaceAll("\\\\", "_");
    	
    	String orginDataSaveFilePath = "/opt/delfino/upload/org/" + fileName;    	
    	result.saveOriginFile(orginDataSaveFilePath);
    	
		out.println("<br/>-. scourtFileSignVerifier.verifyFileSignData: <b>OK</b>");
		out.println("<br/>--. scourtFileSignVerifier.getFileName: <b>" + result.getFileName() + "</b>");
		out.println("<br/>--. scourtFileSignVerifier.getLastModDate : <b>" + result.getLastModDate() + "</b>");
		out.println("<br/>--. scourtFileSignVerifier.getSignerCert.getSubjectDN : <b>" + result.getSignerCert().getSubjectDN().getName() + "</b>");
		out.println("<br/>--. scourtFileSignVerifier.getOriginFileData.length : <b>" + result.getOriginFileData().length + "bytes</b>");
		
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
        out.println("<br/>FileName: " + signFilePath);
        
        java.io.StringWriter sw = new java.io.StringWriter();
        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
        e.printStackTrace();
        e.printStackTrace(pw);
        out.println("<br><br><b>printStackTrace</b><br>");
        out.println("<font size='2'>" + sw.toString() + "<font>");
    } catch(Exception e) {
        out.println("<br/><hr/><b>Exception - ERR(?)</b>");
        out.println("<br/>FileName: " + signFilePath);
        out.println("<br/>getMessage: " + e.getMessage());
        java.io.StringWriter sw = new java.io.StringWriter();
        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
        e.printStackTrace(pw);
        out.println("<br><br><b>printStackTrace</b><br>");
        out.println("<font size='2'>" + sw.toString() + "<font>");
    }
%>
