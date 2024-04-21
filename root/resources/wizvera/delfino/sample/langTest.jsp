<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>   
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="initial-scale=1.0,width=device-width" />
		<title>lang test</title>
<%@ include file="../svc/delfino.jsp" %>
    </head>
    <body>    	
		
		<form>
	  		<input name="lang" type="radio" value="KOR" checked="checked">한국어
			<input name="lang" type="radio" value="ENG">영어
			<input name="lang" type="radio" value="CHN">중국어
			<input name="lang" type="radio" value="JPN">일본어
		</form>
			
    	<ol>    	
	    	<li>
	    		<button onclick="Delfino.setLang(getLang()); Delfino.manageCertificate()">인증서관리</button>
			</li>			
			<li>
				<button onclick="Delfino.setLang(getLang()); Delfino.login('login', complete)">서명</button>
			</li>			
			<li>
				<button onclick="Delfino.setLang(getLang()); Delfino.requestCertificate2('yessign', '1234567890', '1234567890', complete)">인증서발급</button>
			</li>			
			<li>		 
				<button onclick="Delfino.setLang(getLang()); Delfino.updateCertificate2('yessign', complete)">금결원 인증서 갱신</button>
			</li>		
		</ol>
		
		<script>
		function getLang(){
			var lang =  $(":input:radio[name=lang]:checked").val();
			alert(lang);
			return lang;
		}
		
		function complete(result){
			alert(result.status + ":" + result.message);
		}		
		</script>
    	
	</body>
</html>
