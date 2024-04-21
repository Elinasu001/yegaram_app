<%@page import="java.util.*"%>
<%@page import="java.net.URLEncoder"%>
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%

	HashMap<String, String> formatMap = new HashMap<String, String>();
	
	formatMap.put("account", "출금계좌번호");
	formatMap.put("amount", "이체금액");
	formatMap.put("commission", "수수료");
	formatMap.put("memo", "송금메모");
	formatMap.put("recvBank", "입금은행");
	formatMap.put("recvAccount", "입금계좌번호");
	formatMap.put("recvUser", "받는분");
	
	String format="";
	for(Map.Entry<String, String> entry: formatMap.entrySet()){
		if(format.length()>0) format += "&";
		format += URLEncoder.encode(entry.getKey(), "utf8") + "=" + URLEncoder.encode(entry.getValue(), "utf8");
	}
	
	session.setAttribute("confirmSign.format", format);
	session.removeAttribute("confirmSign.data");
%>


<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>전자서명</title>
<%@ include file="../svc/delfino.jsp" %>
	<style type="text/css">
		label { width: 110px; display: inline-block; } 
	</style>
</head>
<body>
	<h1>사용자 확인 전자서명 - 폼</h1>
	<form name="delfinoForm" method="post" action="confirmSignAction.jsp">
		<input type="hidden" name="PKCS7">
		<input type="hidden" name="VID_RANDOM">
	</form>
	
    <form method="post" name="sign" action="confirmSignAction.jsp" onsubmit="Delfino.confirmSign(this, '<%=format%>', complete);return false;">
		<label>출금계좌번호</label><input type="text" name="account" value="111111-22-333333"><br/>
		<label>이체금액</label><input type="text" name="amount" value="10,000"><br/>
		<label>수수료</label><input type="text" name="commission" value="0"><br/>
		<label>송금메모</label><input type="text" name="memo" value=""><br/>
		
		<label>입금은행</label><input type="text" name="recvBank" value="국민"><br/>
		<label>입금계좌번호</label><input type="text" name="recvAccount" value="444444-55-666666"><br/>
		<label>받는분</label><input type="text" name="recvUser" value="김모군"><br/>
		<label>기타</label><input type="text" name="etc" value="기타">(표시되지안음)<br/>
		<input type="submit" value="전자서명">
	</form>
	
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
	</script>
</body>
</html>