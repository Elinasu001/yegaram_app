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
			<form name="form" method="post" action="signMultiKeyValueAction.jsp">
			<input type="hidden" name="PKCS7">
			<input type="hidden" name="VID_RANDOM">
			<input type="hidden" name="etc1" value="asdf"/>
			<input type="hidden" name="etc2" value="12345"/>
		</form>
		
		<button onclick="sign()">서명 </button>
		<script>
			function signCallback(pkcs7, vid_random){				
				document.form.PKCS7.value = pkcs7;
				document.form.VID_RANDOM.value = vid_random;
				document.form.submit();
			}
			
			function sign(){				
				var delimeter = ":";
				var keys1 = "출금계좌번호:이체금액:수수료:내 통장 표시내용:입금은행:입금계좌번호:수취인:수취인 통장 표시내용";
				var keys2 = "출금계좌번호:이체금액:수수료:내 통장 표시내용:입금은행:입금계좌번호:수취인:수취인 통장 표시내용";
				var keys = keys1 + ":" + keys2 + ":건수";
				var values1 = "@1234-1234-1234:@10,000:@100::@국민은행:@4321-4321-4321:@아무개:";
				var values2 = "#1234-1234-1234:#10,000:#100::#국민은행:#4321-4321-4321:#아무개:";
				var values = values1 + ":" + values2 + ":2";
				
				var formats1 = "출금계좌번호1:이체금액1:수수료1:내 통장 표시내용1:입금은행1:입금계좌번호1:수취인1:수취인 통장 표시내용1";
				var formats2 = "출금계좌번호2:이체금액2:수수료2:내 통장 표시내용2:입금은행2:입금계좌번호2:수취인2:수취인 통장 표시내용2";
				var formats = formats1 + ":" + formats2 + ":";
				
				Delfino.signKeyValue(keys, values, formats, delimeter, signCallback);
			}
			
		
		</script>
		
		
		
	</body>
</html>