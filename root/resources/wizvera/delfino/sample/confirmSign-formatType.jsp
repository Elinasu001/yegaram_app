<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%

// 서명 데이타 포맷 검증하기 

HashMap<String, String> format = new HashMap<String, String>();
format.put("account", "계좌번호;firstHide 3");
//format.put("account", "계좌번호;lastHide 3");
//format.put("account", "계좌번호;insert ###@#####@###");
//format.put("account", "계좌번호;mask ####***####"); 
format.put("recvUser", "받는사람;bold");
format.put("amount", "금액;currency");
format.put("비고", "비고");

request.setAttribute("format", format);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
		<title>전자서명</title>		
<%@ include file="../svc/delfino.jsp" %>
<script src="//code.jquery.com/jquery-1.4.4.min.js"></script>
    </head>
    <body>		
    	<h2>전자서명</h2>
		<form method="post" name="sign" action="signAction.jsp" onsubmit="Delfino.signForm(this);return false;">
			계좌번호 : <input id="account" type="text" name="account" format="${format['account']}" value="123-123-123"><br/>
			받는사람 : <input type="text" name="recvUser" format="${format['recvUser']}" value="아무개"><br/>
			금액 : <input type="text" name="amount" format="${format['amount']}" value="100000"><br/>
			비고 : <input type="text" name="비고" format="${format['비고']}" value=""><br/>
			<input type="submit">
		</form>
	</body>
</html>