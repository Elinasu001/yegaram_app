<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.wizvera.crypto.PKCS7Verifier" %>
<%@ page import="com.wizvera.crypto.CertificateVerifier" %>
<%@ page import="java.security.cert.X509Certificate" %>

<html>
<body>
<%!
	String toStringForMultiValueUserConfirmFormat(HashMap format) {
		StringBuffer sb = new StringBuffer();	
		try {
			
			sb.append('{');
			Set keys = format.keySet();
			Iterator it = keys.iterator();
			while(it.hasNext()) {
				String key = (String)it.next();
				Object valueObj = format.get(key);
				
				String[] values ;
				if (valueObj instanceof String[]) {
					values = (String[])	valueObj;
				} else {
					values = new String[1];
					values[1] = valueObj.toString();
				}
				
				sb.append(key);
				sb.append('=');
				sb.append(Arrays.toString(values));
				if(it.hasNext()) {
					sb.append(',');
				}
			}
			sb.append('}');
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return sb.toString();
	}
%>
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

		
		
		// 서명 데이타 포맷 검증하기 
		HashMap expectedUserConfirmForm = new HashMap();
		
		//var formats1 = "출금계좌번호1:이체금액1:수수료1:내 통장 표시내용1:입금은행1:입금계좌번호1:수취인1:수취인 통장 표시내용1";
		//var formats2 = "출금계좌번호2:이체금액2:수수료2:내 통장 표시내용2:입금은행2:입금계좌번호2:수취인2:수취인 통장 표시내용2";
	
		expectedUserConfirmForm.put("출금계좌번호",new String[] { "출금계좌번호1", "출금계좌번호2" });
		expectedUserConfirmForm.put("이체금액",new String[] { "이체금액1", "이체금액2" });
		expectedUserConfirmForm.put("수수료",new String[] { "수수료1", "수수료2" });
		expectedUserConfirmForm.put("내 통장 표시내용",new String[] { "내 통장 표시내용1", "내 통장 표시내용2" });
		expectedUserConfirmForm.put("입금은행",new String[] { "입금은행1", "입금은행2" });
		expectedUserConfirmForm.put("입금계좌번호",new String[] { "입금계좌번호1", "입금계좌번호2" });
		expectedUserConfirmForm.put("수취인",new String[] { "수취인1", "수취인2" });
		expectedUserConfirmForm.put("수취인 통장 표시내용",new String[] { "수취인 통장 표시내용1", "수취인 통장 표시내용2" });
		
		
		if (p7helper.verifyUserConfirmFormat(expectedUserConfirmForm) == false) {
			String errMsg = "사용자 데이타 포맷이 기대치와 다릅니다."
				+ "<br/>" + toStringForMultiValueUserConfirmFormat(p7helper.getMultiValueUserConfirmFormat())
				+ "<br/>" + toStringForMultiValueUserConfirmFormat(expectedUserConfirmForm);
				
			throw new Exception(errMsg);

		}
		
		Map<String, String[]> signedParameterMap = p7helper.getSignedParameterMap();
		
		for(Map.Entry entry : signedParameterMap.entrySet() ){	
			if("__CERT_STORE_MEDIA_TYPE".equals(entry.getKey())==false 
					&& "__USER_CONFIRM_FORMAT".equals(entry.getKey())==false ){
				for(String value: (String[])entry.getValue()){
					out.print("<br/>" + entry.getKey() + ":" + value);
				}
			}
		}
		
		X509Certificate cert =p7helper.getSignerCertificate();
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
