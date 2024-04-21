<%@page import="java.net.URLEncoder"%>
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>전자서명</title>
<%@ include file="../svc/delfino.jsp" %>

<%
String formattedText = " (1)거래일자: 2015.10.08\n"
            + " (2)거래시간: 10:18:59\n"
			+ " (3)출금계좌번호: 110245101722\n"
			+ " (4)입금은행: 신한\n"
			+ " (5)입금계좌번호: 30612170441\n"
			+ " (6)수취인성명: 채소희\n"
			+ " (7)이체금액: 20,000(원)\n"
			+ " (8)CMS코드:  \n"
			+ " (9)받는통장에 표시내용:  \n"
			+ " (10)출금통장메모:  \n"
			+ " (11)중복이체여부: 해당없음\n"
			+ " (12)테스트: +&=%";
			
			
session.setAttribute("confirmSign.formattedText", formattedText);
String escapedFormattedText = formattedText.replaceAll("\n", "\\\\n");
%>

</head>
<body>
	<h1>사용자 확인 전자서명-formattedText</h1>
	<form name="delfinoForm" method="post" action="confirmSignAction-formattedText.jsp">
		<input type="hidden" name="PKCS7">
		<input type="hidden" name="VID_RANDOM">
	</form>	
	<h3>서명데이터</h3>
<pre>
<%=formattedText%>
</pre>	
    <button onclick="confirmSign()">전자서명</button><br/>	
	<script>
	function confirmSign(){
		Delfino.confirmSign({data:'<%=escapedFormattedText%>', dataType:'formattedText', title: '즉시이체'}, null, complete);
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
