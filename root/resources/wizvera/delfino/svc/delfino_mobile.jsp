<%-- --------------------------------------------------------------------------
 - File Name   : delfino_mobile.jsp(모바일 샘플)
 - Include     : NONE
 - Author      : WIZVERA
 - Last Update : 2023/04/26
-------------------------------------------------------------------------- --%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.lang.*, java.text.*, java.net.*" %>
<%@ page import="java.security.cert.X509Certificate" %>

<%@ page import="com.wizvera.crypto.CertUtil" %>
<%@ page import="com.wizvera.service.SignVerifier" %>
<%@ page import="com.wizvera.service.SignVerifierResult" %>
<%@ page import="com.wizvera.service.DelfinoServiceException" %>
<%@ page import="org.json.JSONObject" %>
<%
    request.setCharacterEncoding("utf8");
    java.text.DateFormat logDate = new java.text.SimpleDateFormat("[yyyy/MM/dd HH:mm:ss] ");
    System.out.println(getRequestParameter(request, "\n"));
    System.out.println(logDate.format(new java.util.Date())+request.getRequestURI()+" "+request.getMethod()+"[" + request.getRemoteAddr() + "]");
    com.wizvera.WizveraConfig delfinoConfig = com.wizvera.WizveraConfig.getDefaultConfiguration();
    //com.wizvera.WizveraConfig delfinoConfig = new com.wizvera.WizveraConfig(getServletConfig().getServletContext().getRealPath("WEB-INF") + "/lib/delfinoCG.properties");
%>
<%
    String action = getParameter(request, "_action");
    if ("TEST_getLoginTbsData".equals(action) || "TEST_getAuthTbsData".equals(action)) {
        String serverTime = Long.toString(System.currentTimeMillis() / 1000L);
        session.setAttribute("delfinoServerTime", serverTime);

        StringBuffer tbsData = new StringBuffer();
        tbsData.append("login=").append(URLEncoder.encode("mobileCertLogin", "UTF-8"));
        if ("TEST_getAuthTbsData".equals(action)) {
            session.setAttribute("tbsData", tbsData.toString()); //서명원문을 세션에 저장해놓고 서명검증시 확인
            //System.out.println("\tTEST_getLoginTbsData[" + tbsData.toString() + "]");
            //tbsData.append("&__CERT_STORE_MEDIA_TYPE=").append("APP"); //서버SDK예약어(앱에서 저장매체추가)
            tbsData.append("&__DELFINO_NONCE=").append(serverTime); //서버SDK예약어(재사용방지)
        } else {
            tbsData.append("&delfinoNonce=").append(serverTime); //재사용방지(WEB모듈과 호환성 유지)
            session.setAttribute("tbsData", tbsData.toString()); //서명원문을 세션에 저장해놓고 서명검증시 확인
            //System.out.println("\tTEST_getLoginTbsData[" + tbsData.toString() + "]");
            //tbsData.append("&__CERT_STORE_MEDIA_TYPE=").append("APP"); //서버SDK예약어(앱에서 저장매체추가)
            //tbsData.append("&__DELFINO_NONCE=").append(serverTime); //서버SDK예약어(재사용방지)
        }

        //요청결과응답
        Map<String, String> resultMap = new HashMap<String, String>();
        resultMap.put("tbsData", tbsData.toString());
        resultMap.put("serverTime", serverTime);
        out.println(new JSONObject(resultMap).toString());
        System.out.println("\t" + new JSONObject(resultMap).toString());
        return;
    }
    if ("TEST_getSignTbsData".equals(action) || "TEST_getConfirmSignTbsData".equals(action) || "TEST_getMultiSignTbsData".equals(action)) {
        String serverTime = Long.toString(System.currentTimeMillis() / 1000L);
        session.setAttribute("delfinoServerTime", serverTime);

        StringBuffer tbsData = new StringBuffer();
        if ("TEST_getConfirmSignTbsData".equals(action)) {
            String formattedSignData  = " (1)거래일자: 2015.10.08\n (2)거래시간: 10:18:59\n (3)출금계좌번호: 120245101777\n (4)입금은행: 신한\n (5)입금계좌번호: 40612170477\n";
            formattedSignData += " (6)수취인성명: 홍길동\n (7)이체금액: 20,000(원)\n (8)CMS코드:  \n (9)받는통장에 표시내용:  \n (10)출금통장메모:  \n (11)중복이체여부: 해당없음 100%";
            //formattedSignData = formattedSignData.replace("\n", "\\n");
            tbsData.append(formattedSignData);
        } else {
            tbsData.append("account=").append(URLEncoder.encode("111111-22-333333", "UTF-8"));
            //tbsData.append("&recvAccount=").append(URLEncoder.encode("444444-55-666666", "UTF-8"));
            //tbsData.append("&amount=").append(URLEncoder.encode("10,000", "UTF-8"));
            tbsData.append("&recvUser=").append(URLEncoder.encode("김모군", "UTF-8"));
        }

        boolean isTest = false; //TODO: 테스트
        //isTest = true;
        if (isTest) {
            tbsData.delete(0, tbsData.length());
            for (int i=0; i<50; i++) { //100byte * i
                tbsData.append("\n" + i + ":개인정보보호법 및 관련법령에 따라 안심하고 지원하실 수 있도록 개인정보 보호에 최선을 다하고 있습니다.아래의 안내된 내용을 읽어보신 후에 동의 여부를 결정하여 주시기 바랍니다");
            }
        }

        session.setAttribute("tbsData", tbsData.toString()); //서명원문을 세션에 저장해놓고 서명검증시 확인
        //System.out.println("\tTEST_getSignTbsData[" + tbsData.toString() + "]");

        //TODO: TEST용
        //tbsData.append("&__CERT_STORE_MEDIA_TYPE=").append("APP"); //서버SDK예약어
        tbsData.append("&__DELFINO_NONCE=").append(serverTime); //서버SDK예약어(재사용방지)

        //요청결과응답
        Map<String, String> resultMap = new HashMap<String, String>();
        resultMap.put("tbsData", tbsData.toString());
        resultMap.put("serverTime", serverTime);

        //다중서명에 대한 서명원문 추가
        if ("TEST_getMultiSignTbsData".equals(action)) {
            resultMap.put("tbsData2", "두번째 다중서명 '대출계약서' 입니다."); //title2: 대출계약서
            resultMap.put("tbsData3", "세번째 다중서명 '출금이체동의서' 입니다."); //titls3: 출금이체동의서
            resultMap.put("title", "전자서명");
            resultMap.put("title2", "대출계약서");
            resultMap.put("title3", "출금이체동의서");
        }

        out.println(new JSONObject(resultMap).toString());
        System.out.println("\t" + new JSONObject(resultMap).toString() + "\n\ttbsData.length: " + tbsData.length());

        return;
    }
    if ("TEST_getMdSignData".equals(action) || "TEST_getMdMultiSignTbsData".equals(action)) {
        String serverTime = Long.toString(System.currentTimeMillis() / 1000L);
        session.setAttribute("delfinoServerTime", serverTime);

        StringBuffer tbsData = new StringBuffer();
        tbsData.append("PDF원문내용입니다");
        tbsData.append("&__DELFINO_NONCE=").append(serverTime); //서버SDK예약어(재사용방지)
        String detachedMD = ""; //"b0e5036fdb1f65006449b245fc46986945fc64433a3d709074f9160480f1a1b7";
        try  {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("SHA-256", new com.wizvera.provider.jce.provider.WizveraProvider());
            md.update(tbsData.toString().getBytes("UTF-8"));
            detachedMD = com.wizvera.util.Hex.encode(md.digest());
        } catch (Exception  e) {
            e.printStackTrace();
        }
        session.setAttribute("tbsData", tbsData.toString()); //서명원문을 세션에 저장해놓고 서명검증시 확인
        session.setAttribute("detachedMD", detachedMD); //PDF해쉬값을 세션에 저장해놓고 서명검증 후 비교확인

        //요청결과응답
        Map<String, String> resultMap = new HashMap<String, String>();
        resultMap.put("detachedMD", detachedMD);
        resultMap.put("serverTime", serverTime);

        //PDF다중서명에 대한 서명원문 추가
        if ("TEST_getMdMultiSignTbsData".equals(action)) {
            String detachedMD2 = "b0e5036fdb1f65006449b245fc46986945fc64433a3d709074f9160480f1a1b7";
            String detachedMD3 = "51c2e60151f5c8b94dbd9d0e7b654c0d9fa57ad97893a223e5ffce1126f6897a";
            resultMap.put("detachedMD2", detachedMD2);
            resultMap.put("detachedMD3", detachedMD3);
            session.setAttribute("detachedMDs", detachedMD + "," + detachedMD2 + "," + detachedMD3); //PDF해쉬값을 세션에 저장해놓고 서명검증 후 비교확인
            resultMap.put("title", "PDF서명1");
            resultMap.put("title2", "PDF서명 두번째");
            resultMap.put("title3", "PDF서명 세번쩨");
        }

        out.println(new JSONObject(resultMap).toString());
        System.out.println("\t" + new JSONObject(resultMap).toString());
        return;
    }
    out.println("" + request.getRequestURI()+" "+request.getMethod()+"[" + request.getRemoteAddr() + "][" + (String)session.getAttribute("delfinoServerTime") +"]<br/><hr/>");
    if ("TEST_TEST".equals(action)) return;
%>
<%
    /**************************************************************
     * 인증서 유효성 검증 타입설정 샘플
     - SignVerifier.CERT_STATUS_CHECK_TYPE_NONE: 유효성검증안함
     - SignVerifier.CERT_STATUS_CHECK_TYPE_CRL:  CRL을 이용한 유효성 확인
     - SignVerifier.CERT_STATUS_CHECK_TYPE_OCSP: OCSP를 이용한 유효성 확인(delfino.propertie에서 OCSP키값 및 서버 설정필요)
     ***************************************************************/
    String certStatusCheckStr = getParameter(request, "certStatusCheckType");
    int certStatusCheckType = SignVerifier.CERT_STATUS_CHECK_TYPE_NONE;
    {
        if ("OCSP".equals(certStatusCheckStr)) {
            certStatusCheckType = SignVerifier.CERT_STATUS_CHECK_TYPE_OCSP;
        } else if ("CRL".equals(certStatusCheckStr)) {
            certStatusCheckType = SignVerifier.CERT_STATUS_CHECK_TYPE_CRL;
        } else {
            certStatusCheckType = SignVerifier.CERT_STATUS_CHECK_TYPE_NONE;
        }
    }
    String pkcs7 = getParameter(request, SignVerifier.PKCS7_NAME);
    String vidRandom = getParameter(request, SignVerifier.VID_RANDOM_NAME);
    boolean isDetachedMD = false; //PDF서명여부
%>
<%
    out.println("<b>전자서명결과</b> [" + action + "]");
    SignVerifier signVerifier = new SignVerifier(delfinoConfig); //서명검증 객체
    SignVerifierResult signVerifierResult = null; //서명검증 결과
    try {
        //1. PKCS7 서명검증 및 유효성 검증: 은행의 경우 별도의 RA를 통해서 유효성 검증해야함
        if ("TEST_mobileLogin".equals(action) || "TEST_mobileAuth".equals(action) || "TEST_mobileSign".equals(action)) {
            String sessionNonce = (String)session.getAttribute("delfinoServerTime");
            //session.removeAttribute("delfinoServerTime"); //TODO: 반드시 삭제해야함(아래 테스트용으로 인해 삭제안함)
            signVerifierResult = signVerifier.verifyPKCS7WithNonce(pkcs7, sessionNonce, certStatusCheckType);
            out.println("<br/>(1) signVerifier.verifyWithNonce: <b>OK</b>" + ("".equals(certStatusCheckStr) ? "" : ": 유효성검증["+certStatusCheckStr+"]"));
        } else if ("TEST_mobileMultiSign".equals(action)) {
            if (com.wizvera.service.FintechSignVerifier.isFintechMultiSignResult(pkcs7)) {
                com.wizvera.service.FintechSignVerifier fintechSignVerifier = new com.wizvera.service.FintechSignVerifier();
                com.wizvera.service.SignVerifierResult[] multiSignVerifierResult = fintechSignVerifier.verifyPKCS(pkcs7);
                out.println("<br/>(1) fintechSignVerifier.verifyPKCS: <b>OK</b>");
                for (int k=0; k<multiSignVerifierResult.length; k++) {
                    signVerifierResult = multiSignVerifierResult[k];
                    out.println("<br/><textarea style='width:345px;height:66px;'>서명원문." + (k+1) + "[" + multiSignVerifierResult[k].getSignedRawData() + "]</textarea>");
                }
                signVerifierResult = multiSignVerifierResult[0]; //TODO: 첫번째 서명만 세부적으로 확인, 나머지 서명문도 확인 필요
            } else {
                String SIGN_Delimeter = getParameter(request, "SIGN_Delimeter");
                if (SIGN_Delimeter.equals("")) SIGN_Delimeter = "|"; //"￡";
                if ("|".equals(SIGN_Delimeter)) SIGN_Delimeter = "\\" + SIGN_Delimeter;
                String[] pkcs7Array = pkcs7.split(SIGN_Delimeter);
                SignVerifierResult[] multiSignVerifierResult = new SignVerifierResult[pkcs7Array.length];
                for(int k=0; k<pkcs7Array.length; k++) {
                    pkcs7 = pkcs7Array[k];
                    multiSignVerifierResult[k] = signVerifier.verifyPKCS7(pkcs7, certStatusCheckType);
                    out.println("<br/><textarea style='width:345px;height:66px;'>서명원문." + (k+1) + "[" + multiSignVerifierResult[k].getSignedRawData() + "]</textarea>");
                }
                signVerifierResult = multiSignVerifierResult[0]; //TODO: 첫번째 서명만 세부적으로 확인, 나머지 서명문도 확인 필요
            }
        } else if ("TEST_mobileMdSign".equals(action)) {
            isDetachedMD = true;
            com.wizvera.service.DetachedSignVerifier detachedSignVerifier = new com.wizvera.service.DetachedSignVerifier(delfinoConfig);
            signVerifierResult = detachedSignVerifier.verifyPKCS7(pkcs7, certStatusCheckType);
            out.println("<br/>(1) detachedVerifier.verifyPKCS7: <b>OK</b>" + ("".equals(certStatusCheckStr) ? "" : ": 유효성검증["+certStatusCheckStr+"]"));

            //mdSign은 세션에 저장된 detachedMD 비교
            String detachedMD = (String)session.getAttribute("detachedMD");
            Map<String, byte[]> messageDigestMap = signVerifierResult.getMessageDigestMap();
            for(String key : messageDigestMap.keySet()) {
                String strValue = com.wizvera.util.Hex.encode(messageDigestMap.get(key));
                if (strValue.equals(detachedMD)) {
                    out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; detachedMD Check: <b>OK</b>");
                } else {
                    out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; detachedMD Check: <b><span style='color:red'>FAIL</span></b>: [" + key + "][" + detachedMD + "][" + strValue + "]");
                }
            }

            //TODO: 테스트를 위해 서명문을 포함하여 재 검증
            if (signVerifierResult.getProvider() == null) {
                String tbsData = (String)session.getAttribute("tbsData");
                SignVerifierResult signVerifierResult2 = detachedSignVerifier.verifyPKCS7(signVerifierResult.getPKCS7SignedData(), tbsData.getBytes("UTF-8"), certStatusCheckType);
            }
        } else if ("TEST_mobileMdMultiSign".equals(action)) {
            isDetachedMD = true;
            String imsi = (String)session.getAttribute("detachedMDs");
            if (imsi == null) imsi = "";
            String[] session_mdMultiSignData = imsi.split(","); //PDF서명요청한 Hash값

            if (com.wizvera.service.FintechSignVerifier.isFintechMultiSignResult(pkcs7)) {
                com.wizvera.service.FintechSignVerifier fintechSignVerifier = new com.wizvera.service.FintechSignVerifier();
                com.wizvera.service.SignVerifierResult[] multiSignVerifierResult = fintechSignVerifier.verifyPKCS(pkcs7);
                out.println("<br/>(1) fintechSignVerifier.verifyPKCS: <b>OK</b>");
                for (int k=0; k<multiSignVerifierResult.length; k++) {
                    String session_mdSignData = (session_mdMultiSignData.length>k) ? session_mdMultiSignData[k] : "";
                    Map<String, byte[]> messageDigestMap = multiSignVerifierResult[k].getMessageDigestMap();
                    for(String key : messageDigestMap.keySet()) {
                        String strValue = com.wizvera.util.Hex.encode(messageDigestMap.get(key));
                        if (strValue.equals(session_mdSignData)) {
                            out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; detachedMD Check[" + k + "]: <b>OK</b>");
                        } else {
                            out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; detachedMD Check[" + k + "]: <b><span style='color:red'>FAIL</span></b>: [" + key + "][" + session_mdSignData + "][" + strValue + "]");
                        }
                    }
                }
                signVerifierResult = multiSignVerifierResult[0]; //TODO: 첫번째 서명만 세부적으로 확인, 나머지 서명문도 확인 필요
            } else {
                String SIGN_Delimeter = getParameter(request, "SIGN_Delimeter");
                if (SIGN_Delimeter.equals("")) SIGN_Delimeter = "|"; //"￡";
                if ("|".equals(SIGN_Delimeter)) SIGN_Delimeter = "\\" + SIGN_Delimeter;
                String[] pkcs7Array = pkcs7.split(SIGN_Delimeter);
                SignVerifierResult[] multiSignVerifierResult = new SignVerifierResult[pkcs7Array.length];
                for(int k=0; k<pkcs7Array.length; k++) {
                    pkcs7 = pkcs7Array[k];
                    multiSignVerifierResult[k] = signVerifier.verifyPKCS7(pkcs7, certStatusCheckType);
                    out.println("<br/>(1." + k + ") detachedSignVerifier.verifyPKCS7: <b>OK</b>");

                    String session_mdSignData = (session_mdMultiSignData.length>k) ? session_mdMultiSignData[k] : "";
                    Map<String, byte[]> messageDigestMap = multiSignVerifierResult[k].getMessageDigestMap();
                    for(String key : messageDigestMap.keySet()) {
                        String strValue = com.wizvera.util.Hex.encode(messageDigestMap.get(key));
                        if (strValue.equals(session_mdSignData)) {
                            out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; detachedMD Check[" + k + "]: <b>OK</b>");
                        } else {
                            out.println("<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; detachedMD Check[" + k + "]: <b><span style='color:red'>FAIL</span></b>: [" + key + "][" + session_mdSignData + "][" + strValue + "]");
                        }
                    }
                }
                signVerifierResult = multiSignVerifierResult[0]; //TODO: 첫번째 서명만 세부적으로 확인, 나머지 서명문도 확인 필요
            }
        } else {
            signVerifierResult = signVerifier.verifyPKCS7(pkcs7, certStatusCheckType);
            out.println("<br/>(1) signVerifier.verifyPKCS7: <b>OK</b>" + ("".equals(certStatusCheckStr) ? "" : ": 유효성검증["+certStatusCheckStr+"]"));
        }

        //사설인증서구분
        String provider = signVerifierResult.getProvider();
        boolean isPrivateCert = true; //사설인증서여부
        if (provider == null) {
            provider = "pubCert"; //NPKI,GPKI,FinCert,FinCertCorp
            isPrivateCert = false;
        }

        //사설인증서 일경우 테스트용
        if (isPrivateCert) {
            Map<String, Object> resultMap = signVerifierResult.getProviderRawResponse();
            //out.println("<br/>-. 서명결과요청[" + pkcs7 + "]");
            //out.println("<!-- <br/>-. 서명결과응답[" + resultMap.toString() + "] -->");
            System.out.println(" # 서명결과요청 [" + pkcs7 + "]");
            System.out.println(" # 서명결과응답 [" + resultMap.toString() + "]");
        }

        //2. 핀테크인증서일경우 saveTxInfo: 내부테스용입니다.
        String vpcgMode = delfinoConfig.getVpcgMode();
        String vpcgResultUrl = delfinoConfig.getVpcgResultUrl();
        if (isPrivateCert && !("agent".equals(vpcgMode) && vpcgResultUrl.indexOf(".certgate.io")>0)) {
            String userId = "TEST_" + signVerifierResult.getSignType() + "_" + signVerifierResult.getProvider();
            if (signVerifierResult.getSignerCertificate() != null) userId = "CN_" + CertUtil.getSubjectEntry(signVerifierResult.getSignerCertificate(), CertUtil.NAME_CN, 0);
            boolean isSaveTxInfo = signVerifierResult.saveTxInfo(userId, "action_" + action);
            out.println("<br/>(2) signVerifierResult.saveTxInfo: <b>" + (isSaveTxInfo?"":"<span style='color:red'>") + isSaveTxInfo + (isSaveTxInfo?"":"</span>") + "</b>");
            if (!isSaveTxInfo) System.out.println(" # signVerifierResult.saveTxInfo: " + isSaveTxInfo + ": " + provider);
        } else {
            out.println("<br/>(2) signVerifierResult.saveTxInfo: <b>SKIP</b>");
        }

        //3. 재 사용방지를 위해서 nonce검증(G10의 경우 서명시간 설정 방법 몰라서 DelfinoNonce체크로)
        if (isDetachedMD) {
            out.println("<br/>(3) checkNonce...: <b>SKIP.PDF서명</b>");
        } else if (isPrivateCert || "G10".equals(getParameter(request, "_delfino"))) {
            if ("kakao".equals(provider) && ("LOGIN".equals(signVerifierResult.getSignType())||"AUTH".equals(signVerifierResult.getSignType()))) {
                out.println("<br/>(3) checkNonce.DelfnoNonce: <b><span style='color:red'>미지원</span></b>: " + provider); //카카오인증(LGOIN,AUTH)는 서명문변경불가
            } else if ("naver2".equals(provider) && ("LOGIN".equals(signVerifierResult.getSignType())||"AUTH".equals(signVerifierResult.getSignType())||"AUTH2".equals(signVerifierResult.getSignType()))) {
                out.println("<br/>(3) checkNonce.DelfnoNonce: <b><span style='color:red'>미지원</span></b>: " + provider); //네이버인증v3(LGOIN,AUTH,AUTH2)는 '본인인증'으로 서명문고정
            } else {
                String delfinoNonce = signVerifierResult.getDelfinoNonce();
                if ("TEST_mobileLogin".equals(action)) delfinoNonce = signVerifierResult.getSignedParameter("delfinoNonce"); //__DELFINO_NONCE 설정안함
                String sessionNonce = (String)session.getAttribute("delfinoServerTime");
                session.removeAttribute("delfinoServerTime"); //TODO: 반드시 삭제해야함
                if (sessionNonce == null || "".equals(sessionNonce)) {
                    out.println("<br/>(3) checkNonce.DelfnoNonce: <b><span style='color:red'>FAIL</style></b>: 세션정보없음");
                    //TODO: 에러처리하세요.
                } else if (!sessionNonce.equals(delfinoNonce)) {
                    String message = "signed data's delfinoNonce[" + delfinoNonce + "] is differentor with sessionNonce[" + sessionNonce + "]";
                    out.println("<br/>(3) checkNonce.DelfnoNonce: <b><span style='color:red'>FAIL</style></b>: 불일치[" + sessionNonce + "][" + delfinoNonce + "]");
                    System.out.println(" # checkNonce.DelfnoNonce: FAIL: 불일치[" + sessionNonce + "][" + delfinoNonce + "]\n\t" + message);
                    //TODO: 에러처리하세요.
                } else {
                    out.println("<br/>(3) checkNonce.DelfnoNonce: <b>OK</b>: " + delfinoNonce);
                }
            }
        } else {
            //공인인증서: 서명시간을 이용한 nonce검증
            String pkcsTimeStr = signVerifierResult.getSignerInfoResults().get(0).getSigningTimeInLocalTime();
            String signing_Time = Long.toString(new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(pkcsTimeStr).getTime()/1000L);
            String session_Time = (String)session.getAttribute("delfinoServerTime");
            session.removeAttribute("delfinoServerTime"); //TODO: 반드시 삭제해야함

            if (session_Time == null || "".equals(session_Time)) {
                out.println("<br/>(3) checkNonce.SigningTime: <b><span style='color:red'>FAIL</style>: 세션정보없음</b>");
                //TODO: 에러처리하세요.
            } else if (!session_Time.equals(signing_Time)) {
                String message = "signed data's signing_Time[" + pkcsTimeStr + "][" + signing_Time + "] is differentor with session_Time[" + session_Time + "]";
                out.println("<br/>(3) <b>checkNonce.SigningTime: <span style='color:red'>FAIL</style></b>: 불일치[" + session_Time + "][" + signing_Time + "]");
                System.out.println(" # checkNonce.SigningTime: FAIL: 불일치" + session_Time + "][" + signing_Time + "]\n\t" + message);
                //TODO: 에러처리하세요.
            } else {
                out.println("<br/>(3) checkNonce.SigningTime: <b>OK</b>: " + signing_Time);
            }
        }

        //4.인증서 소유자 확인
        boolean verifyIdentity = false;
        if ("TEST_registerCert".equals(action)) verifyIdentity = true;
        verifyIdentity = true; //TODO: check
        if (verifyIdentity) {
            boolean verifyUser = false;
            if (signVerifierResult.isVerifiableVid()) { //Vid를 이용한 본인확인 가능
                String idn = getParameter(request, "IDN"); //주민등록번호
                if (!"".equals(idn)) {
                    verifyUser = signVerifierResult.verifyVid(idn, vidRandom); //금융인증서의 경우 vidRandom은 null or "" 로 입력
                    out.println("<br/>(4) signVerifierResult.verifyVid: <b>" + (verifyUser?"":"<span style='color:red'>") + verifyUser + (verifyUser?"":"</span>") + "</b>");
                    if (!verifyUser) System.out.println(" # signVerifierResult.verifyVid: " + verifyUser + ": " + idn);
                } else {
                    out.println("<br/>(4) signVerifierResult.verifyVid: <b><span style='color:red'>SKIP</span></b>");
                }
            }
            else if (signVerifierResult.isVerifiableCi()) { //CI를 이용한 본인확인 가능
                String ci = getParameter(request, "CI"); //CI번호
                //if ("".equals(ci)) ci = "CI01035201278010352012780103520127801035201278010352012780103520127801035201278010352012";
                if (!"".equals(ci)) {
                    verifyUser = signVerifierResult.verifyCi(ci);
                    out.println("<br/>(4) signVerifierResult.verifyCI: <b>" + (verifyUser?"":"<span style='color:red'>") + verifyUser + (verifyUser?"":"</span>") + "</b>");
                    if (!verifyUser) System.out.println(" # signVerifierResult.verifyCi: " + verifyUser + ": " + ci);
                } else {
                    out.println("<br/>(4) signVerifierResult.verifyCi: <b><span style='color:red'>SKIP</span></b>");
                }
            }
            else if ("toss".equals(signVerifierResult.getProvider()) && "LOGIN".equals(signVerifierResult.getSignType())) {
                //TODO: TOSSS일경우 LOGIN은 CI검증 기능을 제공하지 않음
                out.println("<br/>(4) signVerifierResult.verifyCi: <b><span style='color:red'>미지원</span></b>: " + provider);
            }
            else { //본인확인 불가
                out.println("<br/>(4) signVerifierResult.verifyVid(Ci): <b><span style='color:red'>undefined</span></b>");
                System.out.println(" # signVerifierResult.verifyVid(Ci): undefined");
            }
            //if (!verifyUser) throw new DelfinoServiceException(new com.wizvera.crypto.CryptoException(1701, "is not valid VID or CI")); //TODO: 에러처리하세요
        } else {
            out.println("<br/>(4) signVerifierResult.verifyVid: <b><span style='color:red'>SKIP</span></b>");
        }


        //핀테크인증 개인정보확인(CI or service_user_id)
        if (isPrivateCert) {
            String displayUserInfo = "NONE";
            System.out.println(" # getTxid [" + signVerifierResult.getTxId() + "]");
            System.out.println(" # getCi [" + signVerifierResult.getCi() + "]");

            displayUserInfo = signVerifierResult.getCi();
            if (displayUserInfo != null && displayUserInfo.length() == 88) displayUserInfo = displayUserInfo.substring(0,8) + "...";

            //카카오 콜백사용시 service_user_id 가져오기
            if ("kakao".equals(provider) && "LOGIN".equals(signVerifierResult.getSignType())) {
                String service_user_id = String.valueOf(signVerifierResult.getProviderRawResponse().get("service_user_id"));
                System.out.println(" # service_user_id [" + service_user_id +"]");
                //TODO: 카카오 콜백에서 DB에 저장된 사용자매핑정보를  service_user_id를 이용하여 가져오기

                displayUserInfo = service_user_id;
            }
            out.println(": " + displayUserInfo);

            //CI검증이 불가능할경우 세션에 저장된 서명요청정보(이름,생년월일,전화번호) 검증
            if (isPrivateCert) {
                String userName = (String)session.getAttribute("request_userName");
                String userBirthday =  (String)session.getAttribute("request_userBirthday");
                String userPhone =  (String)session.getAttribute("request_userPhone");

                //TODO: 테스트를 위해 request로 받아서 처리
                if (userName == null) userName = request.getParameter("userName");
                if (userBirthday == null) userBirthday = request.getParameter("userBirthday");
                if (userPhone == null) userPhone = request.getParameter("userPhone");

                boolean verifyRi = signVerifierResult.verifyRi(userName, userBirthday, userPhone);
                if (!verifyRi) out.println("<br/> - verifyRi: <b><span style='color:red'>" + verifyRi + "</span></b> [" + userName + "," + userBirthday + "," + userPhone + "]");
                System.out.println(" # verifyRi: " + verifyRi + " [" + userName + "," + userBirthday + "," + userPhone + "]");
            }
        }

        //5. 세션에 저장된 서명원문 비교
        if (isDetachedMD) {
            out.println("<br/>(5) 전자서명데이터원본확인: <b>SKIP.PDF</b>");
        } else {
            String signed_TbsData = signVerifierResult.getOriginSignedRawData();
            String session_TbsData = (String)session.getAttribute("tbsData");
            session.removeAttribute("tbsData"); //TODO: 반드시 삭제해야함

            //System.out.println("\tsession_TbsData[" + session_TbsData + "]");
            //System.out.println("\tsigned_TbsData [" + signed_TbsData + "]");
            //System.out.println("\tsigned_RawData [" + signVerifierResult.getSignedRawData() + "]");

            if (session_TbsData == null || "".equals(session_TbsData)) {
                out.println("<br/>(5) 전자서명데이터원본확인: <b><span style='color:red'>FAIL</style></b>: 세션정보없음");
                //TODO: 에러처리하세요.
            } else if ("kakao".equals(provider) && ("LOGIN".equals(signVerifierResult.getSignType())||"AUTH".equals(signVerifierResult.getSignType()))) {
                 //TODO: 카카오인증(LGOIN,AUTH)는 서명문변경불가
                out.println("<br/>(5) 전자서명데이터원본확인: <b><span style='color:red'>미지원</span></b>: " + provider);
            } else if (("kakaotalk".equals(provider) || "hanaonesign".equals(provider) || "dream".equals(provider)) && "SAUTH".equals(signVerifierResult.getSignType())) {
                //TODO: 카카오톡/하나원사인/드림인증 본인확인(SAUTH)는 서명문사이즈40Byt로 제한되어 nonce만 처리
                out.println("<br/>(5) 전자서명데이터원본확인: <b><span style='color:red'>미지원</span></b>: " + provider + ": nonce[" + signed_TbsData + "]");
            } else if ("naver2".equals(provider) && ("LOGIN".equals(signVerifierResult.getSignType())||"AUTH".equals(signVerifierResult.getSignType())||"AUTH2".equals(signVerifierResult.getSignType()))) {
                 //TODO: 카카오인증(LGOIN,AUTH)는 서명문변경불가
                out.println("<br/>(5) 전자서명데이터원본확인: <b><span style='color:red'>미지원</span></b>: " + provider + ": 본인인증[" + signed_TbsData + "]");
            } else if (!session_TbsData.equals(signed_TbsData)) {
                out.println("<br/>(5) 전자서명데이터원본확인: <b><span style='color:red'>FAIL</style></b>: 불일치[" + session_TbsData + "][" + signed_TbsData + "]");
                System.out.println(" # 전자서명데이터원본확인: FAIL: 불일치[" + session_TbsData + "][" + signed_TbsData + "]");
                //TODO: 에러처리하세요.
            } else {
                out.println("<br/>(5) 전자서명데이터원본확인: <b>OK</b>");
            }
        }
        if ("TEST_certSign".equals(action) || "TEST_mobileSign".equals(action)) out.println("<br/>-. 필요시 업무에 따라 로그인 인증서와 동일여부 확인이 필요합니다.");
        out.println("<br/><hr/>");


        /**************************************************************
        * 전자서명 데이타 확인
        - getOriginSignedRawData(): 전자서명원문데이터
        - getSignedParameter(name): 포맷전자서명시 name에 해당하는 데이터
        ***************************************************************/
        //TODO: PKCS7(전자서명문) 미제공
        if (signVerifierResult.getSignerCertificate() == null && "SAUTH".equals(signVerifierResult.getSignType())) {
            if ("kakaotalk".equals(provider) || "hanaonesign".equals(provider) || "dream".equals(provider)) {
                out.println("<b><span style='color:red; font-size: small;'>카카오톡,하나원사인,드림인증은 SAUTH에서 PKCS7(전자서명문)을 제공하지 않습니다.</span></b>");
                out.println("<br/>-. signType[" + signVerifierResult.getSignType() + "] provider[" + signVerifierResult.getProvider() + "] mediaType[" + signVerifierResult.getCertStoreMediaType() + "]");
                out.println("<br/>-. orgRawData[" + signVerifierResult.getOriginSignedRawData() + "] rawData[" + signVerifierResult.getSignedRawData() + "]");
                return;
            } else {
                out.println("<b><span style='color:red; font-size: small;'>PKCS7(전자서명문)이 없습니다. 서명결과응답을 확인하세요.</span></b>");
                Map<String, Object> resultMap = signVerifierResult.getProviderRawResponse();
                out.println("<br/>-. 서명결과응답 <span style='font-size: small;'>[" + resultMap.toString() + "]</span>");
                return;
            }
        }

        String signingTime = signVerifierResult.getSignerInfoResults().get(0).getSigningTimeInLocalTime();
        if (isPrivateCert && signingTime == null) {
            Long completedAt = signVerifierResult.getCompltedAt();
            try {
                if (completedAt != null) signingTime = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(completedAt));
            } catch (Exception e) {
                System.out.println(" # signVerifierResult.getCompltedAt: FAIL: " + completedAt + ": " + e.getMessage());
            }
        }
        if (isDetachedMD) {
            out.println("<b>전자서명데이타</b> [PDF서명은 서명원문이 없어 확인 불가][" + signingTime + "]");
        } else {
            out.println("<b>전자서명데이타</b> [" + signVerifierResult.getCertStoreMediaType() + "][" + signingTime + "]");
            //out.println("<b>전자서명데이타</b> [" + signVerifierResult.getCertStoreMediaType() + "][" + signVerifierResult.getSignType() + "][" + signingTime + "]");
            out.println("<font size='2'>");
            if (isPrivateCert) {
                out.println("<br/>-. signVerifierResult.completedAt: " + signVerifierResult.getCompltedAt());
                out.println("<br/>-. signVerifierResult.signingTime: " + signVerifierResult.getSignerInfoResults().get(0).getSigningTimeInLocalTime());
            }
            out.println("<br/><textarea style='width:345px;height:66px;'>[" + signVerifierResult.getSignedRawData() + "]</textarea>");
            out.println("<br/><textarea style='width:345px;height:66px;'>[" + signVerifierResult.getOriginSignedRawData() + "]</textarea>");
            if ("TEST_certSign".equals(action) || "TEST_mobileSign".equals(action)) {
                out.println("<br/>- account     [" + signVerifierResult.getSignedParameter("account")     + "]");
                //out.println("<br/>- amount      [" + signVerifierResult.getSignedParameter("amount")      + "]");
                out.println("<br/>- recvUser    [" + signVerifierResult.getSignedParameter("recvUser")    + "]");
            }
            out.println("</font>");
        }
        out.println("<br/><hr/>");


        /**************************************************************
        * 인증서 정보 확인
        ***************************************************************/
        X509Certificate userCert = signVerifierResult.getSignerCertificate(); //사용자인증서(BC);
        String subjectDN = CertUtil.getSubjectDN(userCert,true,true); //인증서 발급주체 DN정보(인증서,소문자,역순): 고객사별로 확인필요: INITECH호환(새마을금고)
        String certSerial = CertUtil.getSerialDecimal(userCert); //인증서시리얼(10진수)
        String certBefore = new java.text.SimpleDateFormat("yyyy-MM-dd").format(userCert.getNotBefore()); //인증서유효기간:시작일
        String certAfter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(userCert.getNotAfter());   //인증서유효기간:종료일

        out.println("<b>인증서 정보</b> [" + ((isPrivateCert) ? "사설" : "공인") + "] [" + provider + "]");
        out.println("<br/>- 유효기간 [" + certBefore + " ~ " + certAfter + "]");
        out.println("<br/>- 일련번호 [" + certSerial + "]");
        out.println("<br/>- 발급주체 [" + subjectDN + "]");

        if (!isDetachedMD) {
            out.println("<!--\n[pkcs7SignedData.dump]\n" + com.wizvera.crypto.PKCS7Dump.dumpAsString(signVerifierResult.getPKCS7SignedData()) + "\n-->\n");
            System.out.println(" # pkcs7SignedData.dump\n" + com.wizvera.crypto.PKCS7Dump.dumpAsString(signVerifierResult.getPKCS7SignedData()));
        }

    } catch(DelfinoServiceException e) {
        e.printStackTrace();
        out.println("<br/><hr/><b>DelfinoServiceException - ERR(?)</b>");
        out.println("<br/>getServletPath: " + request.getServletPath() + "?action=" + action);
        out.println("<br/>getMessage: " + e.getMessage());
        out.println("<br/>getErrorCode: " + e.getErrorCode());
        out.println("<br/>getErrorUserMessage(kr): " + e.getErrorUserMessage());
        out.println("<br/>getErrorUserMessage(en): " + e.getErrorUserMessage(com.wizvera.service.util.ErrorConvert.LOCALE_EN));
        if (e.getVpcgProviderErrorInfo() != null) {
            com.wizvera.service.VpcgProviderErrorInfo vpcgError = e.getVpcgProviderErrorInfo();
            out.println("<br/>vpcgProviderError: " + vpcgError.getErrorMessage() + "[" + vpcgError.getErrorCode() + "][" + vpcgError.getProvider() + "]");
        }

        java.io.StringWriter sw = new java.io.StringWriter();
        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
        e.printStackTrace(pw);
        out.println("<br><br><b>printStackTrace</b><br>");
        out.println("<font size='2'>" + sw.toString() + "<font>");

        String pkcs7SignedData = e.getPKCS7SignedData(); //PKCS7 데이타 오류 확인을 위해 로그 저장 필요
        if (pkcs7SignedData != null) {
            out.println("<!--\n[pkcs7SignedData]\n" + pkcs7SignedData + "\n-->\n");
            System.out.println(" # pkcs7SignedData\n" + pkcs7SignedData);
            if (!isDetachedMD) {
                out.println("<!--\n[pkcs7SignedData.dump]\n" + com.wizvera.crypto.PKCS7Dump.dumpAsString(pkcs7SignedData) + "\n-->\n");
                System.out.println(" # pkcs7SignedData.dump\n" + com.wizvera.crypto.PKCS7Dump.dumpAsString(pkcs7SignedData));
            }
        } else {
            out.println("<!--\n[pkcs7]\n" + pkcs7 + "\n-->\n");
            System.out.println(" # pkcs7\n" + pkcs7);
            if (!isDetachedMD) {
                out.println("<!--\n[pkcs7.dump]\n" + com.wizvera.crypto.PKCS7Dump.dumpAsString(pkcs7) + "\n-->\n");
                System.out.println(" # pkcs7.dump\n" + com.wizvera.crypto.PKCS7Dump.dumpAsString(pkcs7));
            }
        }
        System.out.println(" # getMessage: " + e.getMessage());
        System.out.println(" # getErrorUserMessage: " + e.getErrorUserMessage());
    } catch(Exception e) {
        e.printStackTrace();
        out.println("<br/><hr/><b>Exception - ERR(?)</b>");
        out.println("<br/>FileName: " + request.getServletPath());
        out.println("<br/>getMessage: " + e.getMessage());
        java.io.StringWriter sw = new java.io.StringWriter();
        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
        e.printStackTrace(pw);
        out.println("<br><br><b>printStackTrace</b><br>");
        out.println("<font size='2'>" + sw.toString() + "<font>");
    }
%>
<%!
    public static String cleanXSS(String value) {
        String sValid = value;
        if (sValid == null || sValid.equals("")) return sValid;
        sValid = sValid.replaceAll("&", "&amp;");
        sValid = sValid.replaceAll("<", "&lt;");
        sValid = sValid.replaceAll(">", "&gt;");
        //sValid = sValid.replaceAll("\"", "&qout;");
        sValid = sValid.replaceAll("\'", "&#039;");
        sValid = sValid.replaceAll("\\r", "");
        sValid = sValid.replaceAll("\\n", "");
        return sValid;
    }
    public static String getParameter(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        if (value == null) value = "";
        return cleanXSS(value);
    }
    public static String getRequestParameter(HttpServletRequest request, String tag) {
        StringBuffer sb = new StringBuffer();
        java.util.Enumeration he3 = request.getParameterNames();
        sb.append(tag); //request.getContextPath() + request.getServletPath();
        sb.append("###########################################################################" + tag);
        sb.append("#" + request.getRequestURI() + " " + request.getMethod() + "][" + request.getRemoteAddr() + "]" + tag);
        //request.getContextPath() + request.getServletPath()

        while (he3.hasMoreElements()) {
            String name = (String)he3.nextElement();
            String[] value = request.getParameterValues(name);
            if (value == null) {
                sb.append("#   [" + name + "] = [null]" + tag);
            } else {
                for (int i=0; i<value.length; i++) {
                    sb.append("#   [" + name + "] = [" + cleanXSS(value[i]) + "]" + tag);
                }
            }
        }
        sb.append("###########################################################################");
        return sb.toString();
    }
%>
