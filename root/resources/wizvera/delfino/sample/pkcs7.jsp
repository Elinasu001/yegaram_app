<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.lang.*, java.text.*, java.net.*" %>
<%@ page import="java.security.cert.X509Certificate" %>
<%@ page import="com.wizvera.crypto.*" %>
<%!
    public static String _requestEncoding = ""; //"8859_1"
    public static String getRequestValue(String value) {
    	try {
            if (value == null || "".equals(value) || "".equals(_requestEncoding)) return value;
            return new String(value.getBytes(_requestEncoding));
    	} catch (Exception e) {};
    	return value;
    }
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta http-equiv="Progma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <title>PKCS7 Dump</title>
</head>

<body>

<div style="font-size:11pt;"><br/>

<%
    String requestInfo = request.getContextPath() + request.getServletPath();
    requestInfo = "\n" + request.getRequestURI() + " " + request.getMethod() + "[" + request.getRemoteAddr() + "]";
    {
        requestInfo+= "<ul>";
        requestInfo+= "<li>request.getHeader(\"Referer\") = [" + request.getHeader("Referer") + "]</li>";
        String testData = request.getParameter("testData");
        if (testData!=null && testData.length()>=1024) requestInfo+= "<li>testData.lgngth() = [" + testData.length() + "]</li>";
        requestInfo+= "</ul>";
    }
    {
        StringBuffer sb = new StringBuffer();
        sb.append("<ul>");
        Enumeration em = request.getParameterNames();
        while (em.hasMoreElements()) {
            String name = (String)em.nextElement();
            String value[] = request.getParameterValues(name);
            if (value == null) {
                sb.append("<li>request.getParameter(\"" + name + "\") = [null]</li>");
            } else {
                for (int i=0; i<value.length; i++) {
                    if (PKCS7Verifier.PKCS7_NAME.equals(name)) {
                    	
                    	if ("hex".equals(request.getParameter("PKCS_TYPE"))) {
                    		String pkcs7 = value[i];
                        	byte[] imsi = com.wizvera.util.Hex.decode(pkcs7);
                        	value[i] = com.wizvera.util.Base64.encode(imsi);
                    	} else {
                    		String pkcs7 = value[i];
                    	 	byte[] imsi = com.wizvera.util.Base64.decode(pkcs7.getBytes());
                    		pkcs7 = com.wizvera.util.Hex.encode(imsi);
                    		out.println("<!--Hex[" + pkcs7 + "]-->");
                    	}
                    	
                        sb.append("<li>request.getParameter(\"" + name + "\") = [???size=" + value[i].length() + "???]");
                        sb.append("<!--\n" + value[i] + "\n-->");
                        sb.append("<!--\n" + PKCS7Dump.dumpAsString(value[i]) + "\n-->");
                        sb.append("<ul>");
                        try {
                            PKCS7Verifier p7verifier = new PKCS7Verifier(value[i]);
                            Map map = p7verifier.getSignedParameterMap();
                            Set<String> keySet = map.keySet();
                            Iterator<String> it = keySet.iterator();
                            while (it.hasNext()) {
                                String name2 = it.next();
                                String value2[] = (String[])map.get(name2);
                                if (value2 == null) {
                                    sb.append("<li>PKCS7.getSignedParameter(\"" + name2 + "\") = [null]</li>");
                                } else {
                                    for (int j=0; j<value2.length; j++) {
                                    	if (PKCS7Verifier.USER_CONFIRM_FORMAT_NAME.equals(name2)) {
	                                        sb.append("<li>PKCS7.getSignedParameter(\"" + name2 + "\") = [" + value2[j] + "]</li>");
	                                        sb.append("<li>ULRDecoder.decode(USER_CONFIRM_FORMAT_NAME) = [" + java.net.URLDecoder.decode(value2[j], "UTF-8") + "]</li>");
                                    	} else {
	                                        sb.append("<li>PKCS7.getSignedParameter(\"" + name2 + "\") = [" + value2[j] + "]</li>");
                                    	}
                                    }
                                }
                            }
                            sb.append("<li><b>User Certificate Info</b><ul>");
                            X509Certificate cert = p7verifier.getSignerCertificate();
                    		String[] oidArray = CertUtil.getCertificatePolicyOIDs(cert);
                            String oidPrintString = "";
                    		for (int j=0; j<oidArray.length; j++) oidPrintString += "[" + oidArray[j] + "]";
                            
                            String subjectDN = cert.getSubjectX500Principal().getName();
                            String cn = subjectDN.split(",")[0];
                            String userName = cn.split("=")[1];
                            userName = userName.split("\\(")[0];
                            sb.append("  <li>issuerDN [" + cert.getIssuerX500Principal().getName() + "]</li>");
                            sb.append("  <li>subjectDN [" + subjectDN + "]</li>");
                            sb.append("  <li>before/after [" + cert.getNotBefore() + "~" + cert.getNotAfter() + "]</li>");
                            sb.append("  <li>serailNumber [" + cert.getSerialNumber().toString() + "]</li>");
                            sb.append("  <li>userName [" + userName + "]</li>");
                            sb.append("  <li>certOIDs " + oidPrintString + "</li>");
                            sb.append("</ul></li>");

                        } catch (Exception e) { sb.append("<li>" + e.toString() + "</li>"); }
                        sb.append("</ul></li>");
                    } else {
                        sb.append("<li>request.getParameter(\"" + name + "\") = [" + getRequestValue(value[i]) + "]</li>");
                    }
                }
            }
        }
        sb.append("</ul>");
        requestInfo += sb.toString();
    }
    out.println("<b>Request Info: </b>" + requestInfo);
%>

</body>
</html>
