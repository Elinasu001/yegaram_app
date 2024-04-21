<%-- --------------------------------------------------------------------------
 - File Name   : option_pack.jsp(선택기능)
 - Include     : delfino.jsp
 - Author      : WIZVERA
 - Last Update : 2016/3/23
-------------------------------------------------------------------------- --%>
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>
<HEAD>
    <META http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <META http-equiv="X-UA-Compatible" content="IE=edge" />
    <META http-equiv="Expires" content="-1" />
    <META http-equiv="Progma" content="no-cache" />
    <META http-equiv="cache-control" content="no-cache" />
    <title>WizIN-Delfino Sample</title>
    <style type="text/css">
        #desc { width: 800px; display: inline-block; text-align: left; font-size: 10pt; }
    </style>

	<%@ include file="../svc/delfino.jsp"%>

	<script type=text/javascript>
	$(document).ready(function() {
    var fileInput = $("#fileInput").get(0);
    fileInput.addEventListener("change",
        function(e) {
            fileContent = "";
            var filee = fileInput.files[0];
            var textType = /text.*/;
            if(filee.type.match(textType)) {
                var reader = new FileReader();
                reader.onload = function(e) { 
					//$("#xml").html(reader.result); 
					document.signXmlForm.orgTaxInvoice.value = reader.result;
					document.signXmlForm.fileName.value = filee.name;
				}
                reader.readAsText(filee, "UTF-8");
            } else {
                alert("File not supported");
            }
        });
	});//END OF READY
	</script>

</head>

<body>
    <h2>1. 파일전자서명 <font size=2><a href="./index.jsp">Home</a></font></h2>
    <div id="desc">
	이체나 약관동의시 사용되는 전자서명 기능을 확인합니다.
    <a href="javascript:Delfino.setPolicyOidCertFilter('');Delfino.setIssuerCertFilter('');alert('인증서필터링이 제거되엇습니다.');">인증서필터링해제</a>
    <br/>인증서로그인시 사용된 인증서만 보여집니다.
    <a href="javascript:Delfino.manageCertificate();">인증서관리</a>
    <a href="javascript:Delfino.resetCertificate();alert('인증서 캐쉬가 초기화되었습니다.');">인증서캐쉬초기화</a>
    </div>
    <script type="text/javascript">
    //<![CDATA[

    //파일서명(로컬방식): signFile
	function signFile_complete(result) {
		if(result.status==1) {
			document.signFileForm.signature.value = result.data;
			document.signFileForm.cert.value = result.cert;
			alert(document.signFileForm.tbsFilePath.value);
			Delfino.verifySignFile(document.signFileForm.tbsFilePath.value, result.data, result.cert, {signType:'signature'}, verify_complete);
		} else if(result.status==0) {
			alert("Cancel");
		} else {
			alert(result.message+"("+result.status+")");
		}
	}
	function verify_complete(result) {
		if(result.status==1) {
			alert("검증결과: OK");
			document.signFileForm.action = "signFileResult.jsp";
			document.signFileForm.target = "testResult";
			document.signFileForm.submit();
		} else if(result.status==0) {
			alert("검증결과: Cancel");
		} else {
			alert(result.message+"("+result.status+")");
		}
	}
	function upload_complete(result) {
		if(result.status==1) {
			alert("업로드: OK");
			document.signFileUrlForm.action = "signFileResult.jsp";
			document.signFileUrlForm.target = "testResult";
			document.signFileUrlForm.uploadResult.value = result.data;
			document.signFileUrlForm.submit();
		} else if(result.status!=0) {
			alert(result.message);
		}		 
	}
	function down_complete(result){
		if(result.status==1){
			alert("다운로드: OK");
			document.signFileUrlDivForm.action = "signFileResult.jsp";
			document.signFileUrlDivForm.target = "testResult";
			document.signFileUrlDivForm.downResult.value = result.filePath;	// 다운로드파일 경로
			alert("다운로드 저장: " + result.filePath);
		} else {
			alert(result.message + "(" + result.status + ")");
		}
	}
	function sign_complete(result){
		if(result.status==1){
			alert("파일서명: OK");
			document.signFileUrlDivForm.action = "signFileResult.jsp";
			document.signFileUrlDivForm.target = "testResult";
			document.signFileUrlDivForm.signResult.value = result.filepath;	// 전자서명파일 경로
			alert("서명파일 저장: " + result.filepath);
		} else {
			alert(result.message + "(" + result.status + ")");
		}
	}
	function div_upload_complete(result) {
		if(result.status==1) {
			alert("업로드: OK");
			document.signFileUrlDivForm.action = "signFileResult.jsp";
			document.signFileUrlDivForm.target = "testResult";
			document.signFileUrlDivForm.uploadResult.value = result.data;
			document.signFileUrlDivForm.submit();
		} else if(result.status!=0) {
			alert(result.message);
		}		 
	}
	//]]>
    </script>
	<h3>A. 파일서명(로컬방식)-LG유플러스</h3>
    <div id="desc">
	<ul>
	<form name="signFileForm">
		<input type="hidden" name="_action" value="signFileForm"/>
		<li>원본: <input type="text" name="tbsFilePath" value="C:/temp/dump.pdf" style="width:480px;"/></li>
		<li>서명값: <textarea name="signature" style="width:480px;"/></textarea></li>
		<li>인증서: <textarea name="cert" style="width:480px;"/></textarea></li>
	</form>
	<button onclick="Delfino.signFile(document.signFileForm.tbsFilePath.value, {signType:'signature'}, signFile_complete);">파일서명</button><p>
	</ul>
	</div>

	<h3>B. 파일서명(업다운로드)-KEB하나은행</h3>
	<div id="desc">
    <ul>
	<form name="signFileUrlForm">
		<input type="hidden" name="_action" value="signFileUrlForm"/>
		<li>다운로드: <input type="text" name="down_url" value="/resources/wizvera/delfino/demo/tbsFileDownload.jsp?file=dump.pdf" style="width:480px;"/></li>
		<li>업로드: <input type="text" name="up_url" value="/resources/wizvera/delfino/demo/fileUpload.jsp" style="width:480px;"/></li>
		<li>업로드 결과: <input type="text" name="uploadResult" value=""/></li>
	</form>
	<button onclick="Delfino.signFileUrl(document.signFileUrlForm.down_url.value, document.signFileUrlForm.up_url.value, {signType:'sig',saveType:'select',deleteFile:true}, upload_complete);">파일서명</button><p>
	</ul>
	</div>

	<script type="text/javascript">
	var downResultArr = [];
	var upResultArr = [];
	function multi_down_complete(result){
		if(result.status==1){
			//alert("다운로드: OK");
			document.signFileUrlDivForm.action = "signFileResult.jsp";
			document.signFileUrlDivForm.target = "testResult";
			downResultArr.push(result.filePath);
			alert("다운로드 저장: " + result.filePath);
		} else {
			alert(result.message + "(" + result.status + ")");
		}
	}
	function multi_sign_complete(result){
		if(result.status==1){
			//alert("파일서명: OK");
			document.signFileUrlDivForm.action = "signFileResult.jsp";
			document.signFileUrlDivForm.target = "testResult";
			document.signFileUrlDivForm.signResult.value = result.filepath;	// 전자서명파일 경로
			upResultArr = (result.filepath).split("|");
			alert("서명파일 저장: " + result.filepath);
		} else {
			alert(result.message + "(" + result.status + ")");
		}
	}
	function multi_upload_complete(result) {
		if(result.status==1) {
			//alert("업로드: OK");
			document.signFileUrlDivForm.action = "signFileResult.jsp";
			document.signFileUrlDivForm.target = "testResult";
			alert("업로드 경로: " + result.data);
			document.signFileUrlDivForm.submit();
		} else if(result.status!=0) {
			alert(result.message);
		}		 
	}
	function setCount() {
		downResultArr = [];
		upResultArr = [];
		var cnt = parseInt(document.signFileUrlDivForm.setCnt.value);
		var download_path = "/delfino-demo/delfino/sample/tbsFileDownload.jsp";
		var download_file = "";
		var download_url = "";
		var download_list = "";
		var download_result = "";
		var download_button = "";
		var sign_result = "";
		var sign_button = "";
		var upload_list = "";
		var upload_url= "/delfino-demo/delfino/sample/fileUpload.jsp";
		var upload_button = "";
		var upload_result = "";

		$(".download_url").empty();
		$(".downResult").empty();
		$(".signResult").empty();
		$(".upload_url").empty();
		$(".uploadResult").empty();

		for(var i=1; i<cnt+1; i++) {
			download_file = "dump" + i + ".pdf";
			download_url = download_path + "?file=" + download_file;
			//download_button = "<li><button onclick=\"Delfino.signFileUrlDown(document.signFileUrlDivForm.download_url_"+i+".value, {saveType:'default', deleteFile:true}, {complete:multi_down_complete, context:'1'});\">다운로드"+i+"</button>&nbsp";
			download_button = "<li><a href=\"javascript:Delfino.signFileUrlDown(document.signFileUrlDivForm.download_url_"+i+".value, {saveType:'default', deleteFile:false}, multi_down_complete);\">다운로드"+i+"</a>&nbsp";
			download_list = "<input type='text' name='download_url_" + i + "' value='" + download_url + "' style='width:480px;'/></li>";
			download_button += download_list;
			$(".download_url").append(download_button);

			upload_button = "<li><a href=\"javascript:Delfino.signFileUrlUp(upResultArr["+(i-1)+"], document.signFileUrlDivForm.upload_url_"+i+".value, {deleteFile:false}, multi_upload_complete);\">업로드"+i+"</a>&nbsp";
			upload_list = "<input type='text' name='upload_url_" + i + "' value='" + upload_url + "' style='width:480px;'/></li>";
			upload_button += upload_list;
			$(".upload_url").append(upload_button);
		}
	    // saveType : default(C:\Users\~\AppData\Local\Temp\Delfino)
	    //downResultArr = [];
		sign_button = "<li><a href=\"javascript:alert(downResultArr);Delfino.signFileUrlSign(downResultArr, {saveType:'default', signType:'sig', multiSign:true , multiSignDelimiter:'|'}, multi_sign_complete);\">전자서명</a>&nbsp";
		sign_result = "<input type='text' name='signResult' value='' style='width:480px;'/></li>";
		sign_button += sign_result;
		$(".signResult").append(sign_button);
	}
	</script>

	<h3>C. 멀티파일서명(다운로드/전자서명/업로드)-KEB하나은행</h3>
	<div id="desc">
	<ul>
	<form name="signFileUrlDivForm">
		<li><button type="button" onclick="setCount();">클릭</button> <input type="text" name="setCnt" value="1" style="width:50px;"/> 건 </li>
		<input type="hidden" name="_action" value="signFileUrlDivForm"/>
		<div class="download_url"></div>
		<div class="downResult"></div>
		<div class="signResult"></div>
		<div class="upload_url"></div>
		<div class="uploadResult"></div>
	</form>
	</ul>
	</div>

    <h2>2. XML 전자서명 <font size=2><a href="./index.jsp">Home</a></font></h2>

	<script type="text/javascript">
		var index = 0;
		var cnt = 2;

		function xml_complete(result) {
			if(result.status==0) return; // cancel
			if(result.status==1) {
				document.signXmlForm.dsigTaxInvoice.value = result.signData;
				document.signXmlForm.rValue.value = result.vidRandom;
				//document.signXmlForm.orgTaxInvoice.value = document.xmlForm.xml.value;
				document.signXmlForm.target = "testResult";
				document.signXmlForm.action = "xmldsigAction.jsp";
				document.signXmlForm.submit();
			} else {
				alert(result.status + ":" + result.message);
				return;
			}
		}
		function xmldsig() {
			Delfino.sign(document.signXmlForm.orgTaxInvoice.value, xml_complete, {dataType:"xml", signType:"xmldsig-kec"});
		}

		function end_xmldsig(result) {
			if(result.status==0) return; // cancel
			if(result.status!=1) { alert(result.status + ":" + result.message); return; }
		}
		function silent_complete(result) {
			if(result.status==0) return; // cancel
			if(result.status!=1) { alert(result.status + ":" + result.message); return; }

			var params = "dsigTaxInvoice=" + encodeURIComponent(result.signData);
				params += "&rValue=" + encodeURIComponent(result.vidRandom);
				params += "&orgTaxInvoice=" + encodeURIComponent(document.signXmlForm.orgTaxInvoice.value);
				params += "&fileName=" + encodeURIComponent(document.signXmlForm.fileName.value);
			var post_url = "xmldsigAction.jsp";

			$.ajax({
				type: "post",
				url: post_url,
				data: params,
				contentType: "application/x-www-form-urlencoded", // 전송 데이터 타입
				dataType: "html", // 응답 데이터 타입
				beforeSend: "", //ajax로 전송 전 호출할 함수
				success: function(data){
					var iframe = document.getElementById("testResult"); 
					var doc; 
					if(iframe.contentDocument) doc = iframe.contentDocument; 
					else doc = iframe.contentWindow.document;
					doc.body.innerHTML = data;
				},
				error: function(e){
					alert(e.responseText);
				}
			});
			
			if(index < cnt-1) {
				Delfino.sign(document.signXmlForm.orgTaxInvoice.value, {silentSign:true, ssid:result.ssid, dataType: "xml", signType:"xmldsig-kec"}, silent_complete);
				index++;
			} else {
				Delfino.endSign(result.ssid, end_xmldsig);
			}
		}
		function start_xmldsig() {
			Delfino.sign(document.signXmlForm.orgTaxInvoice.value, {silentSign:true, ssid:null, dataType:"xml", signType:"xmldsig-kec"}, silent_complete);
		}

	</script>
    <div id="desc">
	1. 아래의 입력상자에 XML형태의 세금계산서를 입력 후 하단의 "XML전자서명" 버튼을 클릭합니다.<br/>
	2. 인증서를 제출하여 세금계산서를 전자서명합니다.<br/>
	3. 다음화면에서 [서명된 전자세금계산서] "XML다운로드" 버튼을 클릭하여 "서명된 전자세금계산서"를 다운로드 합니다.<br/>
	4. http://www.taxcerti.or.kr 접속하여 다운로드된 파일을 검증합니다.<p>
	<form method="post" name="signXmlForm">
		사업자번호 <input type="text" name="idn">
		<textarea style="display:none" rows="10" cols="80" name="dsigTaxInvoice"></textarea>
		<textarea style="display:none" rows="10" cols="80" name="orgTaxInvoice"></textarea>
		<textarea style="display:none" rows="1" cols="80" name="rValue"></textarea>
		<textarea style="display:none" rows="1" cols="80" name="fileName"></textarea>
	</form>
    전자세금계산서(XML) <input type="file" id="fileInput"><br/>
	<button onclick="xmldsig();">XML 전자서명</button>
	<button onclick="start_xmldsig();">XML 반복서명</button>
	</div>

    <h2>3. 스마트폰 가져오기/내보내기 <font size=2><a href="./index.jsp">Home</a></font></h2>
	<script type="text/javascript">
	function export_complete(result) {
		if(result.status==0) return; // cancel
		if(result.status==1) {
			alert(result.status + ":" + result.message);
		} else {
			alert(result.status + ":" + result.message);
			return;
		}
	}
	function import_complete(result) {
		if(result.status==0) return; // cancel
		if(result.status==1) {
			alert(result.status + ":" + result.message);
		} else {
			alert(result.status + ":" + result.message);
			return;
		}
	}
	</script>
	<button onclick="Delfino.exportCertificate({providerUrl:'https://smart.kfcc.co.kr/sb/app/cert-relay-v12.jsp', provider:'initech'}, export_complete);">인증서 내보내기(initech)</button>
	<button onclick="Delfino.importCertificate({providerUrl:'https://smart.kfcc.co.kr/sb/app/cert-relay-v12.jsp', provider:'initech'}, import_complete);">인증서 가져오기(initech)</button>

	<hr/>

	<h2>Result</h2>
    <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0">
      <tr><td bgcolor="#FFFFFF" height="320">
        <iframe name='testResult' id='testResult' frameborder='0' width='100%' height='100%'></iframe>
      </td></tr>
    </table>

</body>
</html>
