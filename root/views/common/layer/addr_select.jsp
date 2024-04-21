<%@page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">

var FLAG = ''; 			// 주소조회검증플래그 1:조회, 2:검증
var INPT_ADDR ='';		// 입력주소
var ZPCD = '';			// 우편번호 
var ZPCD_ADDR  = '';	// 우편번호주소
var DTAD = '';			// 상세주소

//s: 대출용
var bldgNo  = ''
var emdNm  = '';
var ccwNm  = '';
var bldgNm  = '';
var cnpNm  = '';
var roadNm  = '';
// e: 대출용 

var result;

var reqDsId = ${reqDs.id};

var ${reqDs.id}_Func = ({
	// 닫기  
	close : function(){
		
	},
	
	// 취소 (그만하기)
	cancel : function(){},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(){
		
		var zpcd = '';		 //현재거주지우편번호
		var zpcdMngNo = '';	//현재거주지우편번호관리번호
		var bsicAddr = '';	//현재거주지기본주소
		var dtad = '';		//현재거주지상세주소
		var refItemNm = '';	//현재거주지참조항목명	
		var bldgMngno = '';	//현재거주지건물관리번호
		var lttCndVal = '';	//현재거주지주소위도좌표값
		var lgtCdnVal = '';	//현재거주지주소경도좌표값
		
		// 도로명 주소 return
		zpcd = $("#roadZocd").val();
		zpcdMngNo = $("#roadBldgMngNo").val();
		bsicAddr = $("#roadAddr1").val();
		dtad = $("#roadAddr2").val();
		refItemNm = $("#roadRefItem").val();
		lttCndVal = $("#roadLttCdn").val();
		lgtCdnVal = $("#roadLgtCdn").val();
		
		result = {	"zpcd"			:	zpcd,
					"zpcdMngNo" 	:	zpcdMngNo,
					"bsicAddr"		:	bsicAddr,
					"dtad"			:	dtad,
					"refItemNm"		:	refItemNm,
					"bldgMngno"		:	bldgMngno,
					"lttCndVal"		:	lttCndVal,
					"lgtCdnVal"		:	lgtCdnVal,
					"bldgNo"		:	bldgNo,
					"emdNm"			:	emdNm,
					"ccwNm"			:	ccwNm,
					"bldgNm"		:	bldgNm,
					"cnpNm"			:	cnpNm,
					"roadNm"		:	roadNm };
		
		${reqDs.id}_Func.callback(result);
		
	},
	// 호출 화면 콜백 처리	
	callback : function(){}
});



$(function() {	
	// 검색어 입력
	$("#INPT_ADDR").keydown(function (key){
		if(key.keyCode == 13){
			roadBtnAction();
		}
	})
});

// 주소검색 버튼 클릭
function roadBtnAction() {

	if($.trim($("#INPT_ADDR").val()) == ''){
		biz.alert("주소를 입력해주세요.");
		$("#INPT_ADDR").focus();
		return;
	}
	FLAG = '1';
	INPT_ADDR = $("#INPT_ADDR").val();
	$("#roadNoDataDiv").css("display","none");
	$("#roadListUl").css("display","none");
	$("#inspectAddrDiv").css("display","none");
	//$("#inspectListDiv").css("display","none");
	//$("#inspectListUl").css("display","none");
	//$("#inspectInfoDiv").css("display","none");
	$("#bottomDiv").css("display","flex");
	$("#bottomCloseDiv").css("display","block");
	$("#DTAD").val("");
	$("#basicAddr").val("");
	
	doRoadSrchAction();
}

/** 도로명 검색 서비스 호출 */
function doRoadSrchAction() {
	
    var dataForm = $("#addrFrm");	
   	addFormData(dataForm, "FLAG", FLAG);
   	addFormData(dataForm, "ZPCD", ZPCD);
   	addFormData(dataForm, "ZPCD_ADDR", ZPCD_ADDR.replaceAll(" [0-9]+동~[0-9]+동", ""));
   	addFormData(dataForm, "DTAD", DTAD);
   	
	doAction("ADDR_SELECT", $("#addrFrm"), function(res){
		console.log(res);
		
		// 정상응답여부 확인
		if (res.APP_HEADER.respCd != "N00000") {
			biz.alert(res.APP_HEADER.respMsg);
			
		} else {

			// 조회
			if (FLAG == '1') { 
				
				if (res.API_RS_MSG != "SUCCESS") {
					biz.alert(res.API_RS_MSG, "확인", function(){
						$("#INPT_ADDR").focus();
					});
					return;
					
				} else {
					
					var addrList = res.REC;
					
					// 검색결과 여부 체크
					if (addrList == undefined || addrList.length == 0) {
						if(res.API_RS_MSG.split(",")[0] == "ECB12262"){
							biz.alert("입력하신 주소로 200건 이상의 주소가 검색돼요.<br>주소를 상세하게 입력해주세요.");
						} else {
							$("#roadNoDataDiv").css("display","block");
							$("#roadListUl").css("display","none");
							$("#exSearch").css("display","none");
						}
						
					} else {
						var str ="<h3>검색결과</h3>";
						$.each(addrList, function(i){
						str += '<div class="result-box"><a name="addr1" onclick="selectAddr(this)">';
						str += '<span class="zipcode" name="zpcd" id="'+addrList[i].ZPCD+'">'+ addrList[i].ZPCD +'</span>';
						str += '<ul class="juso-list">';
						str += '<li id="'+addrList[i].ZPCD_ADDR.split('\n')[0].replace("[도로명주소] ", "")+'"><em class="roadname">도로명</em>';
						str += '<p name="roadAddr">'
						str += addrList[i].ZPCD_ADDR.split('\n')[0].replace("[도로명주소] ", "")+'</p></li>';
						str += '<li><em>지번</em>';
						str += '<p class="font14 address" name="jibunAddr">'+ addrList[i].ZPCD_ADDR.split('\n')[1].replace("[지번주소] ", "")+'</p></li>';
						str += '</ul>'
						str += '<input type="hidden" name="bldgNo" value="' + addrList[i].BLDG_NO +'">'
						str += '<input type="hidden" name="emdNm" value="' + addrList[i].EMD_NM +'">'
						str += '<input type="hidden" name="ccwNm" value="' + addrList[i].CCW_NM +'">'
						str += '<input type="hidden" name="bldgNm" value="' + addrList[i].BLDG_NM +'">'
						str += '<input type="hidden" name="cnpNm" value="' + addrList[i].CNP_NM +'">'
						str += '<input type="hidden" name="roadNm" value="' + addrList[i].ROAD_NM +'">'
						str += '</a></div>';
						});
						
						$("#exSearch").css("display","none");
						$("#roadListUl").css("display","block");
						$("#getAddrInfoBtn").css("display","none");
						$("#insertCompletBtn").css("display","block");
						$("#bottomDiv").css("display","flex");
						$("#bottomCloseDiv").css("display","none");
						$("#roadListUl").html(str);
						
					}
				}
				
			} else if (FLAG == '2') { // 검증
				
				//정상응답 아닐경우 에러메세지 노출
				if(res.API_RS_MSG != "SUCCESS"){
					biz.alert(res.API_RS_MSG,"확인",function(){
						$("#detailAddr").parent().parent().addClass("error");
					});
					return;
				} else {
					$("#detailAddr").parent().parent().removeClass("error");
				
					var data = res.REC_1[0];
					$("#roadZocd").val(data.RFM_ROAD_NM_ZOCD);
					$("#roadBldgMngNo").val(data.RFM_ROAD_NM_BLDG_MNGNO);
					$("#roadAddr1").val(data.RFM_ROAD_NM_ADDR1+" "+data.RFM_ROAD_NM_BLDG_MLNO);
					$("#roadAddr2").val(data.RFM_ROAD_NM_ADDR2);
					$("#roadRefItem").val(data.RFM_ROAD_NM_REF_ITEM);
					$("#roadLttCdn").val(data.RFM_ROAD_NM_LTT_CDN);
					$("#roadLgtCdn").val(data.RFM_ROAD_NM_LGT_CDN);
					
					//검증 후 바로 콜백
					${reqDs.id}_Func.confirm();
				}
				
				/* 				var str = '';
				str += '<div class="result-box"><a href="#none">'
				str += '<span class="zipcode">'+data.RFM_ROAD_NM_ZOCD+'</span>'
				str += '<ul class="juso-list"><li><em class="roadname">도로명</em>'
				str += '<p>'+data.RFM_ROAD_NM_ADDR1+' '+data.RFM_ROAD_NM_ADDR2+' '+data.RFM_ROAD_NM_REF_ITEM+'</p></li><li><em>지번</em>'       
				str += '<p>'+data.RFM_LNBR_ADDR1+' '+data.RFM_LNBR_ADDR2+'</p></li></ul></a></div>'
				str += '<input type="hidden" id="roadZocd" value="'+data.RFM_ROAD_NM_ZOCD+'">'
				str += '<input type="hidden" id="roadBldgMngNo" value="'+data.RFM_ROAD_NM_BLDG_MNGNO+'">'
				str += '<input type="hidden" id="roadAddr1" value="'+data.RFM_ROAD_NM_ADDR1+" "+data.RFM_ROAD_NM_BLDG_MLNO+'">'
				str += '<input type="hidden" id="roadAddr2" value="'+data.RFM_ROAD_NM_ADDR2+'">'
				str += '<input type="hidden" id="roadRefItem" value="'+data.RFM_ROAD_NM_REF_ITEM+'">'
				str += '<input type="hidden" id="roadLttCdn" value="'+data.RFM_ROAD_NM_LTT_CDN+'">'
				str += '<input type="hidden" id="roadLgtCdn" value="'+data.RFM_ROAD_NM_LGT_CDN+'">'
				str += '<input type="hidden" id="lnbrZipcd" value="'+data.REM_LNBR_ZIPCD+'">'
				str += '<input type="hidden" id="lnbrAddr1" value="'+data.RFM_LNBR_ADDR1+'">'
				str += '<input type="hidden" id="lnbrAddr2" value="'+data.RFM_LNBR_ADDR2+'">'
				str += '<input type="hidden" id="lnbrLttCdn" value="'+data.RFM_LNBR_LTT_CDN+'">'
                         */
				
				/* $("#inspectListDiv").html(str);
				$("#inspectAddrDiv").css("display","none");
				$("#inspectListDiv").css("display","block");
				$("#inspectListUl").css("display","block");
				$("#inspectInfoDiv").css("display","block");
				$("#getAddrInfoBtn").css("display","block");
				$("#insertCompletBtn").css("display","none"); */
			} 
			
		} 
		
	});
	
}

//주소 리스트 클릭시 텍스트 셋팅
function selectAddr(obj) {
	
	ZPCD = $(obj).children().eq(0).attr('id');
	ZPCD_ADDR = $(obj).children().eq(1).children().eq(0).attr('id'); 
	bldgNo = $(obj).children().eq(2).val();
	emdNm = $(obj).children().eq(3).val();
	ccwNm = $(obj).children().eq(4).val();
	bldgNm = $(obj).children().eq(5).val();
	cnpNm = $(obj).children().eq(6).val();
	roadNm = $(obj).children().eq(7).val();
	
	$(obj).attr("name","");
	var selectedAddr = $(obj).closest("div").html();
	$("#basicAddrArea").html(selectedAddr);
	
	$("#roadListUl").css("display","none");
	$("#inspectAddrDiv").css("display","block");
	$("#bottomDiv").css("display","flex");
	$("#bottomCloseDiv").css("display","none");
	$("#basicAddr").val(ZPCD_ADDR);
};

// 주소 검증 '다음'버튼 클릭
function insertCompletBtnAction() {
	
	if($("#basicAddr").val() == null || $("#basicAddr").val() == ''){
		biz.alert("저장할 주소를 선택해 주세요.", "닫기");
		return true;
	}
	
	if($("#detailAddr").val() == null || $("#detailAddr").val() == ''){
		biz.alert("상세주소를 입력해 주세요.", "닫기", function(){
			$("#detailAddr").focus(); 
		});
		return true;
	}
	
	FLAG= '2';
	DTAD = $("#detailAddr").val();
	doRoadSrchAction();		
}


// 재검색
function searchAgain(){
	$("#exSearch").css("display","block")
	$("#roadNoDataDiv").css("display","none");
	$("#roadListUl").css("display","none");
	$("#inspectAddrDiv").css("display","none");
	//$("#inspectListDiv").css("display","none");
	//$("#inspectListUl").css("display","none");
	//$("#inspectInfoDiv").css("display","none");
	$("#bottomDiv").css("display","none");
	$("#bottomCloseDiv").css("display","block");
	$("#INPT_ADDR").val("");
	$("#detailAddr").val("");
	$("#basicAddr").val("");
	
	if (!$("#insertCompletBtn").hasClass("disabled")) $("#insertCompletBtn").addClass("disabled");
	if (!$("#${reqDs.id}_procBtn").hasClass("disabled")) $("#${reqDs.id}_procBtn").addClass("disabled");
	$("#detailAddr").parent().parent().removeClass("error");
}
	
//상세주소 입력 후 버튼 컨트롤
function detailAddrChk(){
	if(null != $("#detailAddr").val() && $("#detailAddr").val() != '') {
		$("#insertCompletBtn").removeClass("disabled");
	} else {
		if (!$("#insertCompletBtn").hasClass("disabled")) $("#insertCompletBtn").addClass("disabled");
	}
	
}

</script>
<div class="content-wrap">
    <div class="pop-header">
        <h2 class="pop-title">${reqDs.title }</h2>
        <button type="button" name="button" class="btn-layer-close" data-focus="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
    </div>
    <div class="pop-con-wrap">
        <div class="default-wrap">
        <form id="addrFrm" name="addrFrm" method="post">
        	<input type="hidden" id="ZPCD" name="ZPCD" value="" />
        	<input type="hidden" id="ZPCD_ADDR" name="ZPCD_ADDR" value="" />
        	<input type="hidden" id="DTAD" name="DTAD" value="" />
        	<input type="hidden" id="FLAG" name="FLAG" value="" />
        	
        	<input type="hidden" id="roadZocd" value="" />
        	<input type="hidden" id="roadBldgMngNo" value="" />
        	<input type="hidden" id="roadAddr1" value="" />
        	<input type="hidden" id="roadAddr2" value="" />
        	<input type="hidden" id="roadRefItem" value="" />
        	<input type="hidden" id="roadLttCdn" value="" />
        	<input type="hidden" id="roadLgtCdn" value="" />
            
            <!-- s: 검색 영역 -->
            <div class="search-area">
                <div class="form-wrap">
                    <div class="input">
                        <input type="search" title="" id="INPT_ADDR" class="${reqDs.id}_validChk" name="INPT_ADDR" value="" placeholder="도로명주소, 건물명 또는 지번입력" required="" onkeyup="validChk('${reqDs.id}');">
                    </div>
                    <button type="button" class="btn-search" id="roadBtn" onclick="roadBtnAction();">검색</button>
                    <button type="button" class="btn-delete" onclick="searchAgain();">검색어 삭제</button>
                </div>
				<dl class="juso-ex-list" id="exSearch" >
					<!-- 예시) [퍼블] 텍스트 삭제 -->
                    <dt>도로명 + 건물번호</dt>
                    <dd>중앙대로 244</dd>
                    <dt>지역명(동/리)+번지</dt>
                    <dd>초량동 1193-1</dd>
                    <dt>지역명(동/리) + 건물명(아파트명)</dt>
                    <dd>초량동 흥국생명</dd>
                </dl>
            </div>
            <!-- // e: 검색 영역 -->
            </form>
            
            <!-- s: 검색 결과 영역 -->
            <div class="search-result-area" id="roadListUl" style="display:none;" >
                <!-- <h3>검색결과</h3> [퍼블] 삭제 -->
                <div class="result-box" >
                    <a href="#none">
                        <span class="zipcode">12345</span>
                        <ul class="juso-list">
                            <li>
                                <em class="roadname">도로명</em>
                                <p>서울시 동작구 동작로 131 고려아파트 1154동 702호</p>
                            </li>
                            <li>
                                <em>지&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;번</em><!-- [퍼블] 공백5개 추가 -->
                                <p>서울시 동작구 동작로 131</p>
                            </li>
                        </ul>
                    </a>
                </div>
			</div>
                
           <div class="result-area nodata" id="roadNoDataDiv" style="display:none;" ><!-- [퍼블] 클래스 변경 -->
				<!-- [퍼블] 수정 범위 -->
                <p lass="desc">검색결과가 없어요</p>
                <p class="desc">도로명, 지번주소, 지역명(동/리) + 건물명으로<br>다시 검색하세요</p>
				<!-- // [퍼블] 수정 범위 -->
            </div>
            <!-- // e: 검색 결과 영역 -->
            
            <!-- 주소입력 -->
			<div class="search-result-area"  id="inspectAddrDiv" style="display:none;">
                <h3>기본주소</h3>
                <div class="result-box" id="basicAddrArea">
				</div>
				<input type="hidden" id="basicAddr" name="" value="" readonly required />
				
				
				
				<!-- <h3>상세주소</h3> [퍼블] 삭제 -->
				<div class="form-wrap"><!-- [퍼블] 클래스 변경 -->
					<div class="input">
						<input type="text" title="상세주소" id="detailAddr" class="inp" name="" value="" placeholder="상세주소" required onkeyup="detailAddrChk();"/><!-- [퍼블] placeholder 값 변경 -->
					</div>
					<p class="error-txt">상세주소를 입력해주세요</p>
				</div>
			</div>
			<!-- // e: 주소입력 -->
            
            <!-- 정제된 주소 선택 -->
			<!-- <div class="search-result-area" id="inspectListDiv" style="display:none;">
			</div>
			<ul class="list-bull mt20" id="inspectListUl" style="display:none;">2023-06-14 클래스명 변경
                <li>저장할 주소를 선택해 주세요 </li>
                <li>표준화된 주소를  선택하시길 권해드려요</li>
            </ul> -->
            
        </div>
        
         <!-- //e: 검색 결과 영역 -->
        
        <!-- 주소선택 안내 문구 -->    
        <!-- <div id="inspectInfoDiv" style="display:none;">
			<div class="default-wrap">
			    <ul class="list-bull exception mt15">
			        <li>저장할 주소를 선택해 주세요 </li>
			        <li>표준화된 주소를  선택하시길 권해드려요</li>
			    </ul>
			</div>
        </div> -->
         <!-- //e: 주소선택 안내 문구 -->
    </div>
    
    <div class="btn-wrap fixed-btn-wrap type-multi" id="bottomDiv" style="display:none;">
        <a href="javascript:void(0);" class="btn btn-cancel" onclick ="searchAgain();" >재검색</a>
        <a href="javascript:void(0);" class="btn btn-confirm disabled" id="insertCompletBtn" onclick="insertCompletBtnAction();">확인</a>
        <a href="javascript:void(0);" class="btn btn-confirm" style="display:none;" id="getAddrInfoBtn" onclick="${reqDs.id}_Func.confirm();">확인</a>
    </div>
	<div class="btn-wrap fixed-btn-wrap" id="bottomCloseDiv">
        <a href="javascript:void(0);" class="btn disabled" id="${reqDs.id}_procBtn" onclick="roadBtnAction();">검색</a>
    </div>
    
</div>