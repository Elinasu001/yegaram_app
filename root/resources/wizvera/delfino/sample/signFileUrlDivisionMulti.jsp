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

	<script language="javascript">
	var download;
	var upload = 2;
	var filePath = [];
	function down_complete(result){
		if(result.status==1){
			download = download-1;
			filePath.push(result.filePath);
			alert("다운로드 저장: " + result.filePath);
			if(download==2){
				document.result.downResult_1.value = result.filePath;	// 다운로드파일 경로
				Delfino.signFileUrlDown(document.form.downloadurl_2.value, {saveType:'default', deleteFile:false}, down_complete);
			}
			if(download==1){
				document.result.downResult_2.value = result.filePath;	// 다운로드파일 경로
				Delfino.signFileUrlDown(document.form.downloadurl_3.value, {saveType:'default', deleteFile:false}, down_complete);
			}
			if(download==0) document.result.downResult_3.value = result.filePath;	// 다운로드파일 경로
		} else {
			alert(result.message + "(" + result.status + ")");
		}
	}
	function sign_complete(result){
		var arrResult;
		if(result.status==1){
			arrResult = (result.filepath).split('|');
			document.result.signResult_1.value = arrResult[0];	// 전자서명파일 경로
			document.result.signResult_2.value = arrResult[1];	// 전자서명파일 경로
			document.result.signResult_3.value = arrResult[2];	// 전자서명파일 경로
			alert("서명파일 저장: " + result.filepath);
		} else {
			alert(result.message + "(" + result.status + ")");
		}
	}
	function upload_complete(result){
		if(result.status==1){
			upload = upload-1;
			alert("업로드 파일명: " + result.data);
			document.result.uploadResult.value = result.data;	// 업로드파일 명
			if(upload) Delfino.signFileUrlUp(document.result.signResult.value, document.form.uploadurl_2.value, {deleteFile:false}, upload_complete);
		} else {
			alert(result.message + "(" + result.status + ")");
		}
		 
	}
	function signFileUrlDown(){
		download =3;
		Delfino.signFileUrlDown(document.form.downloadurl_1.value, {saveType:'default', deleteFile:false}, down_complete);
	}
	function signFileUrlSign(){
		filePath = [];		
		filePath.push(document.result.downResult_1.value);
		filePath.push(document.result.downResult_2.value);
		filePath.push(document.result.downResult_3.value);
		Delfino.signFileUrlSign(filePath, {saveType:'default', signType:'sig', multiSign:true , multiSignDelimiter:'|'}, sign_complete);
	}
	function signFileUrlUp(){
		Delfino.signFileUrlUp(document.result.signResult_2.value, document.form.uploadurl.value, {deleteFile:true}, upload_complete);
	}
	</script>

	<script language="javascript">
	$(document).ready(function(){
		//var down_file = "테스트_20111018.pdf";
		//var down_url = "/wizvera/delfino/demo/signFileUrl/tbsFileDownload.jsp?file="+encodeURIComponent(down_file);
		var down_file = "dump.pdf";
		var down_file2 = "dump2.pdf";
		var down_file3 = "dump3.pdf";
		var down_url = "/delfino-demo/delfino/sample/tbsFileDownload.jsp?file="+down_file;
		var down_url2 = "/delfino-demo/delfino/sample/tbsFileDownload.jsp?file="+down_file2;
		var down_url3 = "/delfino-demo/delfino/sample/tbsFileDownload.jsp?file="+down_file3;
		var up_url = "/delfino-demo/delfino/sample/fileUpload.jsp";
		document.form.downloadurl_1.value = down_url;
		document.form.downloadurl_2.value = down_url2;
		document.form.downloadurl_3.value = down_url3;
		document.form.uploadurl.value = up_url;
	});
	</script>

	<form name="form">
		다운로드 URL_1 : <input type="text" name="downloadurl_1" value="" style="width:640px;"/><p/>
		다운로드 URL_2 : <input type="text" name="downloadurl_2" value="" style="width:640px;"/><p/>
		다운로드 URL_3 : <input type="text" name="downloadurl_3" value="" style="width:640px;"/><p/>
		업로드 URL : <input type="text" name="uploadurl" value="" style="width:640px;"/><p/>
	</form>
	<form name="result">
		다운로드 결과 1: <input type="text" name="downResult_1" style="width:640px;"/><p/>
		다운로드 결과 2: <input type="text" name="downResult_2" style="width:640px;"/><p/>
		다운로드 결과 3: <input type="text" name="downResult_3" style="width:640px;"/><p/>
		전자서명 결과_1 : <input type="text" name="signResult_1" style="width:640px;"/><p/>
		전자서명 결과_2 : <input type="text" name="signResult_2" style="width:640px;"/><p/>
		전자서명 결과_3 : <input type="text" name="signResult_3" style="width:640px;"/><p/>
		업로드 결과 : <input type="text" name="uploadResult" style="width:640px;"/><p/>
	</form>

	<!-- saveType : default -->
	<!-- C:\Users\~\AppData\Local\Temp\Delfino -->
	<button onclick="signFileUrlDown();">다운로드</button>
	<button onclick="signFileUrlSign();">전자서명</button>
	<button onclick="signFileUrlUp();">업로드</button>

    <form method="post" name="signFile" action="signFileUrlAction.jsp">
    	<input type="hidden" name="data"/><br/><br/>
    </form>
    <br/><br/>
	
</body>
</html>
