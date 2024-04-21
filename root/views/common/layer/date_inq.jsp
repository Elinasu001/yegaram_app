<%@page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
var ${reqDs.id}_Func = ({
	// 닫기  
	close : function(){},
	// 취소 (그만하기)
	cancel : function(){},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(){
		
		if(UtilFunc.getOnlyNumber($("#inqStdt").val()) > UtilFunc.getOnlyNumber($("#inqEddt").val())){
			biz.alert("조회 시작일을 조회 종료일보다 이전으로 선택해주세요.");
			return;
		}
		
		//화면에 보여줄 TEXT 셋팅
		$("#inqOrderText").val($("#orderUl").find(".active").text());
		$("#inqDateText").val($("#dateUl").find(".active").text());
		if($("#txGbnDiv").is(":visible")) 		$("#inqGbnText").val($("#txGbnUl").find(".active").text());
		else if($("#rsltGbnDiv").is(":visible"))$("#inqGbnText").val($("#rsltGbnUl").find(".active").text());
		
		var resJson = {
			  	 STDT: UtilFunc.getOnlyNumber($("#inqStdt").val())	//조회시작일자
				,EDDT: UtilFunc.getOnlyNumber($("#inqEddt").val())	//조회종료일자
				,ORDER : $("#inqOrder").val()						//정렬순서 (최신순 : DESC, 과거순 : ASC)
				,TXGBN : $("#inqTxGbn").val()						//거래유형 (전체 : A, 출금 : W, 입금 : M) 
				,RSLTGBN : $("#inqRsltGbn").val()					//거래유형 (전체 : A, 정상 : S, 오류 : E)
				,ORDERTXT : $("#inqOrderText").val()				//정렬순서 텍스트
				,GBNTXT : $("#inqGbnText").val()					//거래유형 텍스트
				,DATETXT : $("#inqDateText").val()					//조회기간 텍스트
			};
		// 레이어 업무 선택 및 입력 완료 처리  
		${reqDs.id}_Func.callback(resJson);
	},
	
	// 호출 화면 콜백 처리	 
	callback : function(){},
	
	//조회기간 셋팅 
	addMonth : function(d){
		$("#inqEddt").val(UtilFunc.getDateStrWithHyphen(new Date()));
		if (d == ""){
			$("#inqStdt").val(UtilFunc.getDateStrWithHyphen(new Date()));
		} else if (d == -7){
			$("#inqStdt").val(UtilFunc.getDateStrWithHyphen(UtilFunc.addDays(new Date(),d)));
		} else {
			$("#inqStdt").val(UtilFunc.getDateStrWithHyphen(UtilFunc.addMonths(new Date(),d)));
		}
	}
});
$(document).ready(function(){
	/* 버튼 클릭시 active */ 
	$(".radio-list li").on('click focusin', function () {
	    $(this).addClass('active').siblings().removeClass('active');
	});
	
	//조회일자 셋팅 
	$("#inqEddt").val(UtilFunc.getDateStrWithHyphen(new Date()));
	$("#inqStdt").val(UtilFunc.getDateStrWithHyphen(UtilFunc.addMonths(new Date(),-3)));

	//거래유형 구분 T:거래(입,출금), R:결과(정상,오류) 
	if("${reqDs.flag}" == "T"){
		$("#txGbnDiv").show();
		$("#inqTxGbn").val("A");
	} else if("${reqDs.flag}" == "R"){
		$("#rsltGbnDiv").show();
		$("#inqRsltGbn").val("A");
	};
});

/* 날짜선택 rolldate 플러그인 적용 */ 
new Rolldate({
    el: '#period1',
    format: 'YYYY-MM-DD',
    beginYear: 2020,
    endYear: 2023,
    lang: {
        title: '', // 팝업 타이틀
        year: '년',
        month: '월',
        day: '일'
    },
    moveEnd: function(scroll) {
    },
    confirm: function(date) {
        $(this.config.el).closest('.select-wrap').addClass('on');
    }
})
  
new Rolldate({
    el: '#period2',
    format: 'YYYY-MM-DD',
    beginYear: 2020,
    endYear: 2023,
    lang: {
        title: '', // 팝업 타이틀
        year: '년',
        month: '월',
        day: '일'
    },
    moveEnd: function(scroll) {
    },
    confirm: function(date) {
        $(this.config.el).closest('.select-wrap').addClass('on');
    }
})    

</script>
<input type="hidden" id="inqTxGbn" value="">
<input type="hidden" id="inqRsltGbn" value="">
<input type="hidden" id="inqOrder" value="DESC">
<input type="hidden" id="inqOrderText" value="">
<input type="hidden" id="inqGbnText" value="">
<input type="hidden" id="inqDateText" value="">

<div class="content-wrap">
    <div class="pop-header">
        <h2 class="pop-title">${reqDs.title}</h2>
        <button type="button" name="button" class="btn-layer-close" data-focus="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">>닫기</button>
    </div>
    <div class="default-wrap">
        <div class="inquiry-set-wrap">
            <div class="period-area">
                <h3 class="area-title">조회기간</h3>
                <!-- <ul class="radio-list">
                    <li><button type="button">1주일</button></li>
                    <li><button type="button">1개월</button></li>
                    <li class="active"><button type="button">3개월</button></li>
                    <li><button type="button">6개월</button></li>
                    <li><button type="button">직접입력</button></li>
                </ul> -->

                <ul class="radio-list" id="dateUl"><!-- [퍼블] 클래스 변경 : syle-button 삭제 -->
                    <li><button type="button" onclick="javascript:${reqDs.id}_Func.addMonth(-7);">1주일</button></li>
                    <li><button type="button" onclick="javascript:${reqDs.id}_Func.addMonth(-1);">1개월</button></li>
                    <li class="active"><button type="button" onclick="javascript:${reqDs.id}_Func.addMonth(-3);">3개월</button></li>
                    <li><button type="button" onclick="javascript:${reqDs.id}_Func.addMonth(-6);">6개월</button></li>
                    <li><button type="button" onclick="javascript:${reqDs.id}_Func.addMonth();">직접입력</button></li>
                </ul>
                <div class="date-sel-wrap">
                    <div class="form-wrap w50">
                        <div class="input">
                            <span id="period1" class="inp option"></span>
                            <input type="date" title="" id="inqStdt" name="" value="" required="">
                            <span class="inputTextHyphen">~</span>
                            <span id="period2" class="inp option"></span>
                            <input type="date" title="" id="inqEddt" name="" value="" placeholder="" required="">
                            <!-- <span id="period1">
                                <input type="date" title="" id="inqStdt" class="inp option" name="" value="" required="">
                            </span>
                            <span class="inputTextHyphen">~</span>
                            <span id="period2">
                                <input type="date" title="" id="inqEddt" class="inp option" name="" value="" placeholder="" required="">
                            </span> -->
                        </div>
                    </div>
                </div>
            </div>
            <div class="type-area" id="txGbnDiv" style="display:none;">
                <h3 class="area-title">거래유형</h3>
                <ul class="radio-list" id="txGbnUl">
                    <li class="active"><button type="button" onclick="$('#inqTxGbn').val('A');">전체</button></li>
                    <li><button type="button" onclick="$('#inqTxGbn').val('M');">입금</button></li>
                    <li><button type="button" onclick="$('#inqTxGbn').val('W');">출금</button></li>
                </ul>
            </div>
            <div class="type-area" id="rsltGbnDiv" style="display:none;">
                <h3 class="area-title">거래유형</h3>
                <ul class="radio-list"  id="rsltGbnUl">
                    <li class="active"><button type="button" onclick="$('#inqRsltGbn').val('A');">전체</button></li>
                    <li><button type="button" onclick="$('#inqRsltGbn').val('S');">정상</button></li>
                    <li><button type="button" onclick="$('#inqRsltGbn').val('E');">오류</button></li>
                </ul>
            </div>
            <div class="sort-area">
                <h3 class="area-title">정렬순서</h3>
                <ul class="radio-list" id="orderUl">
                    <li class="active"><button type="button" onclick="$('#inqOrder').val('DESC');">최신순</button></li>
                    <li><button type="button" onclick="$('#inqOrder').val('ASC');">과거순</button></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div class="fixed-btn-wrap">
    <div class="btn-wrap type-popup">
        <button href="#none" class="btn" onclick="javascript:${reqDs.id}_Func.confirm();">조회</button>
    </div>
</div>