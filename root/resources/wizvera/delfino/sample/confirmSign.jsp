<%@page import="java.net.URLEncoder"%>
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>전자서명</title>
</head>
<body>
	<h1>사용자 확인 전자서명</h1>    
<ul>
<li><a href="confirmSign-form.jsp">폼전자서명</a></li>
<li><a href="confirmSign-formstring.jsp">form-urlencoding 문자열 전자서명</a></li>
<li><a href="confirmSign-formstring-withoutformat.jsp">form-urlencoding 문자열 전자서명-format 없이</a></li>
<li><a href="confirmSign-strings.jsp">문자열 전자서명</a></li>
<li><a href="confirmSign-formattedText.jsp">formattedText 전자서명</a></li>
<li><a href="confirmSign-formatType.jsp">formatType test</a></li>
</ul>	
</body>
</html>
