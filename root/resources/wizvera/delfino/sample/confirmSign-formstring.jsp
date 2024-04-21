<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.*"%>
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
String data = URLEncoder.encode("account", "utf8") + "=" + URLEncoder.encode("111111-22-333333", "utf8");
data += "&" + URLEncoder.encode("amount", "utf8") + "=" + URLEncoder.encode("10,000", "utf8");
data += "&" + URLEncoder.encode("commission", "utf8") + "=" + URLEncoder.encode("0", "utf8");
data += "&" + URLEncoder.encode("memo", "utf8") + "=" + URLEncoder.encode("", "utf8");
data += "&" + URLEncoder.encode("recvBank", "utf8") + "=" + URLEncoder.encode("국민", "utf8");
data += "&" + URLEncoder.encode("recvAccount", "utf8") + "=" + URLEncoder.encode("444444-55-666666", "utf8");
data += "&" + URLEncoder.encode("recvUser", "utf8") + "=" + URLEncoder.encode("김모군", "utf8");

HashMap<String, String> formatMap = new HashMap<String, String>();

formatMap.put("account", "출금계좌번호");
formatMap.put("amount", "이체금액");
formatMap.put("commission", "수수료");
formatMap.put("memo", "송금메모");
formatMap.put("recvBank", "입금은행");
formatMap.put("recvAccount", "입금계좌번호");
formatMap.put("recvUser", "받는분");

String format="";
for(String key: formatMap.keySet()){
	String value = formatMap.get(key);
	if(format.length()>0) format += "&";
	format += URLEncoder.encode(key, "utf8") + "=" + URLEncoder.encode(value, "utf8");
}

session.setAttribute("confirmSign.data", data);
session.setAttribute("confirmSign.format", format);

%>

<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>전자서명</title>
<%@ include file="../svc/delfino.jsp" %>

</head>
<body>
	<h1>사용자 확인 전자서명 - form-urlencoding 스트링</h1>
	<form name="delfinoForm" method="post" action="confirmSignAction.jsp">
		<input type="hidden" name="PKCS7">
		<input type="hidden" name="VID_RANDOM">
	</form>	
	<button onclick="confirmSign()">전자서명</button><br/>	
	<script>	
	function confirmSign(){
		Delfino.confirmSign('<%=data%>', '<%=format%>', complete);		
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
