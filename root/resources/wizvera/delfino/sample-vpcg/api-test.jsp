<%-- --------------------------------------------------------------------------
- File Name   : api-test.jsp
- Include     : none
- Author      : WIZVERA
- Last Update : 2022/06/02
-------------------------------------------------------------------------- --%>
<%@page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.*, java.io.*" %>
<%
    String TEST_gateway_url = "https://ts.wizvera.com:7443/wizvera/gateway/wizvera-gateway.jsp";
    if (request.getRequestURL().toString().indexOf("test.wizvera.com")>0) {
        TEST_gateway_url = "http://127.0.0.1:8080/vpcg/wizvera-gateway.jsp";
    }
    String TEST_proxy_forward_ip = "127.0.0.1";
    String TEST_proxy_forward_port = "8887";

    String REVERSE_vpcg_service_url = "http://127.0.0.1:8886/CERTGATE/v1/sign/request";
    String DEFAULT_vpcg_service_url = "https://api.certgate.io/v1/sign/request";
    String DEFAULT_vpcg_access_token = "76fa8a6724398916b377f020f793aa74613842ee1feb8d09f9f224973ecfd784";
    String DEFAULT_vpcg_request_data = "action=config&nonce=pDWKEX9S3psHaUeMp6AuRIN6Iu4DAfSL";
    //DEFAULT_vpcg_request_data  = "action=requestSign&title=%EC%9D%B8%EC%A6%9D&dataType=TEXT&triggerType=MESSAGE&channelType=PC_WEB";
    //DEFAULT_vpcg_request_data += "&signType=AUTH2&provider=toss&data=testData";
    //DEFAULT_vpcg_request_data += "&userName=%EA%B9%80%EC%83%81%EA%B7%A0&userBirthday=19721128&userPhone=01035201278";

    String DEFAULT_vpcg_gateway_url = "";
    String DEFAULT_vpcg_proxy_ip = "";
    String DEFAULT_vpcg_proxy_port = "0";

    String REVERSE_yeskey_token_url = "http://127.0.0.1:8886/YESKEY/oauth/2.0/api/token";
    String DEFAULT_yeskey_token_url = "https://t-certapi.yeskey.or.kr/oauth/2.0/api/token";
    //DEFAULT_yeskey_token_url = "http://127.0.0.1:8885/oauth/2.0/api/token";
    String DEFAULT_yeskey_server_id = "DE00040000";
    String DEFAULT_yeskey_client_id = "cc9d7462-7a74-4f76-b903-3e86401f2f27";
    String DEFAULT_yeskey_client_secret = "0e9fd1dd-dfe4-4e9b-bce6-aeffa4e68a45";
    String DEFAULT_yeskey_token_scope = "verification";
    //DEFAULT_yeskey_token_scope = "verification ocsp";

    String DEFAULT_yeskey_gateway_url = "";
    String DEFAULT_yeskey_proxy_ip = "";
    String DEFAULT_yeskey_proxy_port = "0";
%>
<%
    java.text.DateFormat logDate = new java.text.SimpleDateFormat("[yyyy/MM/dd HH:mm:ss] ");
    System.out.println(logDate.format(new java.util.Date())+request.getRequestURI()+" "+request.getMethod()+"[" + request.getRemoteAddr() + "]");
    request.setCharacterEncoding("UTF-8");

    //VPCG TEST
    String vpcg_service_url = getParameter(request, "vpcg_service_url", DEFAULT_vpcg_service_url);
    String vpcg_access_token = getParameter(request, "vpcg_access_token", DEFAULT_vpcg_access_token);
    String vpcg_request_data = getParameter(request, "vpcg_request_data", DEFAULT_vpcg_request_data);

    String vpcg_gateway_url = getParameter(request, "vpcg_gateway_url", DEFAULT_vpcg_gateway_url);
    String vpcg_proxy_ip = getParameter(request, "vpcg_proxy_ip", DEFAULT_vpcg_proxy_ip);
    int vpcg_proxy_port = 0;
    try { vpcg_proxy_port = Integer.parseInt(getParameter(request, "vpcg_proxy_port", DEFAULT_vpcg_proxy_port)); } catch (Exception e) {};

    //CERT-API TEST
    String yeskey_token_url = getParameter(request, "yeskey_token_url", DEFAULT_yeskey_token_url);
    String yeskey_server_id = getParameter(request, "yeskey_server_id", DEFAULT_yeskey_server_id);
    String yeskey_client_id = getParameter(request, "yeskey_client_id", DEFAULT_yeskey_client_id);
    String yeskey_client_secret = getParameter(request, "yeskey_client_secret", DEFAULT_yeskey_client_secret);

    String yeskey_gateway_url = getParameter(request, "yeskey_gateway_url", DEFAULT_yeskey_gateway_url);
    String yeskey_proxy_ip = getParameter(request, "yeskey_proxy_ip", DEFAULT_yeskey_proxy_ip);
    int yeskey_proxy_port = 0;
    try { yeskey_proxy_port = Integer.parseInt(getParameter(request, "yeskey_proxy_port", DEFAULT_yeskey_proxy_port)); } catch (Exception e) {};
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <title>G10 API 테스트</title>
</head>
<body>

<script type="text/javascript">
    var TEST_gateway_url = "<%=TEST_gateway_url%>";
    var TEST_proxy_forward_ip = "<%=TEST_proxy_forward_ip%>";
    var TEST_proxy_forward_port = "<%=TEST_proxy_forward_port%>";;

    var REVERSE_vpcg_service_url = "<%=REVERSE_vpcg_service_url%>";
    var DEFAULT_vpcg_service_url = "<%=DEFAULT_vpcg_service_url%>";
    var DEFAULT_vpcg_access_token = "<%=DEFAULT_vpcg_access_token%>";
    var DEFAULT_vpcg_request_data = "<%=DEFAULT_vpcg_request_data%>";
    var DEFAULT_vpcg_gateway_url = "<%=DEFAULT_vpcg_gateway_url%>";
    var DEFAULT_vpcg_proxy_ip = "<%=DEFAULT_vpcg_proxy_ip%>";
    var DEFAULT_vpcg_proxy_port = "<%=DEFAULT_vpcg_proxy_port%>";

    var REVERSE_yeskey_token_url = "<%=REVERSE_yeskey_token_url%>";
    var DEFAULT_yeskey_token_url = "<%=DEFAULT_yeskey_token_url%>";
    var DEFAULT_yeskey_server_id = "<%=DEFAULT_yeskey_server_id%>";
    var DEFAULT_yeskey_client_id = "<%=DEFAULT_yeskey_client_id%>";
    var DEFAULT_yeskey_client_secret = "<%=DEFAULT_yeskey_client_secret%>";
    var DEFAULT_yeskey_gateway_url = "<%=DEFAULT_yeskey_gateway_url%>";
    var DEFAULT_yeskey_proxy_ip = "<%=DEFAULT_yeskey_proxy_ip%>";
    var DEFAULT_yeskey_proxy_port = "<%=DEFAULT_yeskey_proxy_port%>";

    function TEST_set(type) {
        if (type == "init_vpcg") {
            document.testForm.vpcg_service_url.value = DEFAULT_vpcg_service_url;
            document.testForm.vpcg_access_token.value = DEFAULT_vpcg_access_token;
            document.testForm.vpcg_request_data.value = DEFAULT_vpcg_request_data;
            document.testForm.vpcg_gateway_url.value = DEFAULT_vpcg_gateway_url;
            document.testForm.vpcg_proxy_ip.value = DEFAULT_vpcg_proxy_ip;
            document.testForm.vpcg_proxy_port.value = DEFAULT_vpcg_proxy_port;
        }
        else if (type == "init_yeskey") {
            document.testForm.yeskey_token_url.value = DEFAULT_yeskey_token_url;
            document.testForm.yeskey_server_id.value = DEFAULT_yeskey_server_id;
            document.testForm.yeskey_client_id.value = DEFAULT_yeskey_client_id;
            document.testForm.yeskey_client_secret.value = DEFAULT_yeskey_client_secret;
            document.testForm.yeskey_gateway_url.value = DEFAULT_yeskey_gateway_url;
            document.testForm.yeskey_proxy_ip.value = DEFAULT_yeskey_proxy_ip;
            document.testForm.yeskey_proxy_port.value = DEFAULT_yeskey_proxy_por;
            return;
        }
        else if (type == "yeskey_token_url") {
            if (document.testForm.yeskey_token_url.value == DEFAULT_yeskey_token_url) {
                document.testForm.yeskey_token_url.value = REVERSE_yeskey_token_url;
            } else {
                document.testForm.yeskey_token_url.value = DEFAULT_yeskey_token_url;
            }
        }
        else if (type == "yeskey_proxy_ip") {
            if (document.testForm.yeskey_proxy_ip.value == "") {
                document.testForm.yeskey_proxy_ip.value = TEST_proxy_forward_ip;
                document.testForm.yeskey_proxy_port.value = TEST_proxy_forward_port;
            } else {
                document.testForm.yeskey_proxy_ip.value = DEFAULT_yeskey_proxy_ip;
                document.testForm.yeskey_proxy_port.value = DEFAULT_yeskey_proxy_port;
            }
        }
        else if (type == "yeskey_gateway_url") {
            if (document.testForm.yeskey_gateway_url.value == "") {
                document.testForm.yeskey_gateway_url.value = TEST_gateway_url;
            } else {
                document.testForm.yeskey_gateway_url.value = DEFAULT_yeskey_gateway_url;
            }
        }
        else if (type == "vpcg_service_url") {
            if (document.testForm.vpcg_service_url.value == DEFAULT_vpcg_service_url) {
                document.testForm.vpcg_service_url.value = REVERSE_vpcg_service_url;
            } else {
                document.testForm.vpcg_service_url.value = DEFAULT_vpcg_service_url;
            }
        }
        else if (type == "vpcg_proxy_ip") {
            if (document.testForm.vpcg_proxy_ip.value == "") {
                document.testForm.vpcg_proxy_ip.value = TEST_proxy_forward_ip;
                document.testForm.vpcg_proxy_port.value = TEST_proxy_forward_port;
            } else {
                document.testForm.vpcg_proxy_ip.value = DEFAULT_vpcg_proxy_ip;
                document.testForm.vpcg_proxy_port.value = DEFAULT_vpcg_proxy_port;
            }
        }
        else if (type == "vpcg_gateway_url") {
            if (document.testForm.vpcg_gateway_url.value == "") {
                document.testForm.vpcg_gateway_url.value = TEST_gateway_url;
            } else {
                document.testForm.vpcg_gateway_url.value = DEFAULT_vpcg_gateway_url;
            }
        }
    }
    function TEST_exec(_action) {
        document.testForm._action.value = _action;
        document.testForm.submit();
    }
</script>

<form name="testForm" method="post">
  <h2>G10 AWS-VPCG 테스트 <font size=2><a href="./index.jsp">home</a> <a href="javascript:location.href=location.pathname;">init</a></font></h2>

  <input type="hidden" name="_action" value=""/>
  <ul>
    <li>service_url: <input type="text" name="vpcg_service_url" size="58" value="<%=vpcg_service_url%>" /> <a href="javascript:TEST_set('vpcg_service_url');">set</a></li>
    <li>access_token: <input type="text" name="vpcg_access_token" size="62" value="<%=vpcg_access_token%>" /></li>
    <li>request_data: <input type="text" name="vpcg_request_data" size="62" value="<%=vpcg_request_data%>" /></li>
    <li>gateway_url: <input type="text" name="vpcg_gateway_url" size="60" value="<%=vpcg_gateway_url%>" /> <a href="javascript:TEST_set('vpcg_gateway_url');">set</a></li>
    <li>forward proxy ip: <input type="text" name="vpcg_proxy_ip" size="30" value="<%=vpcg_proxy_ip%>" />
                    port: <input type="text" name="vpcg_proxy_port" size="5" value="<%=vpcg_proxy_port%>" /> <a href="javascript:TEST_set('vpcg_proxy_ip');">set</a></li>
  </ul>
  <input type="button" onclick="javascript:TEST_set('init_vpcg');" value="초기화" />
  <input type="button" onclick="javascript:TEST_exec('exec_vpcg');" value="VPCG테스트" />

  <h2>금결원 CERT-API 테스트 <font size=2><a href="https://fidoweb.yessign.or.kr:3300/guide/api_guide.html" target="_yessign_guide">금결원API메뉴얼</a></font></h2>
  <ul>
    <li>token_url: <input type="text" name="yeskey_token_url" size="50" value="<%=yeskey_token_url%>" /> <a href="javascript:TEST_set('yeskey_token_url');">set</a></li>
    <li>server_id: <input type="text" name="yeskey_server_id" size="50" value="<%=yeskey_server_id%>" /></li>
    <li>client_id: <input type="text" name="yeskey_client_id" size="50" value="<%=yeskey_client_id%>" /></li>
    <li>client_secret: <input type="text" name="yeskey_client_secret" size="50" value="<%=yeskey_client_secret%>" /></li>
    <li>gateway_url: <input type="text" name="yeskey_gateway_url" size="60" value="<%=yeskey_gateway_url%>" /> <a href="javascript:TEST_set('yeskey_gateway_url');">set</a></li>
    <li>forward proxy ip: <input type="text" name="yeskey_proxy_ip" size="30" value="<%=yeskey_proxy_ip%>" />
                    port: <input type="text" name="yeskey_proxy_port" size="5" value="<%=yeskey_proxy_port%>" /> <a href="javascript:TEST_set('yeskey_proxy_ip');">set</a></li>
  </ul>

  <input type="button" onclick="javascript:TEST_set('init_yeskey');" value="초기화" />
  <input type="button" onclick="javascript:TEST_exec('exec_yeskey');" value="CertAPI테스트" />
</form>

<%
    String _action = getParameter(request, "_action", "");
    if ("exec_yeskey".equals(_action) || "exec_vpcg".equals(_action)) {
        String testUrl = "";
        String testData = "";
        String reqHeaderKey = "";
        String reqHeaderValue = "";

        String gatewayUrl = "";
        String proxyIp = "";
        int proxyPort = 0;

        out.println("\n<br/><hr/><b>" + logDate.format(new java.util.Date()) + " Request Info</b>");
        if ("exec_vpcg".equals(_action)) {
            testUrl = vpcg_service_url;
            testData = vpcg_request_data;
            reqHeaderKey = "Authorization";
            reqHeaderValue = "Bearer " + vpcg_access_token;
            gatewayUrl = vpcg_gateway_url;
            proxyIp = vpcg_proxy_ip;
            proxyPort = vpcg_proxy_port;
        } else if ("exec_yeskey".equals(_action)) {
            testUrl = yeskey_token_url;
            testData = "server_id=" + yeskey_server_id + "&client_secret=" + yeskey_client_secret + "&scope=" + DEFAULT_yeskey_token_scope + "&grant_type=client_credentials&reissue=n";
            reqHeaderKey = "client_id";
            reqHeaderValue = yeskey_client_id;
            gatewayUrl = yeskey_gateway_url;
            proxyIp = yeskey_proxy_ip;
            proxyPort = yeskey_proxy_port;
        }
        if (!gatewayUrl.isEmpty()) {
            if (gatewayUrl.indexOf('?') == -1) {
                testUrl = gatewayUrl + "?url=" + URLEncoder.encode(testUrl);
            } else {
                testUrl = gatewayUrl + "&url=" + URLEncoder.encode(testUrl);
            }
        }

        out.println("\n<br/> - testUrl [" + testUrl + "]");
        out.println("\n<br/> - testData [" + testData + "]");

        URL url = null;
        HttpURLConnection http = null;
        OutputStream os = null;
        InputStream is = null;
        ByteArrayOutputStream baos = null;
        int HTTP_readTimeout = 10000;
        int HTTP_connectTimeout = 10000;
        try {
            url = new URL(testUrl);

            Proxy httpProxy = null;
            if (proxyIp != null && !proxyIp.isEmpty()) {
                out.println("\n<br/> - httpProxy [" + proxyIp + ":" + proxyPort + "]");
                httpProxy = new Proxy(Proxy.Type.HTTP, new InetSocketAddress(proxyIp, proxyPort));
            }
            if (url.getProtocol().toLowerCase().equals("https")) {
                trustAllHosts();
                javax.net.ssl.HttpsURLConnection https = (httpProxy!=null) ? (javax.net.ssl.HttpsURLConnection) url.openConnection(httpProxy) : (javax.net.ssl.HttpsURLConnection) url.openConnection();
                //https.setHostnameVerifier(DO_NOT_VERIFY); //TODO
                http = https;
            } else {
                http = (httpProxy!=null) ? (HttpURLConnection) url.openConnection(httpProxy) : (HttpURLConnection) url.openConnection();
            }
            byte[] postData = testData.getBytes("UTF-8");

            if (HTTP_connectTimeout > 0) http.setConnectTimeout(HTTP_connectTimeout);
            if (HTTP_readTimeout > 0) http.setReadTimeout(HTTP_readTimeout);

            http.setDoInput(true);
            http.setDoOutput(true);
            http.setUseCaches(false);
            http.setRequestMethod("POST");
            http.setRequestProperty("content-type", "application/x-www-form-urlencoded;charset=utf-8");

            if (!reqHeaderKey.isEmpty()) {
                out.println("\n<br/> - " + reqHeaderKey + " [" + reqHeaderValue + "]");
                http.setRequestProperty(reqHeaderKey, reqHeaderValue);
            }
            //http.setRequestProperty("X-Forwarded-For", "175.193.45.78");

            os = http.getOutputStream();
            os.write(postData, 0, postData.length);

            int responseCode = http.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                is = http.getInputStream();
            } else {
                is = http.getErrorStream();
            }
            baos = new ByteArrayOutputStream();
            byte[] byteBuffer = new byte[1024];
            int respLength = 0;
            while ((respLength = is.read(byteBuffer, 0, byteBuffer.length)) != -1) {
                baos.write(byteBuffer, 0, respLength);
            }

            out.println("\n<br/><br/><b>" + logDate.format(new java.util.Date()) + " Result Info</b>");
            out.println("\n<br/> - contentType [" + http.getContentType() + "]");
            if (responseCode == HttpURLConnection.HTTP_OK) {
                out.println("\n<br/> - responseCode [" + http.getResponseCode() + "] <b>OK</b>");
            } else {
                out.println("\n<br/> - responseCode [" + http.getResponseCode() + "] <b>FAIL</b>");
            }
            String responseData = new String(baos.toByteArray(), "UTF-8");

            out.println("\n<br/> - responseData [length=" + responseData.getBytes().length + "]");
            out.println("<br/>&nbsp;&nbsp;<textarea style='width: 800px; height: 50px;'>" + responseData + "</textarea>");
            out.println("<hr/>\n");
            out.println(responseData);

        } catch (Exception e) {
            e.printStackTrace();
            out.println("\n<br/><hr/><b>Exception - ERR(?)</b>");
            out.println("\n<br/> - FileName: " + request.getServletPath());
            out.println("\n<br/> - getMessage: " + e.getMessage());
            java.io.StringWriter sw = new java.io.StringWriter();
            java.io.PrintWriter pw = new java.io.PrintWriter(sw);
            e.printStackTrace(pw);
            out.println("\n<br><br><b>printStackTrace</b><br>");
            out.println("<font size='2'>" + sw.toString().replaceAll("\n", "\n<br/>&nbsp;") + "<font>");
        } finally {
            if (baos != null) try { baos.close(); } catch (Exception e) {};
            if (is != null)   try { is.close();   } catch (Exception e) {};
            if (os != null)   try { os.close();   } catch (Exception e) {};
            if (http != null) try { http.disconnect(); } catch (Exception e) { };
        }
    }
%>
<%!
    public static String getParameter(HttpServletRequest request, String name, String defaultValue) {
        String value = request.getParameter(name);
        if (value == null || "".equals(value)) value = defaultValue;
        return value;
    }
    private static void trustAllHosts() throws Exception {
        //Create a trust manager that does not validate certificate chains
        javax.net.ssl.TrustManager[] trustAllCerts = new javax.net.ssl.TrustManager[] { new javax.net.ssl.X509TrustManager() {
            public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                return new java.security.cert.X509Certificate[] {};
            }
            public void checkClientTrusted(java.security.cert.X509Certificate[] chain, String authType) throws java.security.cert.CertificateException {
            }
            public void checkServerTrusted(java.security.cert.X509Certificate[] chain, String authType) throws java.security.cert.CertificateException {
            }
        }};
        //Install the all-trusting trust manager
        try {
            //javax.net.ssl.SSLContext sc = javax.net.ssl.SSLContext.getInstance("TLS");
            javax.net.ssl.SSLContext sc = javax.net.ssl.SSLContext.getInstance("TLSv1.2");
            sc.init(null, trustAllCerts, new java.security.SecureRandom());
            javax.net.ssl.HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage(), e);
        }
    }
    final static javax.net.ssl.HostnameVerifier DO_NOT_VERIFY = new javax.net.ssl.HostnameVerifier() {
        public boolean verify(String hostname, javax.net.ssl.SSLSession session) {
            return true;
        }
    };
%>
<hr/>
</body>
</html>
