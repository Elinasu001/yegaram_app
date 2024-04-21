<%@page import="java.net.URLEncoder"%>
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.wizvera.service.util.FixedLengthDataFormat" %>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>전자서명</title>
<%@ include file="../svc/delfino.jsp" %>

<%
	FixedLengthDataFormat fldf = new FixedLengthDataFormat();
	fldf.addItem(0, 6, "이름", "bold");
	fldf.addItem(6, 16, "계좌번호", "lastHide 2");
	fldf.addItem(22, 10, "날짜", "mask **########");
	fldf.addItem(32, 8, "날짜", "insert ####-##-##");
	String stringifyFormat = fldf.getStringyfyFormat();
	String defaultFormat = fldf.getFormat();
	session.setAttribute("confirmSign.format", defaultFormat);
%>

</head>
<body>
	<h1>사용자 확인 전자서명-fixedLengthData</h1>
	<form name="delfinoForm" method="post" action="confirmSignAction-fixedLengthData.jsp">
		<input type="hidden" name="PKCS7">
		<input type="hidden" name="CONFIRM_PKCS7"/>
		<input type="hidden" name="VID_RANDOM">
	</form>	
    <button onclick="confirmSign()">fixedLengthData서명</button><br/>	
	<script>   
	function confirmSign(){
		var confirmFormat = "<%=stringifyFormat%>";
		Delfino.confirmSign('홍길동524902-01-0559832016-10-2220161022', confirmFormat , {dataType:'fixedLengthData', encoding:'euckr'}, complete);
	}

	function complete(result){
		if(result.status==0) return;
		if(result.status==1){
			document.delfinoForm.PKCS7.value = result.signData;
			document.delfinoForm.CONFIRM_PKCS7.value = result.confirmSignData;
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
