<%--<%@ page import="com.nshc.NSaferJNI" %>--%>
<%--<%@ page import="net.nshc.nfilter.openweb.util.OpenWebNFilterUtil" %>--%>
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
    <title>OWN 4.0 | NSHC</title>
    <link href="./css/ownSample.css" rel="stylesheet">
    <link href="./css/ownCustomKpdSample.css" rel="stylesheet">

    <!-- Open Web nFilter 변수 초기화 -->
    <%@include file="/nfilter/jsp/open_nFilter.jsp" %>

    <!-- ECC 공개키 생성 (해당 설정은 고정키 방식 사용시 properties의 고정키 설정값을 변경하고자 할 때 사용)-->
    <%--    <%--%>
    <%--        // 생성하려는 키의 암호화 모듈 버전에 따라 type을 변경 (nSafer 또는 nSafer2)--%>
    <%--        String type = "nSafer";--%>
    <%--//        String type = "nSafer2";--%>
    <%--        OpenWebNFilterKeyPair keypair = new OpenWebNFilterKeyPair();--%>
    <%--        String[] key = keypair.GenKeypair(type);--%>
    <%--        System.out.println(type + " PublicKey :: " + key[0]);--%>
    <%--        System.out.println(type + " PrivateKey :: " + key[1]);--%>
    <%--    %>--%>

    <!-- ECC 공개키 설정 (해당 설정은 복호화 모듈과 연동시 사용)-->
        <%--    <%--%>
    <%--        String publicKeyExportUsingBase64 = "";--%>
    <%--        if (OpenWebNFilterConfig.getNscryptoUse().equals("true")) {--%>
    <%--            publicKeyExportUsingBase64 = "BK6/zWZ+HRsbY6ayLPgt4nWaWh8fsD0U0ymy/grgT+BMmUINmY47QdyvAsaHF6P3WEt5OC9lLbEaThl/Gg19Lb0=";--%>
    <%--        } else {--%>
    <%--            String financialPubkey = "MF0wRRMABEEErr/NZn4dGxtjprIs+C3idZpaHx+wPRTTKbL+CuBP4EyZQg2ZjjtB3K8CxocXo/dYS3k4L2UtsRpOGX8aDX0tvQQUffMV+i3pgDgzKVGacY1fFWg0Kso=";--%>
    <%--            byte[][] pubkeys = new NSaferJNI().N_PublicKeyExport(OpenWebNFilterUtil.decode(financialPubkey, OpenWebNFilterUtil.BASE64));--%>
    <%--            byte[] pubkey = pubkeys[1];--%>
    <%--            publicKeyExportUsingBase64 = OpenWebNFilterUtil.encode(pubkey, OpenWebNFilterUtil.BASE64);--%>
    <%--        }--%>
    <%--    %>--%>

</head>
<script type="text/javascript">
    function initializedNFilter() {
        // 키패드 초기화 시작
        nshc.setOnInitStart();

        // 키패드 로딩 완료 후 이벤트 callback
        // nshc.setFinishedCallback(function() {
        // alert("완료");
        // });

        // CSRF 관련 metatag 추가 함수
        //nshc.setCsrfToken("oqoghq304hg09reg09q3j409gj49jgsd9rjg093409jg");

        // 키패드 멀티 더미 설정
        // nshc.setMultiDummy(2);

        // 랜덤 숫자키패드 설정
        // nshc.setRandomNumKpd();

        // 키패드 배경 사용중지 설정
        // nshc.setBgNotUse();

        // 재배열 기능 사용중지 설정
        // nshc.setRenewNotUse();

        // text 필드에서 입력 값이 plantext로만 나오게 설정
        // nshc.setPlanTextChangeNotUse();

        // 키 입력시 making 색상 변경 (코드사용시 # 입력 필수)
        // nshc.setMaskingColor('#0aa200');

        // 키패드 언어 세팅 (언어 추가시 키패드 이미지 네임 suffix로 '_언어코드' 추가)
        // nshc.setLanguage("en");

        // PC일때, 숫자키패드 사이즈 설정 (기본값 width 400px)
        // nshc.setPcNumKpdWidth(200);

        // 키패드 하단 픽스 기능 (모바일 모드에만 사용)
        //nshc.setKpdBottomFix();

        // 입력 Formatting 설정 (input type text only)
        nshc.setViewFormatting("formatting1=-;4;2^2*;4*;4|formatting2=,");

        // financial 복호화 필드 설정 (복호화 모듈과 연동시 사용)
        // nshc.setFinancialInputField("pc_num_typeB|pc_num_typeC");

        // financial 키설정 (복호화 모듈과 연동시 사용)
        <%--nshc.setFinancialRsaPublicKey('MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgUH7b/usk2kec72HoAPppvT+xgf7i1mjnKIDWSPzTLsvreUafuDv+Lwe1ZJZZV/YEuoQE' +--%>
        <%--    'e8nt2xZadyzFzravkm09c0qZCd7Rx2kRJeqHyebl925XIbFnV51uYAX77+dnlFZT5iPdS6vAdGbEX5FpM5wQglY2xjDua3VfW+CI3s4uS5Lb4l3Lvq8cGNLPYcslOuHDedQpOY1LN5g' +--%>
        <%--    'wqgPzCfT6vUJJt2YZaGPcrLeNtSuiUmNVm10RtXTcmXWQXLR0xiVIqZPPtXg79rB4/O0s1ijwN5tp7AzJx5oQ9DGOvw1IrzSkW5LuS6OuiMyPqWXwMNx/5lRsbFvQ0JiGThwTQIDAQAB');--%>
        <%--nshc.setFinancialEcdhPublicKey("<%=publicKeyExportUsingBase64%>");--%>

        // 키패드 닫기 버튼 사용중지 설정
        // nshc.setKpdCloseNotUse();

        // 서버 통신 에러 발생시 리턴값 포맷팅 설정
        // param1
        //  : 콜백 타입 (alert, display, status, customizing)
        // param2
        //  : 리턴 값
        //  : param1 타입이 display인 경우 return 받을 elementID (String 타입으로 전달)
        //  : param1 타입이 customizing인 경우 function 타입 객체 전달 (function 객체 파라미터로 errCode, errMsg 전달)
        //  : param1 타입이 display, customizing이 아닌 경우 param2 미사용
        // 해당 API 미사용시 모든 콜백은 alert 타입으로 처리
        // nshc.setExceptionCallBackType("customizing", function (errCode, errMsg) {
        //     // 고객사 환경에 맞춰서 직접 구현
        //     console.log(errCode + " :: " + errMsg);
        // });

        // 에러 메시지 리턴값 포맷팅 설정 (최소값, 최대값 알림)
        // param1
        //  : 콜백 타입 (alert, display, status, customizing)
        // param2
        //  : 리턴 값
        //  : param1 타입이 display인 경우 return 받을 elementID (String 타입으로 전달)
        //  : param1 타입이 customizing인 경우 function 타입 객체 전달 (function 객체 파라미터로 errMsg 전달)
        //  : param1 타입이 display, customizing이 아닌 경우 param2 미사용
        // 해당 API 미사용시 모든 콜백은 alert 타입으로 처리
        // nshc.setErrMsgCallBackType("customizing", function (errMsg) {
        //     // 고객사 환경에 맞춰서 직접 구현
        //     console.log(errMsg);
        // });

        // 키패드 초기화 버튼 비활성화 설정
        // nshc.setKpdAllClearNotUse();

        // 키패드 사이즈 설정 (width 값 전달, PC/모바일 구분 없음)
        // nshc.setKpdSize(500);

        // 키패드 위치 설정 callback 함수 (PC 키패드 only)
        // param1 : 키패드를 사용하는 input 객체
        // param2 : param1에 해당하는 키패드 width 사이즈
        // prarm3 : param1에 해당하는 키패드 height 사이즈
        // reutrn : 키패드 위치 변경 값(left, top)을 배열로 리턴
        //nshc.setPCKpdLocation = function (element, kpdWidthSize, kpdHeightSize) {
        //     // 파라미터를 참고하여 변경 위치값을 아래에 개발
        //     // left 값의 시작점은 0에서 시작 (0 + 개발한 left값 = 최종 left값)
        //     // top 값의 시작점은 param1 element의 하단에서 시작 (시작접 값 + 변경된 값 = 최종 top값) (
        //     // 위치를 수정하고 싶지 않는 영역은 공란으로 넘김
        //     var location = [최종 left값, 최종 top값];
        //     return location;
        //var y = (window.innerHeight - kpdHeightSize) - (own(element).offset().top + own(element).outerHeight() + 10);
        //return [(own(window).width() - kpdWidthSize) / 2, y];
        //}

        // 키패드 비율 조정
        // width 값은 고정하고 height 값의 변화로 비율을 조정함.
        // param1 : 변경할 키패드 type
        // param2 : 변경할 키패드 값 (키패드 높이, 배경 이미지 높이, 단일키 높이, 조합키패드 높이, X버튼 높이)
        //nshc.setKpdRatio('nAKpd', [467, 663, 93, '15.9%', 22.2]);

        // 입력중 input 스타일 변경(targetIdArray, changevalue, mode, color, size)
        // targetIdArray - 변경하고 싶은 input id, String Array로 삽입. 값 없이 []이면 가상키패드 사용 필드 전체 변환
        // ex) [] or ['pc_qwer','pc_num_typeA']
        // changevalue - 지정한 기호로 * 변경. string으로 입력시 첫 문자만 나옴. ""일 경우 default 값 (*)
        // ex) "★" or "♥" or "Ab" => "A"
        // mode - 입력 완료 후 변경된 스타일을 되돌리는 기능. return일 경우 default로 되돌림. ""일 경우 적용된 스타일로 입력
        // color - String으로 입력. ""일 경우 default 값 (black)
        // ex)"red" or "rgb(255,0,0)" or "#FF0000"
        // size - px빼고 숫자만 String으로 입력(단위 픽셀). ""일 경우 default 값 (15px)
        // ex)"18"
        // nshc.inputControl(['pc_qwer', "pc_qwer_pw", 'pc_num_typeA'], "★", "return", "red", "25");

        // 입력값 maxlength 도달시 자동 enter 기능 비활성화
        //nshc.setAutoEnterDisabled();

        // ScreenReader에서 키패드 입력값이 읽혀짐 여부 설정
        //nshc.setScreenReaderUse(false);

        // 동적 키패드 이미지 설정
        //nshc.setKpdImage("site");

        // 파라미터로 받은 Element에 대해서 가상키패드 입력값에 대한 pattern 치환을 바로 적용 (미실행 : 다음값 입력시 이전 입력값 pattern 적용)
        // 단, nshc.setViewFormatting API 사용하는 필드에 대해서만 적용
        // '|' 구분자를 사용하여 필드를 여러개 전달 가능
        //nshc.setChgPatternImmediate("formatting1");

        // 키패드 init 통신 방식을 다른 형태로 변경하고자 하는 경우 사용
        // param1 : 서버 통신 URL (전달받은 그대로 사용)
        // param2 : 서버 전달 파라미터 (전달받은 그대로 사용)
        // param3 : 통신 완료 callback 함수 (파라미터 값으로 꼭 통신 결과 값을 전달해야 함)
        // 해당 API 선언은 필히 키패드 초기화 함수(nshc.setInit) 이전에 선언해야 함
        // nshc.initSyncCustom = function (url, param, syncAfter) {
        //     // 샘플(직접 구현)
        //     console.log(">>> Kpd_Init_Custom <<<");
        //     var kpdInitSync = window.XMLHttpRequest ? new XMLHttpRequest : new ActiveXObject("Microsoft.XMLHTTP");
        //     kpdInitSync.open("POST", url, true);
        //     kpdInitSync.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        //     kpdInitSync.send(param)
        //     kpdInitSync.onreadystatechange = function () {
        //         // 통신 완료 후 결과 값을 callback 함수에 전달
        //         if (kpdInitSync.readyState == 4 && kpdInitSync.status == 200) {
        //             syncAfter(kpdInitSync.response);
        //         }
        //     };
        // }

        // 키패드 위치 설정 callback 함수 (Mobile only)
        // 키패드 좌우 위치값은 변경 불가능합니다.(디바이스 좌우 정중앙 위치)
        // 해당 함수로 위치를 설정하는 경우 키패드 모듈에서 작동하는 기본 위치 설정 기능(배경 밀어올림, 키패드 하단 고정 등)은 작동하지 않습니다. (직접 구현)
        // param1 : 키패드를 사용하는 input 객체
        // param2 : param1에 해당하는 키패드 height 사이즈
        // reutrn : 키패드 위치 변경 값(top) 리턴
        // nshc.setMobileKpdLocation = function (element, kpdHeightSize) {
        //     // 파라미터를 참고하여 변경 위치값을 아래에 개발
        //     var nowScroll = nshc.getNowScroll();
        //     var y = window.innerHeight - kpdHeightSize + nowScroll.Y;
        //     return y;
        // }

        // 키패드 수동 오픈 (사용자 이벤트가 아닌 자바스크립트 코드로 키패드 호출시 사용)
        // param : 호출하고자 하는 inputID 입력 (문자열 타입, 필수)
        // nshc.openKpd(inputId);

        // 키패드 수동 닫기 (사용자 이벤트가 아닌 자바스크립트 코드로 키패드 닫기시 사용)
        // parma1 : 어떤 이벤트로 닫을지 지정 (취소 : "close"", 확인 : "enter", 미입력시 "close"로 작동) 
        // param2 : 키패드가 닫힌 후 포커스를 이동할 element 지정 (객체 타입, 미입력시 키패드가 열려있던 input으로 포커스 이동)
        // nshc.closeKpd(closeType, focusElement);

        nshc.setCommon(document.getElementById('pc_qwer'), "mode=pcCKpd");                              // PC, 쿼티
        nshc.setCommon(document.getElementById('pc_qwer_pw'), "mode=pcCKpd");                           // PC, 쿼티
        nshc.setCommon(document.getElementById('pc_num_typeA'), "mode=nAKpd");                          // 숫자, typeA
        nshc.setCommon(document.getElementById('pc_num_typeB'), "mode=nBKpd");                          // 숫자, typeB
        nshc.setCommon(document.getElementById('pc_num_typeC'), "mode=nCKpd");                          // 숫자, typeC
        nshc.setCommon(document.getElementById('formatting1'), "mode=nAKpd");                           // 숫자, typeA
        nshc.setCommon(document.getElementById('formatting2'), "mode=nAKpd");                           // 숫자, typeA
        nshc.setCommon(document.getElementById('m_qwer'), "mode=mCKpd");                                // Mobile, 쿼티
        nshc.setCommon(document.getElementById('m_qwer_pw'), "mode=mCKpd");                             // Mobile, 쿼티
        nshc.setCommon(document.getElementById('m_num_typeA'), "mode=nAKpd");                           // 숫자, typeA
        nshc.setCommon(document.getElementById('m_num_typeB'), "mode=nBKpd");                           // 숫자, typeB
        nshc.setCommon(document.getElementById('m_num_typeC'), "mode=nCKpd");                           // 숫자, typeC
        nshc.setCommon(document.getElementById('custom_num_kpd_10key'), "mode=cusNKpd", "tenKey", 0);   // 숫자, cusNKpd

        // Open Web nFilter 레이아웃 초기화
        nshc.setInit();

        nshc.ownCallback = function (msg, inputID, focusCallback) {
            console.log(inputID + " :: " + msg);
            if (msg == "close") {
                //nshc.setRemoveAllKeypad();        // 가상키패드 사용 전체 필드 삭제
                //nshc.setRemoveKeypad(inputID);    // 가상키패드 사용 특정 필드 삭제
            }
            if (inputID == "custom_num_kpd_10key" && (msg == "open" || msg == "nfilter_renew") && nshc.isMobile == false) {
                document.getElementById("nshcNumKeypad").style.width = "400px";
                document.getElementById("nshcNumKeypad").style.height = "412px";
            }

            // 키패드가 닫힌 후(close, enter 이벤트 발생후) Focus 처리
            if (msg == "enter" && inputID == "m_qwer") {
                // 1. focusCallback 함수 미호출시 키패드를 호출한 input 엘리먼트로 Focus 이동
                // 2. focusCallback 함수 파라미터로 notFocus 문자열 전달시 Focus 이벤트를 주지 않음.
                // focusCallback("notFocus");
                // 3. focusCallback 함수 파라미터로 특정 객체 전달시 해당 객체 Focus
                focusCallback(document.getElementById("m_qwer_pw"));
            }
        }
    }

    function encryptedNFilter() {
        /** 암호화 **/
        var encData = nshc.encrypted();
        encData = encodeURIComponent(encData);
        var nfilter_token = document.getElementById('nfilter_token');
        if (nfilter_token == null) {
            window.open('./sample-decryption.jsp?encData=' + encData, '_blank');
        } else {
            nfilter_token = encodeURIComponent(nfilter_token.value);
            window.open('./sample-decryption.jsp?encData=' + encData + '&token=' + nfilter_token, '_blank');
        }
    }

     // 팝업키패드 로딩 함수
    function popupKeypad(url, title, w, h) {
        // 팝업창 중앙 정렬
        var screenLeft = window.screenLeft != undefined ? window.screenLeft : screen.left;
        var screenTop = window.screenTop != undefined ? window.screenTop : screen.top;
        var width = window.innerWidth ? window.innerWidth : document.documentElement.clientWidth ? document.documentElement.clientWidth : screen.width;
        var height = window.innerHeight ? window.innerHeight : document.documentElement.clientHeight ? document.documentElement.clientHeight : screen.height;
        var left = ((width / 2) - (w / 2)) + screenLeft;
        var top = ((height / 2) - (h / 2)) + screenTop;

        window.open(url, title, 'scrollbars=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
    }

</script>
<body onload="initializedNFilter()">
<section id="wrapper">
    <h1 class="main_tit">OWN 4.0 Sample Guide page</h1>
    <div class="lst_tab">
        <ul>
            <li class="on"><a href="#">PC</a></li>
            <li><a href="#">Mobile</a></li>
        </ul>
    </div><!-- lst_tab -->
    <div class="tabCont">
        <div id="pc" class="cont on">
            <div class="group">
                <p class="title1">PC 문자키패드(type=text)</p>
                <div class="formBx">
                    <label for="pc_qwer" aria-label="가상키패드 필드 입력하시려면 두번 클릭 하세요"></label>
                    <input type="text" class="ownInput" name="" id="pc_qwer" minlength="4" maxlength="8">
                </div>
            </div>
            <div class="group">
                <p class="title1">PC 문자키패드(type=password)</p>
                <div class="formBx">
                    <label for="pc_qwer_pw" aria-label="가상키패드 필드 입력하시려면 두번 클릭 하세요"></label>
                    <input type="password" class="ownInput" name="" id="pc_qwer_pw" minlength="4" maxlength="8">
                </div>
            </div>
            <div class="group">
                <p class="title1">PC 숫자키패드(3X4)</p>
                <div class="formBx">
                    <label for="pc_num_typeA" aria-label="가상키패드 필드 입력하시려면 두번 클릭 하세요"></label>
                    <input type="text" class="ownInput" name="" id="pc_num_typeA" minlength="4" maxlength="8" placeholder="">
                </div>
            </div>
            <div class="group">
                <p class="title1">PC 숫자키패드(4X3)</p>
                <div class="formBx">
                    <label for="pc_num_typeB" aria-label="가상키패드 필드 입력하시려면 두번 클릭 하세요"></label>
                    <input type="text" class="ownInput" name="" id="pc_num_typeB" minlength="4" maxlength="8">
                </div>
            </div>
            <div class="group">
                <p class="title1">PC 숫자키패드(2X6)</p>
                <div class="formBx">
                    <label for="pc_num_typeC" aria-label="가상키패드 필드 입력하시려면 두번 클릭 하세요"></label>
                    <input type="password" class="ownInput" name="" id="pc_num_typeC" minlength="4" maxlength="8">
                </div>
            </div>
        </div>
        <div id="mobile" class="cont">
            <div class="group">
                <p class="title1">Mobile 문자키패드(type=text)</p>
                <div class="formBx">
                    <label for="m_qwer" aria-label="가상키패드 필드 입력하시려면 두번 클릭 하세요"></label>
                    <input type="text" class="ownInput" name="" id="m_qwer" minlength="4" maxlength="8">
                </div>
            </div>
            <div class="group">
                <p class="title1">Mobile 문자키패드(type=password)</p>
                <div class="formBx">
                    <label for="m_qwer_pw" aria-label="가상키패드 필드 입력하시려면 두번 클릭 하세요"></label>
                    <input type="password" class="ownInput" name="" id="m_qwer_pw" minlength="4" maxlength="8">
                </div>
            </div>
            <div class="group">
                <p class="title1">Mobile 숫자키패드(3X4)</p>
                <div class="formBx">
                    <label for="m_num_typeA" aria-label="가상키패드 필드 입력하시려면 두번 클릭 하세요"></label>
                    <input type="text" class="ownInput" name="" id="m_num_typeA" minlength="4" maxlength="8">
                </div>
            </div>
            <div class="group">
                <p class="title1">Mobile 숫자키패드(4X3)</p>
                <div class="formBx">
                    <label for="m_num_typeB" aria-label="가상키패드 필드 입력하시려면 두번 클릭 하세요"></label>
                    <input type="text" class="ownInput" name="" id="m_num_typeB" minlength="4" maxlength="8">
                </div>
            </div>
            <div class="group">
                <p class="title1">Mobile 숫자키패드(2X6)</p>
                <div class="formBx">
                    <label for="m_num_typeC" aria-label="가상키패드 필드 입력하시려면 두번 클릭 하세요"></label>
                    <input type="password" class="ownInput" name="" id="m_num_typeC" minlength="4" maxlength="8">
                </div>
            </div>
            <div class="group">
                <p class="title1">커스텀 숫자키패드 (10키)</p>
                <div class="formBx">
                    <label for="custom_num_kpd_10key" aria-label="가상키패드 필드 입력하시려면 두번 클릭 하세요"></label>
                    <input type="text" class="ownInput" name="" id="custom_num_kpd_10key" minlength="4" maxlength="8">
                </div>
            </div>
        </div>
    </div><!-- tabCont -->
    <hr>
    <div class="formatting">
        <div class="group mt10">
            <p class="title1">포맷팅</p>
            <div class="formBx">
                <label for="formatting1" aria-label="가상키패드 필드 입력하시려면 두번 클릭 하세요"></label>
                <input type="text" name="" class="ownInput" id="formatting1" minlength="13" placeholder="카드번호 '-' 없이 입력해주세요.">
            </div>
            <div class="formBx mt10">
                <label for="formatting2" aria-label="가상키패드 필드 입력하시려면 두번 클릭 하세요"></label>
                <input type="text" name="" class="ownInput" id="formatting2" minlength="1" maxlength="20" placeholder="금액 ',' 없이 입력해주세요.">
            </div>
        </div>
        <div class="group">
            <div class="group mt10">
                <p class="title1">팝업 키패드</p>
                <button onclick="popupKeypad('./sample-popup-keypad_3x4.jsp', '팝업키패드_3x4', '600', '900')">팝업 3x4</button>
                <button onclick="popupKeypad('./sample-popup-keypad_10key.jsp', '팝업키패드_10key', '600', '900')">팝업 10key</button>
            </div>
        </div>
    </div>
    <div class="btn_next">
        <button onclick="encryptedNFilter();">복호화</button>
    </div>
    <script>
        //탭소스
        own(".lst_tab ul li").click(function () {
            var num = own(this).index();
            own(this).addClass("on").siblings("li").removeClass("on");
            own(this).parents(".lst_tab").next(".tabCont").children(".cont").eq(num).addClass("on").siblings().removeClass("on");
            return false;
        });
    </script>

</section>
</body>
</html>