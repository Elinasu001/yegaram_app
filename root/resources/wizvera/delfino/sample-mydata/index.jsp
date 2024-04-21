<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <meta http-equiv="Expires" content="-1" />
    <meta http-equiv="Progma" content="no-cache" />
    <meta http-equiv="cache-control" content="no-cache" />
    <meta name="viewport" content="initial-scale=1.0, width=device-width" />
    <title>::: WizIN-Delfino MyData/UCPID TEST :::</title>

    <style type="text/css">
        button   { width:160px;  }
        textarea { width:580px; height:80px; font-size:9pt; }
        span     { display:inline-block; width:110px; }
    </style>
</head>
<body>
<h1>WizIN-Delfino MyData/UCPID TEST</h1>


<h2>사업자: MyData생성 및 검증</h2>
    <ul>
        <li><a href="myDataSign.jsp">myDataSign</a></li>
    </ul>


<h2>정보제공자: UCPID 검증
    <font size=2>
        <a href="myDataTest.jsp?caOrg=SignKorea">코스콤</a>
        <a href="myDataTest.jsp?caOrg=KICA">정보인증</a>
        <a href="myDataTest.jsp?caOrg=yessign">금결원</a>
        <a href="myDataTest.jsp?caOrg=CrossCert">전자인증</a>
        <a href="myDataTest.jsp?caOrg=ALL">전체</a></font>
</h2>
<form name="ucpidForm" method="post" action="myDataTest.jsp">
    <input type="hidden" name="_action" value="testUCPID" />
    <ul>
        <li>
            <span>caOrg:</span>
            <select name="caOrg" style="width:150px; height:22px;">
                <option value="SignKorea">코스콤: SignKorea</option>
                <option value="KICA">정보인증: KICA</option>
                <option value="yessign">금결원: yessign</option>
                <option value="CrossCert">전자인증: CrossCert:</option>
            </select>
            <input type="submit" value="UCPID검증" />
        </li>
        <li>
            <span>consentNonce:</span>
            <input type="text" name="consentNonce" style="width:230px;" value="5zQVNsZKl4webMSN5IJoyA" />
        </li>
        <li>
            <span>ucpIdNonce:</span>
            <input type="text" name="ucpIdNonce" style="width:230px;" value="jzaShLTN5vMT7dv-ZtZ84w" />
        </li>
        <li>
            <span>cpRequestNumber:</span><br/>
            <input type="text" name="cpRequestNumber" style="width:580px;" value="MD_0000000000_TESTCP0000_0000000000_ZXAACP0000_20211110172348_000000000143" />
        </li>
        <li>
            <span>signedConsent:</span><br/>
            <textarea name="signedConsent">MIIJ7gYJKoZIhvcNAQcCoIIJ3zCCCdsCAQExDzANBglghkgBZQMEAgEFADCCAhEGCSqGSIb3DQEHAaCCAgIEggH-eyJjb25zZW50Ijoie1xuICAgIFwiaXNfc2NoZWR1bGVkXCI6IFwiMVwiLFxuICAgIFwicmN2X29yZ19jb2RlXCI6IFwiMVwiLFxuICAgIFwiaG9sZGluZ19wZXJpb2RcIjogXCIyNDA4MDQxNTMwMzBcIixcbiAgICBcInRhcmdldF9pbmZvMVwiOiB7XG4gICAgICAgIFwic2NvcGVcIjogXCJiYW5rLmxpc3RcIixcbiAgICAgICAgXCJhc3NldF9saXRcIjoge1xuICAgICAgICAgICAgXCJhc3NldFwiOiBcIjExMTEtMTExMS0xMVwiXG4gICAgICAgIH1cbiAgICB9LFxuICAgIFwicHVycG9zZVwiOiBcInVkMWI1dWQ1Njl1Yzg3MHVkNjhjXCIsXG4gICAgXCJzbmRfb3JnX2NvZGVcIjogXCIxXCIsXG4gICAgXCJlbmRfZGF0ZVwiOiBcIjIyMDgwNDE1MzAzMFwiLFxuICAgIFwiY3ljbGVcIjoge1xuICAgICAgICBcImZuZF9jeWNsZVwiOiBcIjEvd1wiLFxuICAgICAgICBcImFkZF9jeWNsZVwiOiBcIjEvZFwiXG4gICAgfVxufVxuIiwiY29uc2VudE5vbmNlIjoiNXpRVk5zWktsNHdlYk1TTjVJSm95QSJ9oIIFuDCCBbQwggScoAMCAQICAwhcqTANBgkqhkiG9w0BAQsFADBVMQswCQYDVQQGEwJLUjESMBAGA1UECgwJU2lnbktvcmVhMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExGzAZBgNVBAMMElNpZ25Lb3JlYSBUZXN0IENBNTAeFw0yMTA2MDEwMDQ0MDBaFw0yMjA2MDExNDU5NTlaMIGPMQswCQYDVQQGEwJLUjESMBAGA1UECgwJU2lnbktvcmVhMRgwFgYDVQQLDA_thYzsiqTtirjsl4XsooUxGDAWBgNVBAsMD-2FjOyKpO2KuO2ajOyCrDEYMBYGA1UECwwP7YWM7Iqk7Yq47KeA7KCQMR4wHAYDVQQDDBVTaWduS29yZWFfTXlEYXRhX1VzZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCqdw16ltCD_Pa-cE0i5-M4sfcCEGJcfMN1hwRZlD-O-f0e4I_X6QAUaRoXdH-YS8paEjC1jp1cEdsUFureeeqv2x3dTo2o3gBfdHHVFZX7kdU7Xw5AefvUL08CSrBO8aGAHGcKMMX-0P-ZSp5Dj6K2V-fRSK_hiKJW950PyTISDnGuVWDd7z7x_Tc6J-r7x__ZwJIsiwP8s-5zRJWgxbPgN1GfSuCU8eHbbGABv9piFK_TWX1JH1vs92CENaG-rTw695bMhw2E91MUmLGtbyl8lJIR1tzoTsPj55ND08YvyK1YlLwKv00GPQM0fS1TjPvdjRvIaSig-WDqwA5-MDTFAgMBAAGjggJQMIICTDCBkwYDVR0jBIGLMIGIgBTxcKmvb8-di6yBhcwW9HzZhVwMxKFtpGswaTELMAkGA1UEBhMCS1IxDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IENlbnRyYWwxGzAZBgNVBAMMEktpc2EgVGVzdCBSb290Q0EgN4IBBTAdBgNVHQ4EFgQUeiIHaLHTyp0H_w-wM83GeehB-kIwDgYDVR0PAQH_BAQDAgbAMHsGA1UdIAEB_wRxMG8wbQYKKoMajJpEBQEBBTBfMC0GCCsGAQUFBwIBFiFodHRwOi8vd3d3LnNpZ25rb3JlYS5jb20vY3BzLmh0bWwwLgYIKwYBBQUHAgIwIh4gx3QAIMd4yZ3BHAAgwtzV2MapACDHeMmdwRzHhbLIsuQwdAYDVR0RBG0wa6BpBgkqgxqMmkQKAQGgXDBaDBVTaWduS29yZWFfTXlEYXRhX1VzZXIwQTA_BgoqgxqMmkQKAQEBMDEwCwYJYIZIAWUDBAIBoCIEINNlU1wkg0LVTsPBXQlxGFYiD6ntFIv3O_PMWz1bSvv0MFYGA1UdHwRPME0wS6BJoEeGRWxkYXA6Ly8yMTEuMTc1LjgxLjEwMjo2ODkvb3U9ZHAxMXAxMixvdT1BY2NyZWRpdGVkQ0Esbz1TaWduS29yZWEsYz1LUjA6BggrBgEFBQcBAQQuMCwwKgYIKwYBBQUHMAGGHmh0dHA6Ly8yMTEuMTc1LjgxLjEwMS9vY3NwLnBocDANBgkqhkiG9w0BAQsFAAOCAQEAihGQLjAnzhu_cUUvVGh5rqjo4P068-9pdZM_4w1552A6oCrw7sSTK1L9sHDLgfd_RCykx02zsuny3cEy-QyATCHQryqxXVT9sldN2JzqcZKY9I7x6rFa6-TAcORmVFslNrZsqeTMQWasLsc9s0BicnKYZnq1O7l54EP84egZYIzZmpiWK4kBfX5RyJBhxLwsZrHnd8t8WbrNeu46XGRcdpTqwzscu5-EvlbTkiLHaV_Nxa_AgpVmnZL5JsmSviiBScG68ErPSVMxdiNimw1fNiHIqPt_Z1AZQ2RB4PCGNVZbZRIExJa8p8GBV3h3ustrJcQZlJL8V9Co_XrEBIIXbjGCAfIwggHuAgEBMFwwVTELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCVNpZ25Lb3JlYTEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRswGQYDVQQDDBJTaWduS29yZWEgVGVzdCBDQTUCAwhcqTANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMTEyNDA1Mjk0NVowLwYJKoZIhvcNAQkEMSIEIFk-YZXmoHg7-sX8PxmRpqZ0IpQo5wXDkP_abK0sCJNRMA0GCSqGSIb3DQEBAQUABIIBAGdKfP4Z37Wz4ajjso1FupVkgrhuArdqSDNdw66-BlWjfex0L2TTmvXMHsG0vzdRvpM6TYA1u2so9p1OYnbVmpaGbv96OX11fler2-uWZGPs07z6PpTnj_mpf54f0cZ9qmJVSSinX-hz7HZ-MuE62R3PuDUDwmKPu-GT2lnCzdDOsrcP0a8ePbbCK5rt5lZ5_3mBT1jqTSILDMNCZszNnZnyJFOgvM1vB-dIuoSbGKmdqUfiovFeEHkm4vliaeFaZq6TRW0cFgkO43N0WPT7OZRvILGryyBCArScf3AuL1OM51rzgkG3c6smQ2BgNVSUgLMkW0M3fMlSZgJ1pzotsT4</textarea>
        </li>
        <li>
            <span>signedPersonInfoReq:</span><br/>
            <textarea name="signedPersonInfoReq">MIIIaAYJKoZIhvcNAQcCoIIIWTCCCFUCAQExDzANBglghkgBZQMEAgEFADCBjAYJKoZIhvcNAQcBoH8EfTB7AgECBBCPNpKEtM3m8xPt2_5m1nzjMC0MJ-qwnOyduOygleuztCDtmZzsmqnsl5Ag64-Z7J2Y7ZWp64uI64ukLgMCA_gwJAwRV2l6SU4tRGVsZmlubyBHMTAMB1dJWlZFUkEwBgIBCgIBAQwPd3d3LndpenZlcmEuY29toIIFuDCCBbQwggScoAMCAQICAwhcqTANBgkqhkiG9w0BAQsFADBVMQswCQYDVQQGEwJLUjESMBAGA1UECgwJU2lnbktvcmVhMRUwEwYDVQQLDAxBY2NyZWRpdGVkQ0ExGzAZBgNVBAMMElNpZ25Lb3JlYSBUZXN0IENBNTAeFw0yMTA2MDEwMDQ0MDBaFw0yMjA2MDExNDU5NTlaMIGPMQswCQYDVQQGEwJLUjESMBAGA1UECgwJU2lnbktvcmVhMRgwFgYDVQQLDA_thYzsiqTtirjsl4XsooUxGDAWBgNVBAsMD-2FjOyKpO2KuO2ajOyCrDEYMBYGA1UECwwP7YWM7Iqk7Yq47KeA7KCQMR4wHAYDVQQDDBVTaWduS29yZWFfTXlEYXRhX1VzZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCqdw16ltCD_Pa-cE0i5-M4sfcCEGJcfMN1hwRZlD-O-f0e4I_X6QAUaRoXdH-YS8paEjC1jp1cEdsUFureeeqv2x3dTo2o3gBfdHHVFZX7kdU7Xw5AefvUL08CSrBO8aGAHGcKMMX-0P-ZSp5Dj6K2V-fRSK_hiKJW950PyTISDnGuVWDd7z7x_Tc6J-r7x__ZwJIsiwP8s-5zRJWgxbPgN1GfSuCU8eHbbGABv9piFK_TWX1JH1vs92CENaG-rTw695bMhw2E91MUmLGtbyl8lJIR1tzoTsPj55ND08YvyK1YlLwKv00GPQM0fS1TjPvdjRvIaSig-WDqwA5-MDTFAgMBAAGjggJQMIICTDCBkwYDVR0jBIGLMIGIgBTxcKmvb8-di6yBhcwW9HzZhVwMxKFtpGswaTELMAkGA1UEBhMCS1IxDTALBgNVBAoMBEtJU0ExLjAsBgNVBAsMJUtvcmVhIENlcnRpZmljYXRpb24gQXV0aG9yaXR5IENlbnRyYWwxGzAZBgNVBAMMEktpc2EgVGVzdCBSb290Q0EgN4IBBTAdBgNVHQ4EFgQUeiIHaLHTyp0H_w-wM83GeehB-kIwDgYDVR0PAQH_BAQDAgbAMHsGA1UdIAEB_wRxMG8wbQYKKoMajJpEBQEBBTBfMC0GCCsGAQUFBwIBFiFodHRwOi8vd3d3LnNpZ25rb3JlYS5jb20vY3BzLmh0bWwwLgYIKwYBBQUHAgIwIh4gx3QAIMd4yZ3BHAAgwtzV2MapACDHeMmdwRzHhbLIsuQwdAYDVR0RBG0wa6BpBgkqgxqMmkQKAQGgXDBaDBVTaWduS29yZWFfTXlEYXRhX1VzZXIwQTA_BgoqgxqMmkQKAQEBMDEwCwYJYIZIAWUDBAIBoCIEINNlU1wkg0LVTsPBXQlxGFYiD6ntFIv3O_PMWz1bSvv0MFYGA1UdHwRPME0wS6BJoEeGRWxkYXA6Ly8yMTEuMTc1LjgxLjEwMjo2ODkvb3U9ZHAxMXAxMixvdT1BY2NyZWRpdGVkQ0Esbz1TaWduS29yZWEsYz1LUjA6BggrBgEFBQcBAQQuMCwwKgYIKwYBBQUHMAGGHmh0dHA6Ly8yMTEuMTc1LjgxLjEwMS9vY3NwLnBocDANBgkqhkiG9w0BAQsFAAOCAQEAihGQLjAnzhu_cUUvVGh5rqjo4P068-9pdZM_4w1552A6oCrw7sSTK1L9sHDLgfd_RCykx02zsuny3cEy-QyATCHQryqxXVT9sldN2JzqcZKY9I7x6rFa6-TAcORmVFslNrZsqeTMQWasLsc9s0BicnKYZnq1O7l54EP84egZYIzZmpiWK4kBfX5RyJBhxLwsZrHnd8t8WbrNeu46XGRcdpTqwzscu5-EvlbTkiLHaV_Nxa_AgpVmnZL5JsmSviiBScG68ErPSVMxdiNimw1fNiHIqPt_Z1AZQ2RB4PCGNVZbZRIExJa8p8GBV3h3ustrJcQZlJL8V9Co_XrEBIIXbjGCAfIwggHuAgEBMFwwVTELMAkGA1UEBhMCS1IxEjAQBgNVBAoMCVNpZ25Lb3JlYTEVMBMGA1UECwwMQWNjcmVkaXRlZENBMRswGQYDVQQDDBJTaWduS29yZWEgVGVzdCBDQTUCAwhcqTANBglghkgBZQMEAgEFAKBpMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMTEyNDA1Mjk0NVowLwYJKoZIhvcNAQkEMSIEIFU7NgWgUf3w7-B1pFcv6gsHQPXR6wTpo3usfORR_V5RMA0GCSqGSIb3DQEBAQUABIIBAHaIGjtiiAg7hsUQ6Li0f5_v-BrN2dSvYDharHEZPpgb2dQggkPA9DsjVJPsgeUUpShWlR5M4Erd9xE1znjNcmP5jUhYoJGqKvf2kTTI-HQTyFGKGCbxeV0kypxcDQElUeTQEeEVxkF8tZ3VCsST1rDGDb-tyMQTrfxR5iPVHqv2ZrdNU-HVHSvQoNpR6FWNVGsr9uToQQpq2asQHu-vu-arIAFbszrD4yrc5eqTrMHA4QLQvie-zaWClsM9eFgCk7aqsgcWEYlztKjVdIZTbNAMvf2foee5qMuLuEt-ai-vLix-OSmiVJGAAxfmxsGhngh-_mM1FgX7pcPCFrV2uyQ</textarea>
        </li>
    </ul>
</form>
</body>
</html>
