<%@page import="java.net.URLEncoder"%>
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>전자서명</title>
<%@ include file="../svc/delfino.jsp" %>

</head>
<body>
	<h1>사용자 확인 전자서명-fixedLengthData</h1>
	<form name="delfinoForm" method="post" action="confirmSignAction.jsp">
		<input type="hidden" name="PKCS7">
		<input type="hidden" name="VID_RANDOM">
	</form>	
    <button onclick="confirmSign()">fixedLengthData서명</button><br/>	
	<script>   
	
	function confirmSign(){
		var format = [];
		format.push({location: 0, length: 3, label: '이름', format: 'bold'});
		format.push({location: 3, length: 10, label: '계좌번호', format: 'firstHide 3'});
		Delfino.confirmSign({data:'홍길동:524902-01-055983', dataType:'fixedLengthData'}, format, complete);
	}

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
	</script>
</body>
</html>
