<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
		<title>다중전자서명</title>
<%@ include file="../svc/delfino.jsp" %>		
    </head>
    <body> 
    	<h2>다중전자서명</h2>
    	한번의 패스워드 입력으로 여러개의 서명(PKCS7)값을 생성 하고 싶은 경우 사용된다.<br/> 
    	서버에서는 여러개를 각각 잘라내 PKCS7값을 검증해야한다. <br/>
		<form name="delfinoForm" method="post" action="multiSignAction.jsp">
			<input type="hidden" name="PKCS7">
			<input type="hidden" name="VID_RANDOM">
			<input type="hidden" name="etc1" value="asdf"/>
			<input type="hidden" name="etc2" value="12345"/>
		</form>
		
		<button onclick="multiSign()">서명 </button>
		<script>
			function complete(result){
				if(result.status==0) return;
				if(result.status==1){
					document.delfinoForm.PKCS7.value = result.signData;
					document.delfinoForm.VID_RANDOM.value = result.vidRandom;
					document.delfinoForm.submit();
				}
				else{
					alert("error:" + result.message + "[" + result.code + "]");
				}
			}
			
			function multiSign(){
				var data = "a=1&b=2&c=3|a=11&b=22&c=33|a=111&b=222&c=333";				
				Delfino.multiSign(data, complete);
			}
		</script>
		
	</body>
</html>