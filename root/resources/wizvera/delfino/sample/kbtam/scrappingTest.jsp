<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="user-scalable=no, initial-scale=1.0, width=device-width" />
		<title>Scrapping Test</title>
		<style type="text/css">
		button {
			width: 150px;
		}
		</style>
	<script src="../../jquery/jquery-1.6.4.min.js" charset="utf-8"></script>
	<script src="../../delfino_config.js?20160309" charset="utf-8"></script>
	<script src="../../delfino_internal.nomin.js?20160309" charset="utf-8"></script>
	<script src="../../delfino.js?20160309" charset="utf-8"></script>
	<script src="../../delfino_site.js?20160309" charset="utf-8"></script>
	<script src="./delfino_kbtam.js?20160309" charset="utf-8"></script>
    </head>
    <body> 
       	<h2>KB계좌통합 테스트</h2>
       	
		<fieldset style="width:300px">
			<legend>기본정보</legend> 
			UID : <input id="uid" type="text" name="uid" value=""><br/>
			이름  : <input id="name" type="text" name="name" value=""><br/>
			서버PIN : <input id="pinNumber" type="text" name="pinNumber" value=""><br/>
		</fieldset>
		 
		<h4> 1. 사설개인키/공개키 발급 </h4>
		issuingUserPublicKey : <input id="issuingUserPublicKey" type="text" name="issuingUserPublicKey" value=""><br/>
		userPublicKey : <input id="userPublicKey" type="text" name="userPublicKey" value=""><br/>
		<button onclick="DelfinoKbtam.issueKeyPair(document.getElementById('uid').value, document.getElementById('name').value, document.getElementById('pinNumber').value, completeIssueKeyPair);">키 발급</button><br/>
		
		 
		<h4> 2. 스크래핑 등록 처리 </h4>
		<button onclick="DelfinoKbtam.listCertStore(completeListCertStore);">인증서 드라이브 요청</button>
		<select id="driveName"></select><br/>
		<button onclick="DelfinoKbtam.listCertInfo(getSelectedDrive(), {}, completeListCertInfo);">인증서목록요청</button>
		<select id="certInfoList"></select><br/>
		<button onclick="DelfinoKbtam.envelop(getSelectedCertInfo(), document.getElementById('uid').value, 'CERT_INFO', document.getElementById('userPublicKey').value, completeEnvelop);">인증매체암호화(CERT_INFO)</button>
		<button onclick="DelfinoKbtam.envelop(getSelectedCertInfo(), document.getElementById('uid').value, 'DATA', document.getElementById('userPublicKey').value, completeEnvelop2);">인증매체암호화(DATA)</button><br/>
		 
		
		<h4> 3. 스크래핑 요청 </h4>
		serverPublicKey : <input id="serverPublicKey" type="text" name="serverPublicKey" value=""><br/>
		<button onclick="getServerPublicKey();">serverPublicKey요청</button><br/>
		wrapSeedList : <input id="wrapSeedList" type="text" name="wrapSeedList" value=""><br/>
		<button onclick="getWrapSeedList();">wrapSeedList요청</button><br/>
		doubleWrapSeedList : <input id="doubleWrapSeedList" type="text" name="doubleWrapSeedList" value=""><br/>
		<button onclick="DelfinoKbtam.convertWrapSeedList(document.getElementById('serverPublicKey').value, document.getElementById('wrapSeedList').value, document.getElementById('uid').value, document.getElementById('pinNumber').value, completeConvert);">인증매체 복호화</button><br/>
		<textarea cols="80" rows="4" placeholder="result" id="result" name="result" value=""></textarea><br/>
		
		
		<h4> 4. 삭제 및 검증</h4> 
		UID : <input id="myUid" type="text" value=""><br/>
		<button onclick="DelfinoKbtam.deleteKeyPair(document.getElementById('myUid').value, completeDeleteKeyPair);">개인키 삭제</button>
		<button onclick="DelfinoKbtam.verifyKeyPair(document.getElementById('myUid').value, completeVerifyKeyPair);">개인키 검증</button>
		
		<h4> 5. 로밍 </h4>
		로밍 데이터 : <input id="roamingData" type="text" name="roamingData" value=""><br/>
		<button onclick="DelfinoKbtam.makeRoamingData(document.getElementById('uid').value, document.getElementById('name').value, document.getElementById('pinNumber').value,completeMakeRoamingData);">로밍 데이타 생성</button>
		<button onclick="DelfinoKbtam.resolveRoamingData(document.getElementById('uid').value, document.getElementById('name').value, document.getElementById('pinNumber').value, document.getElementById('roamingData').value, completeResolveRoamingData);">로밍 데이타 저장</button><br/>
		
				
		<script>
			function completeResolveRoamingData(result){
				if(result.status == 1){
					alert("저장 성공");	
				}else{
					alert('['+ result.status + '][' + result.message + ']');
				}
			} 
			function completeMakeRoamingData(result){
				if(result.status == 1){
					document.getElementById('roamingData').value = result.data;
				}else{
					alert('['+ result.status + '][' + result.message + ']');
				}
			}
			function completeListCertStore(result){
		    	var driveCombo = document.getElementById("driveName");
				var optionsLength = driveCombo.options.length;
				while(optionsLength--){
					driveCombo.remove(0);
				}
		    	for(var i = 0; i < result.data.length; ++i){
					var option = document.createElement('option');
					if(i == 0)
						option.selected = "selected";
		    		option.value = result.data[i].name;
					option.appendChild(document.createTextNode(result.data[i].name));
					driveCombo.appendChild(option);
		    	}
		    }
		    function completeListCertInfo(result){
				var certInfoCombo = document.getElementById("certInfoList");
				var optionsLength = certInfoCombo.options.length;
				while(optionsLength--){
					certInfoCombo.remove(0);
				}
				certInfoCombo.value = "";
		    	for(var i = 0; i < result.length; ++i){
					var option = document.createElement('option');
					if(i == 0)
						option.selected = "selected";
					option.value = result[i].certInfo;
					option.appendChild(document.createTextNode(option.value));
					certInfoCombo.appendChild(option);
		    	}
		    }
		    function completeIssueKeyPair(result){
		    	if(result.status == 1){
					alert("키발급 성공");
					document.getElementById('issuingUserPublicKey').value = result.issuingUserPublicKey;
					var form = createForm("uid", "name", "issuingUserPublicKey");
					form.uid.value = document.getElementById('uid').value;
					form.name.value = document.getElementById('name').value;
					form.issuingUserPublicKey.value = result.issuingUserPublicKey;
					callAjaxSubmit(form, 'userPublicKey');
				}else{
					alert('['+ result.status + '][' + result.message + ']');
				}
		    }
		    function completeEnvelop(result){
				if(result.status == 1){
					var authItem = jQuery.parseJSON(result.clientAuthItemString);
					var form = createForm("uid", "authItem");
					form.uid.value = document.getElementById('uid').value;
					form.authItem.value = authItem[0] + "," + authItem[1];
					callAjaxSubmit(form);
				}else{
					alert('['+ result.status + '][' + result.message + ']');
				}
		    }
			function completeEnvelop2(result){
				if(result.status == 1){
					var form = createForm("uid", "authItem");
					form.uid.value = document.getElementById('uid').value;
					form.authItem.value = result.clientAuthItemString;
					callAjaxSubmit(form);
				}else{
					alert('['+ result.status + '][' + result.message + ']');
				}
		    }
		    function completeConvert(result){
				if(result.status == 1){
					var doubleWrapSeedList = jQuery.parseJSON(result.doubleWrapSeedList);
					var fixData = "";
					for(var i = 0; i < doubleWrapSeedList.length; ++i){
						if(fixData.length != 0){
							fixData += ",";
						}
						fixData += doubleWrapSeedList[i];
					}
					document.getElementById("doubleWrapSeedList").value = fixData;

					var form = createForm("uid", "name", "doubleWrapSeedList");
					form.uid.value = document.getElementById('uid').value;
					form.name.value = document.getElementById('name').value;
					form.doubleWrapSeedList.value = fixData;
					callAjaxSubmit(form, "result", true);
				}else{
					alert('['+ result.status + '][' + result.message + ']');
				}
		    }
		    function completeDeleteKeyPair(result){
				alert('['+ result.status + '][' + result.message + ']');
		    }
		    function completeVerifyKeyPair(result){
		    	alert('['+ result.status + '][' + result.message + ']');
		    }
		    

			function createInput(inputName){
				var input = document.createElement('input');
				input.type = "text";
				input.name = inputName;
				return input;
			}
			function createForm(inputName1, inputName2, inputName3){
				var form = document.createElement('form');
				form.method = "post";
				if(inputName1 != null){
					form.appendChild(createInput(inputName1));
				}
				if(inputName2 != null){
					form.appendChild(createInput(inputName2));
				}
				if(inputName3 != null){
					form.appendChild(createInput(inputName3));
				}
				return form;
			}
			function callAjaxSubmit(form, elemId, b64){
				$.ajax({
					type: 'POST',
					url: "http://192.168.0.174/delfino4html/html5/demo/mockup.jsp",
					data: $(form).serialize(),
					success: function(data) {
						if(elemId != null){
							if(b64){
								data = Base64.decode(data);
							}
							document.getElementById(elemId).value = data;
						}else{
							alert(data);
						}	
					},
					error: function(res) {
						alert("error:"  + res);
					}
				});
			}
			function getServerPublicKey(){
				var form = createForm("uid", "name", "serverPublicKey");
				form.uid.value = document.getElementById('uid').value;
				form.name.value = document.getElementById('name').value;
				callAjaxSubmit(form, 'serverPublicKey');
			}
			function getWrapSeedList(){
				var form = createForm("uid", "name", "wrapSeedList");
				form.uid.value = document.getElementById('uid').value;
				form.name.value = document.getElementById('name').value;
				callAjaxSubmit(form, 'wrapSeedList');
			}
			function getSelectedDrive(){
				var e = document.getElementById("driveName");
				if(e.selectedIndex == -1) 
					return "";
				return e.options[e.selectedIndex].value;
			}
			function getSelectedCertInfo(){
				var e = document.getElementById("certInfoList");
				if(e.selectedIndex == -1) 
					return "";
				return e.options[e.selectedIndex].value;
			}


			var Base64 = {
				// private property
				_keyStr : "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",
				// public method for encoding
				encode : function (input){
					var output = "";
					var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
					var i = 0;

					while (i < input.length) {

					  chr1 = input.charCodeAt(i++);
					  chr2 = input.charCodeAt(i++);
					  chr3 = input.charCodeAt(i++);

					  enc1 = chr1 >> 2;
					  enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
					  enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
					  enc4 = chr3 & 63;

					  if (isNaN(chr2)) {
						  enc3 = enc4 = 64;
					  } else if (isNaN(chr3)) {
						  enc4 = 64;
					  }

					  output = output +
						  this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) +
						  this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);

					}

					return output;
				},

				// public method for decoding
				decode : function (input){
					var output = "";
					var chr1, chr2, chr3;
					var enc1, enc2, enc3, enc4;
					var i = 0;

					input = input.replace(/[^A-Za-z0-9+/=]/g, "");

					while (i < input.length){
						enc1 = this._keyStr.indexOf(input.charAt(i++));
						enc2 = this._keyStr.indexOf(input.charAt(i++));
						enc3 = this._keyStr.indexOf(input.charAt(i++));
						enc4 = this._keyStr.indexOf(input.charAt(i++));

						chr1 = (enc1 << 2) | (enc2 >> 4);
						chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
						chr3 = ((enc3 & 3) << 6) | enc4;

						output = output + String.fromCharCode(chr1);

						if (enc3 != 64) {
							output = output + String.fromCharCode(chr2);
						}
						if (enc4 != 64) {
							output = output + String.fromCharCode(chr3);
						}
					}
					return output;
				}
			}
		</script>
	</body>
</html>
