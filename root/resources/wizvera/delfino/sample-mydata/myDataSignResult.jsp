
<%-- --------------------------------------------------------------------------
 - File Name   : myDataSignResult.jsp(마이데이터 전자서명 검증 샘플)
 - Include     : NONE
 - Author      : WIZVERA
 - Last Update : 2021/05/04
-------------------------------------------------------------------------- --%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.*, java.lang.*, java.text.*, java.net.*" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="java.security.cert.X509Certificate" %>

<%@ page import="com.wizvera.WizveraConfig" %>
<%@ page import="com.wizvera.util.Base64Url" %>

<%@ page import="com.wizvera.service.mydata.*"%>
<%@ page import="com.wizvera.service.mydata.SignedMyData"%>
<%@ page import="com.wizvera.service.mydata.MyDataAuthService"%>
<%@ page import="com.wizvera.service.mydata.MyDataVerifyResult"%>
<%@ page import="com.wizvera.service.mydata.MyDataAuthException"%>
<%@ page import="com.wizvera.crypto.ucpid.response.PersonInfo" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<meta http-equiv="Expires" content="-1" />
		<meta http-equiv="Progma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta name='viewport' content='initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, width=device-width' />
		<title>서명 test</title>
		<%@ include file="../svc/delfino.jsp" %>		
    </head>

<body>
<%
	request.setCharacterEncoding("utf8");

	String _action = request.getParameter("_action");	
	String caOrg = request.getParameter("caOrg"); 	// 인증기관코드
	String orgCode = "";									// 정보제공자코드
	String signedPersonInfoReq = "";					// 본인확인 전자서명값(UCPID)
	String signedConsent = "";							// 전송요구 전자서명값

	// 마이데이터 서버에서 전송된 전자서명값 저장할 배열
	ArrayList<String> signedDataLists = new ArrayList<String>();	

	// 1) 전자서명값이 String 형태로 전송되는 경우(Android 샘플)
	if("TEST_mydataSignString".equals(_action)) {	// 
		String signedData_string = request.getParameter("signedDataList");
		// System.out.println("[signedData_string] : " + signedData_string);

		// String -> 배열에 저장
		JSONArray jsonArr = new JSONArray(signedData_string);
		if (jsonArr != null) {
		   for (int k=0; k<jsonArr.length(); k++) {
				JSONObject obj = jsonArr.getJSONObject(k);
				signedDataLists.add(obj.toString());
			}
		} else {
			System.out.println("* jsonArr is null");
		} 

	// 2) 전자서명값이 배열 형태로 전송되는 경우(iOS, G10 샘플)
	} else {
		String [] signedDataList_array = request.getParameterValues("signedDataList");
		signedDataLists = new ArrayList<String>(Arrays.asList(signedDataList_array));
	}
	
	out.println("<br/><b>- 인증기관코드(caOrg) : </b>" + caOrg + "<br/>");
	out.println("<b>- 전자서명값 배열 사이즈 (signedDataList) : </b>" + signedDataLists.size() + "<br/><br/>");
	System.out.println("- 인증기관코드(caOrg) : " + caOrg);
	System.out.println("- 전자서명값 배열 사이즈 (signedDataList) : " + signedDataLists.size());
	System.out.println("");
		
	// 다건 전자서명값 추출 및 검증 수행
	for (int i=0; i<signedDataLists.size(); i++) {
		int j = i+1; // 로그용
		
		// 1건에 대한 signedDataList
		JSONObject jsonSignedDataList = new JSONObject(signedDataLists.get(i));	
		orgCode = jsonSignedDataList.getString("orgCode");						  // 정보제공자 코드
		signedConsent = jsonSignedDataList.getString("signedConsent");			  // 전송요구내역 전자서명값
		//signedConsent = "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";
		signedPersonInfoReq = jsonSignedDataList.getString("signedPersonInfoReq");// 본인확인약관 전자서명값(UCPID)
		//signedPersonInfoReq = "MIIIgQYJKoZIhvcNAQcCoIIIcjCCCG4CAQExDTALBglghkgBZQMEAgEwgZYGCSqGSIb3DQEHAaCBiASBhTCBggIBAgQId3l6VGlINlYwLQwn6rCc7J247KCV67O0IO2ZnOyaqeyXkCDrj5nsnZjtlanri4jri6QuAwID+DAyDA9EU19VQ1BJRF9DbGllbnQMDURyZWFtc2VjdXJpdHkwEAIBAgIBAaADAgEAoQMCAQAMEHd3dy5teWRhdGEub3Iua3KgggXJMIIFxTCCBK2gAwIBAgIDR1U1MA0GCSqGSIb3DQEBCwUAMFcxCzAJBgNVBAYTAmtyMRAwDgYDVQQKDAd5ZXNzaWduMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExHzAdBgNVBAMMFnllc3NpZ25DQS1UZXN0IENsYXNzIDQwHhcNMjEwNjI0MTUwMDAwWhcNMjEwODE4MTQ1OTU5WjBqMQswCQYDVQQGEwJrcjEQMA4GA1UECgwHeWVzc2lnbjEUMBIGA1UECwwLcGVyc29uYWw0SUIxDDAKBgNVBAsMA0tNQjElMCMGA1UEAwwc66y464uk66CIKCkwMDA0MDQ0SDAwMDAzMTU4MjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMDAWKbojfTKY/eyP/IzP8UnuztVheE1zThBbGJOQKj9LiKuEaxjqAJboO+iVxyOtvObRpv1EdFgyR0Nb7va5FS8XOnb6Yt47QRqFUAxCYXpQO4BJ9yrQrQewaEd9ikQs0bHgSz98r2wv1K44YzgldtIPDxr/bGp/Gp9ySvU8zfiPwjm0rJIh/mqRLBsGkbqsppayQQObgHMsXpnGXPChpA1UC5duLMRSOIy8KU9BIgr3SH1ZNd8QOsuNt6bJnlvRDqPW9QTI/Ztt7W18KbTXhs4T/e/3p892Bvk4PkT5UQJLJNtQIqbP4eMEEVdcDUJ3H86UR9bAs8dKoc38zBHYd0CAwEAAaOCAoUwggKBMIGTBgNVHSMEgYswgYiAFGY17Oj9/tu4KmKpArHm3Idc3PnDoW2kazBpMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEbMBkGA1UEAwwSS2lzYSBUZXN0IFJvb3RDQSA3ggECMB0GA1UdDgQWBBTT/HJEy81QjSNx8x8qWksVN3lpkDAOBgNVHQ8BAf8EBAMCBsAwgZkGA1UdIAEB/wSBjjCBizCBiAYJKoMajJpFAQEEMHswSAYIKwYBBQUHAgIwPB46x3QAIMd4yZ3BHLKUACCuCMc1rLDIHMbQxdDBHAAgvByuCdVcACDC3NXYxqkAIMd4yZ3BHMeFssiy5DAvBggrBgEFBQcCARYjaHR0cDovL3Nub29weS55ZXNzaWduLm9yLmtyL2Nwcy5odG0waAYDVR0RBGEwX6BdBgkqgxqMmkQKAQGgUDBODAnrrLjri6TroIgwQTA/BgoqgxqMmkQKAQEBMDEwCwYJYIZIAWUDBAIBoCIEIP1q3MTG6ihR+2ALKxYLz/3C7374sIJc7OndUYurUj+0MHYGA1UdHwRvMG0wa6BpoGeGZWxkYXA6Ly9zbm9vcHkueWVzc2lnbi5vci5rcjo2MDIwL291PWRwMThwNTgzLG91PUFjY3JlZGl0ZWRDQSxvPXllc3NpZ24sYz1rcj9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0MDwGCCsGAQUFBwEBBDAwLjAsBggrBgEFBQcwAYYgaHR0cDovL3Nub29weS55ZXNzaWduLm9yLmtyOjQ2MTIwDQYJKoZIhvcNAQELBQADggEBAEUwbIpxUtGtoT3rmw9n+QHcEl3MQwjrKTMNB3ZVJ5Rf3z6is/jHN0laig3hAPP3Td6F9BI84Xg0hrDB0o8FTrdwvjVnIsph4iq3/cQjnVsT3L7wG0KL79RdHSMwHRDuXAAtEMJYxEKuLr+JV9lT4K1hXmSbEyi/ct7SdFaFL9+qih6LahykWQx8ovWFdxhKEji8/T+WZfoFEDEoBdelOPYbdTnpBbtcHlA+5zs4XHvg0CnqIIuMQVWiflPgmmBmCjrWwjFDDwabw3rNOFTPgCG4ITmFSplOzAUgSDuCmwQwjRdJzgTEppZ9rHpDthAprxOKuoyuZYTsrdw16xyUC6wxggHyMIIB7gIBATBeMFcxCzAJBgNVBAYTAmtyMRAwDgYDVQQKDAd5ZXNzaWduMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExHzAdBgNVBAMMFnllc3NpZ25DQS1UZXN0IENsYXNzIDQCA0dVNTALBglghkgBZQMEAgGgaTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yMTA3MDEwMDQxMTZaMC8GCSqGSIb3DQEJBDEiBCBL+4oGAcq3IgymNMGFz1rshEZQJjVmoZnESZL1nwkDJzANBgkqhkiG9w0BAQsFAASCAQAJfU7LMrhNLvihMjU6IVzhL3DCGbdts4zxzhrglroIpiwSgSGzf/k21jVTqBV5pJohA8umNZRD53QHANeu2PPOy+LfjpOgFaRzPs151NEeEj5QoJv5rj4Z2Fitxi5roJpJEAIDZ9jnuHNxS4IYD4ceW+gtJItloLGoTmmEy+s9lGOM4Y+E8FMWClfAOoDvQnz1dOW+JWkgLATVMVaxDqkmSvvHOqb6PjCRBbWEWU6DvaCFrdIaMQL//lDW19HU6nt4udN2+k53BpCNfzGD1ocWzU8bDUEzaOJr9pMLMpX8AL/72xQe7o4L167I3BIehU07StvGGZw4Hp2CDufs7sth";
		//caOrg = "yessign";
		String consentNonce = "HBtfsJz8ooZRWyw_mmwJXw";
		String ucpidNonce = "HBtfsJz8ooZRWyw_mmwJXw";
		//String consentNonce = "wyzTiH6V";
		//String ucpidNonce = "wyzTiH6V";
		
		//String nonce = Base64.getEncoder().withoutPadding().encodeToString("1234567890123456".getBytes());
		//String nonce = Base64.getUrlEncoder().withoutPadding().encodeToString("1234567890123456".getBytes());
				
		out.println("<hr style='height:2px;background-color:#000000;'>");
		out.println("<b><h3> ##### " + j + "-1. 정보제공자 코드 (orgCode) : " + orgCode + "<br/> ##### " + j + "-2. 전자서명값  (signedDataList) : </h3></b>" + jsonSignedDataList +  "<br/> ");

		System.out.println("--------------------------------------------------------------------------------------");
		System.out.println("[" + j + "] 정보제공자 코드 (orgCode) : " + orgCode);
		System.out.println("[" + j + "] 전자서명값  (signedDataList) : " + jsonSignedDataList);
		System.out.println("");

		/**************************************************************
        * 1. signedMyData : - 마이데이터 전자서명 검증을 위한 데이터 저장 클래스 
	        - signedConsent		  : 전송요구내역 전자서명값
	        - signedPersonInfoReq : 본인확인약관 전자서명값
	        - consentNonce		  : 전송요구내역 서명nonce 
	        - ucpidNonce		  : 본인확인약관 서명nonce
        ***************************************************************/
		SignedMyData signedMyData = new SignedMyData(); // 검증데이터 객체 생성
		signedMyData.setSignedConsent(signedConsent);				// 전송요구내역 전자서명값
		signedMyData.setSignedPersonInfoReq(signedPersonInfoReq);	// 본인확인약관 전자서명값
		signedMyData.setConsentNonce(consentNonce); 				// 전송요구내역 서명nonce 
		signedMyData.setUcpidNonce(ucpidNonce); 				// 본인확인약관 서명nonce

		// Delfino라이브러리와 properties 경로가 다른 경우
		//WizveraConfig delfinoConfig = new WizveraConfig(getServletConfig().getServletContext().getRealPath("WEB-INF") + "/lib/delfino.properties");

		try {
			/**************************************************************
	        * 2. MyDataAuthService : 마이데이터 전자서명 및 UCPID 검증 클래스 ( 1),2) 통합)
	        	1) MyDataAuthService.verifySignedData: 마이데이터 전자서명 검증  
	        		- (변경전) MyDataVerifier.verify
	        	2) MyDataAuthService.getUCPIDPersonInfo: UCPID 검증 (인증기관통신)  
	        		- (변경전) UCPIDManager.getPersonInfo
	        ***************************************************************/
            MyDataAuthService myAuthService = new MyDataAuthService(); //기본설정값 사용
			//MyDataAuthService myAuthService = new MyDataAuthService(delfinoConfig); // 설정파일경로 지정
			
			/**************************************************************
			* 2-1. MyAuthService.verifySignedData: 마이데이터 전자서명 검증
	        	- 본인확인약관 및 전송요구내역 전자서명 검증 :ucpidNonce 검증 + consentNonce 검증 + 인증서동일유무 검증 포함
	        	- 전자서명시간 검증 허용범위 시간(ms) : 10분 내외 설정필요 (ex. 10분 : 10*60*1000L)
	        ***************************************************************/
            long now_before = System.currentTimeMillis() - (10*60*1000L*60*24*365);	// 검증시간 10분 전
			long now_after = System.currentTimeMillis() + (10*60*1000L);	// 검증시간 10분 후

			// 마이데이터 전자서명 검증 및 결과 저장
			MyDataVerifyResult myDataVerifyResult = myAuthService.verifySignedData(signedMyData, now_before, now_after);			
			
			out.println("<br/>");
			out.println("<h3> ##### " + j + "-3. 마이데이터 전자서명 검증 (myAuthService.verifySignedData) 결과 </h3>");
			
			// (전자서명 검증된) 전송요구내역 정보 저장
			ConsentInfo _getConsentInfo = myDataVerifyResult.getConsentInfo();
			// (전자서명 검증된) 본인확인약관  정보 저장
			PersonInfoReqInfo _getPersonInfoReqInfo = myDataVerifyResult.getPersonInfoReqInfo();	

			out.println("<br/><b>[전송요구내역 정보 : getConsentInfo]</b>");
			out.println("<br/>- getConsent: " + _getConsentInfo.getConsent());	// 전송요구내역
			out.println("<br/>- getConsentNonce: " + _getConsentInfo.getConsentNonce());  // 전송요구내역 서명nonce 
			out.println("<br/>- getSubjectDN: " + _getConsentInfo.getSignerCertificate().getSubjectDN());	// 사용자인증서 DN(이름)
			out.println("<br/><br/><b>[본인확인약관  정보 : getPersonInfoReqInfo]</b>");
			out.println("<br/>- getUserAgreement: " + _getPersonInfoReqInfo.getUserAgreement());	// 본인확인약관
			out.println("<br/>- getUcpidNonce: " + _getPersonInfoReqInfo.getUcpidNonce());	// 본인확인약관 서명nonce 
			out.println("<br/>- getSubjectDN: " + _getPersonInfoReqInfo.getSignerCertificate().getSubjectDN()); // 사용자인증서 DN(이름)
			out.println("<br/>- getIspUrlInfo: " + _getPersonInfoReqInfo.getIspUrlInfo()); // 마이데이타 서비스 도메인
			out.println("<br/><br/><b>[전자서명 모듈정보 : getModuleInfo]</b>");	// 전자서명 모듈정보
			out.println("<br/>- getModuleName: " + _getPersonInfoReqInfo.getModuleName());	// 전자서명 모듈명
			out.println("<br/>- getModuleVendorName: " + _getPersonInfoReqInfo.getModuleVendorName());	// 전자서명 모듈 제공업체
			out.println("<br/>- getModuleVersionMajor: " + _getPersonInfoReqInfo.getModuleVersionMajor());	// 전자서명 모듈 버전(Major)
			out.println("<br/>- getModuleVersionMinor: " + _getPersonInfoReqInfo.getModuleVersionMinor());	// 전자서명 모듈 버전(Minor)
			out.println("<br/>- getModuleVersionBuild: " + _getPersonInfoReqInfo.getModuleVersionBuild());		// 전자서명 빌드 버전
			out.println("<br/>- getModuleVersionRevision: " + _getPersonInfoReqInfo.getModuleVersionRevision());	// 전자서명 개정 버전
			out.println("<br/>");
			System.out.println("[전송요구내역 정보 : getConsentInfo]");
			System.out.println("- getConsent: " + _getConsentInfo.getConsent());
			System.out.println("- getConsentNonce: " + _getConsentInfo.getConsentNonce());
			System.out.println("- getSubjectDN: " + _getConsentInfo.getSignerCertificate().getSubjectDN());
			System.out.println("[본인확인약관  정보 : getPersonInfoReqInfo]");
			System.out.println("- getUserAgreement: " + _getPersonInfoReqInfo.getUserAgreement());
			System.out.println("- getUcpidNonce: " + _getPersonInfoReqInfo.getUcpidNonce());
			System.out.println("- getSubjectDN: " + _getPersonInfoReqInfo.getSignerCertificate().getSubjectDN());
			System.out.println("- getIspUrlInfo: " + _getPersonInfoReqInfo.getIspUrlInfo());
			System.out.println("[전자서명 모듈정보 : getModuleInfo]");
			System.out.println("- getModuleName: " + _getPersonInfoReqInfo.getModuleName());
			System.out.println("- getModuleVendorName: " + _getPersonInfoReqInfo.getModuleVendorName());
			System.out.println("- getModuleVersionMajor: " + _getPersonInfoReqInfo.getModuleVersionMajor());
			System.out.println("- getModuleVersionMinor: " + _getPersonInfoReqInfo.getModuleVersionMinor());
			System.out.println("- getModuleVersionBuild: " + _getPersonInfoReqInfo.getModuleVersionBuild());
			System.out.println("- getModuleVersionRevision: " + _getPersonInfoReqInfo.getModuleVersionRevision());
			System.out.println("");
			//out.println("[인증서 : getSignerCertificate]" +_getPersonInfoReqInfo.getSignerCertificate().getEncoded().toString());

			/**************************************************************
			* 2-2. MyAuthService.getUCPIDPersonInfo : UCPID 검증결과 저장 클래스
		      	- 인증기관과 UCPID(본인인증)통신 후 CI 추출
		      	- 인증기관코드 : yessign(금결원), SignKorea(코스콤), KICA(정보인증), CrossCert(전자인증)
		       	- 본인확인약관 전자서명값 : signedMyData.getSignedPersonInfoReq();
		       	- cpRequestNumber : 트랜잭션ID(tx_id)
		   	***************************************************************/
			
			String caCode = caOrg;	//인증기관코드 : 전자서명에 사용한 인증서의 인증기관
			String cpRequestNumber = "MD_O100000001_A100000001_0000000000_Q100000001_20210805011015_000000000001"; //트랜잭션ID(tx_id)
			//String cpRequestNumber = "0123456789";
			
			// UCPID 검증 및 결과 저장
			PersonInfo _getUcpidPersonInfo = myAuthService.getUCPIDPersonInfo(caCode, signedMyData.getSignedPersonInfoReq(), cpRequestNumber);
			
			// ciUpdate가 null or 홀수인 경우 : getCi() 사용 
			// ciUpdate가 짝수인 경우 : getCi2() 사용 
			out.println("<br/>");
			out.println("<h3> ##### " + j + "-4. UCPID 검증 (myAuthService.getUCPIDPersonInfo) 결과 </h3>");
			out.println("<br/><b>[본인확인약관  정보 : ucpidPersonInfo]</b>");
			out.println("<br/>- getRealName: " + _getUcpidPersonInfo.getRealName());	// 이용자의 실명정보
			out.println("<br/>- getCi: " + _getUcpidPersonInfo.getCi());						// 이용자의 CI
			out.println("<br/>- getCiupdate: " + _getUcpidPersonInfo.getCiupdate());		// CI가 변경된 경우 최종 업데이트 날짜 
			out.println("<br/>- getCi2: " + _getUcpidPersonInfo.getCi2()); 					// CI가 변경된 경우 최종 CI 
			out.println("<br/><br/><br/>");
			
			System.out.println("[ucpidPersonInfo]");
			System.out.println("- getRealName: " + _getUcpidPersonInfo.getRealName());
			System.out.println("- getCi: " + _getUcpidPersonInfo.getCi());				
			System.out.println("- getCiupdate: " + _getUcpidPersonInfo.getCiupdate());	 
			System.out.println("- getCi2: " + _getUcpidPersonInfo.getCi2());
			System.out.println("");

		// 에러처리 (상세 에러코드는 에러코드정의서 참고)
		} catch (MyDataAuthException e) {
			java.io.StringWriter sw = new java.io.StringWriter();
			java.io.PrintWriter pw = new java.io.PrintWriter(sw);
			e.printStackTrace(pw);
			
			out.println("<br/><h3> ##### " + j + "-error. MyDataAuthException - ERR(?)</h3>");
			out.println("<br/><b>- ErrorCode: </b>" + e.getErrorCode());
			out.println("<br/><b>- ErrorMsg: </b>" + e.getMessage());
			out.println("<br/><b>- DelfinoErrorCode: </b>" +  e.getDelfinoErrorCode());
			out.println("<br><br><b>- printStackTrace</b><br>");
			out.println(sw.toString());
			out.println("</br></br></br></br>");

			System.out.println("MyDataAuthException - ERR(?)");
			System.out.println("ErrorCode: " + e.getErrorCode());
			System.out.println("ErrorMsg: " + e.getMessage());
			System.out.println("DelfinoErrorCode: " +  e.getDelfinoErrorCode());
			System.out.println("printStackTrace");
			System.out.println(sw.toString());
			
			//errorCode "MIA_???" 에러처리
			//UCPID request/response 처리중 규격에 정의되지 않는 에러발생
			if(e.getErrorCode().startsWith("MIA_")){
				System.out.println("MIA_ErrorCode:" + e.getErrorCode());
				System.out.println("MIA_ErrorMessage:" + e.getMessage());
				System.out.println("MIA_DelfinoErrorCode:" + e.getDelfinoErrorCode());
			}
			
		} catch(Exception e) {
			java.io.StringWriter sw = new java.io.StringWriter();
			java.io.PrintWriter pw = new java.io.PrintWriter(sw);
			e.printStackTrace(pw);
			
			out.println("<br/><h3> ##### " + j + "-error. Exception - ERR(?)</h3>");
			out.println(sw.toString());
			out.println("</br></br></br></br>");
			
			System.out.println("Exception - ERR(?)");
			System.out.println("printStackTrace");
			System.out.println(sw.toString());
		}
	}
	
%>
</body>
</html>