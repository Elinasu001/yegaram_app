<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.wizvera.crypto.PKCS7Verifier" %>
<%@ page import="com.wizvera.crypto.CertificateVerifier" %>
<%@ page import="java.security.cert.X509Certificate" %>

<html>
<body>

<%
	String pkcs7 = request.getParameter(PKCS7Verifier.PKCS7_NAME);
	String vid = request.getParameter(CertificateVerifier.VID_RANDOM_NAME);
%>

PKCS7:<%=pkcs7%><br/>
VID_RANDOM:<%=vid%><br/>

<%
	try {
		PKCS7Verifier p7helper = null;
		String encoding = request.getCharacterEncoding();
		p7helper = new PKCS7Verifier(pkcs7,encoding);

		String account = p7helper.getSignedParameter("account");
		String recvUser = p7helper.getSignedParameter("recvUser");
		String amount = p7helper.getSignedParameter("amount");
		String remark = p7helper.getSignedParameter("비고");
	
		// 서명 데이타 포맷 검증하기 
		HashMap<String, String> expectedUserConfirmForm = new HashMap<String, String>();
		expectedUserConfirmForm.put("account", "계좌번호");
		expectedUserConfirmForm.put("recvUser", "받는사람");
		expectedUserConfirmForm.put("amount", "금액;currency");
		expectedUserConfirmForm.put("비고", "비고");
		expectedUserConfirmForm.put("포맷비어있음", "");
		HashMap<String, String> userConfirmForm = p7helper.getUserConfirmFormat();
		
		if (expectedUserConfirmForm.equals(userConfirmForm) == true) {
			String errMsg = "사용자 데이타 포맷이 기대치와 다릅니다."
					+ "<br/>" + expectedUserConfirmForm
					+ "<br/>" + userConfirmForm ;
					
			out.println(errMsg);
			//throw new Exception(errMsg);
		}
		
		X509Certificate cert = p7helper.getSignerCertificate(); 
	
		out.println("<br/> account:" + account);
		out.println("<br/> recvUser:" + recvUser);
		out.println("<br/> amount:" + amount);
		out.println("<br/> 비고:" + amount);
		
		out.println("<br/> Certificate issuer:" + cert.getIssuerX500Principal().getName());
		out.println("<br/> Certificate subject:" + cert.getSubjectX500Principal().getName());
		out.println("<br/> Certificate Serial Number:" + cert.getSerialNumber());
		out.println("<br/>");

	} catch (Exception e) {
		out.println("<p/>");
		out.println("Error Occured:" + e.toString());
		out.println("<p/>");
		e.printStackTrace();
	}

%>

</body>
</html>
