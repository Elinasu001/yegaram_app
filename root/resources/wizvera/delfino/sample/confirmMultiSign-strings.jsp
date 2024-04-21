<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.*"%>
<%@page import="java.util.*"%>
<%
String data ="";
data +=       "111111-22-333333:10,000:0::국민:444444-55-666666:김모군";
data += "|" + "111111-22-333333:20,000:2::기업:555555-66-777777:이모군";

String format = "";
format +=       "출금계좌번호:이체금액:수수료:송금메모:입금은행:입금계좌번호:받는분";
//format += "|" + "출금계좌번호:이체금액:수수료:송금메모:입금은행:입금계좌번호:받는분";

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

	<form name="delfinoForm" method="post" action="confirmMultiSignAction.jsp">
		<input type="hidden" name="PKCS7">
	</form>
	<br/>
	<button onclick="confirmMultiSign();return false;">서명</button>
	<script>
		function confirmMultiSign(){			
			Delfino.confirmMultiSign({data:'<%=data%>', dataType:'strings'}, '<%=format%>', {}, completeMultiSign);
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
