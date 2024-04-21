<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@page import="java.util.*"%>
<%
String data ="";
data +=       URLEncoder.encode("account", "utf8") + "=" + URLEncoder.encode("111111-22-333333", "utf8");
data += "&" + URLEncoder.encode("amount", "utf8") + "=" + URLEncoder.encode("10,000", "utf8");
data += "&" + URLEncoder.encode("commission", "utf8") + "=" + URLEncoder.encode("0", "utf8");
data += "&" + URLEncoder.encode("memo", "utf8") + "=" + URLEncoder.encode("", "utf8");
data += "&" + URLEncoder.encode("recvBank", "utf8") + "=" + URLEncoder.encode("국민", "utf8");
data += "&" + URLEncoder.encode("recvAccount", "utf8") + "=" + URLEncoder.encode("444444-55-666666", "utf8");
data += "&" + URLEncoder.encode("recvUser", "utf8") + "=" + URLEncoder.encode("김모군", "utf8");

data += "|" + URLEncoder.encode("account", "utf8") + "=" + URLEncoder.encode("111111-22-333333", "utf8");
data += "&" + URLEncoder.encode("amount", "utf8") + "=" + URLEncoder.encode("20,000", "utf8");
data += "&" + URLEncoder.encode("commission", "utf8") + "=" + URLEncoder.encode("2", "utf8");
data += "&" + URLEncoder.encode("memo", "utf8") + "=" + URLEncoder.encode("", "utf8");
data += "&" + URLEncoder.encode("recvBank", "utf8") + "=" + URLEncoder.encode("기업", "utf8");
data += "&" + URLEncoder.encode("recvAccount", "utf8") + "=" + URLEncoder.encode("555555-66-777777", "utf8");
data += "&" + URLEncoder.encode("recvUser", "utf8") + "=" + URLEncoder.encode("이모군", "utf8");


String format = "";
format +=       URLEncoder.encode("account", "utf8") + "=" + URLEncoder.encode("출금계좌번호", "utf8");
format += "&" + URLEncoder.encode("amount", "utf8") + "=" + URLEncoder.encode("이체금액", "utf8");
format += "&" + URLEncoder.encode("commission", "utf8") + "=" + URLEncoder.encode("수수료", "utf8");
format += "&" + URLEncoder.encode("memo", "utf8") + "=" + URLEncoder.encode("송금메모", "utf8");
format += "&" + URLEncoder.encode("recvBank", "utf8") + "=" + URLEncoder.encode("입금은행", "utf8");
format += "&" + URLEncoder.encode("recvAccount", "utf8") + "=" + URLEncoder.encode("입금계좌번호", "utf8");
format += "&" + URLEncoder.encode("recvUser", "utf8") + "=" + URLEncoder.encode("받는분", "utf8");

format += "|" + URLEncoder.encode("account", "utf8") + "=" + URLEncoder.encode("출금계좌번호", "utf8");
format += "&" + URLEncoder.encode("amount", "utf8") + "=" + URLEncoder.encode("이체금액", "utf8");
format += "&" + URLEncoder.encode("commission", "utf8") + "=" + URLEncoder.encode("수수료", "utf8");
format += "&" + URLEncoder.encode("memo", "utf8") + "=" + URLEncoder.encode("송금메모", "utf8");
format += "&" + URLEncoder.encode("recvBank", "utf8") + "=" + URLEncoder.encode("입금은행", "utf8");
format += "&" + URLEncoder.encode("recvAccount", "utf8") + "=" + URLEncoder.encode("입금계좌번호", "utf8");
format += "&" + URLEncoder.encode("recvUser", "utf8") + "=" + URLEncoder.encode("받는분", "utf8");


session.setAttribute("confirmSign.format", format);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0; width=device-width" />
	<title>Login</title>		
<%@ include file="../svc/delfino.jsp" %>
	</head>
<body>
   	<h2>다중전자서명</h2>
   	한번의 패스워드 입력으로 여러개의 서명(PKCS7)값을 생성 하고 싶은 경우 사용된다.<br/> 
    서버에서는 여러개를 각각 잘라내 PKCS7값을 검증해야한다. <br/>
   	<form name="delfinoForm" method="post" action="confirmMultiSignAction.jsp" >
		<input type="hidden" name="PKCS7"/>
	</form>
	<br/>	
	<button onclick="confirmMultiSign();return false;">서명</button>
	<script>
		function confirmMultiSign(){
			Delfino.confirmMultiSign({data:'<%=data%>'}, '<%=format%>', completeMultiSign);
		}
		
		
		function completeMultiSign(result, context){
	        if(result.status==1){
	            document.delfinoForm.PKCS7.value = result.signData;
	            document.delfinoForm.submit();
	        }
	        else if(result.status!=0){
	            alert("sign error:" + result.message + "[" + result.status + "]");
	        }
	    }
	</script>
	</body>
</html>
