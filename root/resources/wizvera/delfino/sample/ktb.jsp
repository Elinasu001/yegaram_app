<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, width=device-width" />
		<title>KTB 단말 정보 수집(대구은행)</title>		
<%@ include file="../svc/delfino.jsp" %>			

    </head>
    <body>
    	<h2>KTB 단말 정보 수집(대구은행)</h2>
		<script type="text/javascript">
			function completeResult(res){
				if(res.status == 1){
					alert(res.ktbScanResult);
				}else{
					alert("[" + res.status + "]" + res.message);
				}
			}
		</script>
    	<button onclick="Delfino.getKTBScanResult(completeResult);">정보 수집</button><br/>
	</body>	
</html>
