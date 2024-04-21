<%@page import="java.nio.ByteBuffer"%>
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="org.bouncycastle.util.encoders.Base64"%>
<%@page import="com.wizvera.WizveraConfig"%>
<%@page import="com.wizvera.util.Hex"%>
<%@page import="com.wizvera.service.SignVerifier"%>
<%@page import="com.wizvera.service.DetachedSignVerifier"%>
<%@page import="com.wizvera.service.SignVerifierResult"%>

<div>
Expected Values<br/>
b0e5036fdb1f65006449b245fc46986945fc64433a3d709074f9160480f1a1b7<br/>
22e5036fdb1f65006449b245fc46986945fc64433a3d709074f9160480f1a1b7<br/>
dfaeerewre4f65006449b245fc46986945fc64433a3d709074f9160480f1a1b7<br/>
</div>
<br/>
<br/>
<%
    String signData = request.getParameter("PKCS7");
    List<String> signDataList = Arrays.asList(signData.split(","));

    WizveraConfig wizveraConfig = WizveraConfig.getDefaultConfiguration();

    for(String pkcs7 : signDataList) {
        DetachedSignVerifier detachedSignVerifier = new DetachedSignVerifier(wizveraConfig);
        //SignVerifierResult signVerifierResult = detachedSignVerifier.verifyPKCS7(pkcs7, "UTF-8", SignVerifier.CERT_STATUS_CHECK_TYPE_NONE);
        SignVerifierResult signVerifierResult = detachedSignVerifier.verifyPKCS7(pkcs7, SignVerifier.CERT_STATUS_CHECK_TYPE_NONE);
        Map<String, byte[]> messageDigestMap = signVerifierResult.getMessageDigestMap();
        
        for(String key : messageDigestMap.keySet()) {
            byte[] value = messageDigestMap.get(key);
            out.println("<div>" + key + "=><strong>" + Hex.encode(value) + "</strong></div>");
        }
    }

    out.println("<div>PKCS7=" + signData + "</div>");
%>
