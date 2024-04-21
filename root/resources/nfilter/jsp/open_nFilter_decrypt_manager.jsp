<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.fasterxml.jackson.core.JsonGenerationException" %>
<%@ page import="com.fasterxml.jackson.core.type.TypeReference" %>
<%@ page import="com.fasterxml.jackson.databind.JsonMappingException" %>
<%@ page import="com.fasterxml.jackson.databind.ObjectMapper" %>
<%@ page import="net.nshc.nfilter.openweb.service.OpenWebNFilterSessionManager" %>
<%@ page import="net.nshc.nfilter.openweb.util.crypto.OpenWebNFilterDecryptor" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%
    StringBuffer json = new StringBuffer();
    String line = null;
    String jsonData = null;
    Map<String, String> pMap = new HashMap<String, String>();

    try {
        BufferedReader reader = request.getReader();
        while ((line = reader.readLine()) != null) {
            json.append(line);
            jsonData = json.toString();
        }
        ObjectMapper mapper = new ObjectMapper();
        pMap = mapper.readValue(jsonData, new TypeReference<Map<String, String>>() {});
        //System.out.println(pMap);
    } catch (JsonGenerationException e) {
        e.printStackTrace();
    } catch (JsonMappingException e) {
        e.printStackTrace();
    } catch (IOException e) {
        e.printStackTrace();
    } catch (Exception e) {
        System.out.println("Error reading JSON string: " + e.toString());
    }

    String token = pMap.get("token");
    if (token != null && !token.equals("")) {
        OpenWebNFilterSessionManager sessionManager = new OpenWebNFilterSessionManager();
        String sessionData = sessionManager.DBHandler(token, null, "select");
        OpenWebNFilterSessionManager.setSessionData(session, sessionData);
    }

    String encData = pMap.get("encData");

    OpenWebNFilterDecryptor process = new OpenWebNFilterDecryptor();
    Map decryptedMap = process.nFilterDecrypt(request, encData, session);

    // 20191025 - jhlee :: 복호화 데이터 json으로 만들기
    ObjectMapper obm = new ObjectMapper();
    String jsonStr = obm.writerWithDefaultPrettyPrinter().writeValueAsString(decryptedMap);
    //System.out.println("Decrypted Data Json : " + jsonStr);
%>
<%=jsonStr%>


