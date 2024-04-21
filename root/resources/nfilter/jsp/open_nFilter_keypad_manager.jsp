<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="net.nshc.nfilter.openweb.OpenWebNFilterConfig" %>
<%@ page import="net.nshc.nfilter.openweb.service.OpenWebNFilterKeypadManager" %>
<%@ page import="net.nshc.nfilter.openweb.service.OpenWebNFilterSessionManager" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.security.PrivateKey" %>
<%@ page import="net.nshc.nfilter.openweb.keypad.keymap.KeyMapSession" %>
<%@ page import="net.nshc.nfilter.openweb.util.OpenWebNFilterUtil" %>
<%@ page import="net.nshc.nfilter.openweb.service.OpenWebNFilterLicenseManager" %>
<%@ page import="java.lang.reflect.Field" %>

<%
    String nFilterHTML = null;
    OpenWebNFilterKeypadManager kepadManager = new OpenWebNFilterKeypadManager(getServletConfig(), request, response);

    if (OpenWebNFilterConfig.getTokenSystemUse().equals("true")) {
        OpenWebNFilterSessionManager sessionManager = new OpenWebNFilterSessionManager();
        String token = sessionManager.create();

        // 생성된 token을 설정.
        kepadManager.setToken(token);

        // 키패드 init
        nFilterHTML = kepadManager.initializer(true);

        // sessionData DB insert
        String sessionData = OpenWebNFilterSessionManager.getSessionData(session);
        sessionManager.DBHandler(kepadManager.getToken(), sessionData, "insert");

    } else {
        nFilterHTML = kepadManager.initializer(true);
    }

    /**
     * 세션 클러스트링 환경에서 OWN 세션 값이 정상인지 확인하기 위해 사용 (TEST 필요한 경우만 활성화)
     */
//    Enumeration se = session.getAttributeNames();
//    System.out.println("nFilter_keypad_session >> [JSESSIONID] - " + session.getId());
//
//    while(se.hasMoreElements()){
//        String getse = se.nextElement()+"";
//        if(getse.equals("nshc_keypad_request_language") || getse.equals("nshc_keypad_ses_key_exponent") || getse.equals("nshc_keypad_ses_private_key_keytable")
//                || getse.equals("nshc_keypad_ses_key_module") || getse.equals("sesCheck4iframe")) {
//            System.out.println("nFilter_keypad_session >> ["+getse+"] - " + session.getAttribute(getse));
//
//        } else if(getse.equals("nshc_keypad_ses_private_key") && OpenWebNFilterConfig.getAlgName().equals("RSA")) {
//            PrivateKey pk = (PrivateKey) session.getAttribute(getse);
//            System.out.println("nFilter_keypad_session >> ["+getse+"] - " + OpenWebNFilterUtil.byteArrayToHex(pk.getEncoded()));
//
//        } else if(getse.equals("nshc_keypad_ses_private_key") && OpenWebNFilterConfig.getAlgName().equals("ECDH")) {
//            System.out.println("nFilter_keypad_session >> ["+getse+"] - " + session.getAttribute(getse));
//
//        } else if(getse.equals("nshc_keypad_ses_char_s") || getse.equals("nshc_keypad_ses_char_u") || getse.equals("nshc_keypad_ses_num") || getse.equals("nshc_keypad_ses_char_l")) {
//            KeyMapSession keymap = (KeyMapSession) session.getAttribute(getse);
//            System.out.println("nFilter_keypad_session >> ["+getse+"] - " + keymap.getSecretKeyCodeSet());
//        }
//    }

    /**
     * 라이선스 기간 체크
     * 라이선스 파일의 정보를 확인해야 하는 경우 사용
     */
//    OpenWebNFilterLicenseManager lic = OpenWebNFilterLicenseManager.getInstance();
//    try {
//        Field field = lic.getClass().getDeclaredField("licenseData");
//        field.setAccessible(true);
//        System.out.println(field.get(lic));
//    } catch (Exception e) {
//        e.printStackTrace();
//    }
%>
<%=nFilterHTML%>