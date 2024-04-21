<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>파일서명 암호화 업로드 테스트</title>
	<%@ include file="../svc/delfino.jsp" %>
</head>
<body>
	<h2>1. 파일서명 다운로드, 서명, 업로드</h2>
	<form name="form">
		다운로드 URL : <input type="text" name="downloadurl" value="/delfino-demo/delfino/sample/tbsFileDownload.jsp?file=data.pdf" style="width:400px;"/><br/>
		업로드 URL : <input type="text" name="uploadurl" value="/delfino-demo/delfino/sample/fileUpload.jsp" style="width:400px;"/><br/>
	</form>
	
	<form name="result">
		<input type="text" name="downResult">
		<input type="text" name="signResult">
		<input type="text" name="uploadResult">
	</form>
		

	<!-- saveType : default, select, path -->
	<button onclick="Delfino.signFileUrlDown(document.form.downloadurl.value, {saveType:'default', deleteFile:true}, down_complete);">다운로드</button>
	<button onclick="Delfino.signFileUrlSign(document.result.downResult.value, {saveType:'default', signType:'sig'}, sign_complete);">서명</button>
	<button onclick="Delfino.signFileUrlUp(document.result.signResult.value, document.form.uploadurl.value, {deleteFile:false}, upload_complete);">업로드</button>

    <form method="post" name="signFile" action="signFileUrlAction.jsp">
    	<input type="hidden" name="data"/><br/><br/>    	
    </form>
    <br/><br/>
	<script>
	function down_complete(result){
		if(result.status==1){
			document.result.downResult.value = result.filePath;
			alert("다운로드 성공:" + result.filePath);
		}
		else if(result.status!=0){
			alert("다운로드 실패:" + result.message);
		}
	}
	
	function sign_complete(result){
		if(result.status==1){
			document.result.signResult.value = result.filepath;
			alert("서명 성공:" + result.filepath);
		}
		else if(result.status!=0){
			alert("서명 실패:" + result.message);
		}
	}
	
	function upload_complete(result){
		if(result.status==1){
			alert("업로드 성공:" + result.data);
			document.result.uploadResult.value = result.data;
		}
		else if(result.status!=0){
			alert("업로드 실패:" + result.message);
		}
		 
	}
	</script>
	
</body>
</html>
