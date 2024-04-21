<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0; width=device-width" />
	<title>Login</title>		
<%@ include file="../svc/delfino.jsp" %>
	<script>
		function useMobile(){
			DelfinoConfig.usim.certSelector = "mobile";
			Delfino.inited = false;
			Delfino.init(false);
		}
		function usePc(){
			DelfinoConfig.usim.certSelector = "pc";
			Delfino.inited = false;
			Delfino.init(false);
		}
		function printSignData(display){
			DelfinoConfig.usim.raon.displayDataAtMobile = display;
			DelfinoConfig.usim.dream.displayDataAtMobile = display;
			DelfinoConfig.usim.sumion.displayDataAtMobile = display;
			Delfino.inited = false;
			Delfino.init(false);
		}
	</script>
</head>
<body>
   	<h2>인증서 선택 위치 설정</h2>
   	<form>		
   		<input type="radio" name="selectcert" checked="checked" onclick="useMobile(false);">mobile에서 선택
   		<input type="radio" name="selectcert" onclick="usePc(false);">pc에서 선택
   	</form>
 	<h2>서명 원문 출력 여부 설정</h2>
   	<form>		
		<input type="radio" name="selectcert" checked="checked" onclick="printSignData(false);">서명원문 출력 안함
		<input type="radio" name="selectcert" onclick="printSignData(true);">서명원문 출력
   	</form>
   	<br/>
   	<form name="delfinoForm" method="post" action="loginAction.jsp" >
		<input type="hidden" name="PKCS7">
	</form>
	<form name="nonceform" onsubmit="return false" method="post">
		<button onclick="Delfino.login(document.delfinoForm, complete);return false;">로그인</button>
	</form>
	<br/>
	<hr/>
	<h2>사용자 확인 전자서명</h2>    
	<ul>
	<li><a href="confirmSign-form.jsp">form-urlencoding 전자서명</a></li>
	<li><a href="confirmSign-strings.jsp">문자열 전자서명</a></li>
	<li><a href="confirmSign-formattedText.jsp">formattedText 전자서명</a></li>
	</ul>

	<script>
		function complete(result){
			if(result.status==1){			
				document.delfinoForm.PKCS7.value = result.signData;
				document.delfinoForm.submit();
			}
			else if(result.status!=0){
				alert("서명 실패:" + result.message + ":" + result.status);
			}
		}
	</script>
</body>
</html>
