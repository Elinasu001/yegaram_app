<%-- --------------------------------------------------------------------------
 - File Name   : signResultVpcg.jsp(통합인증 전자서명 샘플)
 - Include     : NONE
 - Author      : WIZVERA
 - Last Update : 2023/04/26
-------------------------------------------------------------------------- --%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.lang.*, java.text.*, java.net.*" %>
<%@ page import="java.security.cert.X509Certificate" %>
<%@ page import="java.security.NoSuchProviderException" %>
<%@ page import="java.security.cert.CertificateException" %>

<%@ page import="com.wizvera.crypto.CertUtil" %>
<%@ page import="com.wizvera.service.SignVerifier" %>
<%@ page import="com.wizvera.service.SignVerifierResult" %>
<%@ page import="com.wizvera.service.DelfinoServiceException" %>
<%
    request.setCharacterEncoding("utf8");
    java.text.DateFormat logDate = new java.text.SimpleDateFormat("[yyyy/MM/dd HH:mm:ss] ");
    System.out.println(logDate.format(new java.util.Date())+request.getRequestURI()+" "+request.getMethod()+"[" + request.getRemoteAddr() + "]");
    //com.wizvera.WizveraConfig delfinoConfig = new com.wizvera.WizveraConfig(getServletConfig().getServletContext().getRealPath("WEB-INF") + "/lib/delfino.properties");
%>
<%
    //out.println("<!-- " + request.getRequestURI()+" "+request.getMethod()+"[" + request.getRemoteAddr() + "] -->");
    out.println("<!-- " + getRequestParameter(request, "\n") + "\n-->") ;
    if ("TEST_TEST".equals(request.getParameter("_action"))) return;
%>
<%
    /**************************************************************
     * 인증서 유효성 검증 타입설정 샘플
     - SignVerifier.CERT_STATUS_CHECK_TYPE_NONE: 유효성검증안함
     - SignVerifier.CERT_STATUS_CHECK_TYPE_CRL:  CRL을 이용한 유효성 확인
     - SignVerifier.CERT_STATUS_CHECK_TYPE_OCSP: OCSP를 이용한 유효성 확인(delfino.propertie에서 OCSP키값 및 서버 설정필요)
     ***************************************************************/
    int certStatusCheckType = SignVerifier.CERT_STATUS_CHECK_TYPE_NONE;
    {
        String imsi = request.getParameter("certStatusCheckType");
        if ("OCSP".equals(imsi)) {
            certStatusCheckType = SignVerifier.CERT_STATUS_CHECK_TYPE_OCSP;
        } else if ("CRL".equals(imsi)) {
            certStatusCheckType = SignVerifier.CERT_STATUS_CHECK_TYPE_CRL;
        } else {
            certStatusCheckType = SignVerifier.CERT_STATUS_CHECK_TYPE_NONE;
        }
    }
%>
<%
    StringBuffer debugLOG = new StringBuffer();
    String action = request.getParameter("_action");
    String pkcs7 = request.getParameter(SignVerifier.PKCS7_NAME);
    String vidRandom = request.getParameter(SignVerifier.VID_RANDOM_NAME);
    boolean isDetachedMD = false; //PDF서명여부
%>
<%
    out.println("<b>전자서명결과</b>[" + action + "] " + logDate.format(new java.util.Date()));
    try{
        /**************************************************************
        * PKCS7을 이용한 서명검증,인증서소유자 및 유효성확인
        * 사설인증서는 유효성검증된 상태에서 수신되기 때문에 인증서유효성검증 설정은 내부적으로 생력됨
        * 카카오(6x0) 전문 사용시 서명원문변경이 불가능하여 nonce검증은 내부적으로 생략됨
        - verifyPKCS7WithNonce:       인증서로그인:  서명확인 + Nonce확인 + 인증서유효성검증
        - verifyPKCS7WithVIDAndNonce: 본인확인로그인:서명확인 + Nonce확인 + 인증서유효성검증
        - verifyPKCS7WithUserConfirm: 포맷전자서명:  서명확인 + 사용자포맷확인 + 인증서유효성검증
        - verifyPKCS7:                일반서명:     서명확인 + 인증서유효성검증
        ***************************************************************/
        SignVerifier signVerifier = new SignVerifier(); //서명검증 객체
        SignVerifierResult signVerifierResult = null; //서명검증 결과

        if ("TEST_certLogin".equals(action) || "TEST_registerCert".equals(action)) {
            String sessionNonce = (String)session.getAttribute("delfinoNonce");
            session.removeAttribute("delfinoNonce"); //TODO: 반드시 삭제해야함
            signVerifierResult = signVerifier.verifyPKCS7WithNonce(pkcs7, sessionNonce, certStatusCheckType);
            out.println("<br/>-. signVerifier.verifyPKCS7WithNonce: <b>OK</b>");
        }
        else if ("TEST_vidLogin".equals(action)) {
            String idn = request.getParameter("idn");
            String sessionNonce = (String)session.getAttribute("delfinoNonce");
            session.removeAttribute("delfinoNonce"); //TODO: 반드시 삭제해야함
            signVerifierResult = signVerifier.verifyPKCS7WithVIDAndNonce(pkcs7, vidRandom, idn, sessionNonce, certStatusCheckType);
            //signVerifierResult = signVerifier.verifyPKCS7WithVID(pkcs7, vidRandom, idn, certStatusCheckType);
            out.println("<br/>-. signVerifier.verifyPKCS7WithVIDAndNonce: <b>OK</b>");
        }
        else if ("TEST_confirmSign_string".equals(action)) {
            String expectedUserConfirmFormat = (String)session.getAttribute("TEST_confirmSign_string");
            signVerifierResult = signVerifier.verifyPKCS7WithUserConfirm(pkcs7, expectedUserConfirmFormat, certStatusCheckType);
            out.println("<br/>-. signVerifier.verifyPKCS7WithUserConfirm: <b>OK</b>");
        }
        else if ("TEST_confirmSign_form".equals(action) || "TEST_confirmSign_formString".equals(action)) {
            String expectedUserConfirmFormat = (String)session.getAttribute("TEST_confirmSign_form");
            signVerifierResult = signVerifier.verifyPKCS7WithUserConfirm(pkcs7, expectedUserConfirmFormat, certStatusCheckType);
            out.println("<br/>-. signVerifier.verifyPKCS7WithUserConfirm: <b>OK</b>");
        }
        else if ("TEST_multiSign".equals(action)) {
            String SIGN_Delimeter = request.getParameter("SIGN_Delimeter");
            if (SIGN_Delimeter == null || SIGN_Delimeter.equals("")) SIGN_Delimeter = "|"; //"￡";
            if ("|".equals(SIGN_Delimeter)) SIGN_Delimeter = "\\" + SIGN_Delimeter;

            String imsi = (String)session.getAttribute(action);
            //session.removeAttribute(action);
            if (imsi == null) imsi = "";
            String[] session_multiSignData = imsi.split(SIGN_Delimeter); //복수전자서명 요청원문

            if (com.wizvera.service.FintechSignVerifier.isFintechMultiSignResult(pkcs7)) {
                com.wizvera.service.FintechSignVerifier fintechSignVerifier = new com.wizvera.service.FintechSignVerifier();
                SignVerifierResult[] multiSignVerifierResult = fintechSignVerifier.verifyPKCS(pkcs7);
                for (int k=0; k<multiSignVerifierResult.length; k++) {
                    debugLOG.append("\n# pkcs7["+(k+1)+"] " + multiSignVerifierResult[k].getPKCS7SignedData());

                    String session_signData = (session_multiSignData.length>k) ? session_multiSignData[k] : "";
                    String check_signData = (multiSignVerifierResult[k].getOriginSignedRawData().equals(session_signData)) ? "<b>OK</b>" : "<b><span style='color:red'>FAIL</span></b>";
                    out.println("<br/>-. fintechSignVerifier.verifyPKCS[" + k + "]=[<span style='font-size: small;'>" + multiSignVerifierResult[k].getOriginSignedRawData() + "]</span> -> 원문확인: " + check_signData);
                }
                signVerifierResult = multiSignVerifierResult[0]; //TODO: 첫번째 서명만 세부적으로 확인, 나머지 서명문도 확인 필요
            } else {
                String[] pkcs7Array = pkcs7.split(SIGN_Delimeter);
                SignVerifierResult[] multiSignVerifierResult = new SignVerifierResult[pkcs7Array.length];
                for(int k=0; k<pkcs7Array.length; k++) {
                    pkcs7 = pkcs7Array[k];
                    debugLOG.append("\n# pkcs7["+(k+1)+"] " + pkcs7);
                    multiSignVerifierResult[k] = signVerifier.verifyPKCS7(pkcs7, certStatusCheckType);

                    String session_signData = (session_multiSignData.length>k) ? session_multiSignData[k] : "";
                    String check_signData = (multiSignVerifierResult[k].getOriginSignedRawData().equals(session_signData)) ? "<b>OK</b>" : "<b><span style='color:red'>FAIL</span></b>";
                    out.println("<br/>-. signVerifier.verifyPKCS7[" + k + "]=[<span style='font-size: small;'>" + multiSignVerifierResult[k].getOriginSignedRawData() + "]</span> -> 원문확인: " + check_signData);
                }
                signVerifierResult = multiSignVerifierResult[0]; //TODO: 첫번째 서명만 세부적으로 확인, 나머지 서명문도 확인 필요
            }
        }
        else if ("TEST_mdSign".equals(action)) {
            isDetachedMD = true; //PDF서명
            com.wizvera.service.DetachedSignVerifier detachedSignVerifier = new com.wizvera.service.DetachedSignVerifier();
            signVerifierResult = detachedSignVerifier.verifyPKCS7(pkcs7, certStatusCheckType);
            out.println("<br/>-. detachedSignVerifier.verifyPKCS7: <b>OK</b>");

            String session_mdSignData = (String)session.getAttribute(action); //PDF서명요청한 Hash값
            //session.removeAttribute(action);

            Map<String, byte[]> messageDigestMap = signVerifierResult.getMessageDigestMap();
            for(String key : messageDigestMap.keySet()) {
                String strValue = com.wizvera.util.Hex.encode(messageDigestMap.get(key));
                if (strValue.equals(session_mdSignData)) {
                    out.println(" -> detachedMD Check: <b>OK</b>");
                } else {
                    out.println(" -> detachedMD Check: <b><span style='color:red'>FAIL</span></b>: [" + key + "][" + session_mdSignData + "][" + strValue + "]");
                }
            }
        }
        else if ("TEST_pkcs7".equals(action)) {
            if (certStatusCheckType == SignVerifier.CERT_STATUS_CHECK_TYPE_NONE) {
                signVerifierResult = signVerifier.verifyPKCS7WithoutCertValidation(pkcs7);
                out.println("<br/>-. signVerifier.verifyPKCS7WithoutCertValidation: <b>OK</b>");
            } else {
                signVerifierResult = signVerifier.verifyPKCS7(pkcs7, certStatusCheckType);
                out.println("<br/>-. signVerifier.verifyPKCS7: <b>OK</b>");
            }
        }
        else {
            signVerifierResult = signVerifier.verifyPKCS7(pkcs7, certStatusCheckType);
            out.println("<br/>-. signVerifier.verifyPKCS7: <b>OK</b>");

            //업무단에서 전자서명 원본 확인(세션에 저장된 값과 전자서명원본값 비교)
            String session_SignData = (String)session.getAttribute(action);
            if (session_SignData == null) session_SignData = "";
            String pkcs7_SignData = signVerifierResult.getOriginSignedRawData();

            if ("TEST_confirmSign_formattedText".equals(action)) {
                //pkcs7_SignData = pkcs7_SignData.replace("\r", ""); //window,unix CR(0x0D),LF(0x0A)보정
                pkcs7_SignData = pkcs7_SignData.replace("\n", "\\n");
            }

            if (pkcs7_SignData == null) {
                out.println("<br/>-. 전자서명데이타원본확인: <b><span style='color:red'>pkcs7_SignData is null</style></b>");
            } else if (pkcs7_SignData.equals(session_SignData)) {
                out.println("<br/>-. 전자서명데이타원본확인: <b>OK</b>");
            } else {
                out.println("<br/>-. 전자서명데이타원본확인: <b><span style='color:red'>FAIL</style></b>");
                out.println("<!--");
                out.println("hex.1 [" + com.wizvera.util.Hex.encode(session_SignData.getBytes()) + "]");
                out.println("hex.2 [" + com.wizvera.util.Hex.encode(pkcs7_SignData.getBytes()) + "]");
                out.println("session_원문 [" + session_SignData + "]");
                out.println("  pkcs7_원문 [" + pkcs7_SignData + "]");
                out.println("\n-->");
            }
        }

        /**************************************************************
         * 서명검증후 필요시 VID,CI를 이용한 인증서 소유자 본인확인
        ***************************************************************/
        boolean verifyIdentity = false;
        if ("TEST_registerCert".equals(action)) verifyIdentity = true;
        //verifyIdentity = true; //TODO: check
        if (verifyIdentity) {
            boolean verifyUser = false; //소유자 본인확인 결과
            boolean isVerifiableVid = signVerifierResult.isVerifiableVid();
            boolean isVerifiableCi = signVerifierResult.isVerifiableCi();
            String idn = request.getParameter("idn"); //주민등록번호 or CI번호

            if (idn == null || "".equals(idn)) { //TODO: 주민번호 또는 CI값이 없어 테스트를 위해 소유자 검증 안함
                out.println("<br/>-. signVerifierResult.verifyVid(Ci): <b><span style='color:red'>SKIP</span></b>: idn is null");
            }
            else if (isVerifiableVid) { //Vid를 이용한 본인확인 가능(공동인증서, 금융인증서)
                verifyUser = signVerifierResult.verifyVid(idn, vidRandom); //금융인증서의 경우 vidRandom은 null or "" 로 입력
                //signVerifierResult = signVerifier.verifyPKCS7WithVID(pkcs7, vidRandom, idn, certStatusCheckType);
                out.println("<br/>-. signVerifierResult.verifyVid: <b>" + (verifyUser?"":"<span style='color:red'>") + verifyUser + (verifyUser?"":"</span>") + "</b>");
            }
            else if (isVerifiableCi) { //CI를 이용한 본인확인 가능(사설인증서:카카오,토스,패스,네이버,페이코)
                verifyUser = signVerifierResult.verifyCi(idn);
                out.println("<br/>-. signVerifierResult.verifyCi: <b>" + (verifyUser?"":"<span style='color:red'>") + verifyUser + (verifyUser?"":"</span>") + "</b>");
            }
            else if ("toss".equals(signVerifierResult.getProvider()) && "LOGIN".equals(signVerifierResult.getSignType())) {
                //TODO: TOSSS일경우 LOGIN은 CI검증 기능을 제공하지 않음
                out.println("<br/>-. signVerifierResult.verifyCi: <b><span style='color:red'>미지원</span></b>: " + signVerifierResult.getProvider() + ": " + signVerifierResult.getSignType());
            }
            else {
                out.println("<br/>-. signVerifierResult.verifyVid(Ci): <b><span style='color:red'>undefined</span></b>");
            }
            //if (!verifyUser) throw new DelfinoServiceException(new com.wizvera.crypto.CryptoException(1701, "is not valid VID or CI")); //TODO: 에러처리하세요
        }

        /**************************************************************
        * 사설인증서 처리로직
        - getPKCS7SignedData(): DB에 저장할 PKCS7 전자서명데이타: 공인인증서의 경우 입력값과 동일
        - getProvider(): 사설인증서 provider(kakao,toss,naver,pass), pkcs7(금융인증서포함) 이면 null
        - getSignType(): 사설인증서 signType(AUTH,SIGN,CONFIRM), pkcs7(금융인증서포함) 이면 null
        ***************************************************************/
        String pkcs7SignedData = signVerifierResult.getPKCS7SignedData();
        String provider = signVerifierResult.getProvider();
        String signType = signVerifierResult.getSignType();

        boolean isPrivateCert = true; //사설인증서여부
        if (provider == null) {
            provider = "pubCert"; //NPKI,GPKI,FinCert,FinCertCorp
            isPrivateCert = false;
        }

        //사설인증서 일경우 테스트용
        if (isPrivateCert) {
            Map<String, Object> resultMap = signVerifierResult.getProviderRawResponse();
            debugLOG.append("\n # 서명결과요청 [" + pkcs7 + "]");
            debugLOG.append("\n # 서명결과응답 [" + resultMap.toString() + "]");
            out.println("<br/>-. 서명결과요청 <span style='font-size: small;'>[" + pkcs7 + "]</span>");
            out.println("<!-- <br/>-. 서명결과응답 <span style='font-size: small;'>[" + resultMap.toString() + "]</span> -->");
        }

        //핀테크인증 개인정보확인(CI or service_user_id)
        if (isPrivateCert) {
            debugLOG.append("\n # getTxid [" + signVerifierResult.getTxId() + "]");
            debugLOG.append("\n # getCi [" + signVerifierResult.getCi() + "]");
            out.println("<br/>-. signVerifierResult.getCi: <span style='font-size: small;'>" + signVerifierResult.getCi() + "</span>");

            //카카오 콜백사용시 service_user_id 가져오기
            if ("kakao".equals(provider) && ("LOGIN".equals(signVerifierResult.getSignType()) || "SAUTH".equals(signVerifierResult.getSignType()) || "AUTH".equals(signVerifierResult.getSignType()))) {
                String service_user_id = String.valueOf(signVerifierResult.getProviderRawResponse().get("service_user_id"));
                debugLOG.append("\n # service_user_id [" + service_user_id +"]");
                out.println(": service_user_id[" + service_user_id + "]");

                //TODO: 카카오 이용기관등록 콜백 처리로직에서 DB에 저장된 사용자매핑정보를  service_user_id를 이용하여 가져옵니다.

                //등록된 사용자 매핑정보가 없다면 이용기관등록 해제 처리 후 사용자가 다시 로그인하면 됩니다.
                /*
                try {
                    com.wizvera.service.VpcgSignResultAddedService.deregister("kakao", service_user_id);
                    out.println("<br/>-. 이용기관등록해제: " + service_user_id + ": OK");
                } catch (Exception e) {
                    out.println("<br/>-. 이용기관등록해제: " + service_user_id + ": Fail: " + e.getMessage());
                    //e.printStackTrace();
                }
                */
            }

            //CI검증이 불가능할경우 세션에 저장된 서명요청정보(이름,생년월일,전화번호) 검증
            /*
            String userName = (String)session.getAttribute("request_userName");
            String userBirthday =  (String)session.getAttribute("request_userBirthday");
            String userPhone =  (String)session.getAttribute("request_userPhone");
            boolean verifyRi = signVerifierResult.verifyRi(userName, userBirthday, userPhone);
            out.println("<br/>-. signVerifierResult.verifyRi: <b>" + verifyRi + "</b> [" + userName + "," + userBirthday + "," + userPhone + "]");
            */
        }

        if (isPrivateCert) {
            out.println("<br/>-. 사설인증서는 인증서버에서 유효성 확인된 인증서입니다.");
        } else if (SignVerifier.CERT_STATUS_CHECK_TYPE_OCSP == certStatusCheckType) {
            out.println("<br/>-. 인증서 유효성확인(OCSP): <b>OK</b>");
        } else if (SignVerifier.CERT_STATUS_CHECK_TYPE_CRL == certStatusCheckType) {
            out.println("<br/>-. 인증서 유효성확인(CRL): <b>OK</b>");
        } else if (SignVerifier.CERT_STATUS_CHECK_TYPE_NONE == certStatusCheckType) {
            out.println("<br/>-. CRL/OCSP를 통한 인증서 유효성 확인이 필요합니다.");
        }
        out.println("<br/>-. 필요시 업무에 따라 로그인 인증서와 동일여부 확인이 필요합니다.");


        /**************************************************************
        * 전자서명 데이타 확인
        - getOriginSignedRawData(): 전자서명원문데이타
        - getSignedParameter(name): 포맷전자서명시 name에 해당하는 데이타
        ***************************************************************/
        //TODO: PKCS7(전자서명문) 미제공
        if (pkcs7SignedData == null && "SAUTH".equals(signVerifierResult.getSignType())) {
            if ("kakaotalk".equals(provider) || "hanaonesign".equals(provider) || "dream".equals(provider)) {
                out.println("<br/><br/><b><span style='color:red; font-size: small;'>카카오톡,하나원사인,드림인증은 SAUTH(useSimpleAuth설정시)에서 PKCS7(전자서명문)을 제공하지 않습니다.</span></b>");
                out.println("<br/>-. signType[" + signVerifierResult.getSignType() + "] provider[" + signVerifierResult.getProvider() + "] mediaType[" + signVerifierResult.getCertStoreMediaType() + "]");
                out.println("<br/>-. orgRawData[" + signVerifierResult.getOriginSignedRawData() + "] rawData[" + signVerifierResult.getSignedRawData() + "]");
                return;
            } else {
                out.println("<br/><br/><b><span style='color:red; font-size: small;'>PKCS7(전자서명문)이 없습니다. 서명결과응답을 확인하세요.</span></b>");
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
                System.err.println("can't parsing completedAt[" + completedAt + "].");
            }
        }

        if (isDetachedMD) {
            out.println("<br/><br/><b>전자서명데이타</b> [PDF서명은 서명원문이 없어 확인 불가][" + signingTime + "]");
        } else {
            out.println("<br/><br/><b>전자서명데이타</b> [" + signVerifierResult.getCertStoreMediaType() + "][" + signVerifierResult.getSignType() + "][" + signingTime + "]");
            out.println("<span style='font-size: small;'>");
            out.println("<br/>\n[" + signVerifierResult.getOriginSignedRawData() + "]\n");
            if ("kakao".equals(provider) && !"AUTH".equals(signType)) out.println("<br/><br/>");
            out.println("<!--\n<br/>\n[" + signVerifierResult.getSignedRawData() + "]\n-->");
            if ("TEST_confirmSign_form".equals(action) || "TEST_confirmSign_formString".equals(action)) {
                out.println("<br/>- account     [" + signVerifierResult.getSignedParameter("account")     + "]");
                out.println("<br/>- amount      [" + signVerifierResult.getSignedParameter("amount")      + "]");
                out.println("<br/>- recvUser    [" + signVerifierResult.getSignedParameter("recvUser")    + "]");
                out.println("<br/>- etc         [" + signVerifierResult.getSignedParameter("etc")         + "]");
            }
            out.println("</span>");
        }


        /**************************************************************
        * 인증서 정보 확인
        ***************************************************************/
        X509Certificate userCert = signVerifierResult.getSignerCertificate(); //사용자인증서(BC);
        //X509Certificate userCert = convertX509Cert(signVerifierResult.getSignerCertificate()); //사용자인증서(SUN)

        //String issuerDN = userCert.getIssuerX500Principal().getName(); //인증서 발급기관 DN정보
        //String subjectDN = userCert.getSubjectX500Principal().getName(); //인증서 발급주체 DN정보
        String issuerDN = CertUtil.getIssuerDN(userCert,false,false); //인증서 발급기관 DN정보(인증서,대문자,cn부터): X509기본설정
        String subjectDN = CertUtil.getSubjectDN(userCert,true,true); //인증서 발급주체 DN정보(인증서,소문자,역순): 고객사별로 확인필요: INITECH호환(새마을금고)

        String subjectCN = CertUtil.getSubjectEntry(userCert, CertUtil.NAME_CN, 0); //인증서 발급주체 CN정보(인증서,엔트리,순번)
        String issuerO = CertUtil.getIssuerEntry(userCert, CertUtil.NAME_O, 0);     //인증서 발급기관명(타기관 구분용)(yessign,KICA,SignKorea,NCASign,TradeSign,CrossCert)
        //String issuerO = CertUtil.getIssuerEntry(userCert, CertUtil.NAME_O, 0).toLowerCase();

        //금결원일경우 은행코드 추출
        String bankCode = "";
        if ("yessign".equals(issuerO)) {
            int idx = subjectCN.lastIndexOf(")");
            if(idx != -1) bankCode = subjectCN.substring(idx+1, idx+5);
        }

        //String certSerial = userCert.getSerialNumber().toString(16); //인증서시리얼
        //if ((certSerial.length()%2) == 1) certSerial = "0" + certSerial;
        String certSerial = CertUtil.getSerialDecimal(userCert); //인증서시리얼(10진수)
        String certSerialHex = CertUtil.getSerialHex(userCert);  //인증서시리얼(16진수) 0A10

        String certBefore = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(userCert.getNotBefore()); //인증서유효기간:시작일
        String certAfter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(userCert.getNotAfter());   //인증서유효기간:종료일

        out.println("<br/><br/><b>인증서 정보</b> [" + ((isPrivateCert) ? "사설" : "공인") + "] [" + provider + "]");
        out.println("<br/>- 인증서발급기관 [" + issuerDN + "]");
        out.println("<br/>- 인증서발급주체 [" + subjectDN + "]");
        out.println("<br/>- 인증서부가정보 [" + issuerO + "][" + subjectCN + "][" + bankCode + "]");
        out.println("<br/>- 인증서일련번호 [<b>" + certSerial + "</b>][" + certSerialHex + "]");
        out.println("<br/>- 인증서유효기간 [<b>" + certBefore + " ~ " + certAfter + "</b>]");

        //인증서 OID로 개인/법인 구분(아래는 샘플입니다. OID리스트를 가지고 담당자와 정책을 정해서 처리해야함)
        //String[] oidArray = CertUtil.getCertificatePolicyOIDs(userCert);
        String firstOID = CertUtil.getCertificatePolicyOID(userCert);
        boolean isPersonal = false;
        boolean isCorporation =  false;
        if ( "1.2.410.200004.5.1.1.5".equals(firstOID)      //증권전산, 개인, 상호연동
              || "1.2.410.200004.5.2.1.2".equals(firstOID)  //정보인증, 개인, 상호연동
              || "1.2.410.200004.5.2.1.7.1".equals(firstOID)//정보인증, 개인, 용도제한(은행)
              || "1.2.410.200004.5.3.1.9".equals(firstOID)  //전산원,   개인, 상호연동
              || "1.2.410.200004.5.4.1.1".equals(firstOID)  //전자인증, 개인, 상호연동
              || "1.2.410.200004.5.4.1.101".equals(firstOID)//전자인증, 개인, 용도제한(은행)
              || "1.2.410.200005.1.1.1".equals(firstOID)    //금결원,  개인, 상호연동
              || "1.2.410.200005.1.1.4".equals(firstOID)    //금결원,  개인, 용도제한(은행,보험,카드)
              || "1.2.410.200012.1.1.1".equals(firstOID)    //무역정보, 개인, 상호연동
              || "1.2.410.200004.5.5.1.1".equals(firstOID) )//이니텍,  개인, 상호연동
        {
            isPersonal = true;
        }

        if ( "1.2.410.200004.5.1.1.7".equals(firstOID)      //증권전산, 법인, 상호연동
              || "1.2.410.200004.5.2.1.1".equals(firstOID)  //정보인증, 법인, 상호연동
              || "1.2.410.200004.5.3.1.2".equals(firstOID)  //전산원,        법인, 상호연동
              || "1.2.410.200004.5.4.1.2".equals(firstOID)  //전자인증, 법인, 상호연동
              || "1.2.410.200005.1.1.5".equals(firstOID)    //금결원,   법인, 상호연동
              || "1.2.410.200005.1.1.2".equals(firstOID)    //금결원,   법인, 용도제한(은행,보험,카드)
              || "1.2.410.200005.1.1.6.1".equals(firstOID)  //금결원,   법인, 용도제한(기업뱅킹)
              || "1.2.410.200012.1.1.101".equals(firstOID)  //무역정보, 법인, 용도제한(은행)
              || "1.2.410.200012.1.1.3".equals(firstOID)    //무역정보, 법인, 상호연동
              || "1.2.410.200004.5.5.1.2".equals(firstOID) )//이니텍,  법인, 상호연동
        {
            isCorporation = true;
        }
        out.println("<br/>- 인증서용도구분  [<b>" + firstOID + "</b>] 개인용[" + isPersonal + "] 법인용[" + isCorporation + "]");

        //디버깅용: 인증서/PKCS7 dump
        out.println("<br/><br/><!--\n[userCertificate]\n"+ CertUtil.toPEM(userCert) + "\n-->\n");
        out.println("<!--\n[userCertificate.dump]\n" + userCert.toString() + "\n-->\n");
        out.println("<!--\n[pkcs7SignedData]\n" + pkcs7SignedData + "\n-->\n");
        if (!isDetachedMD) {
            out.println("<!--\n[pkcs7SignedData.dump]\n" + com.wizvera.crypto.PKCS7Dump.dumpAsString(pkcs7SignedData) + "\n-->\n");
            debugLOG.append("\n # pkcs7SignedData.dump\n" + com.wizvera.crypto.PKCS7Dump.dumpAsString(pkcs7SignedData));
        }

    } catch(DelfinoServiceException e) {
        System.out.println(getRequestParameter(request, "\n"));

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
        out.println("<span style='font-size: small;'>" + sw.toString().replaceAll("\n", "\n<br/>&nbsp;") + "<font>");

        String pkcs7SignedData = e.getPKCS7SignedData(); //PKCS7 데이타 오류 확인을 위해 로그 저장 필요
        if (pkcs7SignedData != null && pkcs7SignedData.indexOf("MI")==0) {
            out.println("<!--\n[pkcs7SignedData]\n" + pkcs7SignedData + "\n-->\n");
            debugLOG.append("\n # pkcs7SignedData [" + pkcs7SignedData + "]");
            if (!isDetachedMD) {
                String dumpAsString = com.wizvera.crypto.PKCS7Dump.dumpAsString(pkcs7SignedData);
                out.println("<!--\n[pkcs7SignedData.dump]\n" + dumpAsString + "\n-->\n");
                debugLOG.append("\n # pkcs7SignedData.dump\n" + dumpAsString);
            }
        } else if (pkcs7 != null && pkcs7.indexOf("MI")==0) {
            out.println("<!--\n[pkcs7]\n" + pkcs7 + "\n-->\n");
            debugLOG.append("\n # pkcs7 [" + pkcs7 + "]");
            if (!isDetachedMD) {
                String dumpAsString = com.wizvera.crypto.PKCS7Dump.dumpAsString(pkcs7);
                out.println("<!--\n[pkcs7.dump]\n" + dumpAsString + "\n-->\n");
                debugLOG.append("\n # pkcs7.dump\n" + dumpAsString);
            }
        } else {
            out.println("<!--\n[pkcs7]\n" + pkcs7 + "\n-->\n");
            debugLOG.append("\n # pkcs7 [" + pkcs7 + "]");
        }

        debugLOG.append("\n # printStackTrace: " + sw.toString());
        debugLOG.append("\n # getMessage: " + e.getMessage());
        debugLOG.append("\n # getErrorUserMessage[" + e.getErrorCode() + "]: " + e.getErrorUserMessage());
        if (e.getVpcgProviderErrorInfo() != null) {
            com.wizvera.service.VpcgProviderErrorInfo vpcgError = e.getVpcgProviderErrorInfo();
            debugLOG.append("\n # vpcgProviderError: " + vpcgError.getErrorMessage() + "[" + vpcgError.getErrorCode() + "][" + vpcgError.getProvider() + "]");
        }
    } catch(Exception e) {
        System.out.println(getRequestParameter(request, "\n"));

        out.println("<br/><hr/><b>Exception - ERR(?)</b>");
        out.println("<br/>FileName: " + request.getServletPath());
        out.println("<br/>getMessage: " + e.getMessage());
        java.io.StringWriter sw = new java.io.StringWriter();
        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
        e.printStackTrace(pw);
        out.println("<br><br><b>printStackTrace</b><br>");
        out.println("<span style='font-size: small;'>" + sw.toString().replaceAll("\n", "\n<br/>&nbsp;") + "<font>");

        debugLOG.append("\n # printStackTrace: " + sw.toString());
        debugLOG.append("\n # getMessage: " + e.getMessage());
    }
    System.out.println(debugLOG.toString());
%>
<%!
    public static X509Certificate convertX509Cert(X509Certificate cert) throws CertificateException, NoSuchProviderException, java.security.cert.CertificateException {
        return convertX509Cert(cert, "SUN"); //SUN, IBMJCE, Wizvera
    }
    public static X509Certificate convertX509Cert(X509Certificate cert, String provider) throws CertificateException, NoSuchProviderException, java.security.cert.CertificateException {
        java.io.ByteArrayInputStream in = new java.io.ByteArrayInputStream(cert.getEncoded());
        java.security.cert.CertificateFactory certFactory = java.security.cert.CertificateFactory.getInstance("X.509", provider);
        return (X509Certificate)certFactory.generateCertificate(in);
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
                    sb.append("#   [" + name + "] = [" + value[i] + "]" + tag);
                }
            }
        }
        sb.append("###########################################################################");
        return sb.toString();
    }
%>
