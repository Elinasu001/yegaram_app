<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="net.nshc.nfilter.openweb.service.OpenWebNFilterSessionManager" %>
<%@ page import="net.nshc.nfilter.openweb.util.crypto.OpenWebNFilterDecryptor" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Map" %>
<%@ page import="net.nshc.nfilter.openweb.OpenWebNFilterConfig" %>
<%--<%@ page import="net.nshc.nfilter.openweb.util.OpenWebNFilterUtil" %>--%>

<!-- ============================================

Open Web NFilter 복호화 샘플 페이지입니다.
다음과 같은 순서로 설정하여 주시기 바랍니다.

1.request로 encdada를 취득.
2.복호화.
3.평문값 취득.

============================================ -->

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>NSHC Open Web nFilter Sample (decryption)</title>
    <%
        // >>>>> DB-Token Session 방식 사용시 설정
        String token = request.getParameter("token");
        if (token != null && !token.equals("")) {
            OpenWebNFilterSessionManager sessionManager = new OpenWebNFilterSessionManager();
            String sessionData = sessionManager.DBHandler(token, null, "select");
            OpenWebNFilterSessionManager.setSessionData(session, sessionData);
        }
        // <<<<< DB-Token Session 방식 사용시 설정

        // 1.request로 encdada를 취득한다.
        // 테스트 페이지이므로 encData 에 대해서는 XSS 체크가 적용되어 있지 않습니다.
        String encData = request.getParameter("encData");

        // 2.복호화
        OpenWebNFilterDecryptor process = new OpenWebNFilterDecryptor();
        // 빈암호화 데이터 리턴 문자열 설정 (default : null)
        //process.setDescReturnNullString("noData");

        // 2-1. 고정키 방식 사용 여부에 따른 복호화 API 분기
        Map decryptedMap;
        if (OpenWebNFilterConfig.getUnusedSessionUse().equals("true")) {
            decryptedMap = process.nFilterDecrypt(encData);
        } else {
            decryptedMap = process.nFilterDecrypt(request, encData, session);
        }
    %>
    <script type="text/javascript">
        /**
         * Financial 기능 사용시 복호화 페이지 포워딩
         */
        function encryptedFinancialNFilter() {
            var encData = document.getElementById("FinEncdata").value;
            encData = encodeURIComponent(encData);
            window.open('./sample-financial-decryption.jsp?encData=' + encData, '_blank');
        }
    </script>

</head>

<body leftmargin="0px" topmargin="0px">

<div>
    <h1><font color="#008000">Your Password(복수건): </font><%= encData %>
    </h1>
    <%
        // 3.평문값 취득
        if (decryptedMap != null) {
            Iterator it = decryptedMap.keySet()
                    .iterator();

            while (it.hasNext()) {
                String iteratorKey = (String) it
                        .next();
    %>
    <h2>
        <%-- 아래 주석은 복호화 모듈과 연동시 테스트 용도로 사용 (default : 미사용, 주석처리) --%>
        <%--        <% if (iteratorKey.equals("nFilter_financial")) { %>--%>
        <%--        <font color="#008000"><%=iteratorKey%>:</font><%=decryptedMap.get(iteratorKey)%>--%>
        <%--        <input type="hidden" id="FinEncdata" value="<%=decryptedMap.get( iteratorKey )%>"></input>--%>
        <%--        <input type="button" value=":::::::Financial 복호화::::::::" onclick="javascript:encryptedFinancialNFilter();"></input>--%>
        <%--        <% } else { %>--%>

        <font color="#008000"><%=iteratorKey%>:</font><%=decryptedMap.get(iteratorKey)%>
    </h2>
    <%
                //                }
            }
        }
    %>
</div>
</body>
</html>