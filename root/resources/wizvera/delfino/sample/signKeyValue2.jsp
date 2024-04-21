<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
		<title>전자서명</title>
<%@ include file="../svc/delfino.jsp" %>		
    </head>
    <body>
    	<h2>전자서명</h2>
			<form name="form" method="post" action="signKeyValueAction.jsp">
			<input type="hidden" name="PKCS7">
			<input type="hidden" name="VID_RANDOM">
			<input type="hidden" name="etc1" value="asdf"/>
			<input type="hidden" name="etc2" value="12345"/>
		</form>
		
		<button onclick="submit()">서명 </button>
		<script>			
			function submit(){
				sign(function(error){
					if(document.form.PKCS7.value.length!=0){
						document.form.submit();
					}
					else{
						if(error==0){
							alert("cancel");
						}
						else{
							alert("fail");
						}
					}					
				});
			}
			
			function sign(func){				
				var delimeter = ":";
				var keys = "출금계좌번호:이체금액:수수료:내 통장 표시내용:입금은행:입금계좌번호:수취인:수취인 통장 표시내용";
				var values = "1234-1234-1234:10,000:100::국민은행:4321-4321-4321:아무개:";
				var formats = "&<>출금계좌번호:이체금액:수수료:내 통장 표시내용:입금은행:입금계좌번호:수취인:수취인 통장 표시내용";
				
				
				Delfino.signKeyValue(keys, values, formats, delimeter,
						function(pkcs7, vid_random){
							document.form.PKCS7.value = pkcs7;
							document.form.VID_RANDOM.value = vid_random;
							func();
						},
						function(error, message){
							func(error);	
						});
				
			}
			
			function signWithoutConfirm(){				
				var delimeter = ":";
				var keys = "출금계좌번호:이체금액:수수료:내 통장 표시내용:입금은행:입금계좌번호:수취인:수취인 통장 표시내용";
				var values = "1234-1234-1234:10,000:100::국민은행:4321-4321-4321:아무개:";
				var formats = ":::::::";
				
				Delfino.signKeyValue(keys, values, formats, delimeter, signCallback);
			}
		</script>
		
		<button onclick="signWithoutConfirm()">서명 확인 창 없이 서명 </button>
		
	</body>
</html>