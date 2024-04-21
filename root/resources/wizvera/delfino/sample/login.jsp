<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
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

<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0; width=device-width" />
	<title>Login</title>		
	<%@ include file="../svc/delfino.jsp" %>
</head>
    
<body>
	<h1>로그인</h1>
    <form name="delfinoForm" method="post" action="loginAction.jsp">
		<input type="hidden" name="PKCS7">
		<input type="hidden" name="VID_RANDOM">
		<input type="hidden" name="certStore">
		<input type="hidden" name="MACAddress">
	</form>
			
				
    Delfino.login
	<form onsubmit="Delfino.login(this, complete);return false;">
		주민번호(VID 체크용) <input type="text" name="juminbunho" value=""/><br/>
		<input type="submit">
	</form>

    <hr/>
    Delfino.loginForm
	<form onsubmit="Delfino.loginForm(this, loginFormCompleteSuccess, loginFormCompleteError);return false;">
		주민번호(VID 체크용) <input type="text" name="juminbunho" value=""/><br/>
		<input type="submit">
	</form>
    <hr/>

	<a href="#" onclick="Delfino.login('hi=hi', complete);return false;">로그인</a><br/>
	
	<a id="loginlink" href="#">로그인(withMACAddress)</a><br/>	
	<script>
	$('#loginlink').click(function(){Delfino.login('hi=hi', complete, {'withMACAddress': true});});
	</script>
	
	
	패스워드가 틀렸을 경우 서명창 닫힘 설정 지정 :
	<button onclick="DelfinoConfig.closeOnError=true">ON</button>
	<button onclick="DelfinoConfig.closeOnError=false">OFF</button>
	
	<script>
	function complete(result){
		if(result.status==0) return;
		if(result.status==1){
			document.delfinoForm.PKCS7.value = result.signData;
			document.delfinoForm.VID_RANDOM.value = result.vidRandom;
			document.delfinoForm.certStore.value = result.certStore;
			
			wiz.util.cookie.set("certStoreFilter",result.certStore);
			
			if(result.MACAddress!=null){
				document.delfinoForm.MACAddress.value = result.MACAddress;
			}
			document.delfinoForm.submit();
		}
		else{
			if(Delfino.isPasswordError(result.status)){
				alert("인증서 암호가 맞지 않습니다. [" + result.signerSubject + "]");
			}
			else{
				alert("error:" + result.message + "[" + result.status + "]");
			}
		}
	}
	
	function loginFormCompleteSuccess(signData, vidRandom){
		document.delfinoForm.PKCS7.value = signData;
		document.delfinoForm.VID_RANDOM.value = vidRandom;
		document.delfinoForm.submit();
	}
	
	function loginFormCompleteError(code, message){
		alert("error:" + message + "[" + code + "]");
	}
	
	</script>
		
		
	<br/><br/>
		
	<form name="agentFrom" id="agentFrom">
	    server userAgent<br/><textarea name="serverAgent" rows=4 cols=50><%=request.getHeader("user-agent")%></textarea><br/>
	    javascript userAgent<br/><textarea name="jsAgent" rows=4 cols=50>TEST</textarea>
	</form>
		
	<script>
       	document.getElementById('agentFrom').jsAgent.value = navigator.userAgent;
	</script>
<!-- 
		<button onclick="Delfino.setCacheCertStore(true);">Enable cacheCertStore</button>	
		<button onclick="Delfino.setCacheCertStore(false)">Disable cacheCertStore</button>
		 -->
</body>
</html>
