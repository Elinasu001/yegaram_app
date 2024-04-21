<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.security.cert.X509Certificate" %>
<%@ page import="com.wizvera.crypto.CertUtil" %>
<%@ page import="com.wizvera.crypto.PKCS1Verifier" %>
<%@ page import="com.wizvera.crypto.PKCS1SignatureAlgorithm" %>
<%
	String SIGNER_CERT = "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";
	//String TBS_VALUE = "blxoaQ3RVvbakBEGfgsDQQNdfd42k_kZMsk9K7NhT-s=";
	//String SIG_VALUE = "F7zJ-9dC4_JdmD4gL5tVhoC1YlltBNq_ydebbbVCo-2rs3QZ6HyvZsQrlPIvqemQFhv-bd-ecWDb_iEcKxi9Af-1JiudTRhD4ZlJBJ4IDnz5c6-ZLKPGZ1o1kVGVMF05UjTP-Wbr3wZyqY97aHD7xopJr406nwvwUd6UcJslX7w-ZIoZxyhLvpfOemjGp-x0FOVgHgiGMQkXXpBcO0GOHOGYriYS_VUQcjWtgSTx9UR54eiAG4tT9PARhd1MZhIRXMNJJgp7B2ljAJGINaPyAVzS3Yb7IILBkvb0eNtB5rYQdyfM2DXibjig49T5gKgGjDS2piULxMtNkfecDyHnWA";
	String TBS_VALUE = "blxoaQ3RVvbakBEGfgsDQQNdfd42k/kZMsk9K7NhT+s=";
	String SIG_VALUE = "F7zJ+9dC4/JdmD4gL5tVhoC1YlltBNq/ydebbbVCo+2rs3QZ6HyvZsQrlPIvqemQFhv+bd+ecWDb/iEcKxi9Af+1JiudTRhD4ZlJBJ4IDnz5c6+ZLKPGZ1o1kVGVMF05UjTP+Wbr3wZyqY97aHD7xopJr406nwvwUd6UcJslX7w+ZIoZxyhLvpfOemjGp+x0FOVgHgiGMQkXXpBcO0GOHOGYriYS/VUQcjWtgSTx9UR54eiAG4tT9PARhd1MZhIRXMNJJgp7B2ljAJGINaPyAVzS3Yb7IILBkvb0eNtB5rYQdyfM2DXibjig49T5gKgGjDS2piULxMtNkfecDyHnWA==";
	
	boolean isVerified = false;
	try {
		byte[] tbsData = com.wizvera.util.Base64.decode(TBS_VALUE);
	 	out.println("<br/>tbsData: Base64.decode: ok");
		byte[] signature = com.wizvera.util.Base64.decode(SIG_VALUE);
	 	out.println("<br/>signature: Base64.decode: ok");
		X509Certificate signerCert = CertUtil.loadCertificateFromString(SIGNER_CERT);
	 	out.println("<br/>signerCert: CertUtil.loadCertificateFromStrin: ok");
		
		PKCS1Verifier pkcs1Verifier = new PKCS1Verifier();
	 	isVerified = pkcs1Verifier.verifyPKCS1(PKCS1SignatureAlgorithm.PKCS1_V15_SHA256, tbsData, signature, signerCert);
	 	out.println("<br/>pkcs1Verifier: result: " + isVerified);
	 	
	 	System.out.println("pkcs1Verifier: result: " + isVerified);
	 	System.out.println(signerCert.toString());
	} catch (Exception e) {
        out.println("<br/><hr/><b>Exception - ERR(?)</b>");
        out.println("<br/>FileName: " + request.getServletPath());
        out.println("<br/>getMessage: " + e.getMessage());
        java.io.StringWriter sw = new java.io.StringWriter();
        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
        e.printStackTrace(pw);
        out.println("<br><br><b>printStackTrace</b><br>");
        out.println("<font size='2'>" + sw.toString() + "<font>");
        
		e.printStackTrace();
	}
%>