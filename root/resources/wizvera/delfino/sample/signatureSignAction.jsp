<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@ page import="com.wizvera.crypto.PKCS7Verifier" %>
<%@ page import="com.wizvera.crypto.CertificateVerifier" %>
<%@ page import="java.security.cert.X509Certificate" %>
<%@ page import="java.security.cert.CertificateFactory" %>
<%@ page import="java.security.Signature" %>
<%@ page import="java.security.GeneralSecurityException" %>
<%@ page import="com.wizvera.util.Base64" %>



<%!
public class SignatureVerifier {
	X509Certificate signer;
	
	public boolean verify(String digestAlg, String certstring, String data, String sig, String charset) throws GeneralSecurityException, UnsupportedEncodingException{		
		CertificateFactory cf = CertificateFactory.getInstance("X.509");
		signer = (X509Certificate) cf.generateCertificate(new ByteArrayInputStream(certstring.getBytes()));

		//TODO: 서명알고리즘 선택
		String sigAlg = signer.getSigAlgName();
		System.out.println(sigAlg);
		sigAlg = digestAlg + "withRSA";
		Signature signature = Signature.getInstance(sigAlg);
		signature.initVerify(signer);
		signature.update(data.getBytes(charset));
		return signature.verify(Base64.decode(sig));
	}
	
	public X509Certificate getSignerCertificate(){
		return signer;
	}
}
%>
<%
	String signData = request.getParameter("signData");
	String cert = request.getParameter("cert");
	String rawData = request.getParameter("rawData");
	String digestAlg = request.getParameter("alg");
	

	SignatureVerifier signVerifier = new SignatureVerifier();
		
	String errorMessage = null;
	X509Certificate signerCert = null;
	boolean signVerify=false;
	try {	
		signVerify = signVerifier.verify(digestAlg, cert, rawData, signData, "utf8");				
		signerCert = signVerifier.getSignerCertificate();
		if(!signVerify){
			errorMessage = "not match sign";	
		}
	} catch (Exception e) {
		errorMessage = "Error Occured:" + e.toString();
		e.printStackTrace();
	}	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
	<title>전자서명</title>
</head>
<body>

<%if(errorMessage!=null){ %>
<h1>서명확인 실패</h1>
<div><%=errorMessage%></div>
<%}else{ %>
<h1>서명확인 성공</h1>
<%}%>

<%if(signerCert!=null){ %>
<div>
<h3>인증서 정보</h3>
<ul>
<li>발급자 : <%=signerCert.getIssuerX500Principal().getName()%></li>
<li>주체 : <%=signerCert.getSubjectX500Principal().getName()%></li>
<li>시리얼번호 : <%=signerCert.getSerialNumber()%></li>
</ul>
</div>
<%} %>

<div>
<h3>서명 데이터</h3>
<ul>
<li>signData : <%=signData%></li>
<li>서명원문 : <%=rawData%></li>
<li>서명자 인증서 :
<pre> 
<%=cert%>
</pre>
</li>
</ul>
</div>


<br/><br/>
<a href="index.jsp">처음으로</a>
<a href="javascript:history.back(-1);">뒤로</a>
</body>
</html>