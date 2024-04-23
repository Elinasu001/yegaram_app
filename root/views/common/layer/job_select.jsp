<%@page import="co.gnbsoftec.common.util.StringUtils"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
var JOB_HTML_TEMP = '<li><a href="#none" onclick="javascript:${reqDs.id }_Func.select(#CODE#,#CODENM#);">#WORKVAL#</a></li>';
var JOB_RESET_ARRY = [
 {CODE:"1", WORKVAL:"임원 등 고위 관리자"}
,{CODE:"2", WORKVAL:"전문가 및 관련종사자"}
,{CODE:"3", WORKVAL:"사무 종사자"}
,{CODE:"4", WORKVAL:"서비스 종사자"}
,{CODE:"5", WORKVAL:"판매 종사자"}
,{CODE:"6", WORKVAL:"농림·어업 숙련 종사자"}
,{CODE:"7", WORKVAL:"기능원 및 관련 기능 종사자"}
,{CODE:"8", WORKVAL:"장치·기계 조작 및 조립 종사자"}
,{CODE:"9", WORKVAL:"단순노무 종사자"}
,{CODE:"A", WORKVAL:"군인"}
,{CODE:"Z", WORKVAL:"기타"}
];
var ${reqDs.id}_Func = ({
	// 닫기  
	close : function(){},
	
	// 취소 (그만하기)
	cancel : function(){},
	// 확인 (처리 완료 버튼, 또는 처리완료 선택)
	confirm : function(jobcd, jobnm){
		var resJson = {
			  	 JOBCD: jobcd
				,JOBNM: jobnm	
			};
		// 레이어 업무 선택 및 입력 완료 처리 
		${reqDs.id}_Func.callback(resJson);
	},
	// 호출 화면 콜백 처리	
	callback : function(){},
	search : function() {
				
		var jobSearchForm = makeForm("jobSearchForm");
		addFormData(jobSearchForm, "WORKVAL", $("#WORKVAL").val());
		doAction("JOB_SELECT", jobSearchForm, function(resJson){
			if(resJson.REC.length > 0){
				var jobHtml = "";
				$.each(resJson.REC, function(idx, data){
					var tempJob = JOB_HTML_TEMP;
					tempJob = tempJob.replace("#CODE#", "'" + data.CODE + "'");
					tempJob = tempJob.replace("#WORKVAL#", data.WORKVAL);
					tempJob = tempJob.replace("#CODENM#", "'" + data.WORKVAL + "'");
					jobHtml += tempJob;
				});
				if (jobHtml == "") { // 검색된 내역이 없습니다.
					var tempJob = JOB_HTML_TEMP;
					tempJob = tempJob.replace("#CODE#", "'RESET'");
					tempJob = tempJob.replace("#WORKVAL#", "검색된 내역이 없습니다.");
				}
				jobSearchView("Y");
				$("#jobSearchArea").html("");
				$("#jobSearchArea").html(jobHtml);
			} else {
				jobSearchView("N");
			}
		});
	},
	select : function(code,codeNm) {
		var jobHtml = "";
		if (code.length == 5) {
			if (code == "RESET") {
				$.each(JOB_RESET_ARRY, function(idx, data){
					var tempJob = JOB_HTML_TEMP;
					tempJob = tempJob.replace("#CODE#", "'" + data.CODE + "'");
					tempJob = tempJob.replace("#WORKVAL#", data.WORKVAL);
					tempJob = tempJob.replace("#CODENM#", "'" + data.WORKVAL + "'");
					jobHtml += tempJob;
				});
				jobSearchView("Y");
				$("#jobSearchArea").html("");
				$("#jobSearchArea").html(jobHtml);
				
			} else {
				${reqDs.id}_Func.confirm(code, codeNm); // 코드, 크도명
			}
		} else {
			var jobSearchForm = makeForm("jobSearchForm");
			addFormData(jobSearchForm, "CODE", code);
			doAction("JOB_SELECT", jobSearchForm, function(resJson){
				$.each(resJson.REC, function(idx, data){
					var tempJob = JOB_HTML_TEMP;
					tempJob = tempJob.replace("#CODE#", "'" + data.CODE + "'");
					tempJob = tempJob.replace("#WORKVAL#", data.WORKVAL);
					tempJob = tempJob.replace("#CODENM#", "'" + data.WORKVAL + "'");
					jobHtml += tempJob;
				});
				if (jobHtml == "") { // 검색된 내역이 없습니다.
					jobSearchView("N");
				} else {
					jobSearchView("Y");
					$("#jobSearchArea").html("");
					$("#jobSearchArea").html(jobHtml);					
				}

			});
		}
		
	},
	
	//검색어 삭제
	delSearch : function(){
		${reqDs.id}_Func.select("RESET");
		$("#WORKVAL").val("");
	}
});

// 결과없음 화면 컨트롤
function jobSearchView(gubun){
	//데이터 있을 경우
	if(gubun == "Y"){
		$("#jobSearchInfo").show();
		$("#jobSearchArea").show();
		$("#jobSearchNoData").hide();
	} else {
		$("#jobSearchInfo").hide();
		$("#jobSearchArea").hide();
		$("#jobSearchNoData").show();
	}
}
</script>
<!-- s: contents -->
    <div class="pop-header">
        <h2 class="pop-title">${reqDs.title }</h2>
        <button type="button" name="button" class="btn-layer-close" onclick="javascript:${reqDs.id}_Func.close();">닫기</button>
    </div>
    <div class="pop-con-wrap">
        <div class="default-wrap"><!-- [D] default-wrap - 좌우 여백 용도로 space(ex. mt0) 외의 다른 클래스와 중복 사용 X -->
            <!-- s: 검색 영역 -->
            <div class="search-area">
                <div class="form-wrap">
                    <div class="input">
                        <input type="search" title="" id="WORKVAL" class="" name="" value="" placeholder="직종을 검색하세요" required=""><!-- [퍼블] placeholder값 수정 -->
                    </div>
                    <button type="button" class="btn-search" onclick="${reqDs.id }_Func.search();">검색</button>
                    <button type="button" class="btn-delete" onclick="${reqDs.id }_Func.delSearch();">검색어 삭제</button>
                </div>
            </div>
            <div class="tit-wrap" id="jobSearchInfo"><!-- [퍼블] 클래스 변경 -->
                <p class="txt">
					<!-- [퍼블] 수정범위 : 문구 분기 -->
					<b>아래의 직군을 선택</b>하거나,<br><b>직종을 검색</b>해보세요 <!-- 선택 전 -->
					<b>사무종사자</b> <!-- 첫번째 선택 -->
					<b><span>사무종사자</span>상담·안내·통계 및 기타 사무직</b> <!-- 두번째도 선택 -->
					<!-- // [퍼블] 수정범위 : 문구 분기 -->
				</p>
            </div>
            <ul class="arrow-button-list" id="jobSearchArea"><!-- [퍼블] 클래스 변경 -->
                <li><a href="#none" onclick="javascript:${reqDs.id }_Func.select('1');">임원 등 고위 <span class="point">관리자</span></a></li><!-- [퍼블] 검색어 활성화 필요시 span.point 로 감싸주세요 : 검색어가 '관리자'일 경우 -->
                <li><a href="#none" onclick="javascript:${reqDs.id }_Func.select('2');">전문가 및 관련종사자</a></li>
                <li><a href="#none" onclick="javascript:${reqDs.id }_Func.select('3');">사무 종사자</a></li>
                <li><a href="#none" onclick="javascript:${reqDs.id }_Func.select('4');">서비스 종사자</a></li>
                <li><a href="#none" onclick="javascript:${reqDs.id }_Func.select('5');">판매 종사자</a></li>
                <li><a href="#none" onclick="javascript:${reqDs.id }_Func.select('6');">농림·어업 숙련 종사자</a></li>
                <li><a href="#none" onclick="javascript:${reqDs.id }_Func.select('7');">기능원 및 관련 기능 종사자</a></li>
                <li><a href="#none" onclick="javascript:${reqDs.id }_Func.select('8');">장치·기계 조작 및 조립 종사자</a></li>
                <li><a href="#none" onclick="javascript:${reqDs.id }_Func.select('9');">단순노무 종사자</a></li>
                <li><a href="#none" onclick="javascript:${reqDs.id }_Func.select('A');">군인</a></li>
                <li><a href="#none" onclick="javascript:${reqDs.id }_Func.select('Z');">기타</a></li>
            </ul>
            
            <div class="result-area nodata" id="jobSearchNoData" style="display:none"><!-- [퍼블] 클래스 변경 -->
                <p lass="desc">검색결과가 없어요</p><!-- [퍼블] 클래스,텍스트 변경 -->
                <div class="btn-cont-wrap btn-add">
					<a href="#none" class="btn normal" onclick="javascript:${reqDs.id }_Func.select('RESET');">처음으로</a>
				</div>
            </div>
            
			<div class="btn-cont-wrap btn-add"><!-- [퍼블] 클래스 변경 -->
				<a href="#none" class="btn">더보기</a><!-- [퍼블] 텍스트 변경 -->
			</div>
        </div>
            <!-- //e: 검색 결과 영역 -->
    </div>