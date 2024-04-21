<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
%><%@ page import="java.io.*"
%><%@ page import="java.net.*"
%><%@ page import="java.util.*"
%><%@ page import="javax.net.ssl.*"
%><%@ page import="java.security.SecureRandom"
%><%@ page import="java.text.SimpleDateFormat"
%><%!
    final static int COPY_BUFFER_SIZE = 8192;
    final static int CONNECT_TIMEOUT = 1000 * 20;
    final static int READ_TIMEOUT = 1000 * 10;
    final static boolean LOGGING = true;
    final static boolean ACCESS_LOGGING = true;
    final static boolean DATA_LOGGING = false;
    final static SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
    final static String TLS_PROTOCOL = "TLSv1.2";

    final static Set<String> IGNORE_REQ_HEADERS = new HashSet<String>(Arrays.asList("content-length", "host", "connection", "user-agent", "accept-encoding"));
    final static Set<String> IGNORE_RES_HEADERS = new HashSet<String>(Arrays.asList("content-length", "connection", "transfer-encoding"));
    long count=0;

    static int copyAndClose(InputStream in, OutputStream out, String charset, long tag, String msgPrefix) throws IOException {
        try {

            int totalLen = 0;
            int len;
            ByteArrayOutputStream baos = DATA_LOGGING ? new ByteArrayOutputStream() : null;
            byte[] bytes = new byte[COPY_BUFFER_SIZE];
            while ((len = in.read(bytes)) != -1) {                
                out.write(bytes, 0, len);
                if(baos!=null) baos.write(bytes, 0, len);
                totalLen += len;
            }
            if(baos!=null) data_log(tag, msgPrefix + baos.toString(charset));
            return totalLen;        
        }
        finally {
            try{
                in.close();
                out.close();
            }catch (Exception e){}
        }
    }
    static Map<String, String> parseUrlEncodedParameters(String urlEncodedParams, String encoding) throws UnsupportedEncodingException {
        if ( encoding == null ) {
            encoding = "UTF-8";
        }

        HashMap<String, String> map = new HashMap<String, String>();
        if(urlEncodedParams==null) return map;

        String[] entries = urlEncodedParams.split("&");
        for (String entry : entries) {
            String[] keyValue = entry.split("=");
            if ( keyValue.length == 2 ) {
                map.put(URLDecoder.decode(keyValue[0], encoding), URLDecoder.decode(keyValue[1], encoding));
            }
        }
        return map;
    }

    static String getLocalHostAddress(){
        try{
            return InetAddress.getLocalHost().getHostAddress();
        }catch(Exception e){
            return "";
        }
    }

    static String getCharsetFromContentType(String contentType){
        if(contentType==null) return null;
        String[] values = contentType.split(";");
        for (String value : values) {
            value = value.trim();
            if (value.toLowerCase().startsWith("charset=")) {
                return value.substring("charset=".length()).trim();
            }
        }
        return null;
    }

    static void log(long tag, String msg){
        if(LOGGING){
            SimpleDateFormat df = (SimpleDateFormat)DATE_FORMAT.clone();
            System.out.printf("%s [GW] [%d] %s\n", df.format(new Date()), tag, msg);
        }
    }

    static void access_log(long tag, String msg){
        if(ACCESS_LOGGING){
            SimpleDateFormat df = (SimpleDateFormat)DATE_FORMAT.clone();
            System.out.printf("%s [GW] [%d] %s\n", df.format(new Date()), tag, msg);
        }
    }

    static void data_log(long tag, String msg){
        if(DATA_LOGGING){
            SimpleDateFormat df = (SimpleDateFormat)DATE_FORMAT.clone();
            System.out.printf("%s [GW] [%d] %s\n", df.format(new Date()), tag, msg);
        }
    }

%><%
long tag = count++;
String url="";
String method="";
int reqLen=0;
int resLen=0;
int resStatus=0;
Exception error=null;
try{

    Map<String, String> queryParams = parseUrlEncodedParameters(request.getQueryString(), request.getCharacterEncoding());
    url = queryParams.get("url");
    method = request.getMethod();

    log(tag, String.format("%s %s", method, url));
    
    if(url==null) {
        response.addHeader("X-wizvera-gateway", "v1 " + getLocalHostAddress());
        response.addHeader("X-wizvera-gateway-status", String.valueOf(400));
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "url is not present");
        log(tag, "error: url is not present");
        return;
    }
    
    HttpURLConnection conn = (HttpURLConnection) new URL(url).openConnection();	
	conn.setInstanceFollowRedirects(false);
	
    conn.setConnectTimeout(CONNECT_TIMEOUT);
    conn.setReadTimeout(READ_TIMEOUT);
    conn.setDoInput(true);
    conn.setUseCaches(false);
    conn.setRequestMethod(method);
    if(conn instanceof HttpsURLConnection && TLS_PROTOCOL!=null){
        SSLContext sslContext = SSLContext.getInstance(TLS_PROTOCOL);
        sslContext.init(null, null, new SecureRandom());

        HttpsURLConnection httpsURLConnection = (HttpsURLConnection) conn;
        httpsURLConnection.setSSLSocketFactory(sslContext.getSocketFactory());
    }

    StringBuffer reqHeaderLogMsg = new StringBuffer();
    Enumeration headerNames = request.getHeaderNames();
    while (headerNames.hasMoreElements()) {
        String name = (String) headerNames.nextElement();
        if(!IGNORE_REQ_HEADERS.contains(name.toLowerCase())){
            String value = request.getHeader(name);
            conn.setRequestProperty(name, value);

            if(name.equalsIgnoreCase("authorization")){
                reqHeaderLogMsg.append(String.format("%s=%s***,", name, value.substring(0, Math.min(value.length(),3))));
            }
            else{
                reqHeaderLogMsg.append(String.format("%s=%s,", name, value));
            }
        }
    }
    log(tag, "req-header: " + reqHeaderLogMsg.toString());

    if ("PUT".equals(method) || "POST".equals(method)) {
        conn.setDoOutput(true);
        String charset = request.getCharacterEncoding();
        if(charset==null) charset = "UTF-8";
        reqLen = copyAndClose(request.getInputStream(), conn.getOutputStream(), charset, tag, "req-body-data: ");

        log(tag, String.format("req-body: %d bytes", reqLen));
    }

    resStatus = conn.getResponseCode();
    log(tag, String.format("res-status: %d", resStatus));
    response.setStatus(resStatus);

    StringBuffer resHeaderLogMsg = new StringBuffer();
    for (Map.Entry<String, List<String>> header : conn.getHeaderFields().entrySet()) {
        if(header.getKey()!=null && !IGNORE_RES_HEADERS.contains(header.getKey().toLowerCase())){
            for (String value : header.getValue()) {
                response.addHeader(header.getKey(), value);
                resHeaderLogMsg.append(String.format("%s=%s, ", header.getKey(), value));
            }
        }
    }

    response.addHeader("X-wizvera-gateway", "v1 " + getLocalHostAddress());
    response.addHeader("X-wizvera-gateway-status", String.valueOf(200));

    log(tag, "res-header: " + resHeaderLogMsg.toString());

    String charset = getCharsetFromContentType(conn.getContentType());
    if(charset==null) charset = "UTF-8";

    if(conn.getResponseCode() < HttpURLConnection.HTTP_BAD_REQUEST){
        resLen = copyAndClose(conn.getInputStream(), response.getOutputStream(), charset, tag, "res-body-data: ");
        log(tag, String.format("res-body: %d bytes", resLen));
    }
    else{
        resLen = copyAndClose(conn.getErrorStream(), response.getOutputStream(), charset, tag, "err-body-data: ");
        log(tag, String.format("err-body: %d bytes", resLen));
    }

}catch(Exception e){
    error = e;
    log(tag, "exception: " + e.getMessage());

    response.addHeader("X-wizvera-gateway", "v1 " + getLocalHostAddress());
    response.addHeader("X-wizvera-gateway-status", String.valueOf(500));

    response.sendError(HttpServletResponse.SC_BAD_GATEWAY);
}finally{
    access_log(tag, String.format("[%s %s %d %d %d %s]", method, url, resStatus, reqLen, resLen, error!=null?error.getMessage():""));
}
%>