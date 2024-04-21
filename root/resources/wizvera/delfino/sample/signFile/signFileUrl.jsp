<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>파일서명 암호화 업로드 테스트</title>
<script src="../../jquery/jquery-1.6.4.min.js" charset="utf-8"></script>
<script src="../../delfino_config.js?20160309" charset="utf-8"></script>
<script src="../../delfino_internal.nomin.js?20160309" charset="utf-8"></script>
<script src="../../delfino.js?20160309" charset="utf-8"></script>
<script src="../../delfino_site.js?20160309" charset="utf-8"></script>
</head>
<body>
	<h2>1. 대법원 파일 전자서명 검증</h2>
	<form name="form1">
		다운로드 URL : <input type="text" name="downloadurl" value="/delfino-demo/delfino/sample/tbsFileDownload.jsp?file=data.pdf" style="width:400px;"/><br/>
		업로드 URL : <input type="text" name="uploadurl" value="/delfino-demo/delfino/sample/fileUpload.jsp" style="width:400px;"/><br/>
	</form>
	<form name="form2">
		<input type="text" name="downResult">
		<input type="text" name="signResult">
		<input type="text" name="uploadResult">
	</form>
	<script type="text/javascript">
	function all_complete(result){
		if(result.status==1){
			console.log(result);
			alert("서명 성공:" + result.data);
			document.signFile.data.value = result.data;
			document.signFile.submit();
		}
		else if(result.status!=0){
			alert("서명 실패:" + result.message);
		}
	}
	function down_complete(result){
		if(result.status==1){
			if(document.form2.downResult.value != "" && result.filePath != ""){
				document.form2.downResult.value += "|";
			}
			document.form2.downResult.value += result.filePath;

			alert("다운로드 성공:" + result.filePath);
		}
		else if(result.status!=0){
			alert("다운로드 실패:" + result.message);
		}
	}
	function sign_complete(result){
		if(result.status==1){
			document.form2.signResult.value = result.filepath;
			alert("서명 성공:" + result.filepath);
		}
		else if(result.status!=0){
			alert("서명 실패:" + result.message);
		}
	}
	function upload_complete(result){
		if(result.status==1){
			alert("업로드 성공:" + result.data);
			document.form2.uploadResult.value = result.data;
		}
		else if(result.status!=0){
			alert("업로드 실패:" + result.message);
		}
	}
	function callSignFileUrl(saveType, del){
		Delfino.signFileUrl(document.form1.downloadurl.value, document.form1.uploadurl.value, {signType:'sig', saveType:saveType, deleteFile:del, setCookie:'test=1234'}, all_complete);
	}
	function callSignFileUrlDown(saveType, del){
		Delfino.signFileUrlDown(document.form1.downloadurl.value, {saveType:saveType, deleteFile:del, setCookie:'test4=2345'}, down_complete);
	}
	function callSignFileUrlSign(saveType, del, multi, arrayData){
		if(multi){
			if(arrayData){
				Delfino.signFileUrlSign(document.form2.downResult.value.split("|"), {signType:'sig', saveType:saveType, deleteFile:del, multiSign:multi, multiSignDelimiter:'|'}, sign_complete);	
			}else{
				Delfino.signFileUrlSign(document.form2.downResult.value, {signType:'sig', saveType:saveType, deleteFile:del, multiSign:multi, multiSignDelimiter:'|'}, sign_complete);
			}
		}else{
			var arr = new Array();
			arr = document.form2.downResult.value.split("|");	
			Delfino.signFileUrlSign(arr[arr.length-1], {signType:'sig', saveType:saveType, deleteFile:del}, sign_complete);
		}
		
	}
	
	function sleep(num){	//[1/1000초]
		 var now = new Date();
		   var stop = now.getTime() + num;
		   while(true){
			 now = new Date();
			 if(now.getTime() > stop)return;
		   }
	}
	
	function callSignFileUrlUp(saveType, del, arrayData){
		if(saveType == 'select'){
			document.form2.signResult.value = "";
		}
		if(arrayData){
			Delfino.signFileUrlUp(document.form2.signResult.value.split("|"), document.form1.uploadurl.value, {saveType:saveType, deleteFile:del}, upload_complete);
		}else{
			Delfino.signFileUrlUp(document.form2.signResult.value, document.form1.uploadurl.value, {saveType:saveType, deleteFile:del, delimiter:'|'}, upload_complete);
		}
	}
	</script>
	<h4>파일서명(다운로드 - 서명 - 업로드)</h4>
	<button onclick="callSignFileUrl('default',false);">파일서명(디폴트)</button><br/>
	<button onclick="callSignFileUrl('default',true);">파일서명(디폴트-delete)</button><br/>
	<button onclick="callSignFileUrl('select',false);">파일서명(유저선택)</button><br/>
	<button onclick="callSignFileUrl('select',true);">파일서명(유저선택-delete)</button><br/>
	<h4>파일서명(다운로드)</h4>
	<button onclick="callSignFileUrlDown('default',false);">다운로드(디폴트)</button><br/>
	<button onclick="callSignFileUrlDown('default',true);">다운로드(디폴트/옵션delete)</button>(다운로드 받기전에 default폴더를 지운후 다운로드를 받음)<br/>
	<button onclick="callSignFileUrlDown('select',false);">다운로드(유저선택)</button><br/>
	<h4>파일서명(서명)</h4>
	<button onclick="callSignFileUrlSign('default',false, false);">서명(디폴트)</button><br/>
	<button onclick="callSignFileUrlSign('default',true, false);">서명(디폴트/옵션delete)</button>(서명후에 원본 파일을 지움)<br/>
	<button onclick="callSignFileUrlSign('select',false, false);">서명(유저선택)</button><br/>
	<button onclick="callSignFileUrlSign('select',true, false);">서명(유저선택/옵션delete)</button>(서명후에 원본 파일을 지움)<br/>
	<br/><br/>	
	<button onclick="callSignFileUrlSign('default',false, true, false);">멀티 서명(디폴트)</button><br/>
	<button onclick="callSignFileUrlSign('default',true, true, false);">멀티 서명(디폴트/옵션delete)</button>(서명후 원본 파일'들'을 지움)<br/>
	<button onclick="callSignFileUrlSign('select',false, true, false);">멀티 서명(유저선택)</button><br/>
	<button onclick="callSignFileUrlSign('select',true, true, false);">멀티 서명(유저선택/옵션delete)</button>(서명후 원본 파일'들'을 지움)<br/>
	<br/><br/>	
	<button onclick="callSignFileUrlSign('default',false, true, true);">멀티 서명 배열 데이타(디폴트)</button><br/>
	<button onclick="callSignFileUrlSign('default',true, true, true);">멀티 서명 배열 데이타(디폴트/옵션delete)</button>(서명후 원본 파일'들'을 지움)<br/>
	<button onclick="callSignFileUrlSign('select',false, true, true);">멀티 서명 배열 데이타(유저선택)</button><br/>
	<button onclick="callSignFileUrlSign('select',true, true, true);">멀티 서명 배열 데이타(유저선택/옵션delete)</button>(서명후 원본 파일'들'을 지움)<br/>
	<h4>파일서명(업로드)</h4>
	<button onclick="callSignFileUrlUp('default',false, false);">업로드(디폴트)</button><br/>
	<button onclick="callSignFileUrlUp('default',true, false);">업로드(디폴트/옵션delete)</button>(업로드후에 내컴퓨터의 업로드한 파일을 지움)<br/>
	<button onclick="callSignFileUrlUp('select',false, false);">업로드(유저선택)</button><br/>
	<button onclick="callSignFileUrlUp('select',true, false);">업로드(유저선택/옵션delete)</button>(업로드후에 내컴퓨터의 업로드한 파일을 지움)<br/>
	
	<button onclick="callSignFileUrlUp('default',false, true);">업로드 배열 데이타(디폴트)</button><br/>
	<button onclick="callSignFileUrlUp('default',true, true);">업로드 배열 데이타(디폴트/옵션delete)</button>(업로드후에 내컴퓨터의 업로드한 파일을 지움)<br/>
	<button onclick="callSignFileUrlUp('select',false, true);">업로드 배열 데이타(유저선택)</button><br/>
	<button onclick="callSignFileUrlUp('select',true, true);">업로드 배열 데이타(유저선택/옵션delete)</button>(업로드후에 내컴퓨터의 업로드한 파일을 지움)<br/>
    <form method="post" name="signFile" action="signFileUrlAction.jsp">
    	<input type="hidden" name="data"/><br/><br/>    	
    </form>
</body>
</html>

