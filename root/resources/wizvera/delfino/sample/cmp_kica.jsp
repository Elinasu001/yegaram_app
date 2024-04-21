<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="user-scalable=no, initial-scale=1.0, width=device-width" />
		<title>CMP</title>
		<style type="text/css">
		button {
			width: 170px;
		}
		</style>
<%@ include file="../svc/delfino.jsp" %>
    </head>
    <body>
    	<h2>CMP</h2>
		
		<script>
		
		function complete(result){
			alert(result.status + ":" + result.message);
		}		
		</script>
    	
		<form name="form">
			참조번호 : <input type="text" name="referenceValue" value=""><br/>
			인가코드 : <input type="text" name="secretValue" value=""><br/>
		</form>
				
		<br/>
		<button onclick="Delfino.requestCertificate2('kica', document.form.referenceValue.value, document.form.secretValue.value, complete)"> 
		정보인증 인증서 발급</button>
		<button onclick="Delfino.resetCertificate();Delfino.updateCertificate2('kica', complete)"> 
		정보인증 인증서 갱신</button>		
		<button onclick="Delfino.requestCertificate2('kica', document.form.referenceValue.value, document.form.secretValue.value, {recovery:true}, complete)"> 
		정보인증 인증서 재발급</button>

		<br/>
		<button onclick="Delfino.requestCertificate2('kica', document.form.referenceValue.value, document.form.secretValue.value, {enableKmCert:true}, complete)"> 
		정보인증 인증서 발급- 암호용인증서포함</button>
		<button onclick="Delfino.resetCertificate();Delfino.updateCertificate2('kica', complete, {enableKmCert:true})"> 
		정보인증 인증서 갱신- 암호용인증서포함</button>		
		<button onclick="Delfino.requestCertificate2('kica', document.form.referenceValue.value, document.form.secretValue.value, {recovery:true, enableKmCert:true}, complete)"> 
		정보인증 인증서 재발급- 암호용인증서포함</button>
    

	
	</body>
</html>
