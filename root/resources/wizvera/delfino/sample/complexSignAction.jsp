<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.wizvera.crypto.PKCS7Verifier" %>
<%@ page import="java.security.cert.X509Certificate" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="com.wizvera.service.DetachedSignVerifier" %>
<%@ page import="com.wizvera.WizveraConfig" %>
<%@ page import="com.wizvera.service.SignVerifierResult" %>
<%@ page import="com.wizvera.service.SignVerifier" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.wizvera.provider.util.encoders.Hex" %>

<html>
<body>

<%
    request.setCharacterEncoding("utf8");
    String signedData = request.getParameter("PKCS7");
    String vid = request.getParameter("VID_RANDOM");
    String dataType = request.getParameter("dataType");
%>

PKCS7:<%=signedData%><br/>
VID_RANDOM:<%=vid%><br/>

<%
	WizveraConfig wizveraConfig = WizveraConfig.getDefaultConfiguration();

	try {

        JSONArray jSignedData = new JSONArray(signedData);
        for (int i = 0; i < jSignedData.length(); i++) {
            JSONObject jSignItem = (JSONObject) jSignedData.get(i);
            String pkcs7 = (String) jSignItem.get("signedData");
            String signDataType = (String) jSignItem.get("dataType");
            String tag = (String) jSignItem.get("tag");
            JSONObject jError = (JSONObject) jSignItem.opt("error");

            PKCS7Verifier p7 = null;
            String encoding = request.getCharacterEncoding();

            out.println("<br/> tag :" + tag);
            out.println("<br/> dataType:" + signDataType);
            if (jError != null) {
                out.println("<br/> tag :" + (String) jError.get("message"));
                out.println("<br/>");
                continue;
            }

            if (signDataType.equalsIgnoreCase("string")) {
                p7 = new PKCS7Verifier(pkcs7, encoding);
                X509Certificate cert = p7.getSignerCertificate();
                out.println("<br/> signedRawData:" + p7.getSignedRawData());

                out.println("<br/> Certificate issuer:" + cert.getIssuerX500Principal().getName());
                out.println("<br/> Certificate subject:" + cert.getSubjectX500Principal().getName());
                out.println("<br/> Certificate Serial Number:" + cert.getSerialNumber());
                out.println("<br/>");
                continue;
            }

            if (signDataType.equalsIgnoreCase("sha256-md")) {
                DetachedSignVerifier detachedSignVerifier = new DetachedSignVerifier(wizveraConfig);
                //SignVerifierResult signVerifierResult = detachedSignVerifier.verifyPKCS7(pkcs7, "UTF-8", SignVerifier.CERT_STATUS_CHECK_TYPE_NONE);
                SignVerifierResult signVerifierResult = detachedSignVerifier.verifyPKCS7(pkcs7, SignVerifier.CERT_STATUS_CHECK_TYPE_NONE);
                Map<String, byte[]> messageDigestMap = signVerifierResult.getMessageDigestMap();
                for (String key : messageDigestMap.keySet()) {
                    byte[] value = messageDigestMap.get(key);
                    out.println("<div>" + key + "=><strong>" + Hex.encode(value) + "</strong></div>");
                }
                out.println("<br/>");
            }


        }

    } catch (Exception e) {
        out.println("<p/>");
        out.println("Error Occured:" + e.toString());
        out.println("<p/>");
        e.printStackTrace();
    }

%>

</body>
</html>
