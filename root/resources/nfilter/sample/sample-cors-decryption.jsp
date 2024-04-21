<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!-- ============================================

크로스 도메인 환경에서 키패드 복호화를 수행하는 예제입니다.
가상키패드가 설치된 서버와 서비스 페이지가 별도의 서버로 구축되어 있는 환경에서(도메인, IP 별도) 키패드 복호화를 구현합니다.

1. Cookie를 이용한 JSESSIONID를 사용할 수 있는 환경이어야 함.
: 가상키패드 입력 페이지에서 전달 받은 sessionID를 해당 페이지에서 request를 통해 받고 쿠키에 세팅한 후 복호화 API페이지에 ajax 통신을 통해 전달하여 복호화 값을 전달 받습니다.
: 해당 페이지는 샘플페이지이입니다. 구성하시는 프로젝트 환경에 맞도록 sessionID를 전달 받아 복호화를 직접 구현하셔야 합니다.

============================================ -->

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>NSHC Open Web nFilter Sample (decryption)</title>
    <%
        // 파라미터 세팅
        String encData = request.getParameter("encData");
        String sessionId = request.getParameter("sessionID");
        String viewType = request.getParameter("viewtype");

        // 받아온 세션값을 쿠키에 세팅
        Cookie cookie = new Cookie("JSESSIONID", sessionId);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    %>
    <script type="text/javascript">
        function encryptedNFilter() {
            var vt = "<%=viewType%>";
            var url = "";
            var encData = "";
            var data = "";
            var setHeader = "";

            // viewType에 따른 분기
            if (vt == "json") {
                url = '../jsp/open_nFilter_decrypt_manager.jsp';
                encData = {'encData': '<%=encData%>'};
                data = JSON.stringify(encData);
                setHeader = "application/json";
            } else {
                url = './sample-decryption.jsp';
                encData = "<%=encData%>";
                data = "encData=" + encData;
                setHeader = "application/x-www-form-urlencoded";
            }

            var xhr = new XMLHttpRequest();
            xhr.open('POST', url);
            xhr.withCredentials = true;
            xhr.setRequestHeader('Content-Type', setHeader);
            xhr.send(data);

            xhr.addEventListener('load', function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var result = xhr.responseText
                    if (xhr.responseText.substr(0, 8) != "ErrCode:") {
                        if (vt == "json") {
                            var decData = JSON.parse(result);
                            var result = "";
                            for (var key in decData) {
                                if (key == "nFilter_financial") {
                                    var jd = JSON.stringify(decData[key]);
                                    jd = jd.replace(/:/g, '=');
                                    jd = jd.replace(/\"/g, "");
                                    result += "<div>" + key + " :: " + jd + "<div>";
                                    result += "<input type=hidden id=EcdhEncdata value=" + jd + ">";
                                    result += "<input type=button value=:::::::Financial_복호화:::::::: onclick=javascript:encryptedEcdhNFilter();></input>";
                                } else {
                                    result += "<div>" + key + " :: " + decData[key] + "<div>";
                                }
                            }
                        }
                        var decryptedAreaElement = document.createElement("div");
                        decryptedAreaElement.setAttribute("id", "decArea");
                        decryptedAreaElement.setAttribute("name", "decArea");
                        var displayElement = document.getElementById("decryptArea");
                        displayElement.parentNode.insertBefore(decryptedAreaElement, displayElement.nextSibling);
                        document.getElementById("decArea").innerHTML = result;
                    } else {
                        alert("DECRYPTOR ERROR :: " + xhr.responseText);
                    }
                }
            });
        }

        function encryptedEcdhNFilter() {
            var encData = document.getElementById("EcdhEncdata").value;
            encData = encodeURIComponent(encData);
            window.open('./sample-financial-decryption.jsp?encData=' + encData, '_blank');
        }
    </script>
</head>
<body onload="encryptedNFilter()">
<div id="decryptArea"></div>
<body>
</body>
</html>