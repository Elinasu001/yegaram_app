<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>OWN 4 | NSHC</title>
    <link href="./css/ownSample.css" rel="stylesheet">

    <!-- Open Web nFilter 변수 초기화 -->
    <%@include file="/nfilter/jsp/open_nFilter.jsp" %>

</head>
<script type="text/javascript">
    // ***************************************************************************************************
    // 인증서 모듈 연동키 세팅
    // 아래 키생성 로직은 샘플 구현을 위해 추가 하였습니다. 실제 연동시에는 생성하신 공개키만 아래 API 파라미터로 넘겨 주시면 됩니다.
    // nshc.setCertPubKey(RSA 공개키 with base64encoding);
    // IE11에서 window.crypto가 작동하지 않아 msCrypto를 사용하도록 분기
    var privatekey;
    if (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) { // IE11
        try {
            nshc.cryptoObj.subtle.generateKey(
                {
                    name          : "RSA-OAEP",
                    modulusLength : 2048,
                    publicExponent: new Uint8Array([0x01, 0x00, 0x01]),
                    hash          : {name: "SHA-256"},
                },
                true,
                ["encrypt", "decrypt"]
            ).oncomplete = function (e) {
                var key = e.target.result;
                nshc.cryptoObj.subtle.exportKey(
                    "spki",
                    key.publicKey
                ).oncomplete = function (e) {
                    var rsaPubKey = e.target.result;
                    // 위즈베라 공인인증서 모듈 연동 공개키 세팅
                    nshc.setCertPubKey(nshc.addNewLines(nshc.arrayBufferToBase64(rsaPubKey)));
                };

                nshc.cryptoObj.subtle.exportKey(
                    "pkcs8",
                    key.privateKey
                ).oncomplete = function (e) {
                    var rsaPriKey = e.target.result;
                    privatekey = rsaPriKey;
                }
            }
        } catch (err) {
            console.log('Error: ' + err.message);
        }

    } else { // non IE11
        nshc.cryptoObj.subtle.generateKey(
            {
                name          : "RSA-OAEP",
                modulusLength : 2048,
                publicExponent: new Uint8Array([0x01, 0x00, 0x01]),
                hash          : {name: "SHA-256"},
            },
            true,
            ["encrypt", "decrypt"]
        ).then(function (key) {
            nshc.cryptoObj.subtle.exportKey(
                "spki",
                key.publicKey
            ).then(function (rsaPubKey) {
                // 위즈베라 공인인증서 모듈 연동 공개키 세팅
                nshc.setCertPubKey(nshc.addNewLines(nshc.arrayBufferToBase64(rsaPubKey)));
                // nshc.setCertPubKey(nshc.arrayBufferToBase64(rsaPubKey));
            });

            nshc.cryptoObj.subtle.exportKey(
                "pkcs8",
                key.privateKey
            ).then(function (rsaPriKey) {
                privatekey = rsaPriKey;
            })

        }).catch(function (err) {
            console.log('Error: ' + err.message);
        });
    }

    // ***************************************************************************************************

    function initializedNFilter() {
        // 키패드 초기화 시작
        nshc.setOnInitStart();

        // HTML 인증서 연동 필드 세팅 (inputID를 문자열 형태로 넘겨주시면 됩니다.)
        nshc.setCertField("cert");

        // 치환된 암호화 데이터 전달 (미사용시 plaintext 전달)
        //nshc.setSubCertEncData();

        // 키패드 사용 필드 세팅
        nshc.setCommon(document.getElementById('cert'), "mode=mCKpd"); // PC, 쿼티

        // Open Web nFilter 레이아웃 초기화
        nshc.setInit();

        // 암호화 진행후 데이터 전달 callback 함수
        nshc.certEncrypted = function (AESEncrypted, ivEncData) {
            // 아래는 샘플용 복호화 API 입니다. (테스트 용도로만 사용)
            // 실적용시 복호화 로직 직접 구현해 주시면 됩니다.
            testDecrypt(privatekey, AESEncrypted, ivEncData);
        }
    }

    /*
     * nshc.setSubCertEncData() 함수를 같이 사용하는 경우의 복호화 예시.
     * nshc.certEncrypted() 콜백함수를 이용하여 전달 받은 암호화 데이터를 복호화시 평문이 아닌 치환된 데이터가 나옴.
     * 해당 치환데이터를 실데이터로 변경시 아래 함수를 참고하여 직접 평문 추출 구현.
     * param1 : 복호화데이터 (키패드입력값||치환테이블)
     */
    function testEncDataToPlainText(data) {
        var returnData = "";
        var divideEncData = data.split("||");
        var splitData = [];

        // 입력값 split 처리 (plaintext 하나당 10자리 치환값이기 때문에 10자리로 분류)
        for (var i = 0; i < divideEncData[0].length / 10; i++) {
            if (i == 0) {
                splitData[i] = divideEncData[0].substring(i, i + 10);
            } else {
                splitData[i] = divideEncData[0].substring(i * 10, i * 10 + 10);
            }
        }

        var tableMap = JSON.parse(divideEncData[1]);
        // 역치환 실행
        for (var i = 0; i < splitData.length; i++) {
            var temp = tableMap[splitData[i]];

            // 특정 특수문자 치환
            if (temp == "quot") {
                temp = "'";
            }
            if (temp == "apos") {
                temp = "\"";
            }
            if (temp == "space") {
                temp = " ";
            }

            returnData += temp;
        }
        return returnData;
    }
</script>
<body onload="initializedNFilter()">
<h1 class="main_tit">OWN4 - Web Cert Keypad Sample</h1>
<div id="pc" class="cont on">
    <div class="group">
        <p class="title1">문자키패드(type=password)</p>
        <div class="formBx">
            <input type="password" name="" class="ownInput" id="cert" minlength="1" maxlength="20" placeholder="인증서 비밀번호를 입력하세요.">
        </div>
    </div>
</div>
</body>
</html>