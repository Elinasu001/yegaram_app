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
       	<h2>위즈베라(wizveraV2) 인증서 내보내기 가져오기</h2>
		<button onclick="Delfino.exportCertificate({providerUrl:'https://rs.wizvera.com/relayServer/certMove.do', provider:'wizveraV2'}, completeExport);">인증서 내보내기(wizvraV2)</button>
		<button onclick="Delfino.importCertificate({providerUrl:'https://rs.wizvera.com/relayServer/certMove.do', provider:'wizveraV2'}, completeImport);">인증서 가져오기(wizvraV2)</button>
    	<h2>이니텍 인증서 내보내기 가져오기</h2>
		<button onclick="Delfino.exportCertificate({providerUrl:'https://smart.kfcc.co.kr/sb/app/cert-relay-v12.jsp', provider:'initech'}, completeExport);">인증서 내보내기(initech)</button>
		<button onclick="Delfino.importCertificate({providerUrl:'https://smart.kfcc.co.kr/sb/app/cert-relay-v12.jsp', provider:'initech'}, completeImport);">인증서 가져오기(initech)</button>
		
		<script>
		    function completeExport(result){
		        if(result.status==0){
		        	return;
		        }
		        if(result.status!=1){
		            alert(result.message);
		            return;
		        }
		        if(result.status==1){
		        	alert(result.message);
		        	return;
		        }
		    }
		    function completeImport(result){
		        if(result.status==0){
		        	return;
		        }
		        if(result.status!=1){
		            alert(result.message);
		            return;
		        }
		        if(result.status==1){
		        	alert(result.message);
		        	return;
		        }
		    }
		</script>
	</body>
</html>