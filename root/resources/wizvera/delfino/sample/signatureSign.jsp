<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>전자서명</title>
<%@ include file="../svc/delfino.jsp" %>
</head>
<body>
	<h1>전자서명</h1>
    
    <!-- 실제로 전송되는 form -->	
   	<form name="form1" method="post">
   		<input type="hidden" name="rawData">
   		<input type="hidden" name="signData">
   		<input type="hidden" name="cert">
   	</form>
  
	<form name="inputform">
		name1:<input type="text" name="name1" value="abcd"/><br/>
		name2:<input type="text" name="name2" value="가나다라"/><br/>		
	</form>
	<button onclick="sign('SHA1')">signature SHA1</button><br/>	
	<button onclick="sign('SHA256')">signature SHA256</button><br/>
	<hr/>	
	
<script>
	function sign(alg){
		document.form1.action = "signatureSignAction.jsp?alg=" + alg;
		Delfino.sign(document.inputform, {signType:'signature', digestAlgorithm:alg}, sign_complete);
	}
	
	function sign_complete(result){
		if(result.status==1){
			document.form1.rawData.value = result.rawData;
			document.form1.signData.value = result.signData;
			document.form1.cert.value = result.cert;
			document.form1.submit();
		}
		else if(result.status!=0){
			alert("서명 실패:" + result.message);
		}
	}
</script>

</body>
</html>
