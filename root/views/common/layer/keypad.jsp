<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript">
var ${reqDs.id}_Func = ({
	// 닫기  
	close : function(){},
	// 취소 (그만하기)
	cancel : function(){},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(encData){
		// 레이어 업무 선택 및 입력 완료 처리 
		${reqDs.id}_Func.callback(encData);
	},
	// 호출 화면 콜백 처리	
	callback : function(){}
});

$(document).ready(function(){
	initializedNFilter();
});

function initializedNFilter() {
    // 키패드 초기화 시작
    nshc.setOnInitStart();
	
    // 키패드 로딩 완료 후 이벤트 callback
    /*
    nshc.setFinishedCallback(function () {
        document.getElementById("custom_num_kpd_10key").click();
    });
	*/
	
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

    nshc.setCommon(document.getElementById('custom_num_kpd_10key'), "mode=cusNKpd", "popup2", 0);  // 숫자, cusNKpd
    
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
                        break;
                    }
                }
            } else if (msg == 'nfilter_clear') {
                for (var i = 1; i <= dom.length; i++) {
                    if (dom.item(dom.length - i).classList.contains('on') == true) {
                        dom.item(dom.length - i).removeAttribute('class', 'on')
                    }
                }
            } else if (msg == 'resize'){
            	for (var i = 1; i <= dom.length; i++) {
                    if (dom.item(dom.length - i).classList.contains('on') == true) {
                        dom.item(dom.length - i).removeAttribute('class', 'on')
                    }
                }
            	
            } else {
            	
                for (var i = 0; i < dom.length; i++) {
                    if (dom.item(i).classList.contains('on') == false) {
                        dom.item(i).setAttribute('class', 'on')
                        break;
                    }
                }
            }
        }
    }
    document.getElementById("custom_num_kpd_10key").click();
    $("#custom_num_kpd_10key").click();
}
function encryptedNFilter() {
    /** 암호화 **/
    var encData = nshc.encrypted("custom_num_kpd_10key"); //nshc.encrypted();
    encData = encodeURIComponent(encData);
    ${reqDs.id}_Func.confirm(encData);
}

</script>
<link href="/resources/nfilter/sample/css/ownSample.css?v=${serverTime}" rel="stylesheet">
<link href="/resources/nfilter/sample/css/ownCustomKpdSample.css?v=${serverTime}" rel="stylesheet">
<div class="content-wrap">
    <div class="pop-header">
        <h2 class="pop-title" id="${reqDs.id}_title">${reqDs.title }</h2>
        <button type="button" name="button" class="btn-layer-close" data-focus="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
    </div>

	<div class="group">
	    <div class="formBx" style="visibility: hidden;">
	        <label for="custom_num_kpd_10key" aria-label="가상키패드 필드 입력하시려면 두번 클릭 하세요"></label>
	        <input type="text" class="ownInput" name="" id="custom_num_kpd_10key" minlength="${reqDs.len }" maxlength="${reqDs.len }">
	    </div>
	    <fmt:parseNumber integerOnly="ture" type="number" var="keypad_length" value="${reqDs.len }"/>
	    <div class="showFormBx">
	        <ul id="${reqDs.id}_keypad_length" id="keypadOpen">
	        	<c:forEach begin="1" end="${keypad_length }">
	        		<li></li>
	        	</c:forEach>
	        </ul>
	    </div>
	</div>
</div>