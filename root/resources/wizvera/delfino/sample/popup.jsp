<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, width=device-width" />
		<title>Login</title>		
<%@ include file="../delfino.jsp" %>		

    </head>
    <body>
    <form action="" name="form">
    <input name="name1"/>
    </form>
    <a href="#" onclick="popup();return false;">widow.open 새창</a> <br/>
    <a href="popupwin.jsp" target="_blank">타겟 _blank 새창</a> <br/>
    <script>
    	function popup(){
    		window.open("popupwin.jsp", "popupwin");
    	}
    </script>
    
    <br/><br/>
	<a href="#" onclick="javascript:window.close();">닫기</a>    
	</body>	
</html>
