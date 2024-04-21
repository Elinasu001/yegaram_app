<%@page import="java.net.URLEncoder"%>
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>전자서명</title>
<%@ include file="../svc/delfino.jsp" %>

<%
String data = "524902-01-055983:2011년 09월 29일:13시 30분:2:004:097-21-0441-120:1:524902-01-055983:004:462202-01-376564:2";
String format ="출금계좌:이체지정일:이체지정시각:이체건수:입금은행코드(1):입금계좌번호(1):이체금액(1)::입금은행코드(2):입금계좌번호(2):이체금액(2)";

session.setAttribute("confirmSign.data", data);
session.setAttribute("confirmSign.format", format);
%>

</head>
<body>
	<h1>사용자 확인 전자서명-문자열</h1>
	<form name="delfinoForm" method="post" action="confirmSignAction.jsp">
		<input type="hidden" name="PKCS7">
		<input type="hidden" name="VID_RANDOM">
	</form>	
    <button onclick="confirmSign()">전자서명</button><br/>	
	<script>
	function confirmSign(){
		Delfino.confirmSign({data:'<%=data%>', dataType:'strings'}, '<%=format%>', complete);
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
