<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>파일서명 테스트</title>
	<%@ include file="../svc/delfino.jsp" %>
	<style type="text/css">
	textarea {width:500px; height: 100px};	
	</style>
</head>
<body>
	<h3>U+ 파일 전자서명</h3>

	<form name="form1">
		경로 : <input type="text" name="tbsFilePath" value="C:\opt\delfino\tbsFile\data.pdf" style="width:400px;"/><br/>
	</form>	
	<button onclick="signFileTest()">파일서명</button><br/>	
	<br/>
	
	<h3>U+ 파일 전자서명 검증</h3>
	<form name="form2" action="signFileAction.jsp">
		경로 : <input type="text" name="tbsFilePath" value="C:\opt\delfino\tbsFile\data.pdf" style="width:400px;"/><br/>
		서명값 (base64)<br/>
		<textarea name="signature"></textarea><br/>
		인증서 (pem string)<br/>
		 <textarea name="cert"></textarea><br/>
		<input type="submit" value="파일서명 검증-서버"/>
	</form>
	
	<button onclick="verifySignFileTest()">파일서명 검증-클라이언트</button><br/>

	
	<script>
	function signFileTest(){
		var path = document.form1.tbsFilePath.value;
		Delfino.signFile(path, {signType:'signature'}, signFile_complete)
	}	
	
	function signFile_complete(result){
		if(result.status==1){
			alert("서명 성공");
			document.form2.signature.value = result.data;
			document.form2.cert.value = result.cert;
		}
		else if(result.status!=0){
			alert("서명 실패:" + result.message);
		}
	}
	
	function verifySignFileTest(){
		var path = document.form2.tbsFilePath.value;
		var signature = document.form2.signature.value;
		var cert = document.form2.cert.value;
		Delfino.verifySignFile(path, signature, cert, {signType:'signature'}, verifySignFile_complete)
	}
	
	function verifySignFile_complete(result){
		if(result.status==1){
			console.log(result);
			alert("검증 성공");
		}
		else{
			alert("검증 실패 [" + result.status +"]"+result.message);
		}
	}

	</script>
	
</body>
</html>
