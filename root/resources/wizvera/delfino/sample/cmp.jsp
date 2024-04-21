<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="user-scalable=no, initial-scale=1.0, width=device-width" />
		<title>CMP</title>
		<style type="text/css">
		button {
			width: 160px;
		}
		</style>
<%@ include file="../svc/delfino.jsp" %>
    </head>
    <body>
    	<h2>CMP</h2>
    	
		<form name="form">
			참조번호 : <input type="text" name="referenceValue" value="93613"><br/>
			인가코드 : <input type="text" name="secretValue" value="0912978800814393922"><br/>
		</form>
		<button onclick="Delfino.requestCertificate('yessign', document.form.referenceValue.value, document.form.secretValue.value, function(code, msg){alert(code+':'+msg)})"> 
		금결원 인증서 발급</button>
		<button onclick="Delfino.resetCertificate();Delfino.updateCertificate('yessign', function(code, msg){alert(code+':'+msg)})"> 
		금결원 인증서 갱신</button>
		<br/>
		
		<button onclick="Delfino.requestCertificate('crosscert', document.form.referenceValue.value, document.form.secretValue.value, function(code, msg){alert(code+':'+msg)})"> 
		전자인증 인증서 발급</button>
		<button onclick="Delfino.resetCertificate();Delfino.updateCertificate('crosscert', function(code, msg){alert(code+':'+msg)})"> 
		전자인증 인증서 갱신</button>
		<br/>
		<button onclick="Delfino.requestCertificate('signkorea', document.form.referenceValue.value, document.form.secretValue.value, function(code, msg){alert(code+':'+msg)})"> 
		증권 전산 인증서 발급</button>
		<button onclick="Delfino.resetCertificate();Delfino.updateCertificate('signkorea', function(code, msg){alert(code+':'+msg)})"> 
		증권 전산 인증서 갱신</button>
		
		<!-- 
		<script>
		function sign(){
			Delfino.signDataForUpdateCertificate("data", function(pkcs7, vidRandom){alert(pkcs7);} );
		}
		</script>
		<button onclick="sign();"> 갱신을 위한 서명		
		</button>
		<hr>
		TEST/TEST
		<form name="form3" action="loginAction.jsp">
		<button onclick="alert('a')">aa</button>
		</form>

		<form name="form2">
			참조번호 : <input type="text" name="referenceValue" value="93613"><br/>
			인가코드 : <input type="text" name="secretValue" value="0912978800814393922"><br/>
		<button onclick="Delfino.requestCertificate('yessign', document.form2.referenceValue.value, document.form2.secretValue.value, function(code, msg){alert(code+':'+msg)});return false;"> 
		금결원 인증서 발급</button><br/>
		</form>
		 -->
	</body>
</html>