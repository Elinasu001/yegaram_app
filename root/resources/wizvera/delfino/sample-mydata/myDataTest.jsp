<%-- --------------------------------------------------------------------------
 - File Name   : myDataTest.jsp(마이데이터 전자서명 검증 샘플)
 - Include     : NONE
 - Author      : WIZVERA
 - Last Update : 2021/11/25
-------------------------------------------------------------------------- --%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.*, java.lang.*, java.text.*, java.net.*" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="java.security.cert.X509Certificate" %>

<%@ page import="com.wizvera.WizveraConfig" %>
<%@ page import="com.wizvera.crypto.CertUtil" %>
<%@ page import="com.wizvera.crypto.ucpid.UCPIDManager" %>
<%@ page import="com.wizvera.crypto.ucpid.UCPIDResponseResult"%>
<%@ page import="com.wizvera.crypto.ucpid.UCPIDException"%>

<%@ page import="com.wizvera.service.mydata.SignedMyData"%>
<%@ page import="com.wizvera.service.mydata.MyDataAuthService"%>
<%@ page import="com.wizvera.service.mydata.MyDataVerifyResult"%>
<%@ page import="com.wizvera.service.mydata.MyDataAuthException"%>
<%@ page import="com.wizvera.crypto.ucpid.response.PersonInfo" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <meta http-equiv="Expires" content="-1" />
    <meta http-equiv="Progma" content="no-cache" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta name="viewport" content="initial-scale=1.0, width=device-width" />
    <title>::: UCPID TEST :::</title>
</head>
<body>

<%
    request.setCharacterEncoding("utf8");

    ArrayList<String> TEST_name = new ArrayList<String>();
    ArrayList<String> TEST_caOrg = new ArrayList<String>();
    ArrayList<String> TEST_consentNonce = new ArrayList<String>();
    ArrayList<String> TEST_ucpIdNonce = new ArrayList<String>();
    ArrayList<String> TEST_signedConsent = new ArrayList<String>();
    ArrayList<String> TEST_signedPersonInfoReq = new ArrayList<String>();

    boolean test_SignKorea = false;
    boolean test_KICA = false;
    boolean test_yessign = false;
    boolean test_CrossCert = false;

    //TODO: 내부테스트시 코스콤의경우 txId는 고정된 아래 txId를 사용해야 UCPID_001(ucpid_badRequest) 발생하지 않음
    //orgcode = TESTCP0000, cpcode = C0123456789A
    String cpRequestNumber = "MD_0000000000_TESTCP0000_0000000000_ZXAACP0000_20211110172348_000000000143";
    //String cpRequestNumber = "MD_O100000001_A100000001_0000000000_Q100000001_20210805011015_000000000001"; //트랜잭션ID(tx_id)

    if ("testUCPID".equals(request.getParameter("_action"))) {
        cpRequestNumber = request.getParameter("cpRequestNumber");
        TEST_name.add("테스트");
        TEST_caOrg.add(request.getParameter("caOrg"));
        TEST_consentNonce.add(request.getParameter("consentNonce"));
        TEST_ucpIdNonce.add(request.getParameter("ucpIdNonce"));
        TEST_signedConsent.add(request.getParameter("signedConsent"));
        TEST_signedPersonInfoReq.add(request.getParameter("signedPersonInfoReq"));
    }

    if ("SignKorea".equals(request.getParameter("caOrg"))) {
        test_SignKorea = true;
    } else if ("KICA".equals(request.getParameter("caOrg"))) {
        test_KICA = true;
    } else if ("yessign".equals(request.getParameter("caOrg"))) {
        test_yessign = true;
    } else if ("CrossCert".equals(request.getParameter("caOrg"))) {
        test_CrossCert = true;
    } else {
        test_SignKorea = true;
        test_KICA = true;
        test_yessign = true;
        test_CrossCert = true;
    }

    if (test_SignKorea) {
        TEST_name.add("G10");
        TEST_caOrg.add("SignKorea"); //코스콤
        TEST_consentNonce.add("5zQVNsZKl4webMSN5IJoyA");
        TEST_ucpIdNonce.add("jzaShLTN5vMT7dv-ZtZ84w");
        TEST_signedConsent.add("MIIJ7gYJKoZIhvcNAQcCoIIJ3zCCCdsCAQExDzANBglghkgBZQMEAgEFADCCAhEGCSqGSIb3DQEHAaCCAgIEggH-eyJjb25zZW50Ijoie1xuICAgIFwiaXNfc2NoZWR1bGVkXCI6IFwiMVwiLFxuICAgIFwicmN2X29yZ19jb2RlXCI6IFwiMVwiLFxuICAgIFwiaG9sZGluZ19wZXJpb2RcIjogXCIyNDA4MDQxNTMwMzBcIixcbiAgICBcInRhcmdldF9pbmZvMVwiOiB7XG4gICAgICAgIFwic2NvcGVcIjogXCJiYW5rLmxpc3RcIixcbiAgICAgICAgXCJhc3NldF9saXRcIjoge1xuICAgICAgICAgICAgXCJhc3NldFwiOiBcIjExMTEtMTExMS0xMVwiXG4gICAgICAgIH1cbiAgICB9LFxuICAgIFwicHVycG9zZVwiOiBcInVkMWI1dWQ1Njl1Yzg3MHVkNjhjXCIsXG4gICAgXCJzbmRfb3JnX2NvZGVcIjogXCIxXCIsXG4gICAgXCJlbmRfZGF0ZVwiOiBcIjIyMDgwNDE1MzAzMFwiLFxuICAgIFwiY3ljbGVcIjoge1xuICAgICAgICBcImZuZF9jeWNsZVwiOiBcIjEvd1wiLFxuICAgICAgICBcImFkZF9jeWNsZVwiOiBcIjEvZFwiXG4gICAgfVxufVxuIiwiY29uc2VudE5vbmNlIjoiNXpRVk5zWktsNHdlYk1TTjVJSm95QSJ9oIIFuDCCBbQwggScoAMCAQICAwhcqTANBgkqhkiG9w0BAQsFADBVMQswCQYDVQQGEwJLUjESMBAGA1UECgwJU2lnbktvcmVhMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExGzAZBgNVBAMMElNpZ25Lb3JlYSBUZXN0IENBNTAeFw0yMTA2MDEwMDQ0MDBaFw0yMjA2MDExNDU5NTlaMIGPMQswCQYDVQQGEwJLUjESMBAGA1UECgwJU2lnbktvcmVhMRgwFgYDVQQLDA_thYzsiqTtirjsl4XsooUxGDAWBgNVBAsMD-2FjOyKpO2KuO2ajOyCrDEYMBYGA1UECwwP7YWM7Iqk7Yq47KeA7KCQMR4wHAYDVQQDDBVTaWduS29yZWFfTXlEYXRhX1VzZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCqdw16ltCD_Pa-cE0i5-M4sfcCEGJcfMN1hwRZlD-O-f0e4I_X6QAUaRoXdH-YS8paEjC1jp1cEdsUFureeeqv2x3dTo2o3gBfdHHVFZX7kdU7Xw5AefvUL08CSrBO8aGAHGcKMMX-0P-ZSp5Dj6K2V-fRSK_hiKJW950PyTISDnGuVWDd7z7x_Tc6J-r7x__ZwJIsiwP8s-5zRJWgxbPgN1GfSuCU8eHbbGABv9piFK_TWX1JH1vs92CENaG-rTw695bMhw2E91MUmLGtbyl8lJIR1tzoTsPj55ND08YvyK1YlLwKv00GPQM0fS1TjPvdjRvIaSig-WDqwA5-MDTFAgMBAAGjggJQMIICTDCBkwYDVR0jBIGLMIGIgBTxcKmvb8-di6yBhcwW9HzZhVwMxKFtpGswaTELMAkGA1UEBhMCS1IxDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IENlbnRyYWwxGzAZBgNVBAMMEktpc2EgVGVzdCBSb290Q0EgN4IBBTAdBgNVHQ4EFgQUeiIHaLHTyp0H_w-wM83GeehB-kIwDgYDVR0PAQH_BAQDAgbAMHsGA1UdIAEB_wRxMG8wbQYKKoMajJpEBQEBBTBfMC0GCCsGAQUFBwIBFiFodHRwOi8vd3d3LnNpZ25rb3JlYS5jb20vY3BzLmh0bWwwLgYIKwYBBQUHAgIwIh4gx3QAIMd4yZ3BHAAgwtzV2MapACDHeMmdwRzHhbLIsuQwdAYDVR0RBG0wa6BpBgkqgxqMmkQKAQGgXDBaDBVTaWduS29yZWFfTXlEYXRhX1VzZXIwQTA_BgoqgxqMmkQKAQEBMDEwCwYJYIZIAWUDBAIBoCIEINNlU1wkg0LVTsPBXQlxGFYiD6ntFIv3O_PMWz1bSvv0MFYGA1UdHwRPME0wS6BJoEeGRWxkYXA6Ly8yMTEuMTc1LjgxLjEwMjo2ODkvb3U9ZHAxMXAxMixvdT1BY2NyZWRpdGVkQ0Esbz1TaWduS29yZWEsYz1LUjA6BggrBgEFBQcBAQQuMCwwKgYIKwYBBQUHMAGGHmh0dHA6Ly8yMTEuMTc1LjgxLjEwMS9vY3NwLnBocDANBgkqhkiG9w0BAQsFAAOCAQEAihGQLjAnzhu_cUUvVGh5rqjo4P068-9pdZM_4w1552A6oCrw7sSTK1L9sHDLgfd_RCykx02zsuny3cEy-QyATCHQryqxXVT9sldN2JzqcZKY9I7x6rFa6-TAcORmVFslNrZsqeTMQWasLsc9s0BicnKYZnq1O7l54EP84egZYIzZmpiWK4kBfX5RyJBhxLwsZrHnd8t8WbrNeu46XGRcdpTqwzscu5-EvlbTkiLHaV_Nxa_AgpVmnZL5JsmSviiBScG68ErPSVMxdiNimw1fNiHIqPt_Z1AZQ2RB4PCGNVZbZRIExJa8p8GBV3h3ustrJcQZlJL8V9Co_XrEBIIXbjGCAfIwggHuAgEBMFwwVTELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCVNpZ25Lb3JlYTEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRswGQYDVQQDDBJTaWduS29yZWEgVGVzdCBDQTUCAwhcqTANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMTEyNDA1Mjk0NVowLwYJKoZIhvcNAQkEMSIEIFk-YZXmoHg7-sX8PxmRpqZ0IpQo5wXDkP_abK0sCJNRMA0GCSqGSIb3DQEBAQUABIIBAGdKfP4Z37Wz4ajjso1FupVkgrhuArdqSDNdw66-BlWjfex0L2TTmvXMHsG0vzdRvpM6TYA1u2so9p1OYnbVmpaGbv96OX11fler2-uWZGPs07z6PpTnj_mpf54f0cZ9qmJVSSinX-hz7HZ-MuE62R3PuDUDwmKPu-GT2lnCzdDOsrcP0a8ePbbCK5rt5lZ5_3mBT1jqTSILDMNCZszNnZnyJFOgvM1vB-dIuoSbGKmdqUfiovFeEHkm4vliaeFaZq6TRW0cFgkO43N0WPT7OZRvILGryyBCArScf3AuL1OM51rzgkG3c6smQ2BgNVSUgLMkW0M3fMlSZgJ1pzotsT4");
        TEST_signedPersonInfoReq.add("MIIIaAYJKoZIhvcNAQcCoIIIWTCCCFUCAQExDzANBglghkgBZQMEAgEFADCBjAYJKoZIhvcNAQcBoH8EfTB7AgECBBCPNpKEtM3m8xPt2_5m1nzjMC0MJ-qwnOyduOygleuztCDtmZzsmqnsl5Ag64-Z7J2Y7ZWp64uI64ukLgMCA_gwJAwRV2l6SU4tRGVsZmlubyBHMTAMB1dJWlZFUkEwBgIBCgIBAQwPd3d3LndpenZlcmEuY29toIIFuDCCBbQwggScoAMCAQICAwhcqTANBgkqhkiG9w0BAQsFADBVMQswCQYDVQQGEwJLUjESMBAGA1UECgwJU2lnbktvcmVhMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExGzAZBgNVBAMMElNpZ25Lb3JlYSBUZXN0IENBNTAeFw0yMTA2MDEwMDQ0MDBaFw0yMjA2MDExNDU5NTlaMIGPMQswCQYDVQQGEwJLUjESMBAGA1UECgwJU2lnbktvcmVhMRgwFgYDVQQLDA_thYzsiqTtirjsl4XsooUxGDAWBgNVBAsMD-2FjOyKpO2KuO2ajOyCrDEYMBYGA1UECwwP7YWM7Iqk7Yq47KeA7KCQMR4wHAYDVQQDDBVTaWduS29yZWFfTXlEYXRhX1VzZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCqdw16ltCD_Pa-cE0i5-M4sfcCEGJcfMN1hwRZlD-O-f0e4I_X6QAUaRoXdH-YS8paEjC1jp1cEdsUFureeeqv2x3dTo2o3gBfdHHVFZX7kdU7Xw5AefvUL08CSrBO8aGAHGcKMMX-0P-ZSp5Dj6K2V-fRSK_hiKJW950PyTISDnGuVWDd7z7x_Tc6J-r7x__ZwJIsiwP8s-5zRJWgxbPgN1GfSuCU8eHbbGABv9piFK_TWX1JH1vs92CENaG-rTw695bMhw2E91MUmLGtbyl8lJIR1tzoTsPj55ND08YvyK1YlLwKv00GPQM0fS1TjPvdjRvIaSig-WDqwA5-MDTFAgMBAAGjggJQMIICTDCBkwYDVR0jBIGLMIGIgBTxcKmvb8-di6yBhcwW9HzZhVwMxKFtpGswaTELMAkGA1UEBhMCS1IxDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IENlbnRyYWwxGzAZBgNVBAMMEktpc2EgVGVzdCBSb290Q0EgN4IBBTAdBgNVHQ4EFgQUeiIHaLHTyp0H_w-wM83GeehB-kIwDgYDVR0PAQH_BAQDAgbAMHsGA1UdIAEB_wRxMG8wbQYKKoMajJpEBQEBBTBfMC0GCCsGAQUFBwIBFiFodHRwOi8vd3d3LnNpZ25rb3JlYS5jb20vY3BzLmh0bWwwLgYIKwYBBQUHAgIwIh4gx3QAIMd4yZ3BHAAgwtzV2MapACDHeMmdwRzHhbLIsuQwdAYDVR0RBG0wa6BpBgkqgxqMmkQKAQGgXDBaDBVTaWduS29yZWFfTXlEYXRhX1VzZXIwQTA_BgoqgxqMmkQKAQEBMDEwCwYJYIZIAWUDBAIBoCIEINNlU1wkg0LVTsPBXQlxGFYiD6ntFIv3O_PMWz1bSvv0MFYGA1UdHwRPME0wS6BJoEeGRWxkYXA6Ly8yMTEuMTc1LjgxLjEwMjo2ODkvb3U9ZHAxMXAxMixvdT1BY2NyZWRpdGVkQ0Esbz1TaWduS29yZWEsYz1LUjA6BggrBgEFBQcBAQQuMCwwKgYIKwYBBQUHMAGGHmh0dHA6Ly8yMTEuMTc1LjgxLjEwMS9vY3NwLnBocDANBgkqhkiG9w0BAQsFAAOCAQEAihGQLjAnzhu_cUUvVGh5rqjo4P068-9pdZM_4w1552A6oCrw7sSTK1L9sHDLgfd_RCykx02zsuny3cEy-QyATCHQryqxXVT9sldN2JzqcZKY9I7x6rFa6-TAcORmVFslNrZsqeTMQWasLsc9s0BicnKYZnq1O7l54EP84egZYIzZmpiWK4kBfX5RyJBhxLwsZrHnd8t8WbrNeu46XGRcdpTqwzscu5-EvlbTkiLHaV_Nxa_AgpVmnZL5JsmSviiBScG68ErPSVMxdiNimw1fNiHIqPt_Z1AZQ2RB4PCGNVZbZRIExJa8p8GBV3h3ustrJcQZlJL8V9Co_XrEBIIXbjGCAfIwggHuAgEBMFwwVTELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCVNpZ25Lb3JlYTEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRswGQYDVQQDDBJTaWduS29yZWEgVGVzdCBDQTUCAwhcqTANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMTEyNDA1Mjk0NVowLwYJKoZIhvcNAQkEMSIEIFU7NgWgUf3w7-B1pFcv6gsHQPXR6wTpo3usfORR_V5RMA0GCSqGSIb3DQEBAQUABIIBAHaIGjtiiAg7hsUQ6Li0f5_v-BrN2dSvYDharHEZPpgb2dQggkPA9DsjVJPsgeUUpShWlR5M4Erd9xE1znjNcmP5jUhYoJGqKvf2kTTI-HQTyFGKGCbxeV0kypxcDQElUeTQEeEVxkF8tZ3VCsST1rDGDb-tyMQTrfxR5iPVHqv2ZrdNU-HVHSvQoNpR6FWNVGsr9uToQQpq2asQHu-vu-arIAFbszrD4yrc5eqTrMHA4QLQvie-zaWClsM9eFgCk7aqsgcWEYlztKjVdIZTbNAMvf2foee5qMuLuEt-ai-vLix-OSmiVJGAAxfmxsGhngh-_mM1FgX7pcPCFrV2uyQ");
    }
    if (test_KICA) {
        TEST_name.add("G10");
        TEST_caOrg.add("KICA"); //정보인증
        TEST_consentNonce.add("5zQVNsZKl4webMSN5IJoyA");
        TEST_ucpIdNonce.add("jzaShLTN5vMT7dv-ZtZ84w");
        TEST_signedConsent.add("MIIJzQYJKoZIhvcNAQcCoIIJvjCCCboCAQExDzANBglghkgBZQMEAgEFADCCAhEGCSqGSIb3DQEHAaCCAgIEggH-eyJjb25zZW50Ijoie1xuICAgIFwiaXNfc2NoZWR1bGVkXCI6IFwiMVwiLFxuICAgIFwicmN2X29yZ19jb2RlXCI6IFwiMVwiLFxuICAgIFwiaG9sZGluZ19wZXJpb2RcIjogXCIyNDA4MDQxNTMwMzBcIixcbiAgICBcInRhcmdldF9pbmZvMVwiOiB7XG4gICAgICAgIFwic2NvcGVcIjogXCJiYW5rLmxpc3RcIixcbiAgICAgICAgXCJhc3NldF9saXRcIjoge1xuICAgICAgICAgICAgXCJhc3NldFwiOiBcIjExMTEtMTExMS0xMVwiXG4gICAgICAgIH1cbiAgICB9LFxuICAgIFwicHVycG9zZVwiOiBcInVkMWI1dWQ1Njl1Yzg3MHVkNjhjXCIsXG4gICAgXCJzbmRfb3JnX2NvZGVcIjogXCIxXCIsXG4gICAgXCJlbmRfZGF0ZVwiOiBcIjIyMDgwNDE1MzAzMFwiLFxuICAgIFwiY3ljbGVcIjoge1xuICAgICAgICBcImZuZF9jeWNsZVwiOiBcIjEvd1wiLFxuICAgICAgICBcImFkZF9jeWNsZVwiOiBcIjEvZFwiXG4gICAgfVxufVxuIiwiY29uc2VudE5vbmNlIjoiNXpRVk5zWktsNHdlYk1TTjVJSm95QSJ9oIIFoDCCBZwwggSEoAMCAQICAjZoMA0GCSqGSIb3DQEBCwUAME0xCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSUNBMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExGDAWBgNVBAMMD3NpZ25HQVRFIEZUQ0EwNjAeFw0yMTA0MjAwNTE4MDBaFw0yMjA0MjAxNDU5NTlaMHMxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSUNBMRMwEQYDVQQLDApsaWNlbnNlZENBMQswCQYDVQQLDAJSQTEUMBIGA1UECwwLUkHthYzsiqTtirgxHTAbBgNVBAMMFFVDUElE7Ya17ZWp7YWM7Iqk7Yq4MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApppjEa77DDhdSw_rfZ660Za8fdPpvmmF5T5I_biXyH0BEBkFQwIpfAEoJg7jIVWEWj6b3sR325W59V9kXctdSVuFzvjXCUa_pQU8Mkij8DcdwLnpnzFNpY6sdcsC_vIVtfuE7GsQZANI4lJVriaK6eFC1_R56r-1Y2OMMagyiGxyzH-VA_SIyKa_Qp7boRmzEXCA8LpOysXe-ykjsjoXVhhWyaFv7WuFAuIse3YefwBN7mLl35VYtgpEEr0NBoKJveETrdvmTkFfBRZYEJvkTYpsRNsE2-amNYz8VmfS7b1ja126R98w_bsoADSrGUmaxuom0CoidJZg1eXvwp_mRwIDAQABo4ICXjCCAlowgZMGA1UdIwSBizCBiIAUj2_26IlxagID23oqjlWoU-fQzDOhbaRrMGkxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSVNBMS4wLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBDZW50cmFsMRswGQYDVQQDDBJLaXNhIFRlc3QgUm9vdENBIDeCAQswHQYDVR0OBBYEFFJIN2yowZJyPto7a23VbJ009DJHMA4GA1UdDwEB_wQEAwIGwDB0BgNVHSAEbTBrMGkGCSqDGoyaRAKBSTBcMCwGCCsGAQUFBwIBFiBodHRwOi8vd3d3LnNpZ25nYXRlLmNvbS9jcHMuaHRtbDAsBggrBgEFBQcCAjAgHh7HdAAgx3jJncEcspQAIKz1s9nHeMmdwRzHhbLIsuQwcwYDVR0RBGwwaqBoBgkqgxqMmkQKAQGgWzBZDBRVQ1BJRO2Gte2Vqe2FjOyKpO2KuDBBMD8GCiqDGoyaRAoBAQEwMTALBglghkgBZQMEAgGgIgQgX5M-sB9V087yt1bjJ0PMIR678y9TB-R2BvFFAEyCaLowXgYDVR0fBFcwVTBToFGgT4ZNbGRhcDovL2NhdGVzdC5zaWduZ2F0ZS5jb206Mzg5L291PWRwMnAxNCxvdT1jcmxkcCxvdT1BY2NyZWRpdGVkQ0Esbz1LSUNBLGM9S1IwSAYIKwYBBQUHAQEEPDA6MDgGCCsGAQUFBzABhixodHRwOi8vb2NzcHRlc3Quc2lnbmdhdGUuY29tOjkwMjAvT0NTUFNlcnZlcjANBgkqhkiG9w0BAQsFAAOCAQEAkkCBjRMwXtivuqcdY2Pl_2TM_C4aNvHhi6na4xrGmxWfA1wkukmPhbAbEz0zj75PKG-q9g-XhiQOhdPtlZsEd--x4mYjeveUirP3Zt-JEIayXtERIPrWFimt1AsV_CX6qVjc_aqssTrRcqEMhVKyMbfsILHSDAfR0zPZ5uEoCuJe9U-gqCrsoWOlPE3tE4HQtizqc28lIDo7D5d9Mp5XXcrKVFcby6wN9pHmfN12F3Q_xadvrhMcUOHg-3pFI3kANFa_lgVeb5g3LeRwsMiL1ihfevkJu9xBTDPcOzcj5eoUr9APZc47GCjkrBCMT5WWRmUNvs30u1vSDNpL4G6P-TGCAekwggHlAgEBMFMwTTELMAkGA1UEBhMCS1IxDTALBgNVBAoMBEtJQ0ExFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEYMBYGA1UEAwwPc2lnbkdBVEUgRlRDQTA2AgI2aDANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMTEyNDA1MzAyNVowLwYJKoZIhvcNAQkEMSIEIFk-YZXmoHg7-sX8PxmRpqZ0IpQo5wXDkP_abK0sCJNRMA0GCSqGSIb3DQEBAQUABIIBACVNCaBwlQhyk7s3AhGPATHi74wgG6SRY2vtGShvqTNtO1CGO5tSIUol6h8aqKK8QQOCyAyxOjWQVLd7bwQSD9Liq0pGlGpdCEFrnHc-hHGHkgHGDvwuEFWJM3GqTqK2_tEw2wbdHA2BZ07dU4OpO_Yb5qJ1uHCjKqlUKsYXdMdfcImU3iC5f3BlLHYCcBoAzctYmbUcPT8gmnKNeNdzOgieGzXP7YvoiEVLCImE4g8YKQhkWzYcp6DTkmvoXt7fB1V-UQpqQV8xs-aCcd3v0qVRQdEbspFwnUgPYwSq-64ml0QukGWOBvCU40A0rXQueiXg8sfH6o5H7NIJpCuf2Vo");
        TEST_signedPersonInfoReq.add("MIIIRwYJKoZIhvcNAQcCoIIIODCCCDQCAQExDzANBglghkgBZQMEAgEFADCBjAYJKoZIhvcNAQcBoH8EfTB7AgECBBCPNpKEtM3m8xPt2_5m1nzjMC0MJ-qwnOyduOygleuztCDtmZzsmqnsl5Ag64-Z7J2Y7ZWp64uI64ukLgMCA_gwJAwRV2l6SU4tRGVsZmlubyBHMTAMB1dJWlZFUkEwBgIBCgIBAQwPd3d3LndpenZlcmEuY29toIIFoDCCBZwwggSEoAMCAQICAjZoMA0GCSqGSIb3DQEBCwUAME0xCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSUNBMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExGDAWBgNVBAMMD3NpZ25HQVRFIEZUQ0EwNjAeFw0yMTA0MjAwNTE4MDBaFw0yMjA0MjAxNDU5NTlaMHMxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSUNBMRMwEQYDVQQLDApsaWNlbnNlZENBMQswCQYDVQQLDAJSQTEUMBIGA1UECwwLUkHthYzsiqTtirgxHTAbBgNVBAMMFFVDUElE7Ya17ZWp7YWM7Iqk7Yq4MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApppjEa77DDhdSw_rfZ660Za8fdPpvmmF5T5I_biXyH0BEBkFQwIpfAEoJg7jIVWEWj6b3sR325W59V9kXctdSVuFzvjXCUa_pQU8Mkij8DcdwLnpnzFNpY6sdcsC_vIVtfuE7GsQZANI4lJVriaK6eFC1_R56r-1Y2OMMagyiGxyzH-VA_SIyKa_Qp7boRmzEXCA8LpOysXe-ykjsjoXVhhWyaFv7WuFAuIse3YefwBN7mLl35VYtgpEEr0NBoKJveETrdvmTkFfBRZYEJvkTYpsRNsE2-amNYz8VmfS7b1ja126R98w_bsoADSrGUmaxuom0CoidJZg1eXvwp_mRwIDAQABo4ICXjCCAlowgZMGA1UdIwSBizCBiIAUj2_26IlxagID23oqjlWoU-fQzDOhbaRrMGkxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSVNBMS4wLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBDZW50cmFsMRswGQYDVQQDDBJLaXNhIFRlc3QgUm9vdENBIDeCAQswHQYDVR0OBBYEFFJIN2yowZJyPto7a23VbJ009DJHMA4GA1UdDwEB_wQEAwIGwDB0BgNVHSAEbTBrMGkGCSqDGoyaRAKBSTBcMCwGCCsGAQUFBwIBFiBodHRwOi8vd3d3LnNpZ25nYXRlLmNvbS9jcHMuaHRtbDAsBggrBgEFBQcCAjAgHh7HdAAgx3jJncEcspQAIKz1s9nHeMmdwRzHhbLIsuQwcwYDVR0RBGwwaqBoBgkqgxqMmkQKAQGgWzBZDBRVQ1BJRO2Gte2Vqe2FjOyKpO2KuDBBMD8GCiqDGoyaRAoBAQEwMTALBglghkgBZQMEAgGgIgQgX5M-sB9V087yt1bjJ0PMIR678y9TB-R2BvFFAEyCaLowXgYDVR0fBFcwVTBToFGgT4ZNbGRhcDovL2NhdGVzdC5zaWduZ2F0ZS5jb206Mzg5L291PWRwMnAxNCxvdT1jcmxkcCxvdT1BY2NyZWRpdGVkQ0Esbz1LSUNBLGM9S1IwSAYIKwYBBQUHAQEEPDA6MDgGCCsGAQUFBzABhixodHRwOi8vb2NzcHRlc3Quc2lnbmdhdGUuY29tOjkwMjAvT0NTUFNlcnZlcjANBgkqhkiG9w0BAQsFAAOCAQEAkkCBjRMwXtivuqcdY2Pl_2TM_C4aNvHhi6na4xrGmxWfA1wkukmPhbAbEz0zj75PKG-q9g-XhiQOhdPtlZsEd--x4mYjeveUirP3Zt-JEIayXtERIPrWFimt1AsV_CX6qVjc_aqssTrRcqEMhVKyMbfsILHSDAfR0zPZ5uEoCuJe9U-gqCrsoWOlPE3tE4HQtizqc28lIDo7D5d9Mp5XXcrKVFcby6wN9pHmfN12F3Q_xadvrhMcUOHg-3pFI3kANFa_lgVeb5g3LeRwsMiL1ihfevkJu9xBTDPcOzcj5eoUr9APZc47GCjkrBCMT5WWRmUNvs30u1vSDNpL4G6P-TGCAekwggHlAgEBMFMwTTELMAkGA1UEBhMCS1IxDTALBgNVBAoMBEtJQ0ExFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEYMBYGA1UEAwwPc2lnbkdBVEUgRlRDQTA2AgI2aDANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMTEyNDA1MzAyNVowLwYJKoZIhvcNAQkEMSIEIFU7NgWgUf3w7-B1pFcv6gsHQPXR6wTpo3usfORR_V5RMA0GCSqGSIb3DQEBAQUABIIBAJvT2qURKpnbjWN44JpJDgVF9gMXIC-oNhUw6nyNWCsRUTDU_64IhWV0IQIxUYX0IjBQqYNfsOJr1Og9S7iAD3qI54Dw8FHLn3vIM5ZDw7fMmAlN5SpP_C1LxdsBXebMA2sO3_mbkkTWT_SxEODdFdvaIeAhlhsPrZ2ZKBg19JluyhUSV-BfnLcpGbDaYNjuXdNlXKHZeLoT4hSSJkcyui8zJx20OBZMWZ6uz6UtoquUQjqReDy95zxYEb0haLvBhV3JK6dUOkpuF0I4KPcfugLU9cxQ6TeFXNHo_GaF3z2KTA6dr-P5LxaUKN_I5tmH0FcRkKCoDD_exXVrHXgLfNA");
    }
    if (test_yessign) {
        TEST_name.add("G10");
        TEST_caOrg.add("yessign"); //금결원
        TEST_consentNonce.add("5zQVNsZKl4webMSN5IJoyA");
        TEST_ucpIdNonce.add("jzaShLTN5vMT7dv-ZtZ84w");
        TEST_signedConsent.add("MIIKIwYJKoZIhvcNAQcCoIIKFDCCChACAQExDzANBglghkgBZQMEAgEFADCCAhEGCSqGSIb3DQEHAaCCAgIEggH-eyJjb25zZW50Ijoie1xuICAgIFwiaXNfc2NoZWR1bGVkXCI6IFwiMVwiLFxuICAgIFwicmN2X29yZ19jb2RlXCI6IFwiMVwiLFxuICAgIFwiaG9sZGluZ19wZXJpb2RcIjogXCIyNDA4MDQxNTMwMzBcIixcbiAgICBcInRhcmdldF9pbmZvMVwiOiB7XG4gICAgICAgIFwic2NvcGVcIjogXCJiYW5rLmxpc3RcIixcbiAgICAgICAgXCJhc3NldF9saXRcIjoge1xuICAgICAgICAgICAgXCJhc3NldFwiOiBcIjExMTEtMTExMS0xMVwiXG4gICAgICAgIH1cbiAgICB9LFxuICAgIFwicHVycG9zZVwiOiBcInVkMWI1dWQ1Njl1Yzg3MHVkNjhjXCIsXG4gICAgXCJzbmRfb3JnX2NvZGVcIjogXCIxXCIsXG4gICAgXCJlbmRfZGF0ZVwiOiBcIjIyMDgwNDE1MzAzMFwiLFxuICAgIFwiY3ljbGVcIjoge1xuICAgICAgICBcImZuZF9jeWNsZVwiOiBcIjEvd1wiLFxuICAgICAgICBcImFkZF9jeWNsZVwiOiBcIjEvZFwiXG4gICAgfVxufVxuIiwiY29uc2VudE5vbmNlIjoiNXpRVk5zWktsNHdlYk1TTjVJSm95QSJ9oIIF6zCCBecwggTPoAMCAQICA0dmHTANBgkqhkiG9w0BAQsFADBXMQswCQYDVQQGEwJrcjEQMA4GA1UECgwHeWVzc2lnbjEVMBMGA1UECwwMQWNjcmVkaXRlZENBMR8wHQYDVQQDDBZ5ZXNzaWduQ0EtVGVzdCBDbGFzcyA0MB4XDTIxMDcxNDE1MDAwMFoXDTIzMDcxNTE0NTk1OVowfTELMAkGA1UEBhMCa3IxEDAOBgNVBAoMB3llc3NpZ24xFDASBgNVBAsMC3BlcnNvbmFsNElCMQ0wCwYDVQQLDARLRlRDMTcwNQYDVQQDDC7snYDtlonrs7Ttl5jsmqnqsJzsnbgwMDEoKTAwOTkwNDEyMDIxMDcxNTAwMDE0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAraetBACz1NtqQkxJsNUd1dMWnHrexTYvw3f5wQFyUhZlpv3Zd3Dl_ubiVziZQuWVZZ1wuoCBDYhl_wNSY2oeJL-uwvJ8Avju05oTPiCzTrM3wUjWWY8RLHcYHiw8s_Pf9bjb-83Z8LNvZAFvrTczmhPHZsICnrrBHXNtl7qpdic1hKVlZhLCCr_m0THHJlcM0G8an-k-pS7Sroy7I9er5Ikbx_C6bqxBisqdZILw0MYe68SviSbJGbIF8PIuXDLJUWst9cv3qUPMWIVbSgWPhJL2Fk0FiMNihPkrQmaS2EJC1wvsMgiqCXPe_XKpCcvQE-PrV7HD76t5uCLW3Wb8bwIDAQABo4IClDCCApAwgZMGA1UdIwSBizCBiIAUZjXs6P3-27gqYqkCsebch1zc-cOhbaRrMGkxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSVNBMS4wLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBDZW50cmFsMRswGQYDVQQDDBJLaXNhIFRlc3QgUm9vdENBIDeCAQIwHQYDVR0OBBYEFNp0eLGdQV_uG0G1w2eVq20Rb7akMA4GA1UdDwEB_wQEAwIGwDCBmQYDVR0gAQH_BIGOMIGLMIGIBgkqgxqMmkUBAQQwezBIBggrBgEFBQcCAjA8HjrHdAAgx3jJncEcspQAIK4IxzWssMgcxtDF0MEcACC8HK4J1VwAIMLc1djGqQAgx3jJncEcx4WyyLLkMC8GCCsGAQUFBwIBFiNodHRwOi8vc25vb3B5Lnllc3NpZ24ub3Iua3IvY3BzLmh0bTB3BgNVHREEcDBuoGwGCSqDGoyaRAoBAaBfMF0MGOydgO2WieuztO2XmOyaqeqwnOyduDAwMTBBMD8GCiqDGoyaRAoBAQEwMTALBglghkgBZQMEAgGgIgQgwTGeadutlnBZHKTToXoIkaSh7iribjPrTnzBwQKEniwwdgYDVR0fBG8wbTBroGmgZ4ZlbGRhcDovL3Nub29weS55ZXNzaWduLm9yLmtyOjYwMjAvb3U9ZHAxOHA1OTAsb3U9QWNjcmVkaXRlZENBLG89eWVzc2lnbixjPWtyP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3QwPAYIKwYBBQUHAQEEMDAuMCwGCCsGAQUFBzABhiBodHRwOi8vc25vb3B5Lnllc3NpZ24ub3Iua3I6NDYxMjANBgkqhkiG9w0BAQsFAAOCAQEAH27BIHach3UNLES0uVMlySYsDOEOJXPx9hMzR8G6-pSAtTwoIPhGwkG2DEg863kb9GSzS3FikuIyIxq1dEZTD86uT6LNTFcZJEHRQN6Pe_BKmZn8gezVk_aTLNkpgw-7xYwHCBg1jgWar6CKfVeoyLt3cS_8VoWgzkN0sMSO7BTL_qnGePyECcgbHJVctCzPmtzaev-26bfwlGKALgo-AeNGd4Z2xJQBTrFM2JpGe18QRteKc8YU2zlvGDmKfcvejgD9RdgTySbAAYkSzhRBA2CoH9GkpjoxrE7UJpZJ_J1jaTtCdO8jBGvXMI2edXYpK_cuXdTCZECBi0mHYllaBTGCAfQwggHwAgEBMF4wVzELMAkGA1UEBhMCa3IxEDAOBgNVBAoMB3llc3NpZ24xFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEfMB0GA1UEAwwWeWVzc2lnbkNBLVRlc3QgQ2xhc3MgNAIDR2YdMA0GCWCGSAFlAwQCAQUAoGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjExMTI0MDUyOTA0WjAvBgkqhkiG9w0BCQQxIgQgWT5hleageDv6xfw_GZGmpnQilCjnBcOQ_9psrSwIk1EwDQYJKoZIhvcNAQEBBQAEggEAGtskZnbOIHHsQU0c5dySpjpsaOhYjYMsyTxbKU5lLkWUV1HH3yvw8e5oHvSjWSCq8IQkCZtmwgUAHzO9jYuNF3YKXtnRlFt0DT-rBuhiRsmf5eiu-vzG3pvtAbDl5T9WvGPCfdmg1by9LJutBEiyz6Lcix8GtMHI36fS9C5REDmgzFo5pAnA2nzQ25QVG7yQIyHiKacdeadSJwBUzR7PeHCKa6uNlV8zt8_rAFGQqjlrZs9cIOy5vlHL0ADJi-CTwGVhGGpL3wn0xGD0pFiawMX6vkJQz4sam0zJGqZUs7ANkQ65Ep5SXZKMj76WBA04qu2mDmZUkLneFikZkn8VKA");
        TEST_signedPersonInfoReq.add("MIIInQYJKoZIhvcNAQcCoIIIjjCCCIoCAQExDzANBglghkgBZQMEAgEFADCBjAYJKoZIhvcNAQcBoH8EfTB7AgECBBCPNpKEtM3m8xPt2_5m1nzjMC0MJ-qwnOyduOygleuztCDtmZzsmqnsl5Ag64-Z7J2Y7ZWp64uI64ukLgMCA_gwJAwRV2l6SU4tRGVsZmlubyBHMTAMB1dJWlZFUkEwBgIBCgIBAQwPd3d3LndpenZlcmEuY29toIIF6zCCBecwggTPoAMCAQICA0dmHTANBgkqhkiG9w0BAQsFADBXMQswCQYDVQQGEwJrcjEQMA4GA1UECgwHeWVzc2lnbjEVMBMGA1UECwwMQWNjcmVkaXRlZENBMR8wHQYDVQQDDBZ5ZXNzaWduQ0EtVGVzdCBDbGFzcyA0MB4XDTIxMDcxNDE1MDAwMFoXDTIzMDcxNTE0NTk1OVowfTELMAkGA1UEBhMCa3IxEDAOBgNVBAoMB3llc3NpZ24xFDASBgNVBAsMC3BlcnNvbmFsNElCMQ0wCwYDVQQLDARLRlRDMTcwNQYDVQQDDC7snYDtlonrs7Ttl5jsmqnqsJzsnbgwMDEoKTAwOTkwNDEyMDIxMDcxNTAwMDE0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAraetBACz1NtqQkxJsNUd1dMWnHrexTYvw3f5wQFyUhZlpv3Zd3Dl_ubiVziZQuWVZZ1wuoCBDYhl_wNSY2oeJL-uwvJ8Avju05oTPiCzTrM3wUjWWY8RLHcYHiw8s_Pf9bjb-83Z8LNvZAFvrTczmhPHZsICnrrBHXNtl7qpdic1hKVlZhLCCr_m0THHJlcM0G8an-k-pS7Sroy7I9er5Ikbx_C6bqxBisqdZILw0MYe68SviSbJGbIF8PIuXDLJUWst9cv3qUPMWIVbSgWPhJL2Fk0FiMNihPkrQmaS2EJC1wvsMgiqCXPe_XKpCcvQE-PrV7HD76t5uCLW3Wb8bwIDAQABo4IClDCCApAwgZMGA1UdIwSBizCBiIAUZjXs6P3-27gqYqkCsebch1zc-cOhbaRrMGkxCzAJBgNVBAYTAktSMQ0wCwYDVQQKDARLSVNBMS4wLAYDVQQLDCVLb3JlYSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eSBDZW50cmFsMRswGQYDVQQDDBJLaXNhIFRlc3QgUm9vdENBIDeCAQIwHQYDVR0OBBYEFNp0eLGdQV_uG0G1w2eVq20Rb7akMA4GA1UdDwEB_wQEAwIGwDCBmQYDVR0gAQH_BIGOMIGLMIGIBgkqgxqMmkUBAQQwezBIBggrBgEFBQcCAjA8HjrHdAAgx3jJncEcspQAIK4IxzWssMgcxtDF0MEcACC8HK4J1VwAIMLc1djGqQAgx3jJncEcx4WyyLLkMC8GCCsGAQUFBwIBFiNodHRwOi8vc25vb3B5Lnllc3NpZ24ub3Iua3IvY3BzLmh0bTB3BgNVHREEcDBuoGwGCSqDGoyaRAoBAaBfMF0MGOydgO2WieuztO2XmOyaqeqwnOyduDAwMTBBMD8GCiqDGoyaRAoBAQEwMTALBglghkgBZQMEAgGgIgQgwTGeadutlnBZHKTToXoIkaSh7iribjPrTnzBwQKEniwwdgYDVR0fBG8wbTBroGmgZ4ZlbGRhcDovL3Nub29weS55ZXNzaWduLm9yLmtyOjYwMjAvb3U9ZHAxOHA1OTAsb3U9QWNjcmVkaXRlZENBLG89eWVzc2lnbixjPWtyP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3QwPAYIKwYBBQUHAQEEMDAuMCwGCCsGAQUFBzABhiBodHRwOi8vc25vb3B5Lnllc3NpZ24ub3Iua3I6NDYxMjANBgkqhkiG9w0BAQsFAAOCAQEAH27BIHach3UNLES0uVMlySYsDOEOJXPx9hMzR8G6-pSAtTwoIPhGwkG2DEg863kb9GSzS3FikuIyIxq1dEZTD86uT6LNTFcZJEHRQN6Pe_BKmZn8gezVk_aTLNkpgw-7xYwHCBg1jgWar6CKfVeoyLt3cS_8VoWgzkN0sMSO7BTL_qnGePyECcgbHJVctCzPmtzaev-26bfwlGKALgo-AeNGd4Z2xJQBTrFM2JpGe18QRteKc8YU2zlvGDmKfcvejgD9RdgTySbAAYkSzhRBA2CoH9GkpjoxrE7UJpZJ_J1jaTtCdO8jBGvXMI2edXYpK_cuXdTCZECBi0mHYllaBTGCAfQwggHwAgEBMF4wVzELMAkGA1UEBhMCa3IxEDAOBgNVBAoMB3llc3NpZ24xFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEfMB0GA1UEAwwWeWVzc2lnbkNBLVRlc3QgQ2xhc3MgNAIDR2YdMA0GCWCGSAFlAwQCAQUAoGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjExMTI0MDUyOTA0WjAvBgkqhkiG9w0BCQQxIgQgVTs2BaBR_fDv4HWkVy_qCwdA9dHrBOmje6x85FH9XlEwDQYJKoZIhvcNAQEBBQAEggEAciy8Xqrb_h1I1zhfE9hKtqW02jZjEw7lVcl5VKX_oWWo-2k7vsECrHS8JfSCuyxNjObb7sLYo60sfXuuugYkokIVAHEg6wNe9-2XQ9dIDJajrlgcn1eTv4jvfVm5Z2lhrUdUD0fjUgCr2lna_ItupYvuv3aCgc5zsVQ6W3TJAgxBdCH0vWt5egMbnok6DzROkUZS1_nbG451IuXweawiaIoFt7N3iSXTDEOU_H5rv_YjG6jOWo3Py2lugRlqfyNNdeThw3x6KfLEgifeho_H7AF1l23ZpsUE0zHVvgfzf6GjxK33RNF0SPkcV61bl_5smCnzSHRsvymZ7CbT63t_CA");
    }
    if (test_CrossCert) {
        TEST_name.add("G10");
        TEST_caOrg.add("CrossCert"); //전자인증
        TEST_consentNonce.add("5zQVNsZKl4webMSN5IJoyA");
        TEST_ucpIdNonce.add("jzaShLTN5vMT7dv-ZtZ84w");
        TEST_signedConsent.add("MIIKHQYJKoZIhvcNAQcCoIIKDjCCCgoCAQExDzANBglghkgBZQMEAgEFADCCAhEGCSqGSIb3DQEHAaCCAgIEggH-eyJjb25zZW50Ijoie1xuICAgIFwiaXNfc2NoZWR1bGVkXCI6IFwiMVwiLFxuICAgIFwicmN2X29yZ19jb2RlXCI6IFwiMVwiLFxuICAgIFwiaG9sZGluZ19wZXJpb2RcIjogXCIyNDA4MDQxNTMwMzBcIixcbiAgICBcInRhcmdldF9pbmZvMVwiOiB7XG4gICAgICAgIFwic2NvcGVcIjogXCJiYW5rLmxpc3RcIixcbiAgICAgICAgXCJhc3NldF9saXRcIjoge1xuICAgICAgICAgICAgXCJhc3NldFwiOiBcIjExMTEtMTExMS0xMVwiXG4gICAgICAgIH1cbiAgICB9LFxuICAgIFwicHVycG9zZVwiOiBcInVkMWI1dWQ1Njl1Yzg3MHVkNjhjXCIsXG4gICAgXCJzbmRfb3JnX2NvZGVcIjogXCIxXCIsXG4gICAgXCJlbmRfZGF0ZVwiOiBcIjIyMDgwNDE1MzAzMFwiLFxuICAgIFwiY3ljbGVcIjoge1xuICAgICAgICBcImZuZF9jeWNsZVwiOiBcIjEvd1wiLFxuICAgICAgICBcImFkZF9jeWNsZVwiOiBcIjEvZFwiXG4gICAgfVxufVxuIiwiY29uc2VudE5vbmNlIjoiNXpRVk5zWktsNHdlYk1TTjVJSm95QSJ9oIIF6DCCBeQwggTMoAMCAQICBAF2VtEwDQYJKoZIhvcNAQELBQAwUzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRkwFwYDVQQDDBBDcm9zc0NlcnRUZXN0Q0E1MB4XDTIxMDkyNDAxMDAwMFoXDTIyMDkyNDE0NTk1OVowgYAxCzAJBgNVBAYTAktSMRIwEAYDVQQKDAlDcm9zc0NlcnQxFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEVMBMGA1UECwwM65Ox66Gd6riw6rSAMRIwEAYDVQQLDAnthYzsiqTtirgxGzAZBgNVBAMMEkND66eI7J20642w7J207YSwNDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANNXcoekEWg22qUkc0K1rvqGDKgkUTi7rQEyrAEINdynzXn9RSCCToLKbEk8SsGP7CHBg55h1Q58Rhbr4Z7XPzBp320vAOnYDOynF_PzEjdAry57tv3Rcn2tZZpIRP52NaHRuhb5eU32BFdyuD6AEzAQ-TGK4hIt-_yRLpJXw7udwmJGCEnhLVdFoyBI-ps2xVCbmdVtVtXSf0CGl6oW7-yFKgBu5YNzl33jmQQ6Uz_34qRCPe6Q8o7p2KVhh1lFLJ_BRkAqwec4Xn-BCaCCe3yn50Xc2i2-fW68GiHBPnWO0IYmt1SwDPIFWfcTPWnWQaUkIQ5JtOvO_zP-ZSDWVWkCAwEAAaOCApAwggKMMIGTBgNVHSMEgYswgYiAFIHVOZnNIv6dxkaYS1CUdi7A5x4_oW2kazBpMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEbMBkGA1UEAwwSS2lzYSBUZXN0IFJvb3RDQSA3ggEOMB0GA1UdDgQWBBRlr42bZu93tKFnCf5y6aAp8qG0ejAOBgNVHQ8BAf8EBAMCBsAwfwYDVR0gAQH_BHUwczBxBgoqgxqMmkQFBAEBMGMwLQYIKwYBBQUHAgEWIWh0dHA6Ly9nY2EuY3Jvc3NjZXJ0LmNvbS9jcHMuaHRtbDAyBggrBgEFBQcCAjAmHiTHdAAgx3jJncEcspQAINFMwqTSuAAgx3jJncEcx4WyyLLkAC4wcQYDVR0RBGowaKBmBgkqgxqMmkQKAQGgWTBXDBJDQ-uniOydtOuNsOydtO2EsDMwQTA_BgoqgxqMmkQKAQEBMDEwCwYJYIZIAWUDBAIBoCIEIBkuYNZPzbuWr6d3aY-Di3dk4IrAGBBH9sH_cFBaOi_JMIGEBgNVHR8EfTB7MHmgd6B1hnNsZGFwOi8vdGVzdGRpci5jcm9zc2NlcnQuY29tOjM4OS9jbj1zMWRwMTJwMjU4MyxvdT1jcmxkcCxvdT1BY2NyZWRpdGVkQ0Esbz1Dcm9zc0NlcnQsYz1LUj9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0MEoGCCsGAQUFBwEBBD4wPDA6BggrBgEFBQcwAYYuaHR0cDovL3Rlc3RvY3NwLmNyb3NzY2VydC5jb206MTQyMDMvT0NTUFNlcnZlcjANBgkqhkiG9w0BAQsFAAOCAQEAWW-Z4OCWOgLTD5oKfvyyiZwfkllpC6adVFomWoygi2b78vm3uxprrdEagEXTA1GSnzqQcXGmNIbx4SQvFc6EZCW2DjJzmIESbFFIHSnDGj7ZJ0Q1BNSNciXN8lo0gVO-oTq70JBL3dtVJWOB0ZXhabBhviEclyghiUI-Iwc7DhuS4sxREnDTedyUukqowoe-cCkVI8w-cVRI0lohPzrv0CeB1HUTXgFYeQnsZdh9hu_B9IxXp7RIhc_7_gTlVS3mWPjWuT-AgwhULJ-1xLkyLy156XtxU_C_WgQVKNoBiAMdmNiOC4JwPia_S9bDQ3BNoHzvUhu-2oFJ-rPLzmnWtTGCAfEwggHtAgEBMFswUzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRkwFwYDVQQDDBBDcm9zc0NlcnRUZXN0Q0E1AgQBdlbRMA0GCWCGSAFlAwQCAQUAoGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjExMTI0MDUzMDU4WjAvBgkqhkiG9w0BCQQxIgQgWT5hleageDv6xfw_GZGmpnQilCjnBcOQ_9psrSwIk1EwDQYJKoZIhvcNAQEBBQAEggEAbEkjNlmS-yl50XcEYlsiZ9UwZkGkJ-_5nFEvrdkub3aEr5b0duTVWJr8NgZchIUkY4eUFcq6YDUOEfLFIf_6gl43Pi6FGc7SAvfm88HCqoHX-bWJA6hMVtIhr23xBF0i-e90Z2gRboIyxUVuL1-0QIAZjKKekSO-smTs7DZ825ECtt7OU9pU32D1jecZpeCtUOH2vNzhyqGsLR_spGaL1a8judivrgTeHpLSR9VqzwIFqHw4POPiv6tu9Q3O1-RLA7PYQGI-W6GxFm3VnnHbgNHY4wkXTt106ECU_qSItbsqSwD90VsDoqPJW7WJ9qzL1Mv0XXGOhib8T0vbaejAiw");
        TEST_signedPersonInfoReq.add("MIIIlwYJKoZIhvcNAQcCoIIIiDCCCIQCAQExDzANBglghkgBZQMEAgEFADCBjAYJKoZIhvcNAQcBoH8EfTB7AgECBBCPNpKEtM3m8xPt2_5m1nzjMC0MJ-qwnOyduOygleuztCDtmZzsmqnsl5Ag64-Z7J2Y7ZWp64uI64ukLgMCA_gwJAwRV2l6SU4tRGVsZmlubyBHMTAMB1dJWlZFUkEwBgIBCgIBAQwPd3d3LndpenZlcmEuY29toIIF6DCCBeQwggTMoAMCAQICBAF2VtEwDQYJKoZIhvcNAQELBQAwUzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRkwFwYDVQQDDBBDcm9zc0NlcnRUZXN0Q0E1MB4XDTIxMDkyNDAxMDAwMFoXDTIyMDkyNDE0NTk1OVowgYAxCzAJBgNVBAYTAktSMRIwEAYDVQQKDAlDcm9zc0NlcnQxFTATBgNVBAsMDEFjY3JlZGl0ZWRDQTEVMBMGA1UECwwM65Ox66Gd6riw6rSAMRIwEAYDVQQLDAnthYzsiqTtirgxGzAZBgNVBAMMEkND66eI7J20642w7J207YSwNDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANNXcoekEWg22qUkc0K1rvqGDKgkUTi7rQEyrAEINdynzXn9RSCCToLKbEk8SsGP7CHBg55h1Q58Rhbr4Z7XPzBp320vAOnYDOynF_PzEjdAry57tv3Rcn2tZZpIRP52NaHRuhb5eU32BFdyuD6AEzAQ-TGK4hIt-_yRLpJXw7udwmJGCEnhLVdFoyBI-ps2xVCbmdVtVtXSf0CGl6oW7-yFKgBu5YNzl33jmQQ6Uz_34qRCPe6Q8o7p2KVhh1lFLJ_BRkAqwec4Xn-BCaCCe3yn50Xc2i2-fW68GiHBPnWO0IYmt1SwDPIFWfcTPWnWQaUkIQ5JtOvO_zP-ZSDWVWkCAwEAAaOCApAwggKMMIGTBgNVHSMEgYswgYiAFIHVOZnNIv6dxkaYS1CUdi7A5x4_oW2kazBpMQswCQYDVQQGEwJLUjENMAsGA1UECgwES0lTQTEuMCwGA1UECwwlS29yZWEgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgQ2VudHJhbDEbMBkGA1UEAwwSS2lzYSBUZXN0IFJvb3RDQSA3ggEOMB0GA1UdDgQWBBRlr42bZu93tKFnCf5y6aAp8qG0ejAOBgNVHQ8BAf8EBAMCBsAwfwYDVR0gAQH_BHUwczBxBgoqgxqMmkQFBAEBMGMwLQYIKwYBBQUHAgEWIWh0dHA6Ly9nY2EuY3Jvc3NjZXJ0LmNvbS9jcHMuaHRtbDAyBggrBgEFBQcCAjAmHiTHdAAgx3jJncEcspQAINFMwqTSuAAgx3jJncEcx4WyyLLkAC4wcQYDVR0RBGowaKBmBgkqgxqMmkQKAQGgWTBXDBJDQ-uniOydtOuNsOydtO2EsDMwQTA_BgoqgxqMmkQKAQEBMDEwCwYJYIZIAWUDBAIBoCIEIBkuYNZPzbuWr6d3aY-Di3dk4IrAGBBH9sH_cFBaOi_JMIGEBgNVHR8EfTB7MHmgd6B1hnNsZGFwOi8vdGVzdGRpci5jcm9zc2NlcnQuY29tOjM4OS9jbj1zMWRwMTJwMjU4MyxvdT1jcmxkcCxvdT1BY2NyZWRpdGVkQ0Esbz1Dcm9zc0NlcnQsYz1LUj9jZXJ0aWZpY2F0ZVJldm9jYXRpb25MaXN0MEoGCCsGAQUFBwEBBD4wPDA6BggrBgEFBQcwAYYuaHR0cDovL3Rlc3RvY3NwLmNyb3NzY2VydC5jb206MTQyMDMvT0NTUFNlcnZlcjANBgkqhkiG9w0BAQsFAAOCAQEAWW-Z4OCWOgLTD5oKfvyyiZwfkllpC6adVFomWoygi2b78vm3uxprrdEagEXTA1GSnzqQcXGmNIbx4SQvFc6EZCW2DjJzmIESbFFIHSnDGj7ZJ0Q1BNSNciXN8lo0gVO-oTq70JBL3dtVJWOB0ZXhabBhviEclyghiUI-Iwc7DhuS4sxREnDTedyUukqowoe-cCkVI8w-cVRI0lohPzrv0CeB1HUTXgFYeQnsZdh9hu_B9IxXp7RIhc_7_gTlVS3mWPjWuT-AgwhULJ-1xLkyLy156XtxU_C_WgQVKNoBiAMdmNiOC4JwPia_S9bDQ3BNoHzvUhu-2oFJ-rPLzmnWtTGCAfEwggHtAgEBMFswUzELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCUNyb3NzQ2VydDEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRkwFwYDVQQDDBBDcm9zc0NlcnRUZXN0Q0E1AgQBdlbRMA0GCWCGSAFlAwQCAQUAoGkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjExMTI0MDUzMDU4WjAvBgkqhkiG9w0BCQQxIgQgVTs2BaBR_fDv4HWkVy_qCwdA9dHrBOmje6x85FH9XlEwDQYJKoZIhvcNAQEBBQAEggEAYEVDrnQ2jBp0p34MxIOfF6trwmv1XFzYCUY2e-MSnOoS-V_GwpZ_VI9nXezY3wcZo8t0FfwTIBAL7HTIREPd-zTZiW0Cj1tO4iHhA9ve5D8O09A_j3kopLgeQtgLs51owgngZcZQDaUGmB1BoliVujBEHfgHP8E6BF-tSpMwJK0y1RP7iYRMR4TajummHmCwRWEQwKxuZJvr3GHdjOmnH7gGxpXwf-R-1NgYxigkXGoNMCtERItcF7IPAS63T8EtFiULaPps74e5lGZQQqYXcFtXn1GHdkKS96129m2I4HCPfeZ8nwTfKzlBW5dYWTqVYdb5fFKWw8SfTMe9k_XxxQ");
    }

    String caOrg = "";                  // 인증기관코드
    String signedPersonInfoReq = "";    // 본인확인 전자서명값(UCPID)
    String signedConsent = "";          // 전송요구 전자서명값

    String orgCode = "000";             // 정보제공자코드
    String ucpIdNonce = "";             // 마이데이터서버에서 전달된 ucpidNonce 추가
    String consentNonce = "";           // 마이데이터서버에서 전달된 consentNonce 추가

    out.println("<h2>");
    out.println("인증기관별 UCPID 테스트 결과");
    for (int j=0; j<TEST_caOrg.size(); j++) out.println(" :" + TEST_caOrg.get(j) + "_" + TEST_name.get(j));
    out.println("</h2>");

    for (int j=0; j<TEST_caOrg.size(); j++) {
        caOrg = TEST_caOrg.get(j);
        consentNonce = TEST_consentNonce.get(j);
        ucpIdNonce = TEST_ucpIdNonce.get(j);
        signedConsent = TEST_signedConsent.get(j);
        signedPersonInfoReq = TEST_signedPersonInfoReq.get(j);

        //TODO: 디버깅/시작
        if (true) {
            out.println("<hr/><b>" + (j+1) + ".0 서명원문확인</b>: " + caOrg + ": " + TEST_name.get(j));
            com.wizvera.service.SignVerifier signVerifier = new com.wizvera.service.SignVerifier(); //서명검증 객체
            try {
                com.wizvera.service.SignVerifierResult signVerifierResult1 = signVerifier.verifyPKCS7WithoutCertValidation(signedConsent);
                out.println("<br/>signedConsent[<b><font color='red'>\n" + signVerifierResult1.getOriginSignedRawData() + "\n</font></b>]");
            } catch (Exception e) {
                out.println("\n\n" + com.wizvera.crypto.PKCS7Dump.dumpAsString(signedConsent) + "\n\n");
            }
            try {
                com.wizvera.service.SignVerifierResult signVerifierResult2 = signVerifier.verifyPKCS7WithoutCertValidation(signedPersonInfoReq);
                out.println("<br/>signedPersonInfoReq[<b><font color='red'>\n" + signVerifierResult2.getOriginSignedRawData() + "\n</font></b>]");
            } catch (Exception e) {
                out.println("\n\n" + com.wizvera.crypto.PKCS7Dump.dumpAsString(signedPersonInfoReq));
            }
        }
        //TODO: 디버깅/종료

        out.println("<hr/><b>" + (j+1) + ".1 서명검증: MyDataVerifer</b>: orgCode[<b>" + orgCode + "</b>] caOrg[<b>" + caOrg + "</b>]");

        // 전자서명 검증값 생성(signedPersonInfoReq + ucpidNonce + signedConsent + consentNonce)
        SignedMyData signedMyData = new SignedMyData();
        signedMyData.setSignedPersonInfoReq(signedPersonInfoReq);   // 마이데이터서버에서 전달된 본인확인 전자서명값 추가
        signedMyData.setSignedConsent(signedConsent);               // 마이데이터서버에서 전달된 전송요구 전자서명값 추가
        signedMyData.setUcpidNonce(ucpIdNonce);                     // 마이데이터서버에서 전달된 ucpidNonce 추가
        signedMyData.setConsentNonce(consentNonce);                 // 마이데이터서버에서 전달된 consentNonce 추가

        MyDataAuthService myAuthService = new MyDataAuthService();
        try {

            // 본인확인 및 전송요구내역 전자서명 검증(ucpidNonce 검증 + consentNonce 검증 + 인증서동일유무 검증 포함), 전자서명검증 허용범위 시간(10분 내외, ms)
            long now = System.currentTimeMillis();
            //MyDataVerifyResult myDataVerifyResult = myAuthService.verifySignedData(signedMyData, now-(1000L*60*10), now+(1000L*60));
            MyDataVerifyResult myDataVerifyResult = myAuthService.verifySignedData(signedMyData, now-(1000L*60*60*24*365), now+(1000L*60));

            // 전송요구내역 정보
            out.println("<br/><b>(1) getConsentInfo</b>");
            out.println("<br/>- getConsent: "); out.println(myDataVerifyResult.getConsentInfo().getConsent());    // 전송요구내역
            out.println("<br/>- getConsentNonce: "); out.println(myDataVerifyResult.getConsentInfo().getConsentNonce());  // consentNonce
            out.println("<br/>- getSubjectDN: "); out.println(myDataVerifyResult.getConsentInfo().getSignerCertificate().getSubjectDN()); // 사용자인증서 DN(이름)
            out.println("<br/>- getNotAfter: "); out.println(new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(myDataVerifyResult.getConsentInfo().getSignerCertificate().getNotAfter())); //만료일

            // 본인인증 정보
            out.println("<br/><br/><b>(2) getPersonInfoReqInfo</b>");
            out.println("<br/>- getUserAgreement: "); out.println(myDataVerifyResult.getPersonInfoReqInfo().getUserAgreement());  // 본인확인약관
            out.println("<br/>- getUcpidNonce: "); out.println(myDataVerifyResult.getPersonInfoReqInfo().getUcpidNonce());    // ucpidNonce
            out.println("<br/>- getIspUrlInfo: "); out.println(myDataVerifyResult.getPersonInfoReqInfo().getIspUrlInfo()); // 마이데이타 서비스 도메인
            out.println("<br/>- getSubjectDN: "); out.println(myDataVerifyResult.getPersonInfoReqInfo().getSignerCertificate().getSubjectDN()); // 사용자인증서 DN(이름)

            // 전자서명 모듈정보
            out.println("<br/><br/><b>(3) getModuleInfo</b>: ");
            out.println(" [" + myDataVerifyResult.getPersonInfoReqInfo().getModuleVendorName() + "]");   // 전자서명 모듈 제공업체
            out.println( "[" + myDataVerifyResult.getPersonInfoReqInfo().getModuleName() + "]"); // 전자서명 모듈명
            out.println(" [version_" + myDataVerifyResult.getPersonInfoReqInfo().getModuleVersionMajor() + "." + myDataVerifyResult.getPersonInfoReqInfo().getModuleVersionMinor() + "]");  // 전자서명 모듈 버전(Major/Minor)
            out.println(" [build_" + myDataVerifyResult.getPersonInfoReqInfo().getModuleVersionBuild() + "]");        // 전자서명 빌드 버전
            out.println(" [Revision_" + myDataVerifyResult.getPersonInfoReqInfo().getModuleVersionRevision() + "]");  // 전자서명 개정 버전

        } catch (MyDataAuthException e) {
            out.println("<br/><hr/><b>MyDataAuthException  - ERR(?)</b>");System.out.println("<br/><hr/><b>MyDataVeriferException - ERR(?)</b>");
            out.println("<br/>getMessage: " + e.getMessage());System.out.println("<br/>getMessage: " + e.getMessage());
            out.println("<br/>getErrorCode: " + e.getErrorCode());System.out.println("<br/>getErrorCode: " + e.getErrorCode());
            java.io.StringWriter sw = new java.io.StringWriter();
            java.io.PrintWriter pw = new java.io.PrintWriter(sw);
            e.printStackTrace(pw);
            out.println("<br><br><b>printStackTrace</b><br>");System.out.println("<br><br><b>printStackTrace</b><br>");
            out.println("<font size='2'>" + sw.toString() + "</font>");System.out.println("<font size='2'>" + sw.toString() + "</font>");
        } catch (Exception e) {
            out.println("<br/><hr/><b>Exception - ERR(?)</b>");System.out.println("<br/><hr/><b>Exception - ERR(?)</b>");
            out.println("<br/>getMessage: " + e.getMessage());System.out.println("<br/>getMessage: " + e.getMessage());
            java.io.StringWriter sw = new java.io.StringWriter();
            java.io.PrintWriter pw = new java.io.PrintWriter(sw);
            e.printStackTrace(pw);
            out.println("<br><br><b>printStackTrace</b><br>");System.out.println("<br><br><b>printStackTrace</b><br>");
            out.println("<font size='2'>" + sw.toString() + "</font>");System.out.println("<font size='2'>" + sw.toString() + "</font>");
        }


        String caCode = caOrg; // yessign, SignKorea, KICA, CrossCert
        out.println("<br/><br/><b>" + (j+1) + ".2 UCPID검증: UCPIDManager</b>: cpCode[<b>" + caCode + "</b>] cpRequestNumber[<b>" + cpRequestNumber + "</b>]");

        // 인증기관과 본인인증(UCPID)통신 후 CI 추출
        try {
            // 인증기관코드, 본인인증전자서명값, 트랜잭션ID(tx_id)-cpRequestNumber
            PersonInfo ucpidPersonInfo = myAuthService.getUCPIDPersonInfo(caCode, signedMyData.getSignedPersonInfoReq(), cpRequestNumber);

            out.println("<br/>getRealName [" + ucpidPersonInfo.getRealName() + "]");
            out.println(" getCi [" + ucpidPersonInfo.getCi() + "]");
            out.println(" getCiupdate [" + ucpidPersonInfo.getCiupdate() + "]");
            out.println(" getCi2 [" + ucpidPersonInfo.getCi2() + "]");

        } catch (MyDataAuthException  e) {
            out.println("<br/><hr/><b>MyDataAuthException - ERR(?)</b>");System.out.println("<br/><hr/><b>UCPIDException - ERR(?)</b>");
            out.println("<br/>getMessage: " + e.getMessage());System.out.println("<br/>getMessage: " + e.getMessage());
            out.println("<br/>getErrorCode: " + e.getErrorCode());System.out.println("<br/>getErrorCode: " + e.getErrorCode());
            java.io.StringWriter sw = new java.io.StringWriter();
            java.io.PrintWriter pw = new java.io.PrintWriter(sw);
            e.printStackTrace(pw);
            out.println("<br><br><b>printStackTrace</b><br>");System.out.println("<br><br><b>printStackTrace</b><br>");
            out.println("<font size='2'>" + sw.toString() + "</font>");System.out.println("<font size='2'>" + sw.toString() + "</font>");
        } catch (Exception e) {
            out.println("<br/><hr/><b>Exception - ERR(?)</b>");System.out.println("<br/><hr/><b>Exception - ERR(?)</b>");
            out.println("<br/>getMessage: " + e.getMessage());System.out.println("<br/>getMessage: " + e.getMessage());
            java.io.StringWriter sw = new java.io.StringWriter();
            java.io.PrintWriter pw = new java.io.PrintWriter(sw);
            e.printStackTrace(pw);
            out.println("<br><br><b>printStackTrace</b><br>");System.out.println("<br><br><b>printStackTrace</b><br>");
            out.println("<font size='2'>" + sw.toString() + "</font>");System.out.println("<font size='2'>" + sw.toString() + "</font>");
        }
        out.println("<br/><br/>");
    }
    out.println("<hr/>");
%>
</body>
</html>