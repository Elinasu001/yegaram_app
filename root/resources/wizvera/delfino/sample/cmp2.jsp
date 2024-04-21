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
			참조번호 : <input type="text" name="referenceValue" value="93613"><br/>
			인가코드 : <input type="text" name="secretValue" value="0912978800814393922"><br/>
		</form>
		<button onclick="Delfino.requestCertificate2('yessign', document.form.referenceValue.value, document.form.secretValue.value, complete)"> 
		금결원 인증서 발급</button>
		<button onclick="Delfino.resetCertificate();Delfino.updateCertificate2('yessign', complete)"> 
		금결원 인증서 갱신</button>
		<br/>
		
		<button onclick="Delfino.requestCertificate2('crosscert', document.form.referenceValue.value, document.form.secretValue.value, complete)"> 
		전자인증 인증서 발급</button>
		<button onclick="Delfino.resetCertificate();Delfino.updateCertificate2('crosscert', complete)"> 
		전자인증 인증서 갱신</button>
		<br/>
		<button onclick="Delfino.requestCertificate2('signkorea', document.form.referenceValue.value, document.form.secretValue.value, complete)"> 
		증권 전산 인증서 발급</button>
		<button onclick="Delfino.resetCertificate();Delfino.updateCertificate2('signkorea', complete)"> 
		증권 전산 인증서 갱신</button>
		
		<br/>
		<button onclick="Delfino.requestCertificate2('kica', document.form.referenceValue.value, document.form.secretValue.value, complete, {enableKmCert:true})"> 
		정보인증 인증서 발급</button>
		<button onclick="Delfino.resetCertificate();Delfino.updateCertificate2('kica', complete, {enableKmCert:true})"> 
		정보인증 인증서 갱신</button>
		
		<button onclick="Delfino.requestCertificate2('kica', document.form.referenceValue.value, document.form.secretValue.value, complete, {recovery:true, enableKmCert:true})"> 
		정보인증 인증서 재발급</button>

		<br/>
		
		<form name="form1">
			시리얼번호: <input type="text" name="serialNumber" value="18E44B04"><br/>
		</form>
		<script>
		function updateCertificate(){
			var serialNumber = document.form1.serialNumber.value;
			Delfino.updateCertificate2('yessign', complete, {serialNumberCertFilter:serialNumber, cacheCertFilter:false, cachCert:false});
		}
		</script>
		<button onclick="updateCertificate()"> 
		인증서 필터링-금결원 인증서 갱신</button>
		<br/>
		
		<br/>
		<br/>
		<form name="form2">
			subject 또는 시리얼번호: <input type="text" name="subjectOrserialNumber" value="18E44B04"><br/>
		</form>
		<script>
		function deleteCertificateBySubject(){
			Delfino.deleteCertificate( document.form2.subjectOrserialNumber.value,{key:'subject'}, function(result){
				alert("status:" + result.status + ", deletedCount:" + result.deletedCount);
			});
		}
		function deleteCertificateBySerialNumber(){
																					//serialNumberHex, serialNumberDec
			Delfino.deleteCertificate( document.form2.subjectOrserialNumber.value, {key:'serialNumber'}, function(result){
				alert("status:" + result.status + ", deletedCount:" + result.deletedCount);
			});
		}
		</script>
		<button onclick="deleteCertificateBySubject()">subject로 삭제 </button>
		<button onclick="deleteCertificateBySerialNumber()">serialNumber로 삭제</button>
		
		<br/>
		
		<h3>disableCertStore(HSM|SWHSM)</h3>
		<button onclick="Delfino.requestCertificate2('yessign', document.form.referenceValue.value, document.form.secretValue.value, {disableCertStore:'HSM|SWHSM'}, complete)"> 
		금결원 인증서 발급</button>
		<button onclick="Delfino.resetCertificate();Delfino.updateCertificate2('yessign', {disableCertStore:'HSM|SWHSM'}, complete)"> 
		금결원 인증서 갱신</button>
		<br/>
		
		
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