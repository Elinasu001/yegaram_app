<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Expires" content="-1" />
    <meta http-equiv="Progma" content="no-cache" />
    <meta http-equiv="cache-control" content="no-cache" />
	<meta name='viewport' content='initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width' />
	<title>마이데이터 전자서명</title>
	
	<%@ include file="../svc/delfino.jsp" %>

<script>
// issuerCertFilter 제거.
//DelfinoConfig.issuerCertFilter="";
//DelfinoConfig.policyOidCertFilter="";
//DelfinoConfig.g4.signServerUrl = "https://local-jeonghun.wizvera.com/wizvera/delfino4html/g10";
</script>

</head>
<body>
	<h1>ucpidSign</h1>
    
    <!-- 실제로 전송되는 form -->
	<!--
   	<form name="delfinoForm" method="post" action="./myDataSignResult.jsp">
   		<input type="hidden" name="_action" />
   		<input type="hidden" name="signData" />
   		<input type="hidden" name="userAgreement" />
   		<input type="hidden" name="userAgreeInfos" />
   	</form>
	-->
    
	<!-- 실제로 전송되는 arrayform -->	
   	<form name="delfinoArrayForm" id="delfinoArrayForm" method="post" action="./myDataSignResult.jsp">
   		<input type="hidden" name="_action" id="_action" />
		<input type="hidden" name="caOrg" id="caOrg" />
		<!--
		<input type="hidden" name="imsi" id="imsi" />
		<input type="hidden" name="signedDataList" id="signedDataList" />
		-->
	</form>

	<form name="ucpidAppForm">
		<h4>1. 앱 테스트용(안드로이드/iOS)</h4>
		<ul style="list-style-type:disc">
			<li>앱에서 출력한 signData 붙여넣기(Ctrl+V)<br/>
<textarea id="signdata" name="signdata" rows="15" cols="55">{
"signedDataList": [
    {
        "orgCode": "000",
        "signedPersonInfoReq": "MIIInQYJKoZIhvcNAQcCoIIIjjCCCIoCAQExDzANBglghkgBZQMEAgEFADCBkgYJKoZIhvcNAQcBoIGEBIGBMH8CAQIEFMMs04h-lWpwk9SxVM9f7vzt_nt5MC0MJ-qwnOyduOygleuztCDtmZzsmqnsl5Ag64-Z7J2Y7ZWp64uI64ukLgMCA_gwJAwRV2l6SU4tRGVsZmlubyBHMTAMB1dJWlZFUkEwBgIBCgIBAQwPd3d3LndpenZlcmEuY29toIIF6DCCBeQwggTMoAMCAQICBAF2VtEwDQYJKoZIhvcNAQELBQAwUzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRkwFwYDVQQDDBBDcm9zc0NlcnRUZXN0Q0E1MB4XDTIxMDkyNDAxMDAwMFoXDTIyMDkyNDE0NTk1OVowgYAxCzAJBgNVBAYTAktSMRIwEAYDVQQKDAlDcm9zc0NlcnQxFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEVMBMGA1UECwwM65Ox66Gd6riw6rSAMRIwEAYDVQQLDAnthYzsiqTtirgxGzAZBgNVBAMMEkND66eI7J20642w7J207YSwNDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANNXcoekEWg22qUkc0K1rvqGDKgkUTi7rQEyrAEINdynzXn9RSCCToLKbEk8SsGP7CHBg55h1Q58Rhbr4Z7XPzBp320vAOnYDOynF_PzEjdAry57tv3Rcn2tZZpIRP52NaHRuhb5eU32BFdyuD6AEzAQ-TGK4hIt-_yRLpJXw7udwmJGCEnhLVdFoyBI-ps2xVCbmdVtVtXSf0CGl6oW7-yFKgBu5YNzl33jmQQ6Uz_34qRCPe6Q8o7p2KVhh1lFLJ_BRkAqwec4Xn-BCaCCe3yn50Xc2i2-fW68GiHBPnWO0IYmt1SwDPIFWfcTPWnWQaUkIQ5JtOvO_zP-ZSDWVWkCAwEAAaOCApAwggKMMIGTBgNVHSMEgYswgYiAFIHVOZnNIv6dxkaYS1CUdi7A5x4_oW2kazBpMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEbMBkGA1UEAwwSS2lzYSBUZXN0IFJvb3RDQSA3ggEOMB0GA1UdDgQWBBRlr42bZu93tKFnCf5y6aAp8qG0ejAOBgNVHQ8BAf8EBAMCBsAwfwYDVR0gAQH_BHUwczBxBgoqgxqMmkQFBAEBMGMwLQYIKwYBBQUHAgEWIWh0dHA6Ly9nY2EuY3Jvc3NjZXJ0LmNvbS9jcHMuaHRtbDAyBggrBgEFBQcCAjAmHiTHdAAgx3jJncEcspQAINFMwqTSuAAgx3jJncEcx4WyyLLkAC4wcQYDVR0RBGowaKBmBgkqgxqMmkQKAQGgWTBXDBJDQ-uniOydtOuNsOydtO2EsDMwQTA_BgoqgxqMmkQKAQEBMDEwCwYJYIZIAWUDBAIBoCIEIBkuYNZPzbuWr6d3aY-Di3dk4IrAGBBH9sH_cFBaOi_JMIGEBgNVHR8EfTB7MHmgd6B1hnNsZGFwOi8vdGVzdGRpci5jcm9zc2NlcnQuY29tOjM4OS9jbj1zMWRwMTJwMjU4MyxvdT1jcmxkcCxvdT1BY2NyZWRpdGVkQ0Esbz1Dcm9zc0NlcnQsYz1LUj9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0MEoGCCsGAQUFBwEBBD4wPDA6BggrBgEFBQcwAYYuaHR0cDovL3Rlc3RvY3NwLmNyb3NzY2VydC5jb206MTQyMDMvT0NTUFNlcnZlcjANBgkqhkiG9w0BAQsFAAOCAQEAWW-Z4OCWOgLTD5oKfvyyiZwfkllpC6adVFomWoygi2b78vm3uxprrdEagEXTA1GSnzqQcXGmNIbx4SQvFc6EZCW2DjJzmIESbFFIHSnDGj7ZJ0Q1BNSNciXN8lo0gVO-oTq70JBL3dtVJWOB0ZXhabBhviEclyghiUI-Iwc7DhuS4sxREnDTedyUukqowoe-cCkVI8w-cVRI0lohPzrv0CeB1HUTXgFYeQnsZdh9hu_B9IxXp7RIhc_7_gTlVS3mWPjWuT-AgwhULJ-1xLkyLy156XtxU_C_WgQVKNoBiAMdmNiOC4JwPia_S9bDQ3BNoHzvUhu-2oFJ-rPLzmnWtTGCAfEwggHtAgEBMFswUzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRkwFwYDVQQDDBBDcm9zc0NlcnRUZXN0Q0E1AgQBdlbRMA0GCWCGSAFlAwQCAQUAoGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjExMTIzMDIzNzM1WjAvBgkqhkiG9w0BCQQxIgQgnT76zPvB-9yYUMH8xfjOfh5QQxgH51fQ_rpRqPyZpPswDQYJKoZIhvcNAQEBBQAEggEAchVzfVcvXGRSctrllSVFwyD99iLZ2ZmzTFaCyoJqK_c2B--t86EFGaEkPcoEywz9aw0Gc9aj6B80VzkOrTHWWXhfOIw2whJI1oSGD2_duAVz_HiMJf--4_5wal613EdSJUS3lW2xamdijJTQ4Htz-WDB1KwptyL79S3FR_ZJVBFkxVVgjvaygxsCSbBt5fQGYPzVyqY_xxZcLZNJVdrNucLFFMzp0R3AJe4yz1_qQa8XyGSZjXQB9zCR4BX7qYLViSb3Kyv9EgBKWSEE7ycblLpnbUdiRErGt6bxGt6fLh3cImUuHm5bZOZo2RrnZNtGmCU9Ew_oYhAU7uQ82SoRAg",
        "signedConsent": "MIIJZQYJKoZIhvcNAQcCoIIJVjCCCVICAQExDzANBglghkgBZQMEAgEFADCCAVkGCSqGSIb3DQEHAaCCAUoEggFGeyJjb25zZW50Ijp7ImlzX3NjaGVkdWxlZCI6IjEiLCJyY3Zfb3JnX2NvZGUiOiIxIiwiaG9sZGluZ19wZXJpb2QiOiIyNDA4MDQxNTMwMzAiLCJ0YXJnZXRfaW5mbzEiOnsic2NvcGUiOiJiYW5rLmxpc3QiLCJhc3NldF9saXQiOnsiYXNzZXQiOiIxMTExLTExMTEtMTEifX0sInB1cnBvc2UiOiJ1ZDFiNXVkNTY5dWM4NzB1ZDY4YyIsInNuZF9vcmdfY29kZSI6IjEiLCJlbmRfZGF0ZSI6IjIyMDgwNDE1MzAzMCIsImN5Y2xlIjp7ImZuZF9jeWNsZSI6IjEvdyIsImFkZF9jeWNsZSI6IjEvZCJ9fSwiY29uc2VudE5vbmNlIjoid3l6VGlINlZhbkNUMUxGVXoxX3VfTzMtZTNrIn2gggXoMIIF5DCCBMygAwIBAgIEAXZW0TANBgkqhkiG9w0BAQsFADBTMQswCQYDVQQGEwJLUjESMBAGA1UECgwJQ3Jvc3NDZXJ0MRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExGTAXBgNVBAMMEENyb3NzQ2VydFRlc3RDQTUwHhcNMjEwOTI0MDEwMDAwWhcNMjIwOTI0MTQ1OTU5WjCBgDELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRUwEwYDVQQLDAzrk7HroZ3quLDqtIAxEjAQBgNVBAsMCe2FjOyKpO2KuDEbMBkGA1UEAwwSQ0Prp4jsnbTrjbDsnbTthLA0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA01dyh6QRaDbapSRzQrWu-oYMqCRROLutATKsAQg13KfNef1FIIJOgspsSTxKwY_sIcGDnmHVDnxGFuvhntc_MGnfbS8A6dgM7KcX8_MSN0CvLnu2_dFyfa1lmkhE_nY1odG6Fvl5TfYEV3K4PoATMBD5MYriEi37_JEuklfDu53CYkYISeEtV0WjIEj6mzbFUJuZ1W1W1dJ_QIaXqhbv7IUqAG7lg3OXfeOZBDpTP_fipEI97pDyjunYpWGHWUUsn8FGQCrB5zhef4EJoIJ7fKfnRdzaLb59brwaIcE-dY7Qhia3VLAM8gVZ9xM9adZBpSQhDkm0687_M_5lINZVaQIDAQABo4ICkDCCAowwgZMGA1UdIwSBizCBiIAUgdU5mc0i_p3GRphLUJR2LsDnHj-hbaRrMGkxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSVNBMS4wLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBDZW50cmFsMRswGQYDVQQDDBJLaXNhIFRlc3QgUm9vdENBIDeCAQ4wHQYDVR0OBBYEFGWvjZtm73e0oWcJ_nLpoCnyobR6MA4GA1UdDwEB_wQEAwIGwDB_BgNVHSABAf8EdTBzMHEGCiqDGoyaRAUEAQEwYzAtBggrBgEFBQcCARYhaHR0cDovL2djYS5jcm9zc2NlcnQuY29tL2Nwcy5odG1sMDIGCCsGAQUFBwICMCYeJMd0ACDHeMmdwRyylAAg0UzCpNK4ACDHeMmdwRzHhbLIsuQALjBxBgNVHREEajBooGYGCSqDGoyaRAoBAaBZMFcMEkND66eI7J20642w7J207YSwMzBBMD8GCiqDGoyaRAoBAQEwMTALBglghkgBZQMEAgGgIgQgGS5g1k_Nu5avp3dpj4OLd2TgisAYEEf2wf9wUFo6L8kwgYQGA1UdHwR9MHsweaB3oHWGc2xkYXA6Ly90ZXN0ZGlyLmNyb3NzY2VydC5jb206Mzg5L2NuPXMxZHAxMnAyNTgzLG91PWNybGRwLG91PUFjY3JlZGl0ZWRDQSxvPUNyb3NzQ2VydCxjPUtSP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3QwSgYIKwYBBQUHAQEEPjA8MDoGCCsGAQUFBzABhi5odHRwOi8vdGVzdG9jc3AuY3Jvc3NjZXJ0LmNvbToxNDIwMy9PQ1NQU2VydmVyMA0GCSqGSIb3DQEBCwUAA4IBAQBZb5ng4JY6AtMPmgp-_LKJnB-SWWkLpp1UWiZajKCLZvvy-be7Gmut0RqARdMDUZKfOpBxcaY0hvHhJC8VzoRkJbYOMnOYgRJsUUgdKcMaPtknRDUE1I1yJc3yWjSBU76hOrvQkEvd21UlY4HRleFpsGG-IRyXKCGJQj4jBzsOG5LizFEScNN53JS6SqjCh75wKRUjzD5xVEjSWiE_Ou_QJ4HUdRNeAVh5Cexl2H2G78H0jFentEiFz_v-BOVVLeZY-Na5P4CDCFQsn7XEuTIvLXnpe3FT8L9aBBUo2gGIAx2Y2I4LgnA-Jr9L1sNDcE2gfO9SG77agUn6s8vOada1MYIB8TCCAe0CAQEwWzBTMQswCQYDVQQGEwJLUjESMBAGA1UECgwJQ3Jvc3NDZXJ0MRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExGTAXBgNVBAMMEENyb3NzQ2VydFRlc3RDQTUCBAF2VtEwDQYJYIZIAWUDBAIBBQCgaTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTExMjMwMjM3MzVaMC8GCSqGSIb3DQEJBDEiBCA71CkX8mbmrufmQLJA1RSzJ-YkxV0K-NVLDaWUVMvSmDANBgkqhkiG9w0BAQEFAASCAQAb4hJq4UEcmMA6qINPLyKjeBjEpDUw5TtuC6b-4SXEVMnwMZPJfcZ904JSZH543xyHG1kJHZvaqMDb85hB1xaR-rMgjQFesZ894gDKKGzeCmVlAJimCUSYZWyNxXUWn_XgJVNPjkD6QuhHIsgg1Gh0kVv8m6Y5UFlvVjdpP1DtMJklTQj-W4iocPErCX3f1bdL5OC38VY0FdZs-ZgN8K_wi7P27zyjNc3ldY_tOFpzFF-nZ1uXrXwvCaBAIwEzb6fKIVZ8QVng_SMe6unD6AaNJmYpcMrpQcMIO-stpTC4RGTFpGCF4gnuy2uCMfHHU5B22LbdZAUJFutm-nHYqEUw"
    }
],
"caOrg": "CrossCert"
}</textarea></li><br/>
			<input type="button" value="전자서명" onclick="javascript:TEST_mydataAppSign();" />
		</ul>
	</form>
	<hr/>
	<form name="ucpidForm">
		<h4>2. 웹 테스트용(Web, WebView)</h4>
		<ul style="list-style-type:disc">
			<li>본인확인요청정보(웹 테스트용)</li>
			<li>이름:<input type="checkbox" name="realName" checked /></li>
			<li>성별:<input type="checkbox" name="gender" checked/></li>
			<li>국적:<input type="checkbox" name="nationalInfo" checked/></li>
			<li>생년월일:<input type="checkbox" name="birthDate" checked/></li>
			<li>CI:<input type="checkbox" name="ci" checked/></li>
			<li>개인정보 활용동의 약관내용<br/>
			<input type="text" name="agreement" value="개인정보 활용에 동의합니다." style="width: 320px; height: 30px;"/></li>
		</ul>
		<ul style="list-style-type:disc">
			<li>전송요구내역<br/>
<textarea id="consent" name="consent" rows="15" cols="55">
{
    "is_scheduled": "1",
    "rcv_org_code": "1",
    "holding_period": "240804153030",
    "target_info1": {
        "scope": "bank.list",
        "asset_lit": {
            "asset": "1111-1111-11"
        }
    },
    "purpose": "ud1b5ud569uc870ud68c",
    "snd_org_code": "1",
    "end_date": "220804153030",
    "cycle": {
        "fnd_cycle": "1/w",
        "add_cycle": "1/d"
    }
}
</textarea></li><br/>
			<!--			
			<input type="text" name="consent" value="출금계좌" style="width: 320px; height: 30px;"/></li><br/><br/>
			-->
			<input type="button" value="전자서명(G10)" onclick="javascript:Delfino.setModule('G10');TEST_mydataSign();" />
			<input type="button" value="전자서명(G4)" onclick="javascript:Delfino.setModule('G4');TEST_mydataSign();" />
		</ul>
	</form>
	<hr/>	
	
<script type="text/javascript">
//<![CDATA[

    //전자서명시 호출되는  CallBack 함수
    var __result = null;
    function TEST_complete(result){
        __result = result;

		if(result.status==1) {
			var delfinoArrayForm = document.getElementById("delfinoArrayForm");
			//document.getElementById("imsi").value = JSON.stringify(result);
			document.getElementById("caOrg").value = result.signData.caOrg;
        	
        	for(var i = 0; i < result.signData.signedDataList.length; i++) {
        		var signedDataList = document.createElement("input");
        		signedDataList.setAttribute("type", "hidden");
        		signedDataList.setAttribute("name", "signedDataList");
        		signedDataList.setAttribute("value", JSON.stringify(result.signData.signedDataList[i]));
            	delfinoArrayForm.appendChild(signedDataList);
        	}
			document.getElementById("_action").value = "TEST_mydataSign";
            document.delfinoArrayForm.submit();
        } else {
            if(result.status==0) return; //사용자취소
            if(result.status==-10301) return; //구동프로그램 설치를 위해 창을 닫을 경우
            if (Delfino.isPasswordError(result.status)) alert("비밀번호 오류 횟수 초과됨"); //v1.1.6,0 over & DelfinoConfig.passwordError = true
            alert("error:" + result.message + "[" + result.status + "]");
        }
    }
    
    function TEST_mydataSign(){
    	var userAgreeInfos = {};
    	var userAgreement = document.ucpidForm.agreement.value;
		var userConsent = document.ucpidForm.consent.value;

		userAgreeInfos['realName'] = document.ucpidForm.realName.checked ? true : false;
    	userAgreeInfos['gender'] = document.ucpidForm.gender.checked ? true : false;
    	userAgreeInfos['nationalInfo'] = document.ucpidForm.nationalInfo.checked ? true : false;
    	userAgreeInfos['birthDate'] = document.ucpidForm.birthDate.checked ? true : false;
    	userAgreeInfos['ci'] = document.ucpidForm.ci.checked ? true : false;

		userConsent = JSON.parse(userConsent);

		var signData = [{
    		orgCode: '000',
    		ucpidRequestInfo: {
    			userAgreement: userAgreement,
    			userAgreeInfo: userAgreeInfos,
    			ispUrlInfo: 'www.wizvera.com',
    			ucpidNonce: 'HBtfsJz8ooZRWyw_mmwJXw'
    		},
    		consentInfo: {
    			consent: userConsent,
    			consentNonce: 'HBtfsJz8ooZRWyw_mmwJXw'
    		}
    	}];
    	
        var myDataSignOptions = {};
    	myDataSignOptions.policyOidCertFilter = DelfinoConfig.policyOidCertFilterForMyData; //마이데이타용 OID필터적용
    	myDataSignOptions.certStoreFilter = "BROWSER|FIND_CERT|LOCAL_DISK"; //설치모듈 G3사용불가로 인하여 테스트 오류 방지
    	Delfino.multiSignForMyData(signData, myDataSignOptions, TEST_complete);
    }

    function TEST_mydataAppSign(){
		var signData = document.ucpidAppForm.signdata.value;
		if(signData != "") {
			var signDataObj = JSON.parse(signData);
			var delfinoArrayForm = document.getElementById("delfinoArrayForm");
			document.getElementById("caOrg").value = signDataObj.caOrg;
        	
        	for(var i = 0; i < signDataObj.signedDataList.length; i++) {
        		var signedDataList = document.createElement("input");
        		signedDataList.setAttribute("type", "hidden");
        		signedDataList.setAttribute("name", "signedDataList");
        		signedDataList.setAttribute("value", JSON.stringify(signDataObj.signedDataList[i]));
            	delfinoArrayForm.appendChild(signedDataList);
        	}
			document.getElementById("_action").value = "TEST_mydataSign";
            document.delfinoArrayForm.submit();
        } else {
            alert("error: signdata is null");
        }
    }
  //]]>
</script>

</body>
</html>
