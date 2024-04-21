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
		<input type="hidden" name="MACAddress">
	</form>
				
    Delfino.login
	<form name="form">
		주민번호(VID 체크용) <input type="text" name="juminbunho" value=""/><br/>
	</form>
	
	<button onclick="Delfino.setModule('G2');Delfino.login(this, complete);">G2</button>
	<button onclick="Delfino.setModule('G3');Delfino.login(this, complete);">G3</button>
	<button onclick="Delfino.setModule('G4');Delfino.login(this, complete);">G4</button>
	<button onclick="Delfino.setModule('EA');Delfino.login(this, complete);">EA</button>
	<button onclick="Delfino.setModule();Delfino.login(this, complete);">recent</button>
	<button onclick="Delfino.setModule(DelfinoConfig.module);Delfino.login(this, complete);">설정</button>
	<button onclick="Delfino.login(this, complete);">none</button>
	<button onclick="Delfino.resetRecentModule()">resetRecentModule</button>
	
	<script>
	//Delfino.resetRecentModule();
	function complete(result){
		if(result.status==0) return;
		if(result.status==1){
			document.delfinoForm.PKCS7.value = result.signData;
			document.delfinoForm.VID_RANDOM.value = result.vidRandom;
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
	</script>
		

</body>
</html>
