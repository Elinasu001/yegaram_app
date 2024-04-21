<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="org.bouncycastle.util.encoders.Base64"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.util.Properties"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.IOException"%>

<%!
static SecureRandom random = new SecureRandom();
%>
<%
	byte[] nonceBuf = new byte[20];
	random.nextBytes(nonceBuf);
	String nonce = new String(Base64.encode(nonceBuf));
	session.setAttribute("login_nonce", nonce);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
		<title>전자서명</title>
<%@ include file="../svc/delfino.jsp" %>
    </head>
    <body>
    	<h2>전자서명</h2>
    	
    	<form action="signTestAction.jsp" method="post" name="signForm">
    		<input type="hidden" name="PKCS7">
    		<input type="hidden" name="VID_RANDOM">
    	</form>
    	
		<button onclick="sign()">전자서명</button>		
		
		<script>
			function complete(param){
				if(param.status!=1 && param.status!=0){
					alert(param.status + ":" + param.message);
					return;
				}
				document.signForm.PKCS7.value = param.signData;
				document.signForm.VID_RANDOM.value = param.signData;
				document.signForm.submit();
			}
			
			function sign(){			
				//Delfino.sign("1234567890", complete, {cacheCertFilter:false, signedAttribute:"signingTime"});
				Delfino.sign("1234567890", complete);
			}		
		</script>
		
		<button onclick="addSign()">전자서명 추가</button>		
		
		<script>		
			function addSign(){				
				var pkcs7 = "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";
				Delfino.addSigner(pkcs7, complete);
			}		
		</script>
	</body>
</html>
