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
    <link href="./css/ownCustomKpdSample.css" rel="stylesheet">

    <!-- Open Web nFilter 변수 초기화 -->
    <%@include file="/nfilter/jsp/open_nFilter.jsp" %>

</head>
<script type="text/javascript">
    function initializedNFilter() {
        // 키패드 초기화 시작
        nshc.setOnInitStart();

        // 키패드 로딩 완료 후 이벤트 callback
        nshc.setFinishedCallback(function () {
            document.getElementById("custom_num_kpd_3x4").click();
        });

        // 랜덤 숫자키패드 설정
        nshc.setRandomNumKpd();

        // 키패드 배경 사용중지 설정
        nshc.setBgNotUse();

        // 재배열 기능 사용중지 설정
        nshc.setRenewNotUse();

        // 키패드 위치 설정 callback 함수 (PC 키패드 only)
        // param1 : 키패드를 사용하는 input 객체
        // param2 : param1에 해당하는 키패드 width 사이즈
        // prarm3 : param1에 해당하는 키패드 height 사이즈
        // reutrn : 키패드 위치 변경 값(left, top)을 배열로 리턴
        nshc.setPCKpdLocation = function (element, kpdWidthSize, kpdHeightSize) {
            // 파라미터를 참고하여 변경 위치값을 아래에 개발
            // left 값의 시작점은 0에서 시작 (0 + 개발한 left값 = 최종 left값)
            // top 값의 시작점은 param1 element의 하단에서 시작 (시작접 값 + 변경된 값 = 최종 top값) (
            // 위치를 수정하고 싶지 않는 영역은 공란으로 넘김
            // var location = [최종 left값, 최종 top값];
            // return location;
            var y = (window.innerHeight - kpdHeightSize) - (own(element).offset().top + own(element).outerHeight() + 10);
            return [(own(window).width() - kpdWidthSize) / 2, y];
        }

        nshc.setCommon(document.getElementById('custom_num_kpd_3x4'), "mode=cusNKpd", "popup", 2);   // 숫자, cusNKpd

        // Open Web nFilter 레이아웃 초기화
        nshc.setInit();

        nshc.ownCallback = function (msg, inputID) {
            if (msg == "enter") {
                encryptedNFilter();
                window.close();
            } else if (msg == "close") {
                window.close();
            } else if (msg != 'open') {
                var dom = document.querySelectorAll('.showFormBx li');
                if (msg == 'delete') {
                    for (var i = 1; i <= dom.length; i++) {
                        if (dom.item(dom.length - i).classList.contains('on') == true) {
                            dom.item(dom.length - i).removeAttribute('class', 'on')
                            break
                        }
                    }
                } else if (msg == 'nfilter_clear') {
                    for (var i = 1; i <= dom.length; i++) {
                        if (dom.item(dom.length - i).classList.contains('on') == true) {
                            dom.item(dom.length - i).removeAttribute('class', 'on')
                        }
                    }
                } else {
                    for (var i = 0; i < dom.length; i++) {
                        if (dom.item(i).classList.contains('on') == false) {
                            dom.item(i).setAttribute('class', 'on')
                            break
                        }
                    }
                }
            }
        }
    }

    function encryptedNFilter() {
        /** 암호화 **/
        var encData = nshc.encrypted();
        encData = encodeURIComponent(encData);
        window.open('./sample-decryption.jsp?encData=' + encData, '_blank');
    }
</script>
<body onload="initializedNFilter()">
<div class="group">
    <div class="formBx" style="visibility: hidden;">
        <label for="custom_num_kpd_3x4" aria-label="가상키패드 필드 입력하시려면 두번 클릭 하세요"></label>
        <input type="text" class="ownInput" name="" id="custom_num_kpd_3x4" minlength="4" maxlength="6">
    </div>
    <div class="showFormBx">
        <ul>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>

    </div>
</div>
<style>
    div.ownKeypadWrap button:focus {
        outline: 0px solid #2f88d9;
    }

    .showFormBx {
        text-align: center;
        margin: 242px 0;
    }

    .showFormBx ul {
        display: inline-block;
    }

    .showFormBx ul:after {
        display: block;
        clear: both;
        content: "";
    }

    .showFormBx ul li {
        width: 20px;
        height: 20px;
        background-color: #c5c5c5;
        -webkit-border-radius: 100%;
        -moz-border-radius: 100%;
        border-radius: 100%;
        float: left;
        margin: 0 8px;
    }

    .showFormBx ul li.on {
        background-color: #11b351;
    }

</style>
</body>
</html>