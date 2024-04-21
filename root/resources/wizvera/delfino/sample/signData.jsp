<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
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
			<form name="form" method="post" action="signKeyValueAction.jsp">
			<input type="hidden" name="PKCS7">
			<input type="hidden" name="VID_RANDOM">
		</form>
		
		<button onclick="sign()">서명 </button>
		<script>
			function signCallback(pkcs7, vid_random){				
				document.form.PKCS7.value = pkcs7;
				document.form.VID_RANDOM.value = vid_random;			
				document.form.submit();
			}
			
			function sign(){				
				var values = "01:201금융 보험 부동산 서비스04:서울시 중구 남대문 2가 9-105:105861004906:테스트성명07:11108:11109:201816869310:400011:40012:2011081713:공인인증서14:400015:116:081717:18:19:20:21:22:23:24:25:26:27:28:29:130:111";
				Delfino.signData(values, signCallback)
			}			
		</script>		
		
	</body>
</html>