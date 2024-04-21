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
		<meta http-equiv="X-UA-Compatible" content="requiresActiveX=true;IE=7">
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
    	<ol>
		<li><button onclick="sign()">전자서명</button></li>	
		<li><button onclick="sign2()">전자서명 nocachefiler</button></li>
		<li><button onclick="sign3()">전자서명 nocachefiler nocache</button></li>
		<li><button onclick="sign4()">전자서명 nocachefiler nocache issuerFilter format</button></li>
		<li><button onclick="sign5()">전자서명 nocachefiler nocache issuerFilter format strings</button></li>
		<li><button onclick="sign6()">전자서명 nocachefiler nocache issuerFilter format strings signeddata</button></li>
		<li><button onclick="sign7()">전자채권 multiSign</button></li>
		
		<li>
		<form name="form1">
			시리얼번호: <input type="text" name="serialNumber" value="18E44B04">
		</form>
		<button onclick="sign8()">serialNumberCertFilter</button></li>
		
		<li><button onclick="sign_context()">전자서명 context</button></li>	
		<li><button onclick="login_context()">login context</button></li>	
		
		<li><button onclick="sign_withMACAddress()">sign withMACAddress</button></li>
		<li><button onclick="sign_withMACAddressAll()">sign withMACAddressAll</button></li>
		
		<li><button onclick="sign_withKTBScanResult()">sign_withKTBScanResult</button></li>
		
		<li><button onclick="certStoreFilterTest()">저장매체 정보 전달시 하위매체 정보까지 함께 전달</button></li>
		</ol>
		
		<script>
		function complete(param){
			if(param.status==0) return;
			if(param.status!=1){
				alert(param.status + ":" + param.message);
				return;
			}
			document.signForm.PKCS7.value = param.signData;
			document.signForm.VID_RANDOM.value = param.vidRandom;
			document.signForm.submit();
		}
		function complete2(param){
			if(param.status==0) return;
			if(param.status!=1){
				alert(param.status + ":" + param.message);
				return;
			}
			document.signForm.PKCS7.value = param.signData;
			document.signForm.VID_RANDOM.value = param.signData;
			document.signForm.action = "multiSignAction.jsp";
			document.signForm.submit();
		}
		function sign(){			
			Delfino.sign("Y", complete);
		}		
		function sign2(){			
			Delfino.sign("Y", complete, 
				{
					cacheCertFilter:false
				}
			);			
		}
		
		function sign3(){
			Delfino.sign("Y", complete, 
				{
					cacheCertFilter:false,
					cacheCert:false
				}
			);			
		}
		
		function sign4(){
			Delfino.sign("Y", complete, 
				{
					dataType: "string",
					format:"동의합니다",
					cacheCertFilter:false,
					cacheCert:false,
					issuerCertFilter:"cn=CrossCertTestCA2,ou=AccreditedCA,o=CrossCert,c=KR|cn=CrossCertTestCA,ou=AccreditedCA,o=CrossCert,c=KR"
				}
			);			
		}
		
		function sign5(){
			Delfino.sign("예:아니오", complete, 
				{
					dataType: "strings",
					format:"동의합니다1:동의합니다2",
					delimeter: ":",
					cacheCertFilter:false,
					cacheCert:false,
					issuerCertFilter:"cn=CrossCertTestCA2,ou=AccreditedCA,o=CrossCert,c=KR|cn=CrossCertTestCA,ou=AccreditedCA,o=CrossCert,c=KR",
					encoding: "euckr"
				}
			);
		}
		
		function sign6(){
			document.signForm.action = "signTestSignedDataAction.jsp";
			
			Delfino.sign("Y:N", complete, 
				{
					dataType: "strings",
					format:"동의합니다1:동의합니다2",
					delimeter: ":",
					cacheCertFilter:false,
					cacheCert:false,
					issuerCertFilter:"",
					signType:"signedData"
				}
			);			
		}
		
		function sign7(){
			Delfino.sign("a=1&b=2&c=3￡a=11&b=22&c=33￡a=111&b=222&c=333", complete2, 
					{
						cacheCertFilter:false,
						cacheCert:false,
						//issuerCertFilter:"cn=CrossCertTestCA2,ou=AccreditedCA,o=CrossCert,c=KR|cn=CrossCertTestCA,ou=AccreditedCA,o=CrossCert,c=KR",
						multiSign:true,
						encoding: "euckr",
						multiSignDelimeter:"￡"
					}
				);
		}
		
		function sign8(){
			var serialNumber = document.form1.serialNumber.value;
			Delfino.sign("123456789", complete, 
					{
						cacheCertFilter:false,
						cacheCert:false,
						serialNumberCertFilter:serialNumber //serialNumberHexCertFilter, serialNumberDecCertFilter
					}
				);
		}
	
		function complete_context(result, context){
			if(result.status==0) return;
			if(result.status!=1){
				alert(result.status + ":" + result.message);
				return;
			}
			alert("context:" + context);
			document.signForm.PKCS7.value = result.signData;
			document.signForm.VID_RANDOM.value = result.vidRandom;
			document.signForm.submit();
		}
		function sign_context(){
			Delfino.sign("123456789", {complete:complete_context, context:"sample sign context"} );
		}
		function login_context(){
			Delfino.login("123456789", {complete:complete_context, context:"sample login context"} );
		}
		function sign_withMACAddress(){
			Delfino.sign("1234567890", function(result){
				alert("signData:" + result.signData + "\n\nMACAddress:" + result.MACAddress);
			}, {withMACAddress:true})
		}
		
		function sign_withMACAddressAll(){
			Delfino.sign("1234567890", function(result){
				alert("signData:" + result.signData + "\n\nMACAddressAll:" + result.MACAddressAll);
			}, {withMACAddressAll:true})
		}
		function sign_withKTBScanResult(){
			Delfino.sign("1234567890", function(result){
				alert("signData:" + result.signData + "\n\nktbScanResult:" + result.ktbScanResult);
			}, {withKTBScanResult:true})
		}
		
		//서명시 사용한 인증서 저장소 추출기능(로그인할 때 사용한 저장매체 정보 전달시 하위 매체정보까지 함께 전달)
		function certStoreFilterTest(){
			var certStoreFilter = wiz.util.cookie.get("certStoreFilter");
			Delfino.sign('123456789', {certStoreFilter: certStoreFilter}, complete);
		}
		
		</script>
		<!-- 
		
		<form name="login" method="post" action="loginAction.jsp" onsubmit="loginForm(this);return false;">
			<input type="hidden" name="nonce" value="<%=nonce%>"/>
			주민번호(VID 체크용) <input type="주민번호" name="juminbunho" value=""/>
			<br/>
			<input type="submit" value="로그인">
		</form>
		
		<script>
			function loginForm(form){
				Delfino.init();
				if(jQuery("#Delfino_PKCS7_form").length==0){
					jQuery('body').append('<form id="Delfino_PKCS7_form"><input type="hidden" name="PKCS7"><input type="hidden" name="VID_RANDOM"></form>');		
				}
				var pkcs7Form = jQuery("#Delfino_PKCS7_form")[0];
					
				pkcs7Form.method = form.method;
				pkcs7Form.action = form.action;
				pkcs7Form.target = form.target;
				
				var data = jQuery(form).serialize();				
				DCrypto.resetCertificate();
				Delfino.loadLogoImage(DelfinoConfig.logoImageUrl);
				Delfino.sign(data, complete_login, 
						{
							cacheCertFilter:false,
							cacheCert:true,
							attributeAsData:true,
							signedAttribute:"certStoreType"
						}
					);
			}			
			function complete_login(param){
				if(param.status==1){
					var pkcs7Form = jQuery("#Delfino_PKCS7_form")[0];
					pkcs7Form.PKCS7.value = param.signData;
					pkcs7Form.VID_RANDOM.value = param.vidRandom;
					pkcs7Form.submit();	
				}
			}
		</script>
		 -->
	</body>
</html>
