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
    <input name="name1" value="가나다라"/>
    </form>
    <a href="#" onclick="myclose();return false;">닫기</a> </br>
    <a href="#" onclick="viewSource();">소스보기</a></br>
    <a href="http://daum.net" target="_blank">test</a>
    
    <script>
    function myclose(){
    	//alert("close");
    	try {
    	opener.document.form.name1.value = document.form.name1.value;
    	}
    	catch(e) {alert(e);}
    	self.close();
    }
    function viewSource()
    {
    	alert(document.body.innerHTML);
    }
    </script>
	</body>	
</html>
