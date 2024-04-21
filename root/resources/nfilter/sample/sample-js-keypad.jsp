<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">

    <%@include file="/nfilter/jsp/open_nFilter.jsp" %>

    <script type="text/javascript">

        function initializedNFilter() {
            //**************************************************************************************
            // 클라이언트 공개키+암호화 데이터를 서버로 전송한다.
            // 서버에서 복호화 후 전달받은 클라이언트 공개키+서버개인키를 이용해서 암호화한다
            // 클라이언트로 재암호화데이터+서버공개키 전달 (전달받은 서버공개키+클라이언트 개인키로 SEED 생성한다)
            //**************************************************************************************

            // 키패드 초기화 시작
            nshc.setOnInitStart();

            // Open Web nFilter 키패드 설정
            nshc.setCommon(document.getElementById('sample1_display_element'), "mode=pcCKpd");

            // Open Web nFilter 초기화
            nshc.setInit();
        }

        /**
         * 복호화
         * 가상키패드로 입력 후 키패드 확인 버튼을 누르면 암호화된 데이터가 공인인증서 입력창에 들어갑니다.(hidden 필도로 입력필드 하단에 생성)
         * 인증서 자체 확인버튼을 클릭할때 아래 함수처럼 복호화 로직 설계해 주시면 됩니다.
         */
        function encryptedNFilter() {
            /***
             * nshc.JSProcess(param1, param2)
             * param1 : 가상키패드로 입력한 inputID의 암호화 데이터
             * param2 : callback (param1 : 복호화 여부, parma2 : 복호화 값)
             * param2로 넘겨준 function에서 code 값이 0이 리턴되면 정상 복호화가 된 것입니다.
             * 0이 리턴되면 이후 프로세서에 복호화 값 사용하셔서 처리하시면 됩니다.
             */
            nshc.JSProcess(nshc.encrypted("sample1_display_element"), function (code, data) {
                if (code == 0) {
                    if (!nshc.isElementExist("decArea")) {
                        var decryptedAreaElement = document.createElement("div");
                        decryptedAreaElement.setAttribute("style", "PADDING-LEFT: 20px");
                        decryptedAreaElement.setAttribute("id", "decArea");
                        decryptedAreaElement.setAttribute("name", "decArea");
                        var displayElement = document.getElementById("decryptButton");
                        displayElement.parentNode.insertBefore(decryptedAreaElement, displayElement.nextSibling);
                    }
                    document.getElementById("decArea").innerHTML = "<br><h4>복호화  >> " + data + "</h4>";
                }
            });
        }

    </script>
</head>
<!-- Open Web nFilter onload 설정  -->
<body onload="initializedNFilter()" leftmargin="0px" topmargin="0px">
<div style="PADDING-LEFT: 10px">
    <h1><font color="#008000">JS Keypad Sample</font></h1>
    <hr>

    <div>
        <h2><font style="background-color:lightblue">기본 키보드</font></h2>
        <div style="PADDING-LEFT: 20px">
            <b>PC, 쿼티 </b>
            <input type="password" size="20" name="sample1_display_element" id="sample1_display_element" value="" minlength="2" maxlength="7"></input>
        </div>
        <div id="decryptButton" style="PADDING-LEFT: 20px">
            <br>
            <input type="button" value=":::::::복호화::::::::" onclick="javascript:encryptedNFilter();"></input>
        </div>
    </div>
</div>
</body>
</html>