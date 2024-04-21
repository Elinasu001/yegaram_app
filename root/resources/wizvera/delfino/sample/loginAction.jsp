<%@page import="java.io.FileOutputStream"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.wizvera.crypto.PKCS7Verifier" %>
<%@ page import="com.wizvera.crypto.CertificateVerifier" %>
<%@ page import="com.wizvera.crypto.CertUtil" %>
<%@ page import="com.wizvera.WizveraConfig" %>

<%@ page import="com.wizvera.WizveraConfig" %>
<%@ page import="com.wizvera.crypto.ocsp.OcspManager" %>
<%@ page import="com.wizvera.crypto.ocsp.response.OcspResponseResult" %>
<%@ page import="com.wizvera.crypto.ocsp.response.CertStatusInfo" %>

<%@ page import="java.security.cert.X509Certificate" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.security.cert.PKIXCertPathBuilderResult" %>
<%@ page import="java.security.cert.CertPath" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0; width=device-width" />
	<title>Login</title>
	<%@ include file="../svc/delfino.jsp" %>
</head>	
<body>

<%

	/////////////////////////////////////////////////////////////////////////
	// 기본설정 생성법
	// 1. WizveraConfig의 기본설정 가져오기
	// delfino.jar와 물리적으로 같은 디렉토리에 delfino.properties를 찾아 기본설정이 생성됩니다.
	// WizveraConfig wizConfig = WizveraConfig.getDefaultConfiguration();
	
	// 2. WizveraConfig 직접 만드는 방법
	// String configFile = "/someWhere/delfino.properties";
	// WizveraConfig wizConfig = new WizveraConfig(configFile);
		
	// delfino-demo 에서는 delfino.properties가 포함(자동으로 생성됨)되어있습니다.
	WizveraConfig wizConfig = WizveraConfig.getDefaultConfiguration();
%>

<%
	String pkcs7 = request.getParameter(PKCS7Verifier.PKCS7_NAME);
	String vid = request.getParameter(CertificateVerifier.VID_RANDOM_NAME);
	String macAddress = request.getParameter("MACAddress");
	String pkcs7Dump = com.wizvera.crypto.PKCS7Dump.dumpAsString(pkcs7);
	System.out.println(pkcs7Dump);
%>

PKCS7:<%=pkcs7%><br/>
VID_RANDOM:<%=vid%><br/>
MACAddress:<%=macAddress%><br/>

<%
	try {
		PKCS7Verifier p7helper = null;
		String encoding = request.getCharacterEncoding();
		p7helper = new PKCS7Verifier(pkcs7,encoding);
		out.println("rawdata:" + p7helper.getSignedRawData());
		CertificateVerifier certVerifier = 
			new CertificateVerifier(p7helper.getSignerCertificate(), wizConfig);
		

		String nonce = p7helper.getSignedParameter("delfinoNonce");
		String idn = p7helper.getSignedParameter("juminbunho");
		out.println("<br/> 주민번호 : " + idn);
		//nonce 처리
		if(nonce==null || !nonce.equals(session.getAttribute("delfinoNonce"))){
			out.println("<br/> login fail:nonce not match:" + nonce);
		}
		else{

			X509Certificate cert = p7helper.getSignerCertificate(); 
			
			//인증서 상태 처리
			// .... 
			
			// vid check
			boolean isValidVid = certVerifier.isValidVID(vid, idn);
			
			// oid check
			boolean isAllowCertificatePolicy = certVerifier.isAllowCertificatePolicy();
			
			// 주의. 인증서 경로 검증 : 경로검증 실패시 CryptoException이 발생한다.
			boolean checkCRL = false;
			PKIXCertPathBuilderResult ppbr = certVerifier.verifyPathValidationWithResult(checkCRL);
			
			// 인증서 경로 검증에 사용된 인증서들 가져오기.
			// 1. root ca
			X509Certificate rootCA = ppbr.getTrustAnchor().getTrustedCert();
			System.out.println("rootCA : " + rootCA.getSubjectDN());
			// 2. 기타 참여 인증서들(0(자기자신, 1번 자신을 발행한 인증서, ...)
			CertPath certPath =  ppbr.getCertPath();
			List certs = certPath.getCertificates();
			for (int i = 0; i < certs.size(); i++) {
				X509Certificate certInPath = (X509Certificate)certs.get(i);
				System.out.println("cert " + i + " : "+ certInPath.getSubjectDN());
			}
			
			// 첫번째 OID 가져오기
			String firstOID = CertUtil.getCertificatePolicyOID(cert);
	
			out.println("<br/> nonce:" + nonce);
			out.println("<br/> Certificate issuer:" + cert.getIssuerX500Principal().getName());
			out.println("<br/> Certificate subject:" + cert.getSubjectX500Principal().getName());
			out.println("<br/> Certificate Serial Number:" + cert.getSerialNumber());
			out.println("<br/> Certificate 첫번째 oid:" + firstOID);
			
			// 3. OCSP Check
			OcspManager ocspManager = OcspManager.getInstance( wizConfig );
			OcspResponseResult ocspResponseResult = ocspManager.getCertStatus( cert );
			
			if( ocspResponseResult.getCertStatusInfo() == CertStatusInfo.GOOD  ){
				out.println("<br/> OCSP STATUS check : OK");
			}else{
				out.println("<br/> OCSP STATUS check : <b>FAIL</b>");
			}
			
			if (isValidVid == true) {
				out.println("<br/> VID check : OK ");
			} else {
				out.println("<br/> VID check : <b>FAIL</b>");
			}
			
			if (isAllowCertificatePolicy) {
				out.println("<br/> OID check : OK");
			} else {
				throw new Exception("로그인이 허용되지 않는 인증서입니다.");
			}
			out.println("<br/>");
			
			
		}

	} catch (Exception e) {
		out.println("<p/>");
		out.println("Error Occured: <b>" + e.toString());
		out.println("</b><p/>");		
		e.printStackTrace();
	}

%>

</body>
</html>
