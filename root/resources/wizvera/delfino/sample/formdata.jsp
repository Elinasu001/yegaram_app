<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, width=device-width" />
		<title>Login</title>		
<%@ include file="../svc/delfino.jsp" %>	
<%@ page import="java.util.*" %>	
<% 
	out.println("referer : "+request.getHeader("Referer")+"<hr>");
	out.println("");
	request.setCharacterEncoding("utf-8");
	Enumeration eParam = request.getParameterNames();
	while (eParam.hasMoreElements()) {
	 String pName = (String)eParam.nextElement();
	 String pValue = request.getParameter(pName);
	
	 out.println(pName + " : " + pValue + "<br>");
	 }

%>
    </head>
    <body>
    <form action="./formdata.jsp?getkey=getvallue" name="form" method="POST">
    	<input type=hidden name="post숨은한글이름" value="post숨은한글값"/>
    	<input name="post한글이름" value="post한글값"/>
    	<input type="submit">
    </form>
	</body>	
</html>
