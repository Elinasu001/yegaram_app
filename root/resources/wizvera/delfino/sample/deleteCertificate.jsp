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
	<meta name="viewport" content="initial-scale=1.0, width=device-width" />
	<title>Login</title>		
	<%@ include file="../svc/delfino.jsp" %>
</head>
    
<body>
	<h1>인증서 삭제</h1>
    <form name="delfinoForm" method="post" action="loginAction.jsp">
		<input type="hidden" name="PKCS7">
		<input type="hidden" name="VID_RANDOM">
		<input type="hidden" name="MACAddress">
	</form>
				
    Delfino.setModule
	
	<button onclick="Delfino.setModule('G3');">G3</button>
	<button onclick="Delfino.setModule('G4');">G4</button>
	<button onclick="Delfino.setModule('G5');">G5</button>

	<form name="form">
		<input name="key" type="radio" id="serialNumberDec" value="serialNumberDec"><label for="serialNumberDec">serialNumberDec</label><br/>
		<input name="key" type="radio" id="serialNumber" value="serialNumber"><label for="serialNumber">serialNumber</label><br/>
		<input name="key" type="radio" id="serialNumberHex" value="serialNumberHex"><label for="serialNumberHex">serialNumberHex</label><br/>
		<input name="key" type="radio" id="subject" value="subject"><label for="subject">subject</label><br/>
		<input name="key" type="radio" id="none(default)" value="none(default)"><label for="none(default)">none(default)</label><br/>
		시리얼 or Subject<input name="serial" value="438676"/>
		<button onclick="return deleteCertificate();">인증서 삭제</button><br/>
	</form>
	<script>
	//Delfino.resetRecentModule();
	function deleteCertificate() {
		var key = document.form.key.value;
		var option = {};
		if(key.indexOf('none') == -1) {
			option.key = key;
		}
		var serialOfSubject = document.form.serial.value;
		Delfino.deleteCertificate(serialOfSubject, option, complete);
		return false;
	}
	function complete(result){
		console.log(result);
		if(result.status==0) return;
		if(result.status==1){
			console.log(result);
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
