<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>   
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="initial-scale=1.0, width=device-width" />
		<title>Login</title>
    </head>
    <body>
    	<h4>VeraPort-CG TEST</h4>
    	<ul>
	    	<li><a href="vpcg-agent-test.jsp">agent모드 테스트</a><br/><br/></li>
<% if (this.getClass().getResource("/com/wizvera/vpcg/VpcgController.class") != null) { %>	    	
			<li><a href="vpcg-test.jsp">lib모드 테스트</a><br/><br/></li>
<% } %>
			<li><a href="kakao-deregister.jsp">카카오 이용등록해제</a><br/><br/></li>
			<li><a href="api-test.jsp">G10 API 테스트</a><br/><br/></li>
		</ul>
    </body>
</html>
