<%@page import="java.net.URLEncoder"%>
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0; width=device-width" />
	<title>전자서명</title>
<%@ include file="../svc/delfino.jsp" %>
</head>
<body>
	<h1>사용자 확인 전자서명</h1>    
<ul>
<li><a href="confirmMultiSign-formstring.jsp">form-urlencoding 문자열 전자서명 다중서명</a></li>
<li><a href="confirmMultiSign-strings.jsp">문자열 전자서명 다중서명</a></li>
</ul>	
</body>
</html>
