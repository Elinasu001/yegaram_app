<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
		<title>전자서명</title>
    </head>
    
    <body>
    	<h2>전자세금계산서 원본 데이터(XML)</h2>
		<form method="post" name="sign" action="signAction.jsp">
			전자세금계산서 원본<br>
			<textarea name="data"  id="data" cols="100" rows="25"></textarea><br><br>
			<input type="submit" value="SEND">
		</form>
	</body>
</html>