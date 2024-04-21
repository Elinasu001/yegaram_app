<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.security.cert.X509Certificate" %>

<%@ page import="com.wizvera.WizveraConfig" %>
<%@ page import="com.wizvera.crypto.PKCS7Verifier" %>
<%@ page import="com.wizvera.crypto.CertificateVerifier" %>
<%@ page import="com.wizvera.crypto.ucpid.UCPIDException"%>
<%@ page import="com.wizvera.crypto.ucpid.UCPIDManager" %>
<%@ page import="com.wizvera.crypto.ucpid.UCPIDResponseResult"%>
<%@ page import="com.wizvera.crypto.ucpid.request.PersonInfoReq"%>
<%@ page import="com.wizvera.crypto.ucpid.response.PersonInfo"%>
<%@ page import="com.wizvera.crypto.ucpid.util.PersonInfoReqUtil"%>
<%@ page import="com.wizvera.crypto.ucpid.util.RandomUtil"%>
<%@ page import="com.wizvera.util.Base64" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
		<meta name="viewport" content="width=device-width" />
		<title>서명 test</title>
		
<%@ include file="../svc/delfino.jsp" %>		

    </head>


<body>

<%
	WizveraConfig wizConfig = WizveraConfig.getDefaultConfiguration();

	String b64SignedPersonInfoReq = request.getParameter("signData");
	String personInfoReq = "";

	byte[] signedPersonInfoReq = Base64.decode(b64SignedPersonInfoReq);

	try {
		PersonInfoReq pir = PersonInfoReqUtil.getPersonInfoReq(signedPersonInfoReq);
		personInfoReq = pir.toString();
	} catch(Exception e) {
		e.printStackTrace();
		out.println("ucpid dump error");
		out.println("b64SignedPersonInfoReq:" + b64SignedPersonInfoReq);
		return;
	}
	
	UCPIDManager ucpidManager = UCPIDManager.getInstance(wizConfig);
	String ucpIdNonce = RandomUtil.randomAlphaNumeric(10);
	
	UCPIDResponseResult ucpidResResult = null;
	try {
		ucpidResResult = ucpidManager.getPersonInfo(signedPersonInfoReq, ucpIdNonce);
	} catch (UCPIDException e) {
	 	out.println("<p/>");
	 	out.println("Error Occured:" + e.toString());
	 	out.println("person-info-req :" + b64SignedPersonInfoReq);
	 	out.println("person-info-req dump:<br/><pre>");
	 	out.println(personInfoReq);
	 	out.println("</pre>");
	 	out.println("<p/>");
	 	e.printStackTrace();
	}
	
	String personInfoData = "";
	
	if( ucpidResResult.isSuccessful() ){
		personInfoData = ucpidResResult.getPersonInfo().toString();
	}
%>
요청(PersionInfoReq) 데이터:<br/><textarea style="width:400px;height:500px;"><%=personInfoReq%></textarea><br/><br>
<% if( ucpidResResult.isSuccessful() ){%>
응답(PersonInfo) 데이터 : <br/><textarea style="width:800px;height:500px;"><%=personInfoData%></textarea><br/><br/>
<% }else{ %>
응답(UCPIDResponseResult) 데이터 : <br/><textarea style="width:800px;height:500px;"><%=ucpidResResult%></textarea><br/><br/>
<% } %>
signed-persion-info-req:<br/><textarea style="width:800px;height:500px;"><%=b64SignedPersonInfoReq%></textarea><br/>
<p/>
<!-- <} %> -->
<br/>
<a href="index.jsp"> 처음으로 </a><a href="ucpidSign.jsp">뒤로</a><!-- <a href="index.jsp">다운로드</a> -->
</body>
</html>